Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88729282
	for <lists+linux-raid@lfdr.de>; Fri, 24 May 2019 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbfEXIK5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 May 2019 04:10:57 -0400
Received: from mail.thorsten-knabe.de ([212.60.139.226]:52146 "EHLO
        mail.thorsten-knabe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbfEXIK4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 May 2019 04:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=thorsten-knabe.de; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8aiYSQ1WGIWj63DKfvMduEvEhqG9bByAzpD7/RO33X8=; b=euFJP1p19cCmyKaMKtJSuKA6bN
        RcyTebEY+itCrCgKh/aN8SNvnAJJTizkKPqooszDnqjbWCWrey9NO/SyxpiJe3euTa3mNjYDPNgUD
        DRHNQg+B41S20BSZczBqYq8n+LzbYENcV9eAl61SGjnlH6EkMvA3FClaGnWhTjA5KCV7yLIN5g4DJ
        ZLh7Nj4DmT4zIt6ISTCSyBMlbD35LNYJqFFiO3RMIFqAWFxyyn4f3UkasINPbUjEGnEyyXlOQyFEQ
        cY4FO19veqRxue+KXIvZe5QYQBAu11o5bhzp/mT3iPrm1X/Eoec9KRBLmPUV1qNTd7f5nfsWrYa3r
        cGUU10Dw==;
Received: from tek01.intern.thorsten-knabe.de ([2a01:170:101e:1::a00:101])
        by mail.thorsten-knabe.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@thorsten-knabe.de>)
        id 1hU5Hu-0006VW-HJ; Fri, 24 May 2019 10:10:54 +0200
Subject: Re: BUG: RAID6 recovery broken by commit
 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Shaohua Li <shli@kernel.org>, Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <69b2ca6b-2ccb-db3b-1fde-62e5b7483293@thorsten-knabe.de>
 <CAPhsuW5Fvd0i-ezmsEpr977kiNfvdTKb5ZXTOi2D1oN5HdXP0w@mail.gmail.com>
 <CAPhsuW4==2vgsmTvd070yjjLtOj38B9kxFv5b-FMpQO+_+XVKA@mail.gmail.com>
From:   Thorsten Knabe <linux@thorsten-knabe.de>
Openpgp: preference=signencrypt
Message-ID: <9b77d8ac-28d2-8822-5662-f626f71223a4@thorsten-knabe.de>
Date:   Fri, 24 May 2019 10:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4==2vgsmTvd070yjjLtOj38B9kxFv5b-FMpQO+_+XVKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Report: Content analysis details:   (-1.1 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 SPF_NONE               SPF: sender does not publish an SPF Record
  0.8 DKIM_ADSP_ALL          No valid author signature, domain signs all mail
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/22/19 8:24 PM, Song Liu wrote:
> Hi Thorsten,
> 
> On Wed, May 22, 2019 at 9:19 AM Song Liu <liu.song.a23@gmail.com> wrote:
>>
>> Hi Thorsten,
>>
>> Thanks for the report. I will follow up with stable@ to fix them.
>>
>> Best regards,
>> Song
> 
> Could you please confirm the follow patches fixes the issue?
> 
> commit a25d8c327bb4 ("Revert "Don't jump to compute_result state from
> check_result state"")
> commit b2176a1dfb51 ("md/raid: raid5 preserve the writeback action
> after the parity check")

Hello Song.

With the two patches applied to Linux 5.1.4 I was not able to reproduce
the previously observed file system and data corruptions by replacing a
disk of a RAID6 array.

Thorsten

> 
> Thanks,
> Song
> 
> 
>>
>> On Wed, May 22, 2019 at 5:26 AM Thorsten Knabe <linux@thorsten-knabe.de> wrote:
>>>
>>> Hello.
>>>
>>> BUG: RAID6 recovery broken by commit
>>> 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3+)
>>>
>>> Replacing a failed disk of a MD RAID6 array causes file system
>>> corruption and data loss on kernels containing commit
>>> 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef.
>>>
>>> Affected kernels: 5.1.3, 5.1.4 possibly others.
>>> Unaffected kernels: 5.1.2
>>>
>>> OS: Debian stretch amd64
>>>
>>> Steps to reproduce the BUG:
>>>
>>> 1. Create a new 4-disk RAID6 array, create a file system and mount it:
>>>    mdadm /dev/md0 --create -l 6 -n 4 /dev/sd[bcde]
>>>    mkfs.ext4 /dev/md0
>>>    mount /dev/md0 /mnt
>>> 2. Store some data (a few GB should be fine) on the RAID6 arrays file
>>> system:
>>>    cp -r whatever /mnt
>>> 3. Fail a disk of the RAID6 array and remove it from the array:
>>>    mdadm /dev/md0 --fail /dev/sdd
>>>    mdadm /dev/md0 --remove /dev/sdd
>>> 4. Drop caches:
>>>    echo "3" > /proc/sys/vm/drop_caches
>>> 5. Compare data copied to the RAID6 array in step 2 with its source:
>>>    diff -r whatever /mnt/whatever
>>>    There should be no differences and no file system errors.
>>> 6. Add a new empty disk to the RAID6 array:
>>>    mdadm /dev/md0 --add /dev/sdf
>>> 7. RAID6 recovery should start now, wait for the RAID6 recovery to finish.
>>> 8. Drop caches again:
>>>    echo "3" > /proc/sys/vm/drop_caches
>>> 9. Compare data copied to the RAID6 array in step 2 with its source again:
>>>    diff -r whatever /mnt/whatever
>>>    diff now reports a lot of differences and the kernel log gets filled
>>> with file system errors. For example:
>>>    EXT4-fs warning (device md0): ext4_dirent_csum_verify:355: inode
>>> #918549: comm diff: No space for directory leaf checksum. Please run
>>> e2fsck -D.
>>>
>>> Reverting commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef from kernel
>>> 5.1.4 resolves the issues described above.
>>>
>>> Kind regards
>>> Thorsten
>>>
>>>
>>> --
>>> ___
>>>  |        | /                 E-Mail: linux@thorsten-knabe.de
>>>  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
>>>


-- 
___
 |        | /                 E-Mail: linux@thorsten-knabe.de
 |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
