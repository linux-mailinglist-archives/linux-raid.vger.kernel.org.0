Return-Path: <linux-raid+bounces-3278-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9B9D33C9
	for <lists+linux-raid@lfdr.de>; Wed, 20 Nov 2024 07:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD06B2480F
	for <lists+linux-raid@lfdr.de>; Wed, 20 Nov 2024 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149A15990C;
	Wed, 20 Nov 2024 06:49:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50C15B14B
	for <linux-raid@vger.kernel.org>; Wed, 20 Nov 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085347; cv=none; b=WKzRkKoMkqTaRNbyosbogJlYXgCLDyKkWAPkVJoAFO9KTgQl6ud5ZiIZ4NMCD8h3mYKMXcopvNHAu4BPzsXutqkAEd2sm1cvkHaUIW6G8emO7xIWyMWix30WJ9rk3CY8Pfwy/gQAuDgi9rikUBl+gJu0nivOTGrPGwNytHYt/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085347; c=relaxed/simple;
	bh=ULHRvj1mA85MBsF/WtPDojfv1rE6ZTRkKC/05hi8kkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtA5jZ8cT8kZNYXKyB8+mshzWsTdQN1rjLljhk5AG+XCB+/vAcD09a/rYyziUg9bI/6ob73Wp34tYthL7UUncRC2mT3IrpZrZ/9DBJ81bfzJY6Hl2lqggFrXML1KpZB+oMOoeXiVtT6DFbuXqsXOtXkrYOTM/uOcZGTmHzcSAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XtX540HZ4z4f3l26
	for <linux-raid@vger.kernel.org>; Wed, 20 Nov 2024 14:48:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 73F091A018D
	for <linux-raid@vger.kernel.org>; Wed, 20 Nov 2024 14:48:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoJZhj1nRlQ5CQ--.45081S5;
	Wed, 20 Nov 2024 14:48:59 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mariusz.tkaczyk@linux.intel.com,
	linux-raid@vger.kernel.org
Cc: yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 1/4] tests/04update-uuid: remove bitmap file test
Date: Wed, 20 Nov 2024 14:46:34 +0800
Message-Id: <20241120064637.3657385-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241120064637.3657385-1-yukuai1@huaweicloud.com>
References: <20241120064637.3657385-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoJZhj1nRlQ5CQ--.45081S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4fJr45Cw17WF17AFyUtrb_yoW8uw4fpF
	43AFna9r1UG3yUXFyUA34kGFnxJFyDXr48A34SgFyfGas8urZYvry8uF1Sqw4UtrWvkw1k
	Z3WvyFWrXrW09wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07UAEfrUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Prepare to remove the bitmap file support.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/04update-uuid | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/tests/04update-uuid b/tests/04update-uuid
index 25314ab5..ce5a958c 100644
--- a/tests/04update-uuid
+++ b/tests/04update-uuid
@@ -22,40 +22,6 @@ mdadm -D /dev/md0 | grep -s > /dev/null 01234567:89abcdef:fedcba98:76543210 || {
 }
 mdadm -S /dev/md0
 
-
-# now if we have a bitmap, that needs updating too.
-rm -f $targetdir/bitmap
-yes | mdadm -CR --assume-clean -b $targetdir/bitmap $md0 -l5 -n3 $dev0 $dev1 $dev2
-mdadm -S /dev/md0
-mdadm -A /dev/md0 -b $targetdir/bitmap --update=uuid --uuid=0123456789abcdef:fedcba9876543210 $dev0 $dev1 $dev2
-no_errors
-mdadm -D /dev/md0 | grep -s > /dev/null 01234567:89abcdef:fedcba98:76543210 || {
-   echo Wrong uuid; mdadm -D /dev/md0 ; exit 2;
-}
-if mdadm -X $targetdir/bitmap | grep -s > /dev/null 01234567:89abcdef:fedcba98:76543210 ||
-   mdadm -X $targetdir/bitmap | grep -s > /dev/null 67452301:efcdab89:98badcfe:10325476
-then : ; else
-   echo Wrong uuid; mdadm -X $targetdir/bitmap ; exit 2;
-fi
-mdadm -S /dev/md0
-
-# and bitmap for version1
-rm -f $targetdir/bitmap
-yes | mdadm -CR --assume-clean -e1.1 -b $targetdir/bitmap $md0 -l5 -n3 $dev0 $dev1 $dev2
-mdadm -S /dev/md0
-mdadm -A /dev/md0 -b $targetdir/bitmap --update=uuid --uuid=0123456789abcdef:fedcba9876543210 $dev0 $dev1 $dev2
-no_errors
-mdadm -D /dev/md0 | grep -s > /dev/null 01234567:89abcdef:fedcba98:76543210 || {
-   echo Wrong uuid; mdadm -D /dev/md0 ; exit 2;
-}
-# -X cannot tell which byteorder to use for the UUID, so allow both.
-if mdadm -X $targetdir/bitmap | grep -s > /dev/null 01234567:89abcdef:fedcba98:76543210 ||
-   mdadm -X $targetdir/bitmap | grep -s > /dev/null 67452301:efcdab89:98badcfe:10325476
-then : ; else
-   echo Wrong uuid; mdadm -X $targetdir/bitmap ; exit 2;
-fi
-mdadm -S /dev/md0
-
 # Internal bitmaps too.
 mdadm -CR --assume-clean  -b internal --bitmap-chunk 4 $md0 -l5 -n3 $dev0 $dev1 $dev2
 mdadm -S /dev/md0
-- 
2.39.2


