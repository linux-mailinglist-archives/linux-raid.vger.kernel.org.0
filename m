Return-Path: <linux-raid+bounces-2479-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3B955CC3
	for <lists+linux-raid@lfdr.de>; Sun, 18 Aug 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E8C281BDE
	for <lists+linux-raid@lfdr.de>; Sun, 18 Aug 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C04204F;
	Sun, 18 Aug 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CHj9mkH/"
X-Original-To: linux-raid@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2077.outbound.protection.outlook.com [40.92.41.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7E947A;
	Sun, 18 Aug 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723988232; cv=fail; b=psVYVPptqlouuSpQMwsTNDQdk3yty09O/5OxKt+BEgshQHFX/HJ9ysg7O7LUfqfgzJFBnNEC2711UgJWgzZCJI+K6EXxoxj665CK1Oan7kLMkd4vhQHogrKpsJNxxKh10e5EcqY6vVUATirIf5brsYy0BdUh2PaR5IQT/6i1Ukw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723988232; c=relaxed/simple;
	bh=ezasEnURb1Nkt0F/hhGlV00GRr9ZBfBRAG/++J/qafM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SWC2Nkl/UH/AZBPZLnwrRYVLonlK7YUA3O9UsuB1ym6hDWJoW/TlfNF1PRllUPDtWMmDHy2T8xvyyo8cLab2mWgVQALkx+lbNeU2HIvMUPNi+FHYofHbUFlIRG43spM7mFfJYHtMS3HNlIugOJgoM/eh7lQO9BD4h5cd0zigPmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CHj9mkH/; arc=fail smtp.client-ip=40.92.41.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdo9+4cgrAS76u7tA3Ji/VZ4ZWKCLhRKvAGtW1sKd09J2rskkR/Pj6WAPAp4bz5SRzisFTmiTxrceVG8bO2Q68DKSUn4VNxwZZxOLXCarsSafWdReIq4XLTXn50gtDG3857i1QnKj4DNym3gTGQE4vcPpZk+lItG2ByPprOQItDy4HCN+1KWYs1INBnl4OiImLg+jG9h8O/T8nbNZ6y6gAGuWmoDxM+vsSDPw4kwrorT8BCgCDMpao8DkUD4UtRNKsknTRF82KgcT5rdJvdc2/u1hYqeLeh2ZMUECtZfELwYt72GwcSwdX5h0fX30H1y2MikAj7b0ICvXd5yqggxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voCvBVqSQa7AKBsnlfxISQ1nLaVp95w2S6QpDwGWoGk=;
 b=uVGayAeLvoA8cMM+vZERvEQsjyalz4T57AYMgR9XszGcCbMiDpRf+C+YWRXECb3LX6+D+6uKzO6Olnu6mi+b5Whry90EgXxLFHM+2Wle3pvV0+2FZBUiR+fvAL5FnZZjHTqoIa4k+o7EyherUkYoO9+XBAJnKOu8puHJcWZsIC6LVLK30xOZV6HEICzH35TrBkT12zDGE6p7BcVzBlrd7Xb3CxJXs8gNDPAmFgHEZFOtmutdqt8T3pVkR9hclC4Sw0Sk3Nd62xLhdxwvOhBkbvz318K365r3tVjh12DX1zVsksT/5+g/iNaP3xs1dybjPEYsxRWFA2+gwwIBppVT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voCvBVqSQa7AKBsnlfxISQ1nLaVp95w2S6QpDwGWoGk=;
 b=CHj9mkH/k+2w64KD37OHSG4w4tsBvg1s/QnJXB9JZh0GCMIpzU0fZYC/4ahAnyAkH0l2ZkT/fDHSN1e9ek3G7kA7vioYTwYiEbGlH8fyyenV+WknLUGip5SDFnPw3nSPM9TPpKOFJ5tRKBmcZ9b0HpqehaQk7o0tbXvdHX9wHmRy48FkdQggQ2bx8Z2HKItqgNGWzlfDExZekap7705oOP9wX74RPRUgWD71Wb0+mEFbad4zh0pbfQqKBCQoWEwq1J1u6AR+PZEQRQazMEoXo7SwL55tIrKNwfQsGHyet3LPblNxWNi/m4Kyod7W7KiZLcRb1wFu2auXVmK8Fn0Ghg==
Received: from SJ0PR10MB5741.namprd10.prod.outlook.com (2603:10b6:a03:3ec::20)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sun, 18 Aug
 2024 13:37:07 +0000
Received: from SJ0PR10MB5741.namprd10.prod.outlook.com
 ([fe80::51c4:f423:321e:5e1]) by SJ0PR10MB5741.namprd10.prod.outlook.com
 ([fe80::51c4:f423:321e:5e1%5]) with mapi id 15.20.7897.010; Sun, 18 Aug 2024
 13:37:07 +0000
From: Shushu Yi <teddyxym@outlook.com>
To: linux-raid@vger.kernel.org
Cc: song@kernel.org,
	yukuai3@huawei.com,
	linux-kernel@vger.kernel.org,
	paul.e.luse@intel.com,
	firnyee@gmail.com,
	hch@infradead.org,
	Yiming Xu <teddyxym@outlook.com>
Subject: [RFC V7] md/bitmap: Optimize lock contention.
Date: Sun, 18 Aug 2024 21:36:38 +0800
Message-ID:
 <SJ0PR10MB57411EB574BA6DD7EC82C557D8832@SJ0PR10MB5741.namprd10.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1JnzNHo/6PSe7kaUYIdYpULD2gWAZLQe]
