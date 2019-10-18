Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCEDCEF9
	for <lists+linux-raid@lfdr.de>; Fri, 18 Oct 2019 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443220AbfJRTEQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 18 Oct 2019 15:04:16 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36310 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439950AbfJRTEP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 18 Oct 2019 15:04:15 -0400
Received: by mail-lj1-f177.google.com with SMTP id v24so7291708ljj.3
        for <linux-raid@vger.kernel.org>; Fri, 18 Oct 2019 12:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date:from
         :to:subject:user-agent:message-id;
        bh=Jvls31zmOiG6IbYQXPv+DcbDhOCI8bpG52hBhjvDxTM=;
        b=rzt72O1jBFhzH7cHn3eeEojMTdNBbTyVBAan3SAFSscH5+WyQpNsDpVcnzFW5372B7
         sGTGV0OOwc1firv/Amytx5CFbTtL9w6G4dH2t5p/7oZ7/jZLXyAsbe8Buxi6CcCZepZf
         3Nc4VEaKU6iF4U61zSXSZqzt/GOBqLjqyHGLpmaI0M0uqkuZyecIKvlrGKaF0dCVjbnI
         j/F7S7C/6SGvmg3I0qzGGSqjlpmphP8bd8hFn559LSFBkZT5FQ77/UuNIeIMZP8UiENX
         aMVRXzh/L+UE/mCE7UuiWqDmNP9hXxcXk2Qf7GMGuXxMnLPe9oWe+jdXooYcSIbSYfPA
         U5Yw==
X-Gm-Message-State: APjAAAXOoXANZYh07wr4oO9TM3NJXBtMkpFI8SNqK6dJn/fa6PSdgp4P
        teHnc7xK/FIRJMDztXVR91cNNAL+uHk=
X-Google-Smtp-Source: APXvYqyaAVE9AysKgFpKrzC7672Du53B2oM7vLuj3btlO/p6aTIvrTPfocPuN3ZjJ3SVNenQyLS8Zw==
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr6271964ljk.85.1571425449838;
        Fri, 18 Oct 2019 12:04:09 -0700 (PDT)
Received: from mail.onse.fi ([109.204.156.230])
        by smtp.gmail.com with ESMTPSA id 4sm3124501lfa.95.2019.10.18.12.04.08
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 12:04:08 -0700 (PDT)
Received: from mail.onse.fi (delta.onse.fi [127.0.0.1])
        by mail.onse.fi (Postfix) with ESMTP id B03234008A
        for <linux-raid@vger.kernel.org>; Fri, 18 Oct 2019 22:04:07 +0300 (EEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Oct 2019 22:04:07 +0300
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     linux-raid@vger.kernel.org
Subject: RAID6 gets stuck during reshape with 100% CPU
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <25373b220163b01b8990aa049fec9d18@iki.fi>
X-Sender: anssi.hannula@iki.fi
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

I'm seeing a reshape issue where the array gets stuck with requests 
seemingly getting blocked and md0_raid6 process taking 100% CPU whenever 
I --continue the reshape.

 From what I can tell, the md0_raid6 process is stuck processing a set of 
stripes over and over via handle_stripe() without progressing.

Log excerpt of one handle_stripe() of an affected stripe with some extra 
logging is below.
The 4600-5200 integers are line numbers for 
http://onse.fi/files/reshape-infloop-issue/raid5.c .

0x1401 = STRIPE_ACTIVE STRIPE_EXPANDING STRIPE_EXPAND_READY
0x1402 = STRIPE_HANDLE STRIPE_EXPANDING STRIPE_EXPAND_READY

0x813 = R5_UPTODATE R5_LOCKED R5_Insync R5_Expanded
0x811 = R5_UPTODATE R5_Insync R5_Expanded
0xa01 = R5_UPTODATE R5_ReadError R5_Expanded

[  499.262769] XX handle_stripe 4694, state 0x1402, reconstr 6
[  499.263376] XX handle_stripe 4703, state 0x1401, reconstr 6
[  499.263681] XX handle_stripe 4709, state 0x1401, reconstr 6
[  499.263988] XX handle_stripe 4713, state 0x1401, reconstr 6
[  499.264355] XX handle_stripe 4732, state 0x1401, reconstr 6
[  499.264657] handling stripe 198248960, state=0x1401 cnt=1, pd_idx=19, 
qd_idx=0
                , check:0, reconstruct:6
[  499.265304] check 19: state 0x813 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.265649] check 18: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.265978] check 17: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.266337] check 16: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.266658] check 15: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.266988] check 14: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.267335] check 13: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.267657] check 12: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.267985] check 11: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.268349] check 10: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.268670] check 9: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.269021] check 8: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.269371] check 7: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.269695] check 6: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.270027] check 5: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.270376] check 4: state 0xa01 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.270700] check 3: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.271031] check 2: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.271380] check 1: state 0x811 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.271707] check 0: state 0x813 read 000000000bfabb56 write 
000000000bfabb56 written 000000000bfabb56
[  499.272039] XX handle_stripe 4742, state 0x1401, reconstr 6
[  499.272410] XX handle_stripe 4746, state 0x1401, reconstr 6
[  499.272740] XX handle_stripe 4753, state 0x1401, reconstr 6
[  499.273093] XX handle_stripe 4765, state 0x1401, reconstr 6
[  499.273446] locked=2 uptodate=20 to_read=0 to_write=0 failed=10 
failed_num=18,17
[  499.273786] XX too many failed
[  499.274174] XX handle_stripe 4834, state 0x1401, reconstr 0
[  499.274523] XX handle_stripe 4847, state 0x1401, reconstr 0
[  499.274877] XX handle_stripe 4874, state 0x1401, reconstr 0
[  499.275250] XX handle_stripe 4882, state 0x1401, reconstr 0
[  499.275591] XX handle_stripe 4893, state 0x1401, reconstr 0
[  499.275939] XX handle_stripe 4923, state 0x1401, reconstr 0
[  499.276324] XX handle_stripe 4939, state 0x1401, reconstr 0
[  499.276666] XX handle_stripe 4956, state 0x1401, reconstr 0
[  499.277033] XX handle_stripe 4965, state 0x1401, reconstr 0
[  499.277399] XX handle_stripe 4990, state 0x1401, reconstr 0
[  499.277742] XX handle_stripe 5019, state 0x1401, reconstr 0
[  499.278090] handle_stripe: 5026
[  499.278477] XX handle_stripe 5035, state 0x1401, reconstr 3
[  499.278831] XX handle_stripe 5040, state 0x1401, reconstr 3
[  499.279198] XX handle_stripe 5043, state 0x1401, reconstr 3
[  499.279547] XX handle_stripe 5057, state 0x1401, reconstr 3
[  499.279898] XX handle_stripe 5087, state 0x1401, reconstr 3
[ ... raid_run_ops() call with STRIPE_OP_RECONSTRUCT ... ]
[  499.280292] XX handle_stripe 5091, state 0x1403, reconstr 6
[  499.280645] XX handle_stripe 5094, state 0x1403, reconstr 6
[  499.281042] XX handle_stripe 5108, state now 0x1402

