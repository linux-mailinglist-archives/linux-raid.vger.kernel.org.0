Return-Path: <linux-raid+bounces-3349-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB009FC4EA
	for <lists+linux-raid@lfdr.de>; Wed, 25 Dec 2024 12:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440CF18839B7
	for <lists+linux-raid@lfdr.de>; Wed, 25 Dec 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13E1B4132;
	Wed, 25 Dec 2024 11:19:58 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029817BB3F;
	Wed, 25 Dec 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735125598; cv=none; b=RfnTk/EQKOK4Sv9xFtM9J+81jzPil2X+C0JeBjwP7NIBquztuzyQ/YOw/E027IP5NtC/RsP2VcjIgbTDBr2YbTyarPt70BR4+IHOwW00IS+BCt3B1WqPMirv6Pjqtjnr2maikIfgKN1dKDBh1G0iSDVdU3c0SbRVE+dwTzY876w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735125598; c=relaxed/simple;
	bh=mclR+Oyq8R5uqVMVB6MkCrDXXP5hYV8HOEdC+3CIDg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GD38OcHcWQj9CJ+wjlJn/lntTu1z23KDXbGgvB9ej0GwHnHXWk8/9V7K/19Zf8MkTxbTeCtiZcnsqZlB+qMp68xHuKpy4pr6WS9G5r3ry2TbxyXKH4paqZnUcO/QdBmakqiD/V5Q4mxWCFxDtg7DGKAOle7tvhKI+TEzpRBNy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YJ8RS5DSCz4f3jsC;
	Wed, 25 Dec 2024 19:19:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6FF371A058E;
	Wed, 25 Dec 2024 19:19:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnT4NV6mtntXlgFg--.39006S6;
	Wed, 25 Dec 2024 19:19:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.14 02/13] md/md-bitmap: merge md_bitmap_group into bitmap_operations
Date: Wed, 25 Dec 2024 19:15:35 +0800
Message-Id: <20241225111546.1833250-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241225111546.1833250-1-yukuai1@huaweicloud.com>
References: <20241225111546.1833250-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnT4NV6mtntXlgFg--.39006S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5CFWktFWrKF1DXF4ktFb_yoW5WryDpa
	9rJa43Zw1rJF45Xa17Z34DuFyrX3s7trZrKFWfC34F9Fy7XasxJr48Ga4UAw1qgFy3CFZI
	qw1Yyw1Uur18WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all bitmap implementations are internal, it doesn't make sense
to export md_bitmap_group anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 5 ++++-
 drivers/md/md-bitmap.h | 2 ++
 drivers/md/md.c        | 6 +++++-
 drivers/md/md.h        | 1 -
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 2f0158703ade..bf6de7ad3b6a 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2977,7 +2977,8 @@ static struct attribute *md_bitmap_attrs[] = {
 	&max_backlog_used.attr,
 	NULL
 };
-const struct attribute_group md_bitmap_group = {
+
+static struct attribute_group md_bitmap_group = {
 	.name = "bitmap",
 	.attrs = md_bitmap_attrs,
 };
@@ -3013,6 +3014,8 @@ static struct bitmap_operations bitmap_ops = {
 	.copy_from_slot		= bitmap_copy_from_slot,
 	.set_pages		= bitmap_set_pages,
 	.free			= md_bitmap_free,
+
+	.group			= &md_bitmap_group,
 };
 
 void mddev_set_bitmap_ops(struct mddev *mddev)
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 6d1ab949ed95..5a2aa1324df0 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -109,6 +109,8 @@ struct bitmap_operations {
 			      sector_t *hi, bool clear_bits);
 	void (*set_pages)(void *data, unsigned long pages);
 	void (*free)(void *data);
+
+	struct attribute_group *group;
 };
 
 /* the bitmap API */
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c60ae2c70102..b3a9f749366b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5682,7 +5682,6 @@ static const struct attribute_group md_redundancy_group = {
 
 static const struct attribute_group *md_attr_groups[] = {
 	&md_default_group,
-	&md_bitmap_group,
 	NULL,
 };
 
@@ -5924,6 +5923,11 @@ struct mddev *md_alloc(dev_t dev, char *name)
 		return ERR_PTR(error);
 	}
 
+	if (mddev->bitmap_ops && mddev->bitmap_ops->group)
+		if (sysfs_create_group(&mddev->kobj, mddev->bitmap_ops->group))
+			pr_warn("md: cannot register extra bitmap attributes for %s\n",
+				mdname(mddev));
+
 	kobject_uevent(&mddev->kobj, KOBJ_ADD);
 	mddev->sysfs_state = sysfs_get_dirent_safe(mddev->kobj.sd, "array_state");
 	mddev->sysfs_level = sysfs_get_dirent_safe(mddev->kobj.sd, "level");
diff --git a/drivers/md/md.h b/drivers/md/md.h
index def808064ad8..87edf81c25b0 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -756,7 +756,6 @@ struct md_sysfs_entry {
 	ssize_t (*show)(struct mddev *, char *);
 	ssize_t (*store)(struct mddev *, const char *, size_t);
 };
-extern const struct attribute_group md_bitmap_group;
 
 static inline struct kernfs_node *sysfs_get_dirent_safe(struct kernfs_node *sd, char *name)
 {
-- 
2.39.2