X-ClientProxiedBy: PS2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:300:59::16) To SJ0PR10MB5741.namprd10.prod.outlook.com
 (2603:10b6:a03:3ec::20)
X-Microsoft-Original-Message-ID:
 <20240818133638.683828-1-teddyxym@outlook.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5741:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e3e62c-338d-4ac8-2162-08dcbf8ada54
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|15080799003|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	p7M0c/a7SPTxbMe0qkNZV8Z/XYQ9g3b+ahvs6WrC8mOSPjsA69dJ86sbY1IlfToeEWwlaaU8qDLg/e3C0HDEDEcUQDTDkfv3wg7a5DW7/+4IaMcyEv3rX1ZmMczLlLHgjMBG6Fkf5lsFrcMVMwpetwx2bBOl5gdGBQ+eeFYSE7cAdWAebN6nCifeu8RBYt3+axAOe5hCe4SkBim4JaF1/rAyq/7GbRMAW3qu1OzoGvvNbOJOJ0ol7NMBO2zniTM7GOxqfO+kQ86uKuqmB0IN6RS5/Svurap3ezE6GekF2In78jIHB2ybDar+kzrmhDpWghPpCmEd/+IPu+ImcGBQRgPkSdfC1SWqShNDmCFVEXXUL3rJJhtFh64BLT27D4hV9a+7bMqXFmWFlPcLHqtdMZYlRR/TsmePx9/vnDuMsL2mCmPSHmLR1Y5ST/iWsgVa9swrLckYtx62Neg7pT6kaj82vTuisvsTKEooQg91GF9WvAepk1WDXzMbkxAzJgbCFbFYDt2uTDSXGWf+vmAUKdeA18kEExidYGiI77joT1XBYyeUEgDJHpQU0J5jVtYbyM/VkKqrb7bPvAXEZ9HLh7xGuR3h0SXP6eDvwg4wq8Rz/qCcBMAeqUc/GKOCobH5Ih8zQ/GaTz4WqAZEvWs5CUpHoqp1XLktyyiwvBZaHRgl7SVHCxMQyC66rUASEPY51PrdskWdbkrjyoJdCNrjzoHOwb31FRTTphBp0RsDvLrSOaUOVTmyLBLlqfR6/V88s2u/QxSvFK9TsMlsKB+fsTEZKzfc8w8r7cgriZhfPPA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Me95FLjvR0o2dg5CJoEwSVmBfNjDp6tNqPTSgtMRan6Rvl6DlaAB5ZMd8j8J?=
 =?us-ascii?Q?aZXhdhi1pg4RXjRekKc/63OALgtceYfrzLGFr+10w39oWFumqdG6kaw9Mh2F?=
 =?us-ascii?Q?xnMnn5B2qVl1DBA91XUrTBP6MNsv/l5XLZEAWD5tW7/R9C6TOQVCTw2YxDmP?=
 =?us-ascii?Q?Fd/KXUD3reGGsiHLFLAH6FumyzVKctIG/Dkze/ITpZ+qYGj8aBtoWr5v51W9?=
 =?us-ascii?Q?WyfS/kfHH8tRvmrY6saureEGEgYlC52AcDxCY5VEbvVBbmRIXYn04Y8YX/Zh?=
 =?us-ascii?Q?jVN5LccYTcsV4wmf2ermmuJuejiALVY32JS9laDBIF3I3jG1GwObg6e7AtS6?=
 =?us-ascii?Q?LrM9A/VT5C68es3WqugyLZlkjdpcL7W/wWQVCzpe8/mJNu0uVQ6vyn4eli79?=
 =?us-ascii?Q?J36O125AiisDgwNusXylaSI2Ogf6TJGf+TkSC9HGhU/4Liburp5eDefnviQb?=
 =?us-ascii?Q?UDk7ZfeKa0t+ChbrhQCDbJzT39QFBysV/fbtiycre2QgZtC6UNDV+hKBOoLw?=
 =?us-ascii?Q?IEFPhCilZykvD2qgcgyR9/0iPl1NYgMPZx8Tv4Z7i/wvWCFVmoAlCZe1rErp?=
 =?us-ascii?Q?CI7+/PN3ZGanUsigWnGjpJOIRZwqSDteP44sVJl9gjsbens4MIWv9KadFLWq?=
 =?us-ascii?Q?/wIgsDVtXXtu52NhsgcBLtNCG/woVJWcMBcQ4P5mU2aVIdC7EI0dObuvT5sg?=
 =?us-ascii?Q?nJ4EqsMLUcVH97ZSLjlmJ706KguWgB3A9tzE1KgWa095VOfzZ405vElsTnJ8?=
 =?us-ascii?Q?4w6PmUuZxwzkybPjnTvbQ5/YyVdm20LUbO5GMhHcfD7x7JdbcwuktGonSXFc?=
 =?us-ascii?Q?WY2YXXXGYrSYdAttYujvUC6N8Jg7gsUwTD/meO0FJPF5mhtvlu5RRy29ekx7?=
 =?us-ascii?Q?y41mFJkqE97eGzkxsC0BNmwYJVgx4a9GHaWNfguc9C+urzXHQxavBPMwj4oE?=
 =?us-ascii?Q?2tBCACvZDql8FkoWugslsMH0XdIbq1D9tWPCMPdv69IlkQuPp+f9qmiJBpj6?=
 =?us-ascii?Q?BQdHukYAxNF6l8EJPEHHcN+nfm2WxnqiofLF1CCBpdYahmjtVUE7Jwxe53Lm?=
 =?us-ascii?Q?3T30Vdz2CSmlFhlwDt5X2OIhhiBBbJegO5Wpo7ssoGLnAoN947ufSBwVSp8s?=
 =?us-ascii?Q?lI/LXl+X6bx3cJ32LLM9s9r2+Bymomnq+VDCzGHBXDnVbYohUdOSGaJgpnz4?=
 =?us-ascii?Q?3hBAEF7DzeUh4YrLroNtdd4WUrXYss9hH1t14Fk1Ytn5nv4KsZI11BdkfU8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e3e62c-338d-4ac8-2162-08dcbf8ada54
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5741.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 13:37:07.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629

