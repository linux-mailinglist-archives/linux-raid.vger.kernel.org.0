Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C956D1E5CF8
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 12:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbgE1KSu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 06:18:50 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:37873 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387677AbgE1KSt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 06:18:49 -0400
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 2A01F67407F6;
        Thu, 28 May 2020 13:18:43 +0300 (MSK)
Received: from sas2-ee0cb368bd51.qloud-c.yandex.net (sas2-ee0cb368bd51.qloud-c.yandex.net [2a02:6b8:c08:b7a3:0:640:ee0c:b368])
        by mxback1g.mail.yandex.net (mxback/Yandex) with ESMTP id gBhXoKrA19-IhCCNc1K;
        Thu, 28 May 2020 13:18:43 +0300
Received: by sas2-ee0cb368bd51.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id oSTmMsILA7-IgWCHjjV;
        Thu, 28 May 2020 13:18:42 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
From:   Michal Soltys <msoltyspl@yandex.pl>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
 <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
 <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
 <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl>
 <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl>
 <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl>
Message-ID: <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
Date:   Thu, 28 May 2020 12:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/27/20 3:36 PM, Michal Soltys wrote:
> On 5/27/20 1:37 AM, Song Liu wrote:
>>
>> Looks like the kernel has processed about 1.2GB of journal (9b69bb8 -
>> 98f65b8 sectors).
>> And the limit is min(1/4 disk size, 10GB).
>>
>> I just checked the code, it should stop once it hits checksum
>> mismatch. Does it keep going
>> after half hour or so?
> 
> It keeps going so far (mdadm started few hours ago):
> 
> xs22:/home/msl☠ head -n 4 trace.out
> TIME     PID     TID     COMM            FUNC             -
> 12:58:21 40739   40739   mdadm           r5l_recovery_read_page 98f65b8
> 12:58:21 40739   40739   mdadm           r5l_recovery_read_page 98f65c0
> 12:58:21 40739   40739   mdadm           r5l_recovery_read_page 98f65c8
> xs22:/home/msl☠ tail -n 4 trace.out
> 15:34:50 40739   40739   mdadm           r5l_recovery_read_page bc04e88
> 15:34:50 40739   40739   mdadm           r5l_recovery_read_page bc04e90
> 15:34:50 40739   40739   mdadm           r5l_recovery_read_page bc04e98
> 

To expand on the above (mdadm was started yesterday):

- it went on for ~19+ hours - like previously
- the last piece in trace output:

xs22:/home/msl☠ tail -n 4 trace.out ; echo
09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8b0
09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8b8
09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8c0
09:08:12 40739   40739   mdadm           r5l_recovery_read_page 1852d8c8

So it went through ~120gb of journal (the journal device is 256gb).
Non-assembling raid issue aside (assuming it's unrelated) - why does it 
take such enormous amount of time ? That's average of like 1.7mb/s

Around 09:08 today, the recovery line popped in the dmesg as previously:

[May27 12:58] md: md124 stopped.
[  +0.006779] md/raid:md124: device sdf1 operational as raid disk 0
[  +0.006929] md/raid:md124: device sdj1 operational as raid disk 3
[  +0.006903] md/raid:md124: device sdi1 operational as raid disk 2
[  +0.006914] md/raid:md124: device sdh1 operational as raid disk 1
[  +0.007426] md/raid:md124: raid level 5 active with 4 out of 4 
devices, algorithm 2
[May28 09:08] md/raid:md124: recovering 24667 data-only stripes and 
50212 data-parity stripes
[May28 09:11] INFO: task mdadm:40739 blocked for more than 120 seconds.
[  +0.007304]       Not tainted 5.4.0-0.bpo.4-amd64 #1 Debian 
5.4.19-1~bpo10+1
[  +0.008008] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  +0.008858] mdadm           D    0 40739  40073 0x00004002
[  +0.006222] Call Trace:
[  +0.002870]  ? __schedule+0x2e6/0x6f0
[  +0.004194]  schedule+0x2f/0xa0
[  +0.003631]  r5l_start.cold.43+0x544/0x549 [raid456]
[  +0.005669]  ? finish_wait+0x80/0x80
[  +0.004108]  md_start.part.48+0x2e/0x50 [md_mod]
[  +0.005271]  do_md_run+0x64/0x100 [md_mod]
[  +0.004696]  md_ioctl+0xe7d/0x17d0 [md_mod]
[  +0.004783]  blkdev_ioctl+0x4d0/0xa00
[  +0.004211]  block_ioctl+0x39/0x40
[  +0.003896]  do_vfs_ioctl+0xa4/0x630
[  +0.004119]  ksys_ioctl+0x60/0x90
[  +0.003824]  __x64_sys_ioctl+0x16/0x20
[  +0.004288]  do_syscall_64+0x52/0x160
[  +0.004202]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.005765] RIP: 0033:0x7f5e2e777427
[  +0.004111] Code: Bad RIP value.
[  +0.003708] RSP: 002b:00007ffd39152d78 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  +0.008562] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 
00007f5e2e777427
[  +0.008083] RDX: 0000000000000000 RSI: 00000000400c0930 RDI: 
0000000000000004
[  +0.008081] RBP: 00007ffd39152ef0 R08: 000055641fb6ff40 R09: 
000055641de6ab60
[  +0.008301] R10: 0000000000000001 R11: 0000000000000246 R12: 
0000000000000004
[  +0.008085] R13: 0000000000000000 R14: 00007ffd391536a0 R15: 
0000000000000004
[May28 09:13] INFO: task mdadm:40739 blocked for more than 241 seconds.

The last dmesg call trace is from few hours ago:

[May28 09:29] INFO: task mdadm:40739 blocked for more than 1208 seconds.
[  +0.030944]       Not tainted 5.4.0-0.bpo.4-amd64 #1 Debian 
5.4.19-1~bpo10+1
[  +0.031885] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  +0.031088] mdadm           D    0 40739  40073 0x00004002
[  +0.028702] Call Trace:
[  +0.024943]  ? __schedule+0x2e6/0x6f0
[  +0.025448]  schedule+0x2f/0xa0
[  +0.025868]  r5l_start.cold.43+0x544/0x549 [raid456]
[  +0.027650]  ? finish_wait+0x80/0x80
[  +0.026630]  md_start.part.48+0x2e/0x50 [md_mod]
[  +0.027959]  do_md_run+0x64/0x100 [md_mod]
[  +0.026500]  md_ioctl+0xe7d/0x17d0 [md_mod]
[  +0.027326]  blkdev_ioctl+0x4d0/0xa00
[  +0.025951]  block_ioctl+0x39/0x40
[  +0.026311]  do_vfs_ioctl+0xa4/0x630
[  +0.026721]  ksys_ioctl+0x60/0x90
[  +0.025582]  __x64_sys_ioctl+0x16/0x20
[  +0.025665]  do_syscall_64+0x52/0x160
[  +0.024993]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.027166] RIP: 0033:0x7f5e2e777427
[  +0.024500] Code: Bad RIP value.
[  +0.024675] RSP: 002b:00007ffd39152d78 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  +0.028617] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 
00007f5e2e777427
[  +0.029175] RDX: 0000000000000000 RSI: 00000000400c0930 RDI: 
0000000000000004
[  +0.028890] RBP: 00007ffd39152ef0 R08: 000055641fb6ff40 R09: 
000055641de6ab60
[  +0.027863] R10: 0000000000000001 R11: 0000000000000246 R12: 
0000000000000004
[  +0.028962] R13: 0000000000000000 R14: 00007ffd391536a0 R15: 
0000000000000004
