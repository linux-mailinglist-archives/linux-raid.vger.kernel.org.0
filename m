Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6114870E52
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 02:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfGWA40 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 20:56:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfGWA40 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 22 Jul 2019 20:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21473308A9E2;
        Tue, 23 Jul 2019 00:56:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48B0860603;
        Tue, 23 Jul 2019 00:56:21 +0000 (UTC)
Subject: Re: [V2 PATCH] Set R5_ReadError when there is read failure on parity
 disk of raid6
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
References: <1562552072-5098-1-git-send-email-xni@redhat.com>
 <CAPhsuW5rAGufksMWYzXPuP26pM=0-u=wTYFHTNiiXXEY6r3iXw@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <7c36b378-bb9d-d087-4ead-270e71da2246@redhat.com>
Date:   Tue, 23 Jul 2019 08:56:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5rAGufksMWYzXPuP26pM=0-u=wTYFHTNiiXXEY6r3iXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Jul 2019 00:56:26 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/23/2019 06:07 AM, Song Liu wrote:
> On Sun, Jul 7, 2019 at 7:14 PM Xiao Ni <xni@redhat.com> wrote:
>> In 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.) It avoids to re-read P
>> when it can be computed from other members. But it misses the chance to re-write the right data
>> to P. Now it sets R5_ReadError if the re-read fails. Because it avoids the re-read, so it misses
>> the chance to set R5_ReadError. The re-write is submitted in state machine when r5dev has flag
>> R5_ReadError. So it doesn't re-write the right data to disk. We need to do this to keep the raid
>> having right data.
>>
>> Because it don't send re-read, so it also misses the chance to reset rdev->read_erros to 0. It can
>> fail the disk when there are many read errors on P member disk(other disks don't have read error)
>>
>> V2: upper layer read request don't read parity/Q data. So there is no need to consider such situation.
>> This is Reported-by: kbuild test robot <lkp@intel.com>
>>
>> Fixes: 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.)
>> Signed-off-by: Xiao Ni <xni@redhat.com>
> The commit log should be 75 byte or narrower. checkpatch.pl should report this.
>
> Applied with modified commit log (see below). Please let me know if anything is
> not accurate.
>
> Thanks,
> Song
>
> md/raid6: Set R5_ReadError when there is read failure on parity disk
>
> 7471fb77ce4d ("md/raid6: Fix anomily when recovering a single device in
> RAID6.") avoids rereading P when it can be computed from other members.
> However, this misses the chance to re-write the right data to P. This
> patch sets R5_ReadError if the re-read fails.
>
> Also, when re-read is skipped, we also missed the chance to reset
> rdev->read_errors to 0. It can fail the disk when there are many read
> errors on P member disk (other disks don't have read error)
>
> V2: upper layer read request don't read parity/Q data. So there is no
> need to consider such situation.
>
> This is Reported-by: kbuild test robot <lkp@intel.com>
>
> Fixes: 7471fb77ce4d ("md/raid6: Fix anomily when recovering a single
> device in RAID6.")
> Cc: <stable@vger.kernel.org> #4.4+
> Signed-off-by: Xiao Ni <xni@redhat.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Hi Song

Sorry for this. The patch is OK for me. I'll take notice about the 
problem next time.

Regards
Xiao