Optimize scattered address space. Achieves significant improvements in
both throughput and latency.

Maximize thread-level parallelism and reduce CPU suspension time caused
by lock contention. Achieve increased overall storage throughput by
89.4% on a system with four PCIe 4.0 SSDs. (Set the iodepth to 32 and
employ libaio. Configure the I/O size as 4 KB with sequential write and
16 threads. In RAID5 consist of 2+1 1TB Samsung 980Pro SSDs, throughput
went from 5218MB/s to 9884MB/s.)

Specifically:
Customize different types of lock structures (mlock and bmclocks) to
manage data and metadata by their own characteristics. Scatter each
segment across the entire address range in the storage such that CPU
threads can be interleaved to access different segments.
The counter lock is also used to protect the metadata update of the
counter table. Modifying both the counter values and their metadata
simultaneously can result in memory faults. mdraid rarely updates the
metadata of the counter table. Thus, employ a readers-writer lock
mechanism to protect the metadata, which can reap the most benefits
from this condition.
Before updating the metadata, the CPU thread acquires the writer lock.
Otherwise, if the CPU threads need to revise the counter values, they
apply for the reader locks and the counter locks successively.
Sequential stripe heads are spread across different locations in the
SSDs via a configurable hash function rather than mapping to a
continuous SSD space. Thus, sequential stripe heads are dispersed
uniformly across the whole space. Sequential write requests are
shuffled to access scattered space. Can effectively reduce the counter
preemption.

Note: Publish this work as a paper and provide the URL
(https://www.hotstorage.org/2022/camera-ready/hotstorage22-5/pdf/
hotstorage22-5.pdf).

