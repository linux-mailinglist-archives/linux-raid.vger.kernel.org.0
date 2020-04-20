Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38751AFFEF
	for <lists+linux-raid@lfdr.de>; Mon, 20 Apr 2020 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDTCrr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Apr 2020 22:47:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbgDTCrr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 19 Apr 2020 22:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587350865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XI2nzAcAH9TQTzAufWhg0YFY+lPuGHF/v7zlRp1bYs=;
        b=QHr/J6sVDwPGqa5NQC241gNOUVPyNypqs5ClqypC/CWQHn8VfCW0UWysbd8AWfWf60F1aO
        MSo0omfZx7g7+UbE9gPXujkW91vcjXnGHRgKnv5s0a8doSZUfDml+HIUJL2ntpkNJsQ7yw
        t9HknXPPku4ospAd/qij0ouiOAJiRJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-0o0EeO66OauAUS2gn9Wzqg-1; Sun, 19 Apr 2020 22:47:43 -0400
X-MC-Unique: 0o0EeO66OauAUS2gn9Wzqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC692107ACC4;
        Mon, 20 Apr 2020 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A78158;
        Mon, 20 Apr 2020 02:47:41 +0000 (UTC)
Subject: Re: [BUG REPORT] md raid5 with write log does not start
To:     Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org
References: <4ad57f1f-a00f-3bc6-33d2-f30ca8e18c0d@suse.de>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <1572ccb3-e8d0-e120-fa91-5d1d9c7d54da@redhat.com>
Date:   Mon, 20 Apr 2020 10:47:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4ad57f1f-a00f-3bc6-33d2-f30ca8e18c0d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 04/17/2020 12:30 AM, Coly Li wrote:
> Hi folks,
>
> When I try to create md raid5 array with 4 NVMe SSD (3 for raid array
> component disks, 1 for write log), the kernel is Linux v5.6 (not Linux
> v5.7-rc), I find the md raid5 array cannot start.
>
> I use this command to create md raid5 with writelog,
>
> mdadm -C /dev/md0 -l 5 -n 3 /dev/nvme{0,1,2}n1 --write-journal /dev/nvme3n1
>
>  From terminal I have the following 2 lines information,
>
> mdadm: Defaulting to version 1.2 metadata
> mdadm: RUN_ARRAY failed: Invalid argument
>
>  From kernel message, I have the following dmesg lines,
>
> [13624.897066] md/raid:md0: array cannot have both journal and bitmap
> [13624.897068] md: pers->run() failed ...
> [13624.897105] md: md0 stopped.
>
> But from /proc/mdstat, it seems an inactive array is still created,
>
> /proc/mdstat
> Personalities : [raid6] [raid5] [raid4]
> md127 : inactive nvme2n1[4](S) nvme0n1[0](S) nvme3n1[3](S)
>        11251818504 blocks super 1.2
>
> unused devices: <none>
>
>  From all the information it seems when initialize raid5 cache the bitmap
> information is not cleared, so an error message shows up and raid5_run()
> fails.
>
> I don't have clear idea who to handle bitmap, journal and ppl properly,
> so I firstly report the problem here.
>
> So far I am not sure whether this is a bug or I do something wrong. Hope
> other people may reproduce the above failure too.
>
> Thanks.
>
> Coly Li
>
Hi Coly

I can reproduce this. mdadm creates internal bitmap automatically if the 
member device is bigger
than 100GB. raid5 journal device and bitmap can't exist at the same 
time. So it needs to check this
when creating raid device.

diff --git a/Create.c b/Create.c
index 6f84e5b..0efa19c 100644
--- a/Create.c
+++ b/Create.c
@@ -542,6 +542,7 @@ int Create(struct supertype *st, char *mddev,
         if (!s->bitmap_file &&
             s->level >= 1 &&
             st->ss->add_internal_bitmap &&
+           s->journaldisks == 0 &&
             (s->consistency_policy != CONSISTENCY_POLICY_RESYNC &&
              s->consistency_policy != CONSISTENCY_POLICY_PPL) &&
             (s->write_behind || s->size > 100*1024*1024ULL)) {

I tried this patch. It can resolve this problem. How do you think about 
this?

Best Regards
Xiao

