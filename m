Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13597224A40
	for <lists+linux-raid@lfdr.de>; Sat, 18 Jul 2020 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGRJ2Q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 18 Jul 2020 05:28:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgGRJ2P (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 18 Jul 2020 05:28:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D1F61F8418634446E78;
        Sat, 18 Jul 2020 17:28:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Jul 2020
 17:28:04 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v7 2/3] md/raid5: set default stripe_size as 4096
Date:   Sat, 18 Jul 2020 05:29:08 -0400
Message-ID: <20200718092909.4020424-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200718092909.4020424-1-yuyufen@huawei.com>
References: <20200718092909.4020424-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In RAID5, if issued bio size is bigger than stripe_size, it will be
split in the unit of stripe_size and process them one by one. Even
for size less then stripe_size, RAID5 also request data from disk at
least of stripe_size.

Nowdays, stripe_size is equal to the value of PAGE_SIZE. Since filesystem
usually issue bio in the unit of 4KB, there is no problem for PAGE_SIZE
as 4KB. But, for 64KB PAGE_SIZE, bio from filesystem requests 4KB data
while RAID5 issue IO at least stripe_size (64KB) each time. That will
waste resource of disk bandwidth and compute xor.

To avoding the waste, we want to make stripe_size configurable. This
patch just set default stripe_size as 4096. User can also set the value
bigger than 4KB for some special requirements, such as we know the
issued io size is more than 4KB.

To evaluate the new feature, we create raid5 device '/dev/md5' with
4 SSD disk and test it on arm64 machine with 64KB PAGE_SIZE.

1) We format /dev/md5 with mkfs.ext4 and mount ext4 with default
 configure on /mnt directory. Then, trying to test it by dbench with
 command: dbench -D /mnt -t 1000 10. Result show as:

 'stripe_size = 64KB'

  Operation      Count    AvgLat    MaxLat
  ----------------------------------------
  NTCreateX    9805011     0.021    64.728
  Close        7202525     0.001     0.120
  Rename        415213     0.051    44.681
  Unlink       1980066     0.079    93.147
  Deltree          240     1.793     6.516
  Mkdir            120     0.004     0.007
  Qpathinfo    8887512     0.007    37.114
  Qfileinfo    1557262     0.001     0.030
  Qfsinfo      1629582     0.012     0.152
  Sfileinfo     798756     0.040    57.641
  Find         3436004     0.019    57.782
  WriteX       4887239     0.021    57.638
  ReadX        15370483     0.005    37.818
  LockX          31934     0.003     0.022
  UnlockX        31933     0.001     0.021
  Flush         687205    13.302   530.088

 Throughput 307.799 MB/sec  10 clients  10 procs  max_latency=530.091 ms
 -------------------------------------------------------

 'stripe_size = 4KB'

  Operation      Count    AvgLat    MaxLat
  ----------------------------------------
  NTCreateX    11999166     0.021    36.380
  Close        8814128     0.001     0.122
  Rename        508113     0.051    29.169
  Unlink       2423242     0.070    38.141
  Deltree          300     1.885     7.155
  Mkdir            150     0.004     0.006
  Qpathinfo    10875921     0.007    35.485
  Qfileinfo    1905837     0.001     0.032
  Qfsinfo      1994304     0.012     0.125
  Sfileinfo     977450     0.029    26.489
  Find         4204952     0.019     9.361
  WriteX       5981890     0.019    27.804
  ReadX        18809742     0.004    33.491
  LockX          39074     0.003     0.025
  UnlockX        39074     0.001     0.014
  Flush         841022    10.712   458.848

 Throughput 376.777 MB/sec  10 clients  10 procs  max_latency=458.852 ms
 -------------------------------------------------------

 It show that setting stripe_size as 4KB has higher thoughput, i.e.
 (376.777 vs 307.799) and has smaller latency than that setting as 64KB.

 2) We try to evaluate IO throughput for /dev/md5 by fio with config:

 [4KB randwrite]
 direct=1
 numjob=2
 iodepth=64
 ioengine=libaio
 filename=/dev/md5
 bs=4KB
 rw=randwrite

 [64KB write]
 direct=1
 numjob=2
 iodepth=64
 ioengine=libaio
 filename=/dev/md5
 bs=1MB
 rw=write

 The result as follow:

               +                   +
               | stripe_size(64KB) | stripe_size(4KB)
 +----------------------------------------------------+
 4KB randwrite |     15MB/s        |      100MB/s
 +----------------------------------------------------+
 1MB write     |   1000MB/s        |      700MB/s

 The result show that when size of io is bigger than 4KB (64KB),
 64KB stripe_size has much higher IOPS. But for 4KB randwrite, that
 means, size of io issued to device are smaller, 4KB stripe_size
 have better performance.