Co-developed-by: Yiming Xu <teddyxym@outlook.com>
Signed-off-by: Yiming Xu <teddyxym@outlook.com>
Signed-off-by: Shushu Yi <firnyee@gmail.com>
Tested-by: Paul Luse <paul.e.luse@intel.com>
---
V1 -> V2: Cleaned up coding style and divided into 2 patches (HemiRAID
and ScalaRAID corresponding to the paper mentioned above). ScalaRAID
equipped every counter with a counter lock and employ our D-Block.
HemiRAID increased the number of stripe locks to 128
V2 -> V3: Adjusted the language used in the subject and changelog.
Since patch 1/2 in V2 cannot be used independently and does not
encompass all of our work, it has been merged into a single patch.
V3 -> V4: Fixed incorrect sending address and changelog format.
V4 -> V5: Resolved a adress conflict on main (commit
f0e729af2eb6bee9eb58c4df1087f14ebaefe26b (HEAD -> md-6.10, tag:
md-6.10-20240502, origin/md-6.10)).
V5 -> V6: Restored changes to the number of NR_STRIPE_HASH_LOCKS. Set
the maximum number of bmclocks (65536) to prevent excessive memory
usage. Optimized the number of bmclocks in RAID5 when the capacity of
each SSD is less than or equal to 4TB, and still performs well when
the capacity of each SSD is greater than 4TB.
V6 -> V7: Changed according to Song Liu's comments: redundant
"locktypes" were subtracted, unnecessary fixes were removed, NULL
Pointers were changed from "0" to "NULL", code comments were added, and
commit logs were refined.

---
 drivers/md/md-bitmap.c | 198 +++++++++++++++++++++++++++++++----------
 drivers/md/md-bitmap.h |  21 ++++-
 2 files changed, 169 insertions(+), 50 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 08232d8dc815..52958748f2a3 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -47,10 +47,12 @@ static inline char *bmname(struct bitmap *bitmap)
  * if we find our page, we increment the page's refcount so that it stays
  * allocated while we're using it
  */
-static int md_bitmap_checkpage(struct bitmap_counts *bitmap,
-			       unsigned long page, int create, int no_hijack)
-__releases(bitmap->lock)
-__acquires(bitmap->lock)
+static int md_bitmap_checkpage(struct bitmap_counts *bitmap, unsigned long page,
+			       int create, int no_hijack, spinlock_t *bmclock)
+__releases(bmclock)
+__acquires(bmclock)
+__releases(bitmap->mlock)
+__acquires(bitmap->mlock)
 {
 	unsigned char *mappage;
 
@@ -65,8 +67,10 @@ __acquires(bitmap->lock)
 		return -ENOENT;
 
 	/* this page has not been allocated yet */
-
-	spin_unlock_irq(&bitmap->lock);
+	if (bmclock)
+		spin_unlock_irq(bmclock); /* lock for bmc */
+	else
+		write_unlock_irq(&bitmap->mlock); /* lock for metadata */
 	/* It is possible that this is being called inside a
 	 * prepare_to_wait/finish_wait loop from raid5c:make_request().
 	 * In general it is not permitted to sleep in that context as it
@@ -81,7 +85,11 @@ __acquires(bitmap->lock)
 	 */
 	sched_annotate_sleep();
 	mappage = kzalloc(PAGE_SIZE, GFP_NOIO);
-	spin_lock_irq(&bitmap->lock);
+
+	if (bmclock)
+		spin_lock_irq(bmclock);  /* lock for bmc */
+	else
+		write_lock_irq(&bitmap->mlock); /* lock for metadata */
 
 	if (mappage == NULL) {
 		pr_debug("md/bitmap: map page allocation failed, hijacking\n");
@@ -1248,16 +1256,35 @@ void md_bitmap_write_all(struct bitmap *bitmap)
 static void md_bitmap_count_page(struct bitmap_counts *bitmap,
 				 sector_t offset, int inc)
 {
-	sector_t chunk = offset >> bitmap->chunkshift;
-	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
+    /*
+     * The stripe heads are spread across different locations in the
+     * SSDs via a configurable hash function rather than mapping to a
+     * continuous SSD space.
+     * Sequential write requests are shuffled to different counter to
+     * reduce the counter preemption.
+     */
+	sector_t blockno = offset >> (PAGE_SHIFT - SECTOR_SHIFT);
+	sector_t totblocks = bitmap->chunks << (bitmap->chunkshift - (PAGE_SHIFT - SECTOR_SHIFT));
+	unsigned long bits = totblocks ? fls((totblocks - 1)) : 0;
+	unsigned long mask = ULONG_MAX << bits | ~(ULONG_MAX <<
+					(bits - (bitmap->chunkshift + SECTOR_SHIFT - PAGE_SHIFT)));
+	unsigned long cntid = blockno & mask;
+	unsigned long page = cntid >> PAGE_COUNTER_SHIFT;
+
 	bitmap->bp[page].count += inc;
 	md_bitmap_checkfree(bitmap, page);
 }
 
 static void md_bitmap_set_pending(struct bitmap_counts *bitmap, sector_t offset)
 {
-	sector_t chunk = offset >> bitmap->chunkshift;
-	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
+	sector_t blockno = offset >> (PAGE_SHIFT - SECTOR_SHIFT);
+	sector_t totblocks = bitmap->chunks << (bitmap->chunkshift - (PAGE_SHIFT - SECTOR_SHIFT));
+	unsigned long bits = totblocks ? fls((totblocks - 1)) : 0;
+	unsigned long mask = ULONG_MAX << bits | ~(ULONG_MAX <<
+					(bits - (bitmap->chunkshift + SECTOR_SHIFT - PAGE_SHIFT)));
+	unsigned long cntid = blockno & mask;
+	unsigned long page = cntid >> PAGE_COUNTER_SHIFT;
+
 	struct bitmap_page *bp = &bitmap->bp[page];
 
 	if (!bp->pending)
@@ -1266,7 +1293,7 @@ static void md_bitmap_set_pending(struct bitmap_counts *bitmap, sector_t offset)
 
 static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
 					       sector_t offset, sector_t *blocks,
-					       int create);
+					       int create, spinlock_t *bmclock);
 
 static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
 			      bool force)
