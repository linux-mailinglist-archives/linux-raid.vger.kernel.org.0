Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEB350EEE
	for <lists+linux-raid@lfdr.de>; Thu,  1 Apr 2021 08:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhDAGRg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 1 Apr 2021 02:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhDAGRa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 1 Apr 2021 02:17:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E50C061788
        for <linux-raid@vger.kernel.org>; Wed, 31 Mar 2021 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=svtwyWZh8lE2SrMq5EIANMDYSuTYtqQjiXgR+54SJXU=; b=Kv6IvT0mlhAy5UsU2fUfjhjN3e
        seXD+H196XA6HYySJEyAzHXyXdvE8W3XcbtYRdMc39AOD+m33eRRHo6CdXSJ5EWNV1PspfMsnEpd5
        vK5FmWfQ3HNwAZ1quIjyNbXZVkDiicBYZ98keu4+LwEzlHUYW3sG5LOPxqpQQ37h0l2NktkL0bYTj
        yULrkjObhLISUlq4xrLrMBgCN70VE2Mv+6/4QSJywzTWf2VN82urONx+zTZyVN5cklEN9sRvBOULd
        VwKQZlyqV+6hW8UjztAZCWs18H4Up1b2j663y7ZDsVjiU4ELUNo5+I4qsP2N5haCTgHcAUr6A1nBa
        6fEk3BZw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRqdu-005hMz-RJ; Thu, 01 Apr 2021 06:17:24 +0000
Date:   Thu, 1 Apr 2021 07:17:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhao Heming <heming.zhao@suse.com>
Cc:     linux-raid@vger.kernel.org, song@kernel.org,
        guoqing.jiang@cloud.ionos.com, lidong.zhong@suse.com,
        xni@redhat.com, neilb@suse.de, colyli@suse.com