Normally, default value (4096) can get relatively good performance.
But if each issued io is bigger than 4096, setting value more than
4096 may get better performance.

Here, we just set default stripe_size as 4096, and we will try to
support setting different stripe_size by sysfs interface in the
following patch.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c |  5 +++++
 drivers/md/raid5.h | 22 +++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 18f20f3d9664..60cfa397f2d6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6943,6 +6943,11 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	if (conf == NULL)
 		goto abort;
 
+#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
+	conf->stripe_size = DEFAULT_STRIPE_SIZE;
+	conf->stripe_shift = ilog2(DEFAULT_STRIPE_SIZE) - 9;
+	conf->stripe_sectors = DEFAULT_STRIPE_SIZE >> 9;
+#endif
 	INIT_LIST_HEAD(&conf->free_list);
 	INIT_LIST_HEAD(&conf->pending_list);
 	conf->pending_data = kcalloc(PENDING_IO_MAX,
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index ca21f30e31da..7fb3b26a181a 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -472,9 +472,14 @@ struct disk_info {
  */
 
 #define NR_STRIPES		256
+#define DEFAULT_STRIPE_SIZE	4096
+
+#if PAGE_SIZE == DEFAULT_STRIPE_SIZE
 #define STRIPE_SIZE		PAGE_SIZE
 #define STRIPE_SHIFT		(PAGE_SHIFT - 9)
 #define STRIPE_SECTORS		(STRIPE_SIZE>>9)
+#endif
+
 #define	IO_THRESHOLD		1
 #define BYPASS_THRESHOLD	1
 #define NR_HASH			(PAGE_SIZE / sizeof(struct hlist_head))
@@ -557,6 +562,11 @@ struct r5conf {
 	int			raid_disks;
 	int			max_nr_stripes;
 	int			min_nr_stripes;
+#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
+	unsigned long	stripe_size;
+	unsigned int	stripe_shift;
+	unsigned long	stripe_sectors;
+#endif
 
 	/* reshape_progress is the leading edge of a 'reshape'
 	 * It has value MaxSector when no reshape is happening
@@ -673,9 +683,15 @@ struct r5conf {
 	struct r5pending_data	*next_pending_data;
 };
 
-#define RAID5_STRIPE_SIZE(conf)       STRIPE_SIZE
-#define RAID5_STRIPE_SHIFT(conf)      STRIPE_SHIFT
-#define RAID5_STRIPE_SECTORS(conf)    STRIPE_SECTORS
+#if PAGE_SIZE == DEFAULT_STRIPE_SIZE
+#define RAID5_STRIPE_SIZE(conf)	STRIPE_SIZE
+#define RAID5_STRIPE_SHIFT(conf)	STRIPE_SHIFT
+#define RAID5_STRIPE_SECTORS(conf)	STRIPE_SECTORS
+#else
+#define RAID5_STRIPE_SIZE(conf)	((conf)->stripe_size)
+#define RAID5_STRIPE_SHIFT(conf)	((conf)->stripe_shift)
+#define RAID5_STRIPE_SECTORS(conf)	((conf)->stripe_sectors)
+#endif
 
 /* bio's attached to a stripe+device for I/O are linked together in bi_sector
  * order without overlap.  There may be several bio's per stripe+device, and
-- 
2.25.4