@@ -1349,7 +1376,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 	 * decrement and handle accordingly.
 	 */
 	counts = &bitmap->counts;
-	spin_lock_irq(&counts->lock);
+	write_lock_irq(&counts->mlock);
 	nextpage = 0;
 	for (j = 0; j < counts->chunks; j++) {
 		bitmap_counter_t *bmc;
@@ -1364,7 +1391,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 			counts->bp[j >> PAGE_COUNTER_SHIFT].pending = 0;
 		}
 
-		bmc = md_bitmap_get_counter(counts, block, &blocks, 0);
+		bmc = md_bitmap_get_counter(counts, block, &blocks, 0, NULL);
 		if (!bmc) {
 			j |= PAGE_COUNTER_MASK;
 			continue;
@@ -1380,7 +1407,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 			bitmap->allclean = 0;
 		}
 	}
-	spin_unlock_irq(&counts->lock);
+	write_unlock_irq(&counts->mlock);
 
 	md_bitmap_wait_writes(bitmap);
 	/* Now start writeout on any page in NEEDWRITE that isn't DIRTY.
@@ -1413,17 +1440,25 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
 static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
 					       sector_t offset, sector_t *blocks,
-					       int create)
-__releases(bitmap->lock)
-__acquires(bitmap->lock)
+					       int create, spinlock_t *bmclock)
+__releases(bmclock)
+__acquires(bmclock)
+__releases(bitmap->mlock)
+__acquires(bitmap->mlock)
 {
 	/* If 'create', we might release the lock and reclaim it.
 	 * The lock must have been taken with interrupts enabled.
 	 * If !create, we don't release the lock.
 	 */
-	sector_t chunk = offset >> bitmap->chunkshift;
-	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
-	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
+	sector_t blockno = offset >> (PAGE_SHIFT - SECTOR_SHIFT);
+	sector_t totblocks = bitmap->chunks << (bitmap->chunkshift - (PAGE_SHIFT - SECTOR_SHIFT));
+	unsigned long bits = totblocks ? fls((totblocks - 1)) : 0;
+	unsigned long mask = ULONG_MAX << bits | ~(ULONG_MAX <<
+					(bits - (bitmap->chunkshift + SECTOR_SHIFT - PAGE_SHIFT)));
+	unsigned long cntid = blockno & mask;
+	unsigned long page = cntid >> PAGE_COUNTER_SHIFT;
+	unsigned long pageoff = (cntid & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
+
 	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
 	int err;
 
@@ -1436,7 +1471,7 @@ __acquires(bitmap->lock)
 		*blocks = csize - (offset & (csize - 1));
 		return NULL;
 	}
-	err = md_bitmap_checkpage(bitmap, page, create, 0);
+	err = md_bitmap_checkpage(bitmap, page, create, 0, bmclock);
 
 	if (bitmap->bp[page].hijacked ||
 	    bitmap->bp[page].map == NULL)
@@ -1461,6 +1496,28 @@ __acquires(bitmap->lock)
 			&(bitmap->bp[page].map[pageoff]);
 }
 
