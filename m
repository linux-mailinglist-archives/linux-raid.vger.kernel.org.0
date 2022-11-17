Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D139762CF1F
	for <lists+linux-raid@lfdr.de>; Thu, 17 Nov 2022 00:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiKPXuZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Nov 2022 18:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiKPXuR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Nov 2022 18:50:17 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C84AF06
        for <linux-raid@vger.kernel.org>; Wed, 16 Nov 2022 15:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=9HNQQ7vpqG7tbLU5LWomzVfWMMKNI2PFBkHz+ntg0fE=; b=MXxgpEe0wR5jIO5ye9roDhPjGS
        OhNh9La90/2QBh1QBEjyWiut8RhvtAH1uMFttZeR4JuFv9B3rrq9yDGHbwBAPp3DIJDPYvSBSkJPD
        2HfTulG4//epUbA/DFaSY0xt1vjP7xYuv2s7wrf6AhqVexa1n67luOKRfR3WvsSyqjc2zdLF3zvXy
        dKpixnn8ia8oml4yKd1WLDMFtQybxHSFTvZzu2Mk6F4qPRXshHUOwIBJuc0IQJxxSCxLy1mGhBrsU
        j5vXYFkQDujYeybul3DNxMmh1TTAKnXAbKa1gFKey7KjnUSw48dHhf5e4MAAb7HS6wpEC2O0Yzp/v
        FndeU4Zg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ovSAW-0043zU-O2; Wed, 16 Nov 2022 16:50:14 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ovSAW-000KnL-Ky; Wed, 16 Nov 2022 16:50:12 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-raid@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, Xiao Ni <xni@redhat.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Coly Li <colyli@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jonmichael Hands <jm@chia.net>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kinga Tanska <kinga.tanska@linux.intel.com>
Date:   Wed, 16 Nov 2022 16:50:05 -0700
Message-Id: <20221116235009.79875-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116235009.79875-1-logang@deltatee.com>
References: <20221116235009.79875-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-raid@vger.kernel.org, jes@trained-monkey.org, guoqing.jiang@linux.dev, xni@redhat.com, colyli@suse.de, chaitanyak@nvidia.com, jm@chia.net, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, mariusz.tkaczyk@linux.intel.com, kinga.tanska@linux.intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH mdadm v5 3/7] Create: Factor out add_disks() helpers
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The Create function is massive with a very large number of variables.
Reading and understanding the function is almost impossible. To help
with this, factor out the two pass loop that adds the disks to the array.

This moves about 160 lines into three new helper functions and removes
a bunch of local variables from the main Create function. The main new
helper function add_disks() does the two pass loop and calls into
add_disk_to_super() and update_metadata(). Factoring out the
latter two helpers also helps to reduce a ton of indentation.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Kinga Tanska <kinga.tanska@linux.intel.com>
---
 Create.c | 382 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 213 insertions(+), 169 deletions(-)

diff --git a/Create.c b/Create.c
index 8ded81dc265d..6a0446644e04 100644
--- a/Create.c
+++ b/Create.c
@@ -91,6 +91,214 @@ int default_layout(struct supertype *st, int level, int verbose)
 	return layout;
 }
 
