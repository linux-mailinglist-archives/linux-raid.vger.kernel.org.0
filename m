Return-Path: <linux-raid+bounces-5292-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F0B52A45
	for <lists+linux-raid@lfdr.de>; Thu, 11 Sep 2025 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5535A17940A
	for <lists+linux-raid@lfdr.de>; Thu, 11 Sep 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4B027A92F;
	Thu, 11 Sep 2025 07:41:23 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438F275B06;
	Thu, 11 Sep 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576483; cv=none; b=L4mEuL5UJYVjktwRSG6gcvh43SNGiEqYBB0Tco7IZGhrKJUD7goCJ7H5wWECWBVcW2vFtlSYiIYHbT6BwIkr/j/ItOjau/jH+VsNy80A5SUVXef3pb0AKkAQDGG0GJB74HZe7H72rgAhUmAfji42ZOxlYFWR5Q224NAtqR3t2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576483; c=relaxed/simple;
	bh=csZ+GoEnlez9E2uDU4rlu/nANlPIFDMYCGOgUvkeOHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aNvBkTq0VIue1gIuRCW5RyqRyXyg+jlg+DLzCo8yKYNAxOiPWfgGS5hTit6s8GQMjwgJ7oBQWJtTv0RtuHJU/CDGfHmhNb5EY95TlplumD2IjLoTNuuM55Cty5K45047Kkhz2y3kgdcRMW3OkasCjavaFHYEzqjmdD/q2N5MniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMqHb3Nj8zYQtty;
	Thu, 11 Sep 2025 15:41:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 001141A1755;
	Thu, 11 Sep 2025 15:41:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0XfcJorYmACA--.14632S4;
	Thu, 11 Sep 2025 15:41:13 +0800 (CST)
From: linan666@huaweicloud.com
To: corbet@lwn.net,
	song@kernel.org,
	yukuai3@huawei.com,
	linan122@huawei.com,
	xni@redhat.com,
	hare@suse.de
Cc: martin.petersen@oracle.com,
	bvanassche@acm.org,
	filipe.c.maia@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linan666@huaweicloud.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: [PATCH v4 0/2] make logical_block_size configurable
Date: Thu, 11 Sep 2025 15:31:42 +0800
Message-Id: <20250911073144.42160-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY0XfcJorYmACA--.14632S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr43WF15Jry7Cw4xtr47Arb_yoWDXFXE9a
	1xXrZ3Kr1I9F4xZay5urs3AFyUKF48u3s7ZF43Kr43u34avr18GFWv9r98Jw1kCFyjqF1U
	Gr1UJ3y8Ars8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw
	0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY2NKUUUU
	U
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

v4:
 patch 1: add fix tag.
 patch 2:
 - add documentation for sysfs.
 - only support metadata format 1.x.
 - do not call md_update_sb when writing sysfs. mddev->pers is NULL here.
 - return directly before hold lock in lbs_store.

v3:
 - logical_block_size must not exceed PAGE_SIZE for bio device.
 - Assign lim to mddev rather than to gendisk in mddev_stack_rdev_limits().
 - Remove the patch that modifies the return value.

v2: No new exported interfaces are introduced.

Li Nan (2):
  md: prevent adding disks with larger logical_block_size to active
    arrays
  md: allow configuring logical_block_size

 Documentation/admin-guide/md.rst |  7 +++
 drivers/md/md.h                  |  1 +
 include/uapi/linux/raid/md_p.h   |  3 +-
 drivers/md/md-linear.c           |  1 +
 drivers/md/md.c                  | 82 ++++++++++++++++++++++++++++++++
 drivers/md/raid0.c               |  1 +
 drivers/md/raid1.c               |  1 +
 drivers/md/raid10.c              |  1 +
 drivers/md/raid5.c               |  1 +
 9 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.39.2


