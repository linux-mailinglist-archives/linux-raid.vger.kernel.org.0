Return-Path: <linux-raid+bounces-4550-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13274AFA901
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 03:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B83B8C82
	for <lists+linux-raid@lfdr.de>; Mon,  7 Jul 2025 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A721ABD4;
	Mon,  7 Jul 2025 01:32:49 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7120AF9C;
	Mon,  7 Jul 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851968; cv=none; b=VmJj1+dyAbvHBNax2IrCCgMHAEUr8xddO2DuvNR1ZWf6d0wXb4CResCu2UG/Hfw937h2OJJZv7Iei9aUykWhmhHglfSxn01wriHAJLzwv6bN64yMa7JQP9niJPnH5m3vH6qGU/uF7tZQqrQ1Kq+p6N6QvPRiOaSmiXMi2XDh2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851968; c=relaxed/simple;
	bh=HYK1oedwmLdwVlRLBg19mNSaqT3tblBIZs990YTzH9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mw9T215eZ8VtxPSxYvd/g53uvOm4Gx+bPzR3gcuu4ac5bwUGcVcJRWiRFiueMaaNuoA/WI/Bp8+OWBMOYjEOE4naKQ2rNFhG+t63N9epS7zJ+xnz1JGgy2GBMujf/XMbMx4vkFWo22oU+MdxLLRArgm15mtn+OxCl91eAA3zStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bb6Dl2njRzKHMh8;
	Mon,  7 Jul 2025 09:32:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D036E1A0C45;
	Mon,  7 Jul 2025 09:32:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCazI2to_nSRAw--.35890S4;
	Mon, 07 Jul 2025 09:32:37 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v5 00/15] md/md-bitmap: introduce CONFIG_MD_BITMAP
Date: Mon,  7 Jul 2025 09:26:56 +0800
Message-Id: <20250707012711.376844-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnSCazI2to_nSRAw--.35890S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1UXFWDKr4rtFyDGFyUJrb_yoW8Kw13pa
	9xt343uw13JFW2qFnxJFW8CF1rXwn7tF9Fkr92kw4rWFyUZF98Xr48KFy0yrykWryfXa43
	Jr15tr4xGr1rXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v5:
 - rebase on the top of md-6.17;
 - fix compile problem if md-mod is build as module;
 - fix two problems for lvm2 dm-raid tests, patch 5,13
 - other cleanups;
Changes in v4:
 - rebase on the top of other patchset;
Changes in v3:
 - update commit message.
Changes in v2:
 - don't export apis, and don't support build md-bitmap as module

Due to known performance issues with md-bitmap and the unreasonable
implementations like following:

 - self-managed pages, bitmap_storage->filemap;
 - self-managed IO submitting like filemap_write_page();
 - global spin_lock
 ...

I have decided not to continue optimizing based on the current bitmap
implementation, and plan to invent a new lock-less bitmap. And a new
kconfig option is a good way for isolation.

However, we still encourage anyone who wants to continue optimizing the
current implementation

Yu Kuai (15):
  md/raid1: change r1conf->r1bio_pool to a pointer type
  md/raid1: remove struct pool_info and related code
  md/md-bitmap: remove the parameter 'init' for bitmap_ops->resize()
  md/md-bitmap: merge md_bitmap_group into bitmap_operations
  md/md-bitmap: add a new parameter 'flush' to bitmap_ops->enabled
  md/md-bitmap: add md_bitmap_registered/enabled() helper
  md/md-bitmap: handle the case bitmap is not enabled before
    start_sync()
  md/md-bitmap: handle the case bitmap is not enabled before end_sync()
  md/raid1: check bitmap before behind write
  md/raid1: check before referencing mddev->bitmap_ops
  md/raid10: check before referencing mddev->bitmap_ops
  md/raid5: check before referencing mddev->bitmap_ops
  md/dm-raid: check before referencing mddev->bitmap_ops
  md: check before referencing mddev->bitmap_ops
  md/md-bitmap: introduce CONFIG_MD_BITMAP

 drivers/md/Kconfig      |  18 +++++
 drivers/md/Makefile     |   3 +-
 drivers/md/dm-raid.c    |  18 +++--
 drivers/md/md-bitmap.c  |  74 +++++++++---------
 drivers/md/md-bitmap.h  |  62 ++++++++++++++-
 drivers/md/md-cluster.c |   2 +-
 drivers/md/md.c         | 112 +++++++++++++++++++--------
 drivers/md/md.h         |   4 +-
 drivers/md/raid1-10.c   |   2 +-
 drivers/md/raid1.c      | 163 +++++++++++++++++++---------------------
 drivers/md/raid1.h      |  22 +-----
 drivers/md/raid10.c     |  49 ++++++------
 drivers/md/raid5.c      |  30 ++++----
 13 files changed, 330 insertions(+), 229 deletions(-)

-- 
2.39.2