+/* set-association */
+static spinlock_t *md_bitmap_get_bmclock(struct bitmap_counts *bitmap, sector_t offset);
+
+static spinlock_t *md_bitmap_get_bmclock(struct bitmap_counts *bitmap, sector_t offset)
+{
+	sector_t blockno = offset >> (PAGE_SHIFT - SECTOR_SHIFT);
+	sector_t totblocks = bitmap->chunks << (bitmap->chunkshift - (PAGE_SHIFT - SECTOR_SHIFT));
+	unsigned long bitscnt = totblocks ? fls((totblocks - 1)) : 0;
+	unsigned long maskcnt = ULONG_MAX << bitscnt | ~(ULONG_MAX << (bitscnt -
+					(bitmap->chunkshift + SECTOR_SHIFT - PAGE_SHIFT)));
+	unsigned long cntid = blockno & maskcnt;
+
+	unsigned long totcnts = bitmap->chunks;
+	unsigned long bitslock = totcnts ? fls((totcnts - 1)) : 0;
+	unsigned long masklock = ULONG_MAX << bitslock | ~(ULONG_MAX <<
+					(bitslock - BITMAP_COUNTER_LOCK_RATIO_SHIFT));
+	unsigned long lockid = cntid & masklock;
+
+	spinlock_t *bmclock = &(bitmap->bmclocks[lockid]);
+	return bmclock;
+}
+
 int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset, unsigned long sectors, int behind)
 {
 	if (!bitmap)
@@ -1480,11 +1537,15 @@ int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset, unsigned long s
 	while (sectors) {
 		sector_t blocks;
 		bitmap_counter_t *bmc;
+		spinlock_t *bmclock;
 
-		spin_lock_irq(&bitmap->counts.lock);
-		bmc = md_bitmap_get_counter(&bitmap->counts, offset, &blocks, 1);
+		bmclock = md_bitmap_get_bmclock(&bitmap->counts, offset);
+		read_lock(&bitmap->counts.mlock);
+		spin_lock_irq(bmclock);
+		bmc = md_bitmap_get_counter(&bitmap->counts, offset, &blocks, 1, bmclock);
 		if (!bmc) {
-			spin_unlock_irq(&bitmap->counts.lock);
+			spin_unlock_irq(bmclock);
+			read_unlock(&bitmap->counts.mlock);
 			return 0;
 		}
 
@@ -1496,7 +1557,8 @@ int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset, unsigned long s
 			 */
 			prepare_to_wait(&bitmap->overflow_wait, &__wait,
 					TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&bitmap->counts.lock);
+			spin_unlock_irq(bmclock);
+			read_unlock(&bitmap->counts.mlock);
 			schedule();
 			finish_wait(&bitmap->overflow_wait, &__wait);
 			continue;
@@ -1513,7 +1575,8 @@ int md_bitmap_startwrite(struct bitmap *bitmap, sector_t offset, unsigned long s
 
 		(*bmc)++;
 
-		spin_unlock_irq(&bitmap->counts.lock);
+		spin_unlock_irq(bmclock);
+		read_unlock(&bitmap->counts.mlock);
 
 		offset += blocks;
 		if (sectors > blocks)
@@ -1542,11 +1605,15 @@ void md_bitmap_endwrite(struct bitmap *bitmap, sector_t offset,
 		sector_t blocks;
 		unsigned long flags;
 		bitmap_counter_t *bmc;
+		spinlock_t *bmclock;
 
-		spin_lock_irqsave(&bitmap->counts.lock, flags);
-		bmc = md_bitmap_get_counter(&bitmap->counts, offset, &blocks, 0);
+		bmclock = md_bitmap_get_bmclock(&bitmap->counts, offset);
+		read_lock(&bitmap->counts.mlock);
+		spin_lock_irqsave(bmclock, flags);
+		bmc = md_bitmap_get_counter(&bitmap->counts, offset, &blocks, 0, bmclock);
 		if (!bmc) {
-			spin_unlock_irqrestore(&bitmap->counts.lock, flags);
+			spin_unlock_irqrestore(bmclock, flags);
+			read_unlock(&bitmap->counts.mlock);
 			return;
 		}
 
@@ -1568,7 +1635,8 @@ void md_bitmap_endwrite(struct bitmap *bitmap, sector_t offset,
 			md_bitmap_set_pending(&bitmap->counts, offset);
 			bitmap->allclean = 0;
 		}
-		spin_unlock_irqrestore(&bitmap->counts.lock, flags);
+		spin_unlock_irqrestore(bmclock, flags);
+		read_unlock(&bitmap->counts.mlock);
 		offset += blocks;
 		if (sectors > blocks)
 			sectors -= blocks;
@@ -1582,13 +1650,16 @@ static int __bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t
 			       int degraded)
 {
 	bitmap_counter_t *bmc;
+	spinlock_t *bmclock;
 	int rv;
 	if (bitmap == NULL) {/* FIXME or bitmap set as 'failed' */
 		*blocks = 1024;
 		return 1; /* always resync if no bitmap */
 	}
-	spin_lock_irq(&bitmap->counts.lock);
-	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0);
+	bmclock = md_bitmap_get_bmclock(&bitmap->counts, offset);
+	read_lock(&bitmap->counts.mlock);
+	spin_lock_irq(bmclock);
+	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0, bmclock);
 	rv = 0;
 	if (bmc) {
 		/* locked */
@@ -1602,7 +1673,8 @@ static int __bitmap_start_sync(struct bitmap *bitmap, sector_t offset, sector_t
 			}
 		}
 	}
-	spin_unlock_irq(&bitmap->counts.lock);
+	spin_unlock_irq(bmclock);
+	read_unlock(&bitmap->counts.mlock);
 	return rv;
 }
 