More details:

- The reshape (level 6, raid-devices 21 => 20) was happening normally 
until almost the end when the array became at least partially 
unresponsive and I was not able to login anymore (/home is on the array) 
so I rebooted the system. Root FS is not on the array so any kernel 
errors should have been logged to journal - I did not see any kernel 
messages, though.

- The current issue now happens immediately whenever I run --grow 
--continue --backup-file=xx on the array.

- The reshape was started on Fedora's 5.2.17-200.fc30.x86_64, but I'm 
now debugging this on torvalds master from a couple of days ago 
(v5.4-rc3-1-g2abd839aa7e6).

- The above log excerpt has 10 devices indicated as "failed" (the array 
state is clean). Those devices all have the exact same 192 sectors in 
their MD bad blocks list, except for sdq which only has 40 sectors 
(subset of the 192). These seem to be bogus entries as I can dd-read the 
entire /dev/md0 just fine and I can read the reported sectors directly 
just fine with dd.

- A full log the above excerpt is from is at 
http://onse.fi/files/reshape-infloop-issue/dmesg.txt .

- Before I started the reshape, I had succesfully --replaced several 
members.

- Before I started the reshape, I had marked RAID member /dev/md8 with 
--replace (i.e. to be replaced once the reshape is complete and a spare 
is available).

- The array was originally 74230862272 kB long (21 devices of size 
3906887488 kB). My intention was to have it end up with 20 slightly 
larger members but the same total size, so I used --grow 
--size=4124036736 to increase the device size slightly, and then 
--array-size=74230862272K to reduce the available size back to original 
before starting the reshape. Note that the --array-size I used is 
smaller than the "actual" size after the reshape (74232661248 kB), in 
case it matters.

- I have not noticed any data loss, the array seems to be functioning 
properly after assembly until I run --grow --continue.

- I think "mdadm --assemble --backup-file=/xx" tries to start a 
continuation of the --grow operation in the background via systemd but 
fails because the --backup-file is not propagated to 
mdadm-grow-continue@.service. But in this case I guess it is a good 
thing as the array keeps being operational :) .. I guess 
--freeze-reshape would be the equivalent proper way to achieve this.

- System is Fedora 30 with mdadm 4.1rc2. --grow --continue on mdadm git 
master gives the same result.


So, regardless of how we ended up in this state, clearly there is at 
least some bug as getting stuck in an infinite loop should not happen - 
hopefully the cause can be determined, let me know if you need anything 
more, e.g. more detailed log prints.

I'd also like to get the array reshape to continue, of course :)


