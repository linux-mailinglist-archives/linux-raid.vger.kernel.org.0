Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38CC67F3B
	for <lists+linux-raid@lfdr.de>; Sun, 14 Jul 2019 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfGNOON (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Jul 2019 10:14:13 -0400
Received: from michael-notr.mail.tiscali.it ([213.205.33.216]:43056 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728146AbfGNOON (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 14 Jul 2019 10:14:13 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 10:14:10 EDT
Received: from [192.168.2.137] ([217.27.115.45])
        by michael.mail.tiscali.it with 
        id ce5i2001F0yqAhV01e5jkf; Sun, 14 Jul 2019 14:05:43 +0000
x-auth-user: farmatito@tiscali.it
From:   Tito <farmatito@tiscali.it>
Subject: Weird behaviour of md, maybe a bug in 4.19.xx kernel?
To:     linux-raid@vger.kernel.org
Message-ID: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
Date:   Sun, 14 Jul 2019 16:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1563113143; bh=989s5rsWmS3QU1VTQPsByzgmcCBNPX8EBQIoRFbKB8g=;
        h=From:Subject:To:Date;
        b=sNBWtA/q2TgwcZWhisbj1kv6rWfYqD6MSiVfEHdDVddmfAiRFm0yIjmTVlPvE3QfW
         miMp6WlUURLFQmR9m0yN+AfqeY+G0S1FNqeTSzetO2Vuo2FE+iHELkOeOKoZH7ztIi
         uKcH6XU53Qxh/L8b9c84YdlAuhsyDJpYhIvU2Z+Q=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,
I've got this email address from the MAINTAINERS file in the linux kernel
source, so I hope it is the right place to contact.
I'm running a debian/devuan system for a long time with several
md arrays on the embedded controller and on a ibm M1015 card
reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
My typical setup is:

Personalities : [raid6] [raid5] [raid4] [raid1] [linear] [multipath] [raid0] [raid10]
md5 : active raid1 sda2[3] sdk2[4](S) sdj2[2]
       9178112 blocks super 1.2 [2/2] [UU]

md4 : active raid1 sda1[3] sdk1[4](S) sdj1[2]
       966656000 blocks super 1.2 [2/2] [UU]
       bitmap: 3/8 pages [12KB], 65536KB chunk

md6 : active raid5 sde1[1] sdc1[4] sdd1[3](S) sdb1[0]
       1953260544 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UUU]
       bitmap: 0/8 pages [0KB], 65536KB chunk

md3 : active raid6 sdf1[0] sdh1[4](S) sdg1[6] sdl1[5] sdi1[7]
       624877568 blocks super 1.2 level 6, 512k chunk, algorithm 2 [4/4] [UUUU]
       bitmap: 0/3 pages [0KB], 65536KB chunk

At some point in time I've started to build my own kernels
with make bindeb-pkg. First kernel was 4.19.15 last was
4.19.58. This worked fine and flawless until 4.19.5*
(if i recall correctly) but I'm not really sure.
I started experiencing strange behavior of the raid5 and 6
arrays (meanwhile the raid1 arrays seem immune to the issue
or at least not so often affected).
The issue manifests itself with drives being marked as faulty
and being kicked out of the arrays. At first I thought it was
due to the old age (some had 40000 lifetime hours) and they not being
all enterprise drives, so some of them have no SCTERC/TLER and I
simply replaced them. But the issue kept coming back again
and again on drives that for smartctl were perfectly sane or new.
A typical syslog about the issue is:

Jul 14 07:54:00 debian anacron[20562]: Normal exit (2 jobs run)
Jul 14 07:54:12 debian kernel: [38809.927619] sd 2:0:6:0: [sdg] tag#580 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:12 debian kernel: [38809.927624] sd 2:0:6:0: [sdg] tag#580 Sense Key : Not Ready [current]
Jul 14 07:54:12 debian kernel: [38809.927627] sd 2:0:6:0: [sdg] tag#580 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:12 debian kernel: [38809.927632] sd 2:0:6:0: [sdg] tag#580 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
Jul 14 07:54:12 debian kernel: [38809.927641] print_req_error: I/O error, dev sdg, sector 2064
Jul 14 07:54:12 debian kernel: [38809.927644] md: super_written gets error=10
Jul 14 07:54:12 debian kernel: [38809.927649] md/raid:md3: Disk failure on sdg1, disabling device.
Jul 14 07:54:12 debian kernel: [38809.927649] md/raid:md3: Operation continuing on 3 devices.
Jul 14 07:54:12 debian kernel: [38809.975739] md: recovery of RAID array md3
Jul 14 07:54:13 debian mdadm[2768]: Fail event detected on md device /dev/md/3, component device /dev/sdg1
Jul 14 07:54:13 debian mdadm[2768]: RebuildStarted event detected on md device /dev/md/3

Jul 14 07:54:16 debian kernel: [38814.174666] mpt2sas_cm0: log_info(0x31110d01): originator(PL), code(0x11), sub_code(0x0d01)
Jul 14 07:54:16 debian kernel: [38814.187658] sd 2:0:4:0: [sde] tag#602 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187662] sd 2:0:4:0: [sde] tag#602 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.187665] sd 2:0:4:0: [sde] tag#602 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.187670] sd 2:0:4:0: [sde] tag#602 CDB: Read(10) 28 00 00 04 e2 f8 00 04 00 00
Jul 14 07:54:16 debian kernel: [38814.187672] print_req_error: I/O error, dev sde, sector 320248
Jul 14 07:54:16 debian kernel: [38814.187794] sd 2:0:4:0: [sde] tag#603 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187797] sd 2:0:4:0: [sde] tag#603 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.187800] sd 2:0:4:0: [sde] tag#603 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.187803] sd 2:0:4:0: [sde] tag#603 CDB: Read(10) 28 00 00 04 de f8 00 04 00 00
Jul 14 07:54:16 debian kernel: [38814.187805] print_req_error: I/O error, dev sde, sector 319224
Jul 14 07:54:16 debian kernel: [38814.187897] sd 2:0:4:0: [sde] tag#672 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187901] sd 2:0:4:0: [sde] tag#672 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.187903] sd 2:0:4:0: [sde] tag#672 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.187906] sd 2:0:4:0: [sde] tag#672 CDB: Read(10) 28 00 00 04 ea f8 00 01 40 00
Jul 14 07:54:16 debian kernel: [38814.187908] print_req_error: I/O error, dev sde, sector 322296
Jul 14 07:54:16 debian kernel: [38814.187935] sd 2:0:4:0: [sde] tag#673 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187938] sd 2:0:4:0: [sde] tag#673 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.187941] sd 2:0:4:0: [sde] tag#673 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.187944] sd 2:0:4:0: [sde] tag#673 CDB: Read(10) 28 00 00 04 e2 f8 00 00 08 00
Jul 14 07:54:16 debian kernel: [38814.187946] print_req_error: I/O error, dev sde, sector 320248
Jul 14 07:54:16 debian kernel: [38814.187956] sd 2:0:4:0: [sde] tag#674 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187959] sd 2:0:4:0: [sde] tag#674 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.187962] sd 2:0:4:0: [sde] tag#674 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.187965] sd 2:0:4:0: [sde] tag#674 CDB: Read(10) 28 00 00 04 e3 00 00 00 08 00
Jul 14 07:54:16 debian kernel: [38814.187966] print_req_error: I/O error, dev sde, sector 320256
Jul 14 07:54:16 debian kernel: [38814.187975] sd 2:0:4:0: [sde] tag#675 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187978] sd 2:0:4:0: [sde] tag#675 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.187981] sd 2:0:4:0: [sde] tag#675 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.187984] sd 2:0:4:0: [sde] tag#675 CDB: Read(10) 28 00 00 04 e3 08 00 00 08 00
Jul 14 07:54:16 debian kernel: [38814.187985] print_req_error: I/O error, dev sde, sector 320264
Jul 14 07:54:16 debian kernel: [38814.187994] sd 2:0:4:0: [sde] tag#676 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.187997] sd 2:0:4:0: [sde] tag#676 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.188000] sd 2:0:4:0: [sde] tag#676 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.188003] sd 2:0:4:0: [sde] tag#676 CDB: Read(10) 28 00 00 04 e3 10 00 00 08 00
Jul 14 07:54:16 debian kernel: [38814.188004] print_req_error: I/O error, dev sde, sector 320272
Jul 14 07:54:16 debian kernel: [38814.188012] sd 2:0:4:0: [sde] tag#677 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.188015] sd 2:0:4:0: [sde] tag#677 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.188018] sd 2:0:4:0: [sde] tag#677 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.188021] sd 2:0:4:0: [sde] tag#677 CDB: Read(10) 28 00 00 04 e3 18 00 00 08 00
Jul 14 07:54:16 debian kernel: [38814.188023] print_req_error: I/O error, dev sde, sector 320280
Jul 14 07:54:16 debian kernel: [38814.188030] sd 2:0:4:0: [sde] tag#603 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 14 07:54:16 debian kernel: [38814.188033] sd 2:0:4:0: [sde] tag#603 Sense Key : Not Ready [current]
Jul 14 07:54:16 debian kernel: [38814.188036] sd 2:0:4:0: [sde] tag#603 Add. Sense: Logical unit not ready, cause not reportable
Jul 14 07:54:16 debian kernel: [38814.188039] sd 2:0:4:0: [sde] tag#603 CDB: Read(10) 28 00 00 04 e3 20 00 00 08 00
Jul 14 07:54:16 debian kernel: [38814.188041] print_req_error: I/O error, dev sde, sector 320288
Jul 14 07:54:16 debian kernel: [38814.189818] md: super_written gets error=10
Jul 14 07:54:16 debian kernel: [38814.189822] md/raid:md3: Disk failure on sde1, disabling device.
Jul 14 07:54:16 debian kernel: [38814.189822] md/raid:md3: Operation continuing on 2 devices.
Jul 14 07:54:16 debian kernel: [38814.189841] md/raid:md3: read error not correctable (sector 319104 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189849] md/raid:md3: read error not correctable (sector 319112 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189863] md/raid:md3: read error not correctable (sector 319120 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189881] md/raid:md3: read error not correctable (sector 319128 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189895] md/raid:md3: read error not correctable (sector 319136 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189912] md/raid:md3: read error not correctable (sector 319144 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189930] md/raid:md3: read error not correctable (sector 319152 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189952] md/raid:md3: read error not correctable (sector 319160 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189968] md/raid:md3: read error not correctable (sector 319168 on sde1).
Jul 14 07:54:16 debian kernel: [38814.189984] md/raid:md3: read error not correctable (sector 319176 on sde1).
Jul 14 07:54:17 debian kernel: [38814.235581] md: md3: recovery interrupted.
Jul 14 07:54:17 debian kernel: [38814.327707] md: recovery of RAID array md3

Jul 14 07:56:46 debian kernel: [38964.179973] sd 2:0:4:0: Power-on or device reset occurred
Jul 14 07:56:47 debian kernel: [38965.179636] sd 2:0:6:0: Power-on or device reset occurred

I can grep the saved syslogs for more data if needed, what captured my attention at first were lots
of "Power-on or device reset occurred" messages in the logs.
So far I've double checked cabling changed a few drives but the problem remains.
In the end I reinstalled the debian/devuan kernel 4.9.168-1+deb9u3. This seems to fix the issue
and by re-adding two marked faulty drives I've experienced the fastest resync in my life:

Jul 14 10:15:08 debian kernel: [  274.987478] md: recovery of RAID array md3
Jul 14 10:15:08 debian kernel: [  274.987480] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
Jul 14 10:15:08 debian kernel: [  274.987482] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for recovery.
Jul 14 10:15:08 debian kernel: [  274.987486] md: using 128k window, over a total of 312438784k.
Jul 14 10:16:10 debian kernel: [  337.256371] md: md3: recovery done.

So I started to investigate what differences exists between 4.9 and 4.19 kernels by comparing the patches applied to the
drivers/md trees. The list of patches that are in 4.19 but not in 4.9 is:

2 hours	md: fix for divide error in status_resync	Mariusz Tkaczyk	1	-14/+22
4 days	md/raid0: Do not bypass blocking queue entered for raid0 bios	Guilherme G. Piccoli	1	-0/+2
11 days	dm log writes: make sure super sector log updates are written in order	zhangyi (F)	1	-2/+21
2019-06-19	bcache: only set BCACHE_DEV_WB_RUNNING when cached device attached	Coly Li	1	-1/+6
2019-05-31	bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYN...	Shenghui Wang	1	-0/+8
2019-05-25	dm mpath: always free attached_handler_name in parse_path()	Martin Wilck	1	-1/+1
2019-05-25	dm integrity: correctly calculate the size of metadata area	Mikulas Patocka	1	-2/+2
2019-05-25	dm zoned: Fix zone report handling	Damien Le Moal	1	-0/+5
2019-05-25	dm cache metadata: Fix loading discard bitset	Nikos Tsironis	1	-1/+8
2019-05-25	md: batch flush requests.	NeilBrown	2	-4/+26
2019-05-25	Revert "MD: fix lock contention for flush bios"	NeilBrown	2	-123/+62
2019-04-17	dm integrity: fix deadlock with overlapping I/O	Mikulas Patocka	1	-3/+1
2019-04-17	dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum errors	Ilya Dryomov	1	-0/+39
2019-04-17	dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES * PAGE_...	Mikulas Patocka	1	-9/+1
2019-04-17	dm integrity: change memcmp to strncmp in dm_integrity_ctr	Mikulas Patocka	1	-4/+4
2019-04-05	bcache: fix potential div-zero error of writeback_rate_p_term_inverse	Coly Li	1	-1/+3
2019-04-05	bcache: fix potential div-zero error of writeback_rate_i_term_inverse	Coly Li	1	-1/+3
2019-03-23	bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata	Coly Li	1	-3/+4
2019-03-23	dm integrity: limit the rate of error messages	Mikulas Patocka	1	-4/+4
2019-02-20	dm crypt: don't overallocate the integrity tag space	Mikulas Patocka	1	-1/+1
2019-02-20	md/raid1: don't clear bitmap bits on interrupted recovery.	Nate Dailey	1	-10/+18
2019-02-12	md: fix raid10 hang issue caused by barrier	Guoqing Jiang	1	-0/+4
2019-02-06	md/raid5: fix 'out of memory' during raid cache recovery	Alexei Naberezhnov	2	-13/+28
2019-01-31	dm crypt: fix parsing of extended IV arguments	Milan Broz	1	-8/+17
2019-01-26	dm crypt: use u64 instead of sector_t to store iv_offset	AliOS system sec

To my untrained eye nothing looks really suspicious but that could be due to my ignorance of kernel internals.
Having managed to make a good backup of my data I am willing to sacrifice my arrays for the science to debug the issue,
just I really don't know where to start as my self-taught C programming skills usually don't involve
kernel work.
Hints and guidance are really welcome.
Thanks in advance for your time and effort if you managed to read that far.

Best regards,
Tito Ragusa <farmatito@tiscali.it>
