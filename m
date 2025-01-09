Return-Path: <linux-raid+bounces-3418-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475B4A06A8C
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2025 03:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA43A7605
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jan 2025 02:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B87DA88;
	Thu,  9 Jan 2025 02:02:05 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E77524C;
	Thu,  9 Jan 2025 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388125; cv=none; b=Ni69flFhD0PI8D18tsi64Xoykn9KufMJqeFPJs7BH+y32FREuta1pfFg72mUQubUWb9g/oW9mnEq3TG0t+9/aV4KfB40JX6cYiZ13iiNn5e1YWmC46UGNcbAjqtYhy/nIq9ZD+aYtWIohun0EIoLm1GRC5Uu1k0BjZotDpvIlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388125; c=relaxed/simple;
	bh=mnUCHlYsxeIqi1Cgibtn+SF/94oLHH3xtJdMiX7jkrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKffvI9/+BwJ3r8iq9DZY3pXMuq3G4WlfJW2QkkzNxB1Vyh+k5fnGklrNcIxoGFs++BPwL/TCjx4neumSQ4JMMFVegV3osxP0HqRV9jIcfY6GGa7iBLifMbyBLwLitgw5FYP2KWcHcK/tSkL0xZObFCqS+sUwh00MjPwLiy9VYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YT7Lp5jrYz4f3kvl;
	Thu,  9 Jan 2025 10:01:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 362631A1340;
	Thu,  9 Jan 2025 10:02:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8XLn9nqDrAAQ--.985S4;
	Thu, 09 Jan 2025 10:02:00 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 md-6.14 00/12] md/md-bitmap: introducet CONFIG_MD_BITMAP
Date: Thu,  9 Jan 2025 09:56:52 +0800
Message-Id: <20250109015704.216128-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8XLn9nqDrAAQ--.985S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWfJFyktry7tryrKFW7Arb_yoW8GrW8pa
	9xt34a9w15GFWavFnxJryjkFyrXr1xtasFkr97Cw4rWFyUZFy3Jr48GFW0y34qgryrJ3Zr
	Jr15Jw1xGry8Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - don't export apis, and don't support build md-bitmap as module

Yu Kuai (12):
  md/md-bitmap: remove the parameter 'init' for bitmap_ops->resize()
  md/md-bitmap: merge md_bitmap_group into bitmap_operations
  md/md-bitmap: add md_bitmap_registered/enabled() helper
  md/md-bitmap: handle the case bitmap is not enabled before
    start_sync()
  md/md-bitmap: handle the case bitmap is not enabled before end_sync()
  md/dm-raid: check if bitmap is registered in raid_ctr()
  md/raid1: check bitmap before behind write
  md/raid1: check before deferencing mddev->bitmap_ops
  md/raid10: check before deferencing mddev->bitmap_ops
  md/raid5: check before deferencing mddev->bitmap_ops
  md: check before deferencing mddev->bitmap_ops
  md/md-bitmap: introducet CONFIG_MD_BITMAP

 drivers/md/Kconfig      |  18 +++++
 drivers/md/dm-raid.c    |   5 +-
 drivers/md/md-bitmap.c  |  65 ++++++++---------
 drivers/md/md-bitmap.h  |  66 +++++++++++++++--
 drivers/md/md-cluster.c |   2 +-
 drivers/md/md.c         | 154 +++++++++++++++++++++++++++++++---------
 drivers/md/md.h         |   2 -
 drivers/md/raid1-10.c   |   2 +-
 drivers/md/raid1.c      |  79 ++++++++++++---------
 drivers/md/raid10.c     |  48 ++++++-------
 drivers/md/raid5.c      |  30 ++++----
 11 files changed, 325 insertions(+), 146 deletions(-)

-- 
2.39.2