Array details (before running --grow --continue) and the --examine 
details of one component are below.
Examine output for all components is at 
http://onse.fi/files/reshape-infloop-issue/examine-all.txt .

/dev/md0:
            Version : 1.1
      Creation Time : Mon Jun  2 00:53:32 2014
         Raid Level : raid6
         Array Size : 74232661248 (70793.78 GiB 76014.25 GB)
      Used Dev Size : 4124036736 (3932.99 GiB 4223.01 GB)
       Raid Devices : 20
      Total Devices : 21
        Persistence : Superblock is persistent

      Intent Bitmap : Internal

        Update Time : Tue Oct 15 04:03:05 2019
              State : clean, reshaping
     Active Devices : 21
    Working Devices : 21
     Failed Devices : 0
      Spare Devices : 0

             Layout : left-symmetric
         Chunk Size : 64K

Consistency Policy : bitmap

     Reshape Status : 97% complete
      Delta Devices : -1, (21->20)

               Name : delta.onse.fi:delta  (local to host delta.onse.fi)
               UUID : b18ea5a9:fe91f26f:96b96dce:73a5d373
             Events : 27216022

     Number   Major   Minor   RaidDevice State
        0      66       32        0      active sync   /dev/sdai
        1      65       96        1      active sync   /dev/sdw
        2       8      192        2      active sync   /dev/sdm
        3      65       32        3      active sync   /dev/sds
       24      66       80        4      active sync   /dev/sdal
       23      66       64        5      active sync   /dev/sdak
       22       8      224        6      active sync   /dev/sdo
       28       9        8        7      active sync   /dev/md8
       16      65      144        8      active sync   /dev/sdz
        9      65       48        9      active sync   /dev/sdt
       10      65       16       10      active sync   /dev/sdr
       11      65       64       11      active sync   /dev/sdu
       27      65       80       12      active sync   /dev/sdv
       13      65        0       13      active sync   /dev/sdq
       25      66       48       14      active sync   /dev/sdaj
       15      65      128       15      active sync   /dev/sdy
       20      65      112       16      active sync   /dev/sdx
       26       8      160       17      active sync   /dev/sdk
       18       8      240       18      active sync   /dev/sdp
       17       8      208       19      active sync   /dev/sdn

       21       8      176       20      active sync   /dev/sdl

md0 : active raid6 sdai[0] sdl[21] sdn[17] sdp[18] sdk[26] sdx[20] 
sdy[15] sdaj[25] sdq[13] sdv[27] sdu[11] sdr[10] sdt[9] sdz[16] md8[28] 
sdo[22] sdak[23] sdal[24] sds[3] sdm[2] sdw[1]
       74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2 
[20/20] [UUUUUUUUUUUUUUUUUUUU]
       [===================>.]  reshape = 97.5% (4024886912/4124036736) 
finish=154611756.8min speed=0K/sec
       bitmap: 5/31 pages [20KB], 65536KB chunk

$ sudo mdadm --examine-badblocks /dev/sdal
Bad-blocks on /dev/sdal:
            198276520 for 88 sectors
            198503424 for 32 sectors
            198503600 for 8 sectors
            198503680 for 8 sectors
            198503808 for 8 sectors
            198503936 for 8 sectors
            198504576 for 8 sectors
            198504704 for 8 sectors
            198504832 for 8 sectors
            198504960 for 8 sectors
            198505088 for 8 sectors

$ sudo mdadm --examine /dev/sdal
/dev/sdal:
           Magic : a92b4efc
         Version : 1.1
     Feature Map : 0xd
      Array UUID : b18ea5a9:fe91f26f:96b96dce:73a5d373
            Name : delta.onse.fi:delta  (local to host delta.onse.fi)
   Creation Time : Mon Jun  2 00:53:32 2014
      Raid Level : raid6
    Raid Devices : 20

  Avail Dev Size : 8248073584 (3932.99 GiB 4223.01 GB)
      Array Size : 74232661248 (70793.78 GiB 76014.25 GB)
   Used Dev Size : 8248073472 (3932.99 GiB 4223.01 GB)
     Data Offset : 256000 sectors
    Super Offset : 0 sectors
    Unused Space : before=255928 sectors, after=7379723696 sectors
           State : active
     Device UUID : 7f100c8b:a7fb3d2d:e75224bf:229be6ff

Internal Bitmap : 8 sectors from superblock
   Reshape pos'n : 1784696832 (1702.02 GiB 1827.53 GB)
   Delta Devices : -1 (21->20)

     Update Time : Fri Oct 18 20:53:56 2019
   Bad Block Log : 512 entries available at offset 24 sectors - bad 
blocks present.
        Checksum : 8a873a9f - correct
          Events : 27357529

          Layout : left-symmetric
      Chunk Size : 64K

    Device Role : Active device 4
    Array State : AAAAAAAAAAAAAAAAAAAAA ('A' == active, '.' == missing, 
'R' == replacing)



-- 
Anssi Hannula