Subject: Re: [PATCH v2] md: don't create mddev in md_open
Message-ID: <20210401061722.GA1355765@infradead.org>
References: <1617240896-15343-1-git-send-email-heming.zhao@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <1617240896-15343-1-git-send-email-heming.zhao@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 01, 2021 at 09:34:56AM +0800, Zhao Heming wrote:
> commit d3374825ce57 ("md: make devices disappear when they are no longer
> needed.") introduced protection between mddev creating & removing. The
> md_open shouldn't create mddev when all_mddevs list doesn't contain
> mddev. With currently code logic, there will be very easy to trigger
> soft lockup in non-preempt env.

As mention below, please don't make this even more of a mess than it
needs to.  We can just pick the two patches doing this from the series
I sent:

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-md-factor-out-a-mddev_find_locked-helper-from-mddev_.patch"

From 86dfff895d62495120d8d61ef2bc5d48db89fe20 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 3 Mar 2021 15:04:15 +0100
Subject: md: factor out a mddev_find_locked helper from mddev_find

Factor out a self-contained helper to just lookup a mddev by the dev_t
"unit".

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 368cad6cd53a6e..5692427e78ba37 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -734,6 +734,17 @@ void mddev_init(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_init);
 
+static struct mddev *mddev_find_locked(dev_t unit)
+{
+	struct mddev *mddev;
+
+	list_for_each_entry(mddev, &all_mddevs, all_mddevs)
+		if (mddev->unit == unit)
+			return mddev;
+
+	return NULL;
+}
+
 static struct mddev *mddev_find(dev_t unit)
 {
 	struct mddev *mddev, *new = NULL;
@@ -745,13 +756,13 @@ static struct mddev *mddev_find(dev_t unit)
 	spin_lock(&all_mddevs_lock);
 
 	if (unit) {
-		list_for_each_entry(mddev, &all_mddevs, all_mddevs)
-			if (mddev->unit == unit) {
-				mddev_get(mddev);
-				spin_unlock(&all_mddevs_lock);
-				kfree(new);
-				return mddev;
-			}
+		mddev = mddev_find_locked(unit);
+		if (mddev) {
+			mddev_get(mddev);
+			spin_unlock(&all_mddevs_lock);
+			kfree(new);
+			return mddev;
+		}
 
 		if (new) {
 			list_add(&new->all_mddevs, &all_mddevs);
@@ -777,12 +788,7 @@ static struct mddev *mddev_find(dev_t unit)
 				return NULL;
 			}
 
-			is_free = 1;
-			list_for_each_entry(mddev, &all_mddevs, all_mddevs)
-				if (mddev->unit == dev) {
-					is_free = 0;
-					break;
-				}
+			is_free = !mddev_find_locked(dev);
 		}
 		new->unit = dev;
 		new->md_minor = MINOR(dev);
-- 
2.30.1


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-md-split-mddev_find.patch"

From f24462e5166808c4fd724f6b09233096d6ac1e56 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 3 Mar 2021 15:16:53 +0100
Subject: md: split mddev_find

Split mddev_find into a simple mddev_find that just finds an existing
mddev by the unit number, and a more complicated mddev_find that deals
with find or allocating a mddev.

This turns out to fix this bug reported by
Zhao Heming <heming.zhao@suse.com>:

------------------------------ snip ------------------------------
commit d3374825ce57 ("md: make devices disappear when they are no longer
needed.") introduced protection between mddev creating & removing. The
md_open shouldn't create mddev when all_mddevs list doesn't contain
mddev. With currently code logic, there will be very easy to trigger
soft lockup in non-preempt env.

*** env ***
kvm-qemu VM 2C1G with 2 iscsi luns
kernel should be non-preempt

*** script ***

about trigger 1 time with 10 tests

```
1  node1="15sp3-mdcluster1"
2  node2="15sp3-mdcluster2"
3
4  mdadm -Ss
5  ssh ${node2} "mdadm -Ss"
6  wipefs -a /dev/sda /dev/sdb
7  mdadm -CR /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda \
   /dev/sdb --assume-clean
8
9  for i in {1..100}; do
10    echo ==== $i ====;
11
12    echo "test  ...."
13    ssh ${node2} "mdadm -A /dev/md0 /dev/sda /dev/sdb"
14    sleep 1
15
16    echo "clean  ....."
17    ssh ${node2} "mdadm -Ss"
18 done
```

I use mdcluster env to trigger soft lockup, but it isn't mdcluster
speical bug. To stop md array in mdcluster env will do more jobs than
non-cluster array, which will leave enough time/gap to allow kernel to
run md_open.

*** stack ***

```
ID: 2831   TASK: ffff8dd7223b5040  CPU: 0   COMMAND: "mdadm"
 #0 [ffffa15d00a13b90] __schedule at ffffffffb8f1935f
 #1 [ffffa15d00a13ba8] exact_lock at ffffffffb8a4a66d
 #2 [ffffa15d00a13bb0] kobj_lookup at ffffffffb8c62fe3
 #3 [ffffa15d00a13c28] __blkdev_get at ffffffffb89273b9
 #4 [ffffa15d00a13c98] blkdev_get at ffffffffb8927964
 #5 [ffffa15d00a13cb0] do_dentry_open at ffffffffb88dc4b4
 #6 [ffffa15d00a13ce0] path_openat at ffffffffb88f0ccc
 #7 [ffffa15d00a13db8] do_filp_open at ffffffffb88f32bb
 #8 [ffffa15d00a13ee0] do_sys_open at ffffffffb88ddc7d
 #9 [ffffa15d00a13f38] do_syscall_64 at ffffffffb86053cb ffffffffb900008c

or:
[  884.226509]  mddev_put+0x1c/0xe0 [md_mod]
[  884.226515]  md_open+0x3c/0xe0 [md_mod]
[  884.226518]  __blkdev_get+0x30d/0x710
[  884.226520]  ? bd_acquire+0xd0/0xd0
[  884.226522]  blkdev_get+0x14/0x30
[  884.226524]  do_dentry_open+0x204/0x3a0
[  884.226531]  path_openat+0x2fc/0x1520
[  884.226534]  ? seq_printf+0x4e/0x70
[  884.226536]  do_filp_open+0x9b/0x110
[  884.226542]  ? md_release+0x20/0x20 [md_mod]
[  884.226543]  ? seq_read+0x1d8/0x3e0
[  884.226545]  ? kmem_cache_alloc+0x18a/0x270
[  884.226547]  ? do_sys_open+0x1bd/0x260
[  884.226548]  do_sys_open+0x1bd/0x260
[  884.226551]  do_syscall_64+0x5b/0x1e0
[  884.226554]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
```

*** rootcause ***

"mdadm -A" (or other array assemble commands) will start a daemon "mdadm
--monitor" by default. When "mdadm -Ss" is running, the stop action will
wakeup "mdadm --monitor". The "--monitor" daemon will immediately get
info from /proc/mdstat. This time mddev in kernel still exist, so
/proc/mdstat still show md device, which makes "mdadm --monitor" to open
/dev/md0.

The previously "mdadm -Ss" is removing action, the "mdadm --monitor"
open action will trigger md_open which is creating action. Racing is
happening.

```
<thread 1>: "mdadm -Ss"
md_release
  mddev_put deletes mddev from all_mddevs
  queue_work for mddev_delayed_delete
  at this time, "/dev/md0" is still available for opening

<thread 2>: "mdadm --monitor ..."
md_open
 + mddev_find can't find mddev of /dev/md0, and create a new mddev and
 |    return.
 + trigger "if (mddev->gendisk != bdev->bd_disk)" and return
      -ERESTARTSYS.
```

In non-preempt kernel, <thread 2> is occupying on current CPU. and
mddev_delayed_delete which was created in <thread 1> also can't be
schedule.

In preempt kernel, it can also trigger above racing. But kernel doesn't
allow one thread running on a CPU all the time. after <thread 2> running
some time, the later "mdadm -A" (refer above script line 13) will call
md_alloc to alloc a new gendisk for mddev. it will break md_open
statement "if (mddev->gendisk != bdev->bd_disk)" and return 0 to caller,
the soft lockup is broken.
------------------------------ snip ------------------------------

Fixes: d3374825ce57 ("md: make devices disappear when they are no longer needed.")
Reported-by: Zhao Heming <heming.zhao@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5692427e78ba37..08d24177bbd4a4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -746,6 +746,22 @@ static struct mddev *mddev_find_locked(dev_t unit)
 }
 
 static struct mddev *mddev_find(dev_t unit)
+{
+	struct mddev *mddev;
+
+	if (MAJOR(unit) != MD_MAJOR)
+		unit &= ~((1 << MdpMinorShift) - 1);
+
+	spin_lock(&all_mddevs_lock);
+	mddev = mddev_find_locked(unit);
+	if (mddev)
+		mddev_get(mddev);
+	spin_unlock(&all_mddevs_lock);
+
+	return mddev;
+}
+
+static struct mddev *mddev_find_or_alloc(dev_t unit)
 {
 	struct mddev *mddev, *new = NULL;
 
@@ -5650,7 +5666,7 @@ static int md_alloc(dev_t dev, char *name)
 	 * writing to /sys/module/md_mod/parameters/new_array.
 	 */
 	static DEFINE_MUTEX(disks_mutex);
-	struct mddev *mddev = mddev_find(dev);
+	struct mddev *mddev = mddev_find_or_alloc(dev);
 	struct gendisk *disk;
 	int partitioned;
 	int shift;
@@ -6530,11 +6546,9 @@ static void autorun_devices(int part)
 
 		md_probe(dev);
 		mddev = mddev_find(dev);
-		if (!mddev || !mddev->gendisk) {
-			if (mddev)
-				mddev_put(mddev);
+		if (!mddev)
 			break;
-		}
+
 		if (mddev_lock(mddev))
 			pr_warn("md: %s locked, cannot run\n", mdname(mddev));
 		else if (mddev->raid_disks || mddev->major_version
-- 
2.30.1


--7AUc2qLy4jB3hD7Z--