@@ -1634,13 +1706,16 @@ void md_bitmap_end_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks
 {
 	bitmap_counter_t *bmc;
 	unsigned long flags;
+	spinlock_t *bmclock;
 
 	if (bitmap == NULL) {
 		*blocks = 1024;
 		return;
 	}
-	spin_lock_irqsave(&bitmap->counts.lock, flags);
-	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0);
+	bmclock = md_bitmap_get_bmclock(&bitmap->counts, offset);
+	read_lock(&bitmap->counts.mlock);
+	spin_lock_irqsave(bmclock, flags);
+	bmc = md_bitmap_get_counter(&bitmap->counts, offset, blocks, 0, bmclock);
 	if (bmc == NULL)
 		goto unlock;
 	/* locked */
@@ -1657,7 +1732,8 @@ void md_bitmap_end_sync(struct bitmap *bitmap, sector_t offset, sector_t *blocks
 		}
 	}
  unlock:
-	spin_unlock_irqrestore(&bitmap->counts.lock, flags);
+	spin_unlock_irqrestore(bmclock, flags);
+	read_unlock(&bitmap->counts.mlock);
 }
 EXPORT_SYMBOL(md_bitmap_end_sync);
 
@@ -1738,10 +1814,15 @@ static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, in
 
 	sector_t secs;
 	bitmap_counter_t *bmc;
-	spin_lock_irq(&bitmap->counts.lock);
-	bmc = md_bitmap_get_counter(&bitmap->counts, offset, &secs, 1);
+	spinlock_t *bmclock;
+
+	bmclock = md_bitmap_get_bmclock(&bitmap->counts, offset);
+	read_lock(&bitmap->counts.mlock);
+	spin_lock_irq(bmclock);
+	bmc = md_bitmap_get_counter(&bitmap->counts, offset, &secs, 1, bmclock);
 	if (!bmc) {
-		spin_unlock_irq(&bitmap->counts.lock);
+		spin_unlock_irq(bmclock);
+		read_unlock(&bitmap->counts.mlock);
 		return;
 	}
 	if (!*bmc) {
@@ -1752,7 +1833,8 @@ static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, in
 	}
 	if (needed)
 		*bmc |= NEEDED_MASK;
-	spin_unlock_irq(&bitmap->counts.lock);
+	spin_unlock_irq(bmclock);
+	read_unlock(&bitmap->counts.mlock);
 }
 
 /* dirty the memory and file bits for bitmap chunks "s" to "e" */
@@ -1806,6 +1888,7 @@ void md_bitmap_free(struct bitmap *bitmap)
 {
 	unsigned long k, pages;
 	struct bitmap_page *bp;
+	spinlock_t *bmclocks;
 
 	if (!bitmap) /* there was no bitmap */
 		return;
@@ -1826,6 +1909,7 @@ void md_bitmap_free(struct bitmap *bitmap)
 
 	bp = bitmap->counts.bp;
 	pages = bitmap->counts.pages;
+	bmclocks = bitmap->counts.bmclocks;
 
 	/* free all allocated memory */
 
@@ -1834,6 +1918,7 @@ void md_bitmap_free(struct bitmap *bitmap)
 			if (bp[k].map && !bp[k].hijacked)
 				kfree(bp[k].map);
 	kfree(bp);
+	kfree(bmclocks);
 	kfree(bitmap);
 }
 EXPORT_SYMBOL(md_bitmap_free);
@@ -1900,7 +1985,9 @@ struct bitmap *md_bitmap_create(struct mddev *mddev, int slot)
 	if (!bitmap)
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock_init(&bitmap->counts.lock);
+	/* initialize metadata lock */
+	rwlock_init(&bitmap->counts.mlock);
+
 	atomic_set(&bitmap->pending_writes, 0);
 	init_waitqueue_head(&bitmap->write_wait);
 	init_waitqueue_head(&bitmap->overflow_wait);
@@ -2143,6 +2230,8 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 	int ret = 0;
 	long pages;
 	struct bitmap_page *new_bp;