+static int add_disk_to_super(int mdfd, struct shape *s, struct context *c,
+		struct supertype *st, struct mddev_dev *dv,
+		struct mdinfo *info, int have_container, int major_num)
+{
+	dev_t rdev;
+	int fd;
+
+	if (dv->disposition == 'j') {
+		info->disk.raid_disk = MD_DISK_ROLE_JOURNAL;
+		info->disk.state = (1<<MD_DISK_JOURNAL);
+	} else if (info->disk.raid_disk < s->raiddisks) {
+		info->disk.state = (1<<MD_DISK_ACTIVE) |
+			(1<<MD_DISK_SYNC);
+	} else {
+		info->disk.state = 0;
+	}
+
+	if (dv->writemostly == FlagSet) {
+		if (major_num == BITMAP_MAJOR_CLUSTERED) {
+			pr_err("Can not set %s --write-mostly with a clustered bitmap\n",dv->devname);
+			return 1;
+		} else {
+			info->disk.state |= (1<<MD_DISK_WRITEMOSTLY);
+		}
+
+	}
+
+	if (dv->failfast == FlagSet)
+		info->disk.state |= (1<<MD_DISK_FAILFAST);
+
+	if (have_container) {
+		fd = -1;
+	} else {
+		if (st->ss->external && st->container_devnm[0])
+			fd = open(dv->devname, O_RDWR);
+		else
+			fd = open(dv->devname, O_RDWR|O_EXCL);
+
+		if (fd < 0) {
+			pr_err("failed to open %s after earlier success - aborting\n",
+			       dv->devname);
+			return 1;
+		}
+		if (!fstat_is_blkdev(fd, dv->devname, &rdev))
+			return 1;
+		info->disk.major = major(rdev);
+		info->disk.minor = minor(rdev);
+	}
+	if (fd >= 0)
+		remove_partitions(fd);
+	if (st->ss->add_to_super(st, &info->disk, fd, dv->devname,
+				 dv->data_offset)) {
+		ioctl(mdfd, STOP_ARRAY, NULL);
+		return 1;
+	}
+	st->ss->getinfo_super(st, info, NULL);
+
+	if (have_container && c->verbose > 0)
+		pr_err("Using %s for device %d\n",
+		       map_dev(info->disk.major, info->disk.minor, 0),
+		       info->disk.number);
+
+	if (!have_container) {
+		/* getinfo_super might have lost these ... */
+		info->disk.major = major(rdev);
+		info->disk.minor = minor(rdev);
+	}
+
+	return 0;
+}
+
+static int update_metadata(int mdfd, struct shape *s, struct supertype *st,
+			   struct map_ent **map, struct mdinfo *info,
+			   char *chosen_name)
+{
+	struct mdinfo info_new;
+	struct map_ent *me = NULL;
+
+	/* check to see if the uuid has changed due to these
+	 * metadata changes, and if so update the member array
+	 * and container uuid.  Note ->write_init_super clears
+	 * the subarray cursor such that ->getinfo_super once
+	 * again returns container info.
+	 */
+	st->ss->getinfo_super(st, &info_new, NULL);
+	if (st->ss->external && is_container(s->level) &&
+	    !same_uuid(info_new.uuid, info->uuid, 0)) {
+		map_update(map, fd2devnm(mdfd),
+			   info_new.text_version,
+			   info_new.uuid, chosen_name);
+		me = map_by_devnm(map, st->container_devnm);
+	}
+
+	if (st->ss->write_init_super(st)) {
+		st->ss->free_super(st);
+		return 1;
+	}
+
+	/*
+	 * Before activating the array, perform extra steps
+	 * required to configure the internal write-intent
+	 * bitmap.
+	 */
+	if (info_new.consistency_policy == CONSISTENCY_POLICY_BITMAP &&
+	    st->ss->set_bitmap && st->ss->set_bitmap(st, info)) {
+		st->ss->free_super(st);
+		return 1;
+	}
+
+	/* update parent container uuid */
+	if (me) {
+		char *path = xstrdup(me->path);
+
+		st->ss->getinfo_super(st, &info_new, NULL);
+		map_update(map, st->container_devnm, info_new.text_version,
+			   info_new.uuid, path);
+		free(path);
+	}
+
+	flush_metadata_updates(st);
+	st->ss->free_super(st);
+
+	return 0;
+}
+
+static int add_disks(int mdfd, struct mdinfo *info, struct shape *s,
+		     struct context *c, struct supertype *st,
+		     struct map_ent **map, struct mddev_dev *devlist,
+		     int total_slots, int have_container, int insert_point,
+		     int major_num, char *chosen_name)
+{
+	struct mddev_dev *moved_disk = NULL;
+	int pass, raid_disk_num, dnum;
+	struct mddev_dev *dv;
+	struct mdinfo *infos;
+	int ret = 0;
+
+	infos = xmalloc(sizeof(*infos) * total_slots);
+	enable_fds(total_slots);
+	for (pass = 1; pass <= 2; pass++) {
+		for (dnum = 0, raid_disk_num = 0, dv = devlist; dv;
+		     dv = (dv->next) ? (dv->next) : moved_disk, dnum++) {
+			if (dnum >= total_slots)
+				abort();
+			if (dnum == insert_point) {
+				raid_disk_num += 1;
+				moved_disk = dv;
+				continue;
+			}
+			if (strcasecmp(dv->devname, "missing") == 0) {
+				raid_disk_num += 1;
+				continue;
+			}
+			if (have_container)
+				moved_disk = NULL;
+			if (have_container && dnum < total_slots - 1)
+				/* repeatedly use the container */
+				moved_disk = dv;
+
+			switch(pass) {
+			case 1:
+				infos[dnum] = *info;
+				infos[dnum].disk.number = dnum;
+				infos[dnum].disk.raid_disk = raid_disk_num++;
+
+				if (dv->disposition == 'j')
+					raid_disk_num--;
+
+				ret = add_disk_to_super(mdfd, s, c, st, dv,
+						&infos[dnum], have_container,
+						major_num);
+				if (ret)
+					goto out;
+
+				break;
+			case 2:
+				infos[dnum].errors = 0;
+
+				ret = add_disk(mdfd, st, info, &infos[dnum]);
+				if (ret) {
+					pr_err("ADD_NEW_DISK for %s failed: %s\n",
+					       dv->devname, strerror(errno));
+					if (errno == EINVAL &&
+					    info->array.level == 0) {
+						pr_err("Possibly your kernel doesn't support RAID0 layouts.\n");
+						pr_err("Either upgrade, or use --layout=dangerous\n");
+					}
+					goto out;
+				}
+				break;
+			}
+			if (!have_container &&
+			    dv == moved_disk && dnum != insert_point) break;
+		}
+
+		if (pass == 1) {
+			ret = update_metadata(mdfd, s, st, map, info,
+					      chosen_name);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	free(infos);
+	return ret;
+}
+
 int Create(struct supertype *st, char *mddev,
 	   char *name, int *uuid,
 	   int subdevs, struct mddev_dev *devlist,
@@ -117,7 +325,7 @@ int Create(struct supertype *st, char *mddev,
 	unsigned long long minsize = 0, maxsize = 0;
 	char *mindisc = NULL;
 	char *maxdisc = NULL;
-	int dnum, raid_disk_num;
+	int dnum;
 	struct mddev_dev *dv;
 	dev_t rdev;
 	int fail = 0, warn = 0;
@@ -126,14 +334,13 @@ int Create(struct supertype *st, char *mddev,
 	int missing_disks = 0;
 	int insert_point = subdevs * 2; /* where to insert a missing drive */
 	int total_slots;
-	int pass;
 	int rv;
 	int bitmap_fd;
 	int have_container = 0;
 	int container_fd = -1;
 	int need_mdmon = 0;
 	unsigned long long bitmapsize;
-	struct mdinfo info, *infos;
+	struct mdinfo info;
 	int did_default = 0;
 	int do_default_layout = 0;
 	int do_default_chunk = 0;
@@ -869,174 +1076,11 @@ int Create(struct supertype *st, char *mddev,
 		}
 	}
 
-	infos = xmalloc(sizeof(*infos) * total_slots);
-	enable_fds(total_slots);
-	for (pass = 1; pass <= 2; pass++) {
-		struct mddev_dev *moved_disk = NULL; /* the disk that was moved out of the insert point */
-
-		for (dnum = 0, raid_disk_num = 0, dv = devlist; dv;
-		     dv = (dv->next) ? (dv->next) : moved_disk, dnum++) {
-			int fd;
-			struct mdinfo *inf = &infos[dnum];
-
-			if (dnum >= total_slots)
-				abort();
-			if (dnum == insert_point) {
-				raid_disk_num += 1;
-				moved_disk = dv;
-				continue;
-			}
-			if (strcasecmp(dv->devname, "missing") == 0) {
-				raid_disk_num += 1;
-				continue;
-			}
-			if (have_container)
-				moved_disk = NULL;
-			if (have_container && dnum < info.array.raid_disks - 1)
-				/* repeatedly use the container */
-				moved_disk = dv;
-
-			switch(pass) {
-			case 1:
-				*inf = info;
-
-				inf->disk.number = dnum;
-				inf->disk.raid_disk = raid_disk_num++;
-
-				if (dv->disposition == 'j') {
-					inf->disk.raid_disk = MD_DISK_ROLE_JOURNAL;
-					inf->disk.state = (1<<MD_DISK_JOURNAL);
-					raid_disk_num--;
-				} else if (inf->disk.raid_disk < s->raiddisks)
-					inf->disk.state = (1<<MD_DISK_ACTIVE) |
-						(1<<MD_DISK_SYNC);
-				else
-					inf->disk.state = 0;
-
-				if (dv->writemostly == FlagSet) {
-					if (major_num == BITMAP_MAJOR_CLUSTERED) {
-						pr_err("Can not set %s --write-mostly with a clustered bitmap\n",dv->devname);
-						goto abort_locked;
-					} else
-						inf->disk.state |= (1<<MD_DISK_WRITEMOSTLY);
-				}
-				if (dv->failfast == FlagSet)
-					inf->disk.state |= (1<<MD_DISK_FAILFAST);
-
-				if (have_container)
-					fd = -1;
-				else {
-					if (st->ss->external &&
-					    st->container_devnm[0])
-						fd = open(dv->devname, O_RDWR);
-					else
-						fd = open(dv->devname, O_RDWR|O_EXCL);
-
-					if (fd < 0) {
-						pr_err("failed to open %s after earlier success - aborting\n",
-							dv->devname);
-						goto abort_locked;
-					}
-					if (!fstat_is_blkdev(fd, dv->devname, &rdev))
-						goto abort_locked;
-					inf->disk.major = major(rdev);
-					inf->disk.minor = minor(rdev);
-				}
-				if (fd >= 0)
-					remove_partitions(fd);
-				if (st->ss->add_to_super(st, &inf->disk,
-							 fd, dv->devname,
-							 dv->data_offset)) {
-					ioctl(mdfd, STOP_ARRAY, NULL);
-					goto abort_locked;
-				}
-				st->ss->getinfo_super(st, inf, NULL);
-
-				if (have_container && c->verbose > 0)
-					pr_err("Using %s for device %d\n",
-						map_dev(inf->disk.major,
-							inf->disk.minor,
-							0), dnum);
-
-				if (!have_container) {
-					/* getinfo_super might have lost these ... */
-					inf->disk.major = major(rdev);
-					inf->disk.minor = minor(rdev);
-				}
-				break;
-			case 2:
-				inf->errors = 0;
-
-				rv = add_disk(mdfd, st, &info, inf);
-
-				if (rv) {
-					pr_err("ADD_NEW_DISK for %s failed: %s\n",
-					       dv->devname, strerror(errno));
-					if (errno == EINVAL &&
-					    info.array.level == 0) {
-						pr_err("Possibly your kernel doesn't support RAID0 layouts.\n");
-						pr_err("Either upgrade, or use --layout=dangerous\n");
-					}
-					goto abort_locked;
-				}
-				break;
-			}
-			if (!have_container &&
-			    dv == moved_disk && dnum != insert_point) break;
-		}
-		if (pass == 1) {
-			struct mdinfo info_new;
-			struct map_ent *me = NULL;
-
-			/* check to see if the uuid has changed due to these
-			 * metadata changes, and if so update the member array
-			 * and container uuid.  Note ->write_init_super clears
-			 * the subarray cursor such that ->getinfo_super once
-			 * again returns container info.
-			 */
-			st->ss->getinfo_super(st, &info_new, NULL);
-			if (st->ss->external && !is_container(s->level) &&
-			    !same_uuid(info_new.uuid, info.uuid, 0)) {
-				map_update(&map, fd2devnm(mdfd),
-					   info_new.text_version,
-					   info_new.uuid, chosen_name);
-				me = map_by_devnm(&map, st->container_devnm);
-			}
-
-			if (st->ss->write_init_super(st)) {
-				st->ss->free_super(st);
-				goto abort_locked;
-			}
-			/*
-			 * Before activating the array, perform extra steps
-			 * required to configure the internal write-intent
-			 * bitmap.
-			 */
-			if (info_new.consistency_policy ==
-				    CONSISTENCY_POLICY_BITMAP &&
-			    st->ss->set_bitmap &&
-			    st->ss->set_bitmap(st, &info)) {
-				st->ss->free_super(st);
-				goto abort_locked;
-			}
-
-			/* update parent container uuid */
-			if (me) {
-				char *path = xstrdup(me->path);
-
-				st->ss->getinfo_super(st, &info_new, NULL);
-				map_update(&map, st->container_devnm,
-					   info_new.text_version,
-					   info_new.uuid, path);
-				free(path);
-			}
+	if (add_disks(mdfd, &info, s, c, st, &map, devlist, total_slots,
+		      have_container, insert_point, major_num, chosen_name))
+		goto abort_locked;
 
-			flush_metadata_updates(st);
-			st->ss->free_super(st);
-		}
-	}
 	map_unlock(&map);
-	free(infos);
 
 	if (is_container(s->level)) {
 		/* No need to start.  But we should signal udev to
-- 
2.30.2

