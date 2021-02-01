Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382C730A9F2
	for <lists+linux-raid@lfdr.de>; Mon,  1 Feb 2021 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhBAOhN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 1 Feb 2021 09:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhBAOhH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 1 Feb 2021 09:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612190141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKWaKyx1UNRYaf8dQvoiKkFjvmulgjMG5r15GBHTufM=;
        b=aikDn2jmPz23hGBFk2J9ww2rnae26ygtH5lBxqVj2wM/F4hGwAkrw/aoayHx5CocLV6xh4
        MOgagB4P/hzmLacPUwfFfKnhg4IFJE41Nz55qKwiDUUndNj3fuA05lqpxA1CMaK6xvi9EU
        K/8xNkijY44zFKnYx1eF0NgO6oHjM68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-7XVtLCpmOfiGKysF0Qo4cg-1; Mon, 01 Feb 2021 09:35:39 -0500
X-MC-Unique: 7XVtLCpmOfiGKysF0Qo4cg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51141800D50;
        Mon,  1 Feb 2021 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3726E5D9DC;
        Mon,  1 Feb 2021 14:35:34 +0000 (UTC)
Subject: Re: One failed raid device can't umount automatically
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid <linux-raid@vger.kernel.org>,
        artur.paszkiewicz@intel.com, Jes Sorensen <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.com>, Nigel Croxon <ncroxon@redhat.com>
References: <1b0aaa70-a7bf-c35f-12c0-425e76200f0c@redhat.com>
Message-ID: <b4cc93d4-4923-4959-3258-f03eca58f18e@redhat.com>
Date:   Mon, 1 Feb 2021 22:35:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1b0aaa70-a7bf-c35f-12c0-425e76200f0c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

Any good suggestion for this problem?

Regards
Xiao

On 01/12/2021 04:42 PM, Xiao Ni wrote:
> Hi all
>
> We support to umount one failed raid device automatically. But it 
> can't work now.
> For example, one 3 disks raid5 device /dev/md0. I unplug two disks one 
> by one.
> The udev rule udev-md-raid-assembly.rules is triggered when unplug disk.
>
> In this udev rule, it calls `mdadm -If $disk` when unplug one disk. 
> Function IncrementalRemove
> is called. When the raid doesn't have enough disks to be active, it 
> tries to stop the array.
> Before stopping the array, it tries to umount the raid device first.
>
> Now it uses udisks to umount raid device. I printed logs during test. 
> It gives error message
> "Permission denied". Then I tried with umount directly, it failed with 
> the same error message.
>
> diff --git a/Incremental.c b/Incremental.c
> index e849bdd..96ba234 100644
> --- a/Incremental.c
> +++ b/Incremental.c
> @@ -1620,6 +1620,7 @@ static void run_udisks(char *arg1, char *arg2)
>                 manage_fork_fds(1);
>                 execl("/usr/bin/udisks", "udisks", arg1, arg2, NULL);
>                 execl("/bin/udisks", "udisks", arg1, arg2, NULL);
> +               execl("/usr/bin/umount", "umount", arg2, NULL);
>                 exit(1);
>         }
>         while (pid > 0 && wait(&status) != pid)
>
> Does anyone know how to fix this problem?
>
> Regards
> Xiao
>