+	spinlock_t *new_bmclocks;
+	int num_bmclocks, i;
 
 	if (bitmap->storage.file && !init) {
 		pr_info("md: cannot resize file-based bitmap\n");
@@ -2211,7 +2300,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		memcpy(page_address(store.sb_page),
 		       page_address(bitmap->storage.sb_page),
 		       sizeof(bitmap_super_t));
-	spin_lock_irq(&bitmap->counts.lock);
+	write_lock_irq(&bitmap->counts.mlock);
 	md_bitmap_file_unmap(&bitmap->storage);
 	bitmap->storage = store;
 
@@ -2227,11 +2316,23 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 	blocks = min(old_counts.chunks << old_counts.chunkshift,
 		     chunks << chunkshift);
 
+	/* initialize bmc locks */
+	num_bmclocks = DIV_ROUND_UP(chunks, BITMAP_COUNTER_LOCK_RATIO);
+	num_bmclocks = min(num_bmclocks, BITMAP_COUNTER_LOCK_MAX);
+
+	new_bmclocks = kvcalloc(num_bmclocks, sizeof(*new_bmclocks), GFP_KERNEL);
+	bitmap->counts.bmclocks = new_bmclocks;
+	for (i = 0; i < num_bmclocks; ++i) {
+		spinlock_t *bmclock = &(bitmap->counts.bmclocks)[i];
+
+		spin_lock_init(bmclock);
+	}
+
 	/* For cluster raid, need to pre-allocate bitmap */
 	if (mddev_is_clustered(bitmap->mddev)) {
 		unsigned long page;
 		for (page = 0; page < pages; page++) {
-			ret = md_bitmap_checkpage(&bitmap->counts, page, 1, 1);
+			ret = md_bitmap_checkpage(&bitmap->counts, page, 1, 1, NULL);
 			if (ret) {
 				unsigned long k;
 
@@ -2261,11 +2362,12 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		bitmap_counter_t *bmc_old, *bmc_new;
 		int set;
 
-		bmc_old = md_bitmap_get_counter(&old_counts, block, &old_blocks, 0);
+		bmc_old = md_bitmap_get_counter(&old_counts, block, &old_blocks, 0, NULL);
 		set = bmc_old && NEEDED(*bmc_old);
 
 		if (set) {
-			bmc_new = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1);
+			bmc_new = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks,
+										1, NULL);
 			if (bmc_new) {
 				if (*bmc_new == 0) {
 					/* need to set on-disk bits too. */
@@ -2301,7 +2403,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		int i;
 		while (block < (chunks << chunkshift)) {
 			bitmap_counter_t *bmc;
-			bmc = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1);
+			bmc = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1, NULL);
 			if (bmc) {
 				/* new space.  It needs to be resynced, so
 				 * we set NEEDED_MASK.
@@ -2317,7 +2419,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		for (i = 0; i < bitmap->storage.file_pages; i++)
 			set_page_attr(bitmap, i, BITMAP_PAGE_DIRTY);
 	}
-	spin_unlock_irq(&bitmap->counts.lock);
+	write_unlock_irq(&bitmap->counts.mlock);
 
 	if (!init) {
 		md_bitmap_unplug(bitmap);
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index bb9eb418780a..3de5b9f09ac8 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -2,7 +2,9 @@
 /*
  * bitmap.h: Copyright (C) Peter T. Breuer (ptb@ot.uc3m.es) 2003
  *
- * additions: Copyright (C) 2003-2004, Paul Clements, SteelEye Technology, Inc.
+ * additions:
+ *		Copyright (C) 2003-2004, Paul Clements, SteelEye Technology, Inc.
+ *		Copyright (C) 2022-2023, Shushu Yi (firnyee@gmail.com)
  */
 #ifndef BITMAP_H
 #define BITMAP_H 1
@@ -103,6 +105,10 @@ typedef __u16 bitmap_counter_t;
 #define PAGE_COUNTER_MASK  (PAGE_COUNTER_RATIO - 1)
 
 #define BITMAP_BLOCK_SHIFT 9
+/* how many counters share the same bmclock? */
+#define BITMAP_COUNTER_LOCK_RATIO_SHIFT 0
+#define BITMAP_COUNTER_LOCK_RATIO (1 << BITMAP_COUNTER_LOCK_RATIO_SHIFT)
+#define BITMAP_COUNTER_LOCK_MAX 65536
 
 #endif
 
@@ -180,7 +186,18 @@ struct bitmap_page {
 struct bitmap {
 
 	struct bitmap_counts {
-		spinlock_t lock;
+		/*
+		 * Customize different types of lock structures to manage
+		 * data and metadata.
+		 * Split the counter table into multiple segments and assigns a
+		 * dedicated lock to each segment.  The counters in the counter
+		 * table, which map to neighboring stripe blocks, are interleaved
+		 * across different segments.
+		 * CPU threads that target different segments can acquire the locks
+		 * simultaneously, resulting in better thread-level parallelism.
+		 */
+		rwlock_t mlock;				/* lock for metadata */
+		spinlock_t *bmclocks;		/* locks for bmc */
 		struct bitmap_page *bp;
 		unsigned long pages;		/* total number of pages
 						 * in the bitmap */
-- 
2.43.0


