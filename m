Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135341FAEEB
	for <lists+linux-raid@lfdr.de>; Tue, 16 Jun 2020 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFPLLe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Jun 2020 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPLLe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 16 Jun 2020 07:11:34 -0400
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B7C08C5C2
        for <linux-raid@vger.kernel.org>; Tue, 16 Jun 2020 04:11:31 -0700 (PDT)
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:167])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 8397C4A1F29;
        Tue, 16 Jun 2020 14:11:25 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by mxback6g.mail.yandex.net (mxback/Yandex) with ESMTP id devUuaWBiM-BPoKrcv2;
        Tue, 16 Jun 2020 14:11:25 +0300
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3LIUxIOV7v-BOL8j0Sg;
        Tue, 16 Jun 2020 14:11:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
From:   Michal Soltys <msoltyspl@yandex.pl>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl>
 <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl>
 <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl>
 <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
 <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl>
 <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
 <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
 <0cf6454d-a8b5-4bee-5389-94b23c077050@yandex.pl>
 <CAPhsuW51u6KWLvUntMXPU7stu7oSA+d-yT6zf7G0zCETzLWwiA@mail.gmail.com>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl>
 <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl>
Message-ID: <1b488097-249e-f479-71fe-6e8ce7319051@yandex.pl>
Date:   Tue, 16 Jun 2020 13:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/9/20 11:51 PM, Michal Soltys wrote:
> On 20/06/09 20:36, Song Liu wrote:
>> On Tue, Jun 9, 2020 at 2:36 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>>>
>>> On 6/5/20 2:26 PM, Michal Soltys wrote:
>>> > On 6/4/20 12:07 AM, Song Liu wrote:
>>> >>
>>> >> The hang happens at expected place.
>>> >>
>>> >>> [Jun 3 09:02] INFO: task mdadm:2858 blocked for more than 120 
>>> seconds.
>>> >>> [  +0.060545]       Tainted: G            E
>>> >>> 5.4.19-msl-00001-gbf39596faf12 #2
>>> >>> [  +0.062932] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> >>> disables this message.
>>> >>
>>> >> Could you please try disable the timeout message with
>>> >>
>>> >> echo 0 > /proc/sys/kernel/hung_task_timeout_secs
>>> >>
>>> >> And during this wait (after message
>>> >> "r5c_recovery_flush_data_only_stripes before wait_event"),
>>> >> checks whether the raid disks (not the journal disk) are taking IOs
>>> >> (using tools like iostat).
>>> >>
>>> >
>>> > No activity on component drives.
>>>
>>> To expand on that - while there is no i/o activity whatsoever at the 
>>> component drives (as well as journal), the cpu is of course still 
>>> fully loaded (5 days so far):
>>>
>>> UID        PID  PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
>>> root      8129  6755 15   740  1904  10 Jun04 pts/2    17:42:34 mdadm 
>>> -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdj1 /dev/sdi1 
>>> /dev/sdg1 /dev/sdh1
>>> root      8147     2 84     0     0  30 Jun04 ?        4-02:09:47 
>>> [md124_raid5]
>>
>> I guess the md thread stuck at some stripe. Does the kernel have
>> CONFIG_DYNAMIC_DEBUG enabled? If so, could you please try enable some 
>> pr_debug()
>> in function handle_stripe()?
>>
>> Thanks,
>> Song
>>
> 
> Massive spam in dmesg with messages like these:
> 
> [464836.603033] handling stripe 1551540328, state=0x41 cnt=1, pd_idx=3, 
> qd_idx=-1
>                  , check:0, reconstruct:0
> [464836.603036] handling stripe 1551540336, state=0x41 cnt=1, pd_idx=3, 
> qd_idx=-1
>                  , check:0, reconstruct:0
> [464836.603038] handling stripe 1551540344, state=0x41 cnt=1, pd_idx=3, 
> qd_idx=-1
>                  , check:0, reconstruct:0
> <cut>

So what should be the next step in debugging/fixing this ?
