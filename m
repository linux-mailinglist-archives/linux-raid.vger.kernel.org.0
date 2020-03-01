Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACD174F7F
	for <lists+linux-raid@lfdr.de>; Sun,  1 Mar 2020 21:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAUQ5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Mar 2020 15:16:57 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:62696 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgCAUQ5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 1 Mar 2020 15:16:57 -0500
Received: from [86.155.171.124] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1j8V1C-0006j2-Bc; Sun, 01 Mar 2020 20:16:55 +0000
Subject: Re: Grow array and convert from raid 5 to 6
To:     Roman Mamedov <rm@romanrm.net>
Cc:     William Morgan <therealbrewer@gmail.com>,
        linux-raid@vger.kernel.org
References: <CALc6PW7C30Z6bccQLXLPf8zYuM=aBVZ_hLgW3i5gqZFVsLRpfA@mail.gmail.com>
 <fa393999-3f56-0bcf-b097-462a209f1eae@youngman.org.uk>
 <20200302004806.54852908@natsu>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <cf69979e-8df7-31f4-a2f0-a6187aef6f6d@youngman.org.uk>
Date:   Sun, 1 Mar 2020 20:16:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302004806.54852908@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 01/03/2020 19:48, Roman Mamedov wrote:
> On Sun, 1 Mar 2020 19:07:56 +0000
> antlists <antlists@youngman.org.uk> wrote:
>   
>> --add disk2 ..." to give an array with 4 active drives and 4 spares.
>> Then you can upgrade to raid 6 - "--grow --level=6 --raid-devices=8".
> This feels risky and unclear, for instance what will be the array state if 2
> disks fail during this conversion? Would it depend on which ones have failed?
>
> Instead I'd suggest doing this in two steps. First and foremost, add one disk
> and convert to RAID6 in a special way:
>
>    --grow --level=6 --raid-devices=5 --layout=preserve
I didn't know about that ...
>
> ...due to the last bit (see the man page), this will be really fast and will
> not even rewrite existing data on the old 4 disks; But you will get a
> full-blown RAID6 redundancy array, albeit with a weird on-disk layout.
>
> Then add 3 remaining disks, and
>
>    --grow --level=6 --raid-devices=8 --layout=normalise
>
> Additionally, before you even begin, consider do you really want to go with
> such a setup in the first place. I used to run large RAID6s with a single
> filesystem on top, but then found them to be too much of a single point of
> failure, and now moved on to merging individual disks on the FS level (using
> MergerFS or mhddfs) for convenience, and doing 100% backups of everything
> for data loss protection. Backups which you have to do anyway, as anyone will
> tell you RAID is not a replacement for backup; but with a RAID6 there's too
> much of a temptation to skimp on them, which tends to bite badly in the end.
> Also back then it seemed way too expensive to backup everything, now with
> todays HDD sizes and prices that's no longer so.

Or use lvm to claim the new space, move all the old partitions into lvm, 
and use that to manage the raid. Okay, you still need to take backups to 
protect against a raid failure, but that makes backups to protect 
against accidental damage dead easy - lvm just takes copy-on-write copies.

Cheers,

Wol

