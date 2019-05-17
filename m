Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC7220A9
	for <lists+linux-raid@lfdr.de>; Sat, 18 May 2019 01:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfEQXLq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 May 2019 19:11:46 -0400
Received: from use.bitfolk.com ([85.119.80.223]:49783 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfEQXLq (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 May 2019 19:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=meJs/MjZubIKitmsSlbcM4Fl6nq8tB4waYCiqpbnDWg=;
        b=sK0dyjdfK3LJ5XF77pRFQrkNmQgWy0+wWQl5L2m92hnMKtjwlbFf0N3Li/J5HGA6xOeyvoNJoOS7OxRMSvHNo/DFQNcwhZGwtelcK6OXxX9Zrwq3QEyRpGB/7OHU1FXiTSu6F66GIJdlsmRNQ2lq1E5J9rE00gu5dDO7Bby6qGiluonKQ7qo7PCSELFCSnTy0BQ39Yjl3RDySzPlhaQJr+zrakjlnTC+YZo1FWLY0SPTOzmZYhpUGvmEdvHs+PtmeSpVM+iMPIsiLXtNLezg7gcbVZKXFOc4mw+VSdhwWG5FHOqGZF+pBFVmDt5FYE4GNRFgLl+eykGmoRSEoIUWmA==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hRm0t-00075o-Lq
        for linux-raid@vger.kernel.org; Fri, 17 May 2019 23:11:43 +0000
Date:   Fri, 17 May 2019 23:11:43 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: Is --write-mostly supposed to do anything for SSD- and
 NVMe-class devices?
Message-ID: <20190517231143.GL4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190517220436.GJ4569@bitfolk.com>
 <b6add019-67a2-846c-dbe3-3db2f2a6e962@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6add019-67a2-846c-dbe3-3db2f2a6e962@thelounge.net>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

On Sat, May 18, 2019 at 12:52:50AM +0200, Reindl Harald wrote:
> sdaly RAID10 don't support --write-mostly, otherwise i won't have bought
> 4 expensive 2 TB SSD's in the last two years.....

Interesting. It certainly looks like you are correct:

$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]

md4 : active raid1 sdc[1](W) nvme0n1[0]
      10485760 blocks super 1.2 [2/2] [UU]
[…]

$ /opt/fio/bin/fio --ioengine=libaio --direct=1 --gtod_reduce=1 --name=limoncello_ro_
mdwritemostly_4jobs --filename=/mnt/fio --bs=32k --iodepth=64 --numjobs=1 --size=8G -
-readwrite=randread --group_reporting
limoncello_ro_mdwritemostly_4jobs: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32
.0KiB-32.0KiB, (T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=64
fio-3.13-42-g8066f
Starting 1 process
limoncello_ro_mdwritemostly_4jobs: Laying out IO file (1 file / 8192MiB)
Jobs: 1 (f=1): [r(1)][100.0%][r=2439MiB/s][r=78.0k IOPS][eta 00m:00s]
limoncello_ro_mdwritemostly_4jobs: (groupid=0, jobs=1): err= 0: pid=24347: Fri May 17
 22:58:13 2019
  read: IOPS=77.0k, BW=2437MiB/s (2556MB/s)(8192MiB/3361msec)
   bw (  MiB/s): min= 2433, max= 2441, per=100.00%, avg=2438.45, stdev= 3.26, samples
=6
   iops        : min=77876, max=78130, avg=78030.33, stdev=104.35, samples=6
  cpu          : usr=7.02%, sys=36.13%, ctx=161966, majf=0, minf=519
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=2437MiB/s (2556MB/s), 2437MiB/s-2437MiB/s (2556MB/s-2556MB/s), io=8192MiB
 (8590MB), run=3361-3361msec

Disk stats (read/write):
    md4: ios=252936/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=131072/0
, aggrmerge=0/0, aggrticks=106599/0, aggrin_queue=106384, aggrutil=95.78%
  nvme0n1: ios=262144/0, merge=0/0, ticks=213198/0, in_queue=212768, util=95.78%
  sdc: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

(note no IOs to sdc)

But it actually gets faster when IOs are allowed to go to both!

$ echo -writemostly | sudo tee /sys/block/md4/md/dev-sdc/state
-writemostly
$ /opt/fio/bin/fio --ioengine=libaio --direct=1 --gtod_reduce=1 --name=limoncello_ro_
mdwritemostly_4jobs --filename=/mnt/fio --bs=32k --iodepth=64 --numjobs=1 --size=8G -
-readwrite=randread --group_reporting
limoncello_ro_mdwritemostly_4jobs: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32
.0KiB-32.0KiB, (T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=64
fio-3.13-42-g8066f
Starting 1 process
Jobs: 1 (f=1)
limoncello_ro_mdwritemostly_4jobs: (groupid=0, jobs=1): err= 0: pid=24385: Fri May 17
 22:59:44 2019
  read: IOPS=92.6k, BW=2894MiB/s (3034MB/s)(8192MiB/2831msec)
   bw (  MiB/s): min= 2888, max= 2904, per=100.00%, avg=2895.91, stdev= 6.50, samples
=5
   iops        : min=92434, max=92940, avg=92669.60, stdev=207.52, samples=5
  cpu          : usr=9.61%, sys=42.83%, ctx=120747, majf=0, minf=521
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=2894MiB/s (3034MB/s), 2894MiB/s-2894MiB/s (3034MB/s-3034MB/s), io=8192MiB
 (8590MB), run=2831-2831msec

Disk stats (read/write):
    md4: ios=245417/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=131067/0
, aggrmerge=4/0, aggrticks=89358/0, aggrin_queue=89192, aggrutil=94.99%
  nvme0n1: ios=215218/0, merge=0/0, ticks=88984/0, in_queue=88700, util=94.99%
  sdc: ios=46917/0, merge=9/0, ticks=89733/0, in_queue=89684, util=94.99%

(92.6k IOPS vs 77k IOPS)

It's also interesting that the exact same fio job against a RAID-10 only
achieves 36.2k IOPS:

$ sudo mdadm --create --verbose --assume-clean /dev/md4 --level=10 --raid-devices=2 --size=10G /dev/nvme0n1 /dev/sdc
mdadm: layout defaults to n2
mdadm: layout defaults to n2
mdadm: chunk size defaults to 512K
mdadm: largest drive (/dev/nvm0n1) exceeds size (10485760K) by more than 1%
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md4 started.
$ sudo mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/md4
mke2fs 1.44.5 (15-Dec-2018)
/dev/md4 contains a ext4 file system
        last mounted on /mnt on Fri May 17 22:55:53 2019
Proceed anyway? (y,N) y
Discarding device blocks: done
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: 22c2c0d1-494b-4435-8da2-114c868d966c
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

$ sudo mount /dev/md4 /mnt
$ sudo chown andy: /mnt
$ /opt/fio/bin/fio --ioengine=libaio --direct=1 --gtod_reduce=1 --name=limoncello_ro_mdwritemostly_4jobs --filename=/mnt/fio --bs=32k --iodepth=64 --numjobs=1 --size=8G --readwrite=randread --group_reporting
limoncello_ro_mdwritemostly_4jobs: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32.0KiB-32.0KiB, (T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=64
fio-3.13-42-g8066f
Starting 1 process
limoncello_ro_mdwritemostly_4jobs: Laying out IO file (1 file / 8192MiB)
Jobs: 1 (f=1): [r(1)][100.0%][r=1127MiB/s][r=36.1k IOPS][eta 00m:00s]
limoncello_ro_mdwritemostly_4jobs: (groupid=0, jobs=1): err= 0: pid=24570: Fri May 17 23:05:59 2019
  read: IOPS=36.2k, BW=1133MiB/s (1188MB/s)(8192MiB/7232msec)
   bw (  MiB/s): min= 1118, max= 1145, per=99.94%, avg=1132.12, stdev= 9.09, samples=14
   iops        : min=35786, max=36656, avg=36227.71, stdev=290.84, samples=14
  cpu          : usr=5.46%, sys=26.12%, ctx=189495, majf=0, minf=519
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=1133MiB/s (1188MB/s), 1133MiB/s-1133MiB/s (1188MB/s-1188MB/s), io=8192MiB (8590MB), run=7232-7232msec

Disk stats (read/write):
    md4: ios=260907/3, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=130711/4, aggrmerge=361/1, aggrticks=228765/8, aggrin_queue=126206, aggrutil=98.07%
  nvme0n1: ios=142323/4, merge=0/1, ticks=21914/0, in_queue=21392, util=96.50%
  sdc: ios=119099/5, merge=722/1, ticks=435617/17, in_queue=231020, util=98.07%

So maybe I should just be using RAID-1 of these and forget about
--write-mostly?

Should the non-implementation of --write-mostly on RAID-10 be
reported as a bug, since mdadm silently accepts it and reports its
use in /proc/mdstat?

Cheers,
Andy
