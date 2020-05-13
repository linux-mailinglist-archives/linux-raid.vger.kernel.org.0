Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8C1D105A
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 12:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgEMK62 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgEMK62 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 May 2020 06:58:28 -0400
Received: from forward102p.mail.yandex.net (forward102p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5EC061A0C
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 03:58:28 -0700 (PDT)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id E707B1D4273F;
        Wed, 13 May 2020 13:58:22 +0300 (MSK)
Received: from mxback5q.mail.yandex.net (mxback5q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:b716:ad89])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id E30107080005;
        Wed, 13 May 2020 13:58:22 +0300 (MSK)
Received: from vla5-e763f15c6769.qloud-c.yandex.net (vla5-e763f15c6769.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:e763:f15c])
        by mxback5q.mail.yandex.net (mxback/Yandex) with ESMTP id 7aPBTSbmI7-wMi08CpO;
        Wed, 13 May 2020 13:58:22 +0300
Received: by vla5-e763f15c6769.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id oGyeAgR6dF-wLYGuOZ9;
        Wed, 13 May 2020 13:58:22 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
 <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
Date:   Wed, 13 May 2020 12:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/12/20 3:27 AM, Song Liu wrote:
> On Mon, May 11, 2020 at 4:13 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>>
>> On 5/10/20 1:57 AM, Michal Soltys wrote:
>>> Anyway, I did some tests with manually snapshotted component devices
>>> (using dm snapshot target to not touch underlying devices).
>>>
>>> The raid manages to force assemble in read-only mode with missing
>>> journal device, so we probably will be able to recover most data
>>> underneath this way (as a last resort).
>>>
>>> The situation I'm in now is likely from uncelan shutdown after all (why
>>> the machine failed to react to ups properly is another subject).
>>>
>>> I'd still want to find out why is - apparently - a journal device giving
>>> issues (contrary to what I'd expect it to do ...), with notable mention of:
>>>
>>> 1) mdadm hangs (unkillable, so I presume in kernel somewhere) and eats 1
>>> cpu when trying to assemble the raid with journal device present; once
>>> it happens I can't do anything with the array (stop, run, etc.) and can
>>> only reboot the server to "fix" that
>>>
>>> 2) mdadm -D shows nonsensical device size after assembly attempt (Used
>>> Dev Size : 18446744073709551615)
>>>
>>> 3) the journal device (which itself is md raid1 consisting of 2 ssds)
>>> assembles, checks (0 mismatch_cnt) fine - and overall looks ok.
>>>
>>>
>>>   From other interesting things, I also attempted to assemble the raid
>>> with snapshotted journal. From what I can see it does attempt to do
>>> something, judging from:
>>>
>>> dmsetup status:
>>>
>>> snap_jo2: 0 536870912 snapshot 40/33554432 16
>>> snap_sdi1: 0 7812500000 snapshot 25768/83886080 112
>>> snap_jo1: 0 536870912 snapshot 40/33554432 16
>>> snap_sdg1: 0 7812500000 snapshot 25456/83886080 112
>>> snap_sdj1: 0 7812500000 snapshot 25928/83886080 112
>>> snap_sdh1: 0 7812500000 snapshot 25352/83886080 112
>>>
>>> But it doesn't move from those values (with mdadm doing nothing eating
>>> 100% cpu as mentioned earlier).
>>>
>>>
>>> Any suggestions how to proceed would very be appreciated.
>>
>>
>> I've added Song to the CC. If you have any suggestions how to
>> proceed/debug this (mdadm stuck somewhere in kernel as far as I can see
>> - while attempting to assembly it).
>>
>> For the record, I can assemble the raid successfully w/o journal (using
>> snapshotted component devices as above), and we did recover some stuff
>> this way from some filesystems - but for some other ones I'd like to
>> keep that option as the very last resort.
> 
> Sorry for delayed response.
> 
> A few questions.
> 
> For these two outputs:
> #1
>                 Name : xs22:r5_big  (local to host xs22)
>                 UUID : d5995d76:67d7fabd:05392f87:25a91a97
>               Events : 56283
> 
>       Number   Major   Minor   RaidDevice State
>          -       0        0        0      removed
>          -       0        0        1      removed
>          -       0        0        2      removed
>          -       0        0        3      removed
> 
>          -       8      145        3      sync   /dev/sdj1
>          -       8      129        2      sync   /dev/sdi1
>          -       9      127        -      spare   /dev/md/xs22:r1_journal_big
>          -       8      113        1      sync   /dev/sdh1
>          -       8       97        0      sync   /dev/sdg1
> 
> #2
> /dev/md/r1_journal_big:
>             Magic : a92b4efc
>           Version : 1.1
>       Feature Map : 0x200
>        Array UUID : d5995d76:67d7fabd:05392f87:25a91a97
>              Name : xs22:r5_big  (local to host xs22)
>     Creation Time : Tue Mar  5 19:28:58 2019
>        Raid Level : raid5
>      Raid Devices : 4
> 
>    Avail Dev Size : 536344576 (255.75 GiB 274.61 GB)
>        Array Size : 11718355968 (11175.50 GiB 11999.60 GB)
>     Used Dev Size : 7812237312 (3725.17 GiB 3999.87 GB)
>       Data Offset : 262144 sectors
>      Super Offset : 0 sectors
>      Unused Space : before=261872 sectors, after=0 sectors
>             State : clean
>       Device UUID : c3a6f2f6:7dd26b0c:08a31ad7:cc8ed2a9
> 
>       Update Time : Sat May  9 15:05:22 2020
>     Bad Block Log : 512 entries available at offset 264 sectors
>          Checksum : c854904f - correct
>            Events : 56289
> 
>            Layout : left-symmetric
>        Chunk Size : 512K
> 
>      Device Role : Journal
>      Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> 
> 
> Are these captured back to back? I am asking because they showed different
> "Events" number.

Nah, they were captured between reboots. Back to back all event fields show identical value (at 56291 now).

> 
> Also, when mdadm -A hangs, could you please capture /proc/$(pidof mdadm)/stack ?
> 

The output is empty:

xs22:/☠ ps -eF fww | grep mdadm
root     10332  9362 97   740  1884  25 12:47 pts/1    R+     6:59  |   \_ mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdi1 /dev/sdg1 /dev/sdj1 /dev/sdh1
xs22:/☠ cd /proc/10332
xs22:/proc/10332☠ cat stack
xs22:/proc/10332☠ 


> 18446744073709551615 is 0xffffffffffffffffL, so it is not initialized
> by data from the disk.
> I suspect we hang somewhere before this value is initialized.
> 
