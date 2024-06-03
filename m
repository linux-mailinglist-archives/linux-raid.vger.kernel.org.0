Return-Path: <linux-raid+bounces-1613-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB08D830B
	for <lists+linux-raid@lfdr.de>; Mon,  3 Jun 2024 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486B11F25817
	for <lists+linux-raid@lfdr.de>; Mon,  3 Jun 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EA12D1FD;
	Mon,  3 Jun 2024 12:58:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DB12C54D;
	Mon,  3 Jun 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419496; cv=none; b=PSScjCAbO0u/TshJzjFwAZAULtrMUHC0dS1QRJkpLlAgygXyEuJs66cE6LWMCTNM5LprUYoJBjhMJuPhjNsdGR0kN/BMd8kWUO9TOo9/FSijzDqxfPg9XIMzGM31580KuQ58M90YEVR60VV89qex+4DArp4X7Gf/yhbbqqf4bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419496; c=relaxed/simple;
	bh=gdmUcErX0vsOeRarPKhA1OeJyebQSfVxmZsfIBoqpRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej+uc+7+vy1WwZa7D2SKqvt+tWrwBbQkv90mEx0U04FEUq5918YXD1LVymoZTJvbKGTgBgqp//+f1/o0K0cFlzg3dwGeaKt2q1u4fBkX4mHP0Jzhu2zn7c5hoOLzFGJ6eI4RR9cBNZk9uY6emIzwcpfjawR/snrpGuchWb4vmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VtDFP1lqYzwRLd;
	Mon,  3 Jun 2024 20:54:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B033140417;
	Mon,  3 Jun 2024 20:58:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 20:58:10 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<song@kernel.org>, <xni@redhat.com>, <mariusz.tkaczyk@linux.intel.com>,
	<l@damenly.org>
CC: <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-raid@vger.kernel.org>, <yukuai3@huawei.com>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH 01/12] md: rearrange recovery_flags
Date: Mon, 3 Jun 2024 20:58:04 +0800
Message-ID: <20240603125815.2199072-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603125815.2199072-1-yukuai3@huawei.com>
References: <20240603125815.2199072-1-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Currently there are lots of flags with the same confusing prefix
"MD_REOCVERY_", and there are two main types of flags, sync thread runnng
status, I prefer prefix "SYNC_THREAD_", and sync thread action, I perfer
prefix "SYNC_ACTION_".

For now, rearrange and update comment to improve code readability,
there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.h | 52 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index ca085ecad504..170412a65b63 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -551,22 +551,46 @@ struct mddev {
 };
 
 enum recovery_flags {
+	/* flags for sync thread running status */
+
+	/*
+	 * set when one of sync action is set and new sync thread need to be
+	 * registered, or just add/remove spares from conf.
+	 */
+	MD_RECOVERY_NEEDED,
+	/* sync thread is running, or about to be started */
+	MD_RECOVERY_RUNNING,
+	/* sync thread needs to be aborted for some reason */
+	MD_RECOVERY_INTR,
+	/* sync thread is done and is waiting to be unregistered */
+	MD_RECOVERY_DONE,
+	/* running sync thread must abort immediately, and not restart */
+	MD_RECOVERY_FROZEN,
+	/* waiting for pers->start() to finish */
+	MD_RECOVERY_WAIT,
+	/* interrupted because io-error */
+	MD_RECOVERY_ERROR,
+
+	/* flags determines sync action */
+
+	/* if just this flag is set, action is resync. */
+	MD_RECOVERY_SYNC,
+	/*
+	 * paired with MD_RECOVERY_SYNC, if MD_RECOVERY_CHECK is not set,
+	 * action is repair, means user requested resync.
+	 */
+	MD_RECOVERY_REQUESTED,
 	/*
-	 * If neither SYNC or RESHAPE are set, then it is a recovery.
+	 * paired with MD_RECOVERY_SYNC and MD_RECOVERY_REQUESTED, action is
+	 * check.
 	 */
-	MD_RECOVERY_RUNNING,	/* a thread is running, or about to be started */
-	MD_RECOVERY_SYNC,	/* actually doing a resync, not a recovery */
-	MD_RECOVERY_RECOVER,	/* doing recovery, or need to try it. */
-	MD_RECOVERY_INTR,	/* resync needs to be aborted for some reason */
-	MD_RECOVERY_DONE,	/* thread is done and is waiting to be reaped */
-	MD_RECOVERY_NEEDED,	/* we might need to start a resync/recover */
-	MD_RECOVERY_REQUESTED,	/* user-space has requested a sync (used with SYNC) */
-	MD_RECOVERY_CHECK,	/* user-space request for check-only, no repair */
-	MD_RECOVERY_RESHAPE,	/* A reshape is happening */
-	MD_RECOVERY_FROZEN,	/* User request to abort, and not restart, any action */
-	MD_RECOVERY_ERROR,	/* sync-action interrupted because io-error */
-	MD_RECOVERY_WAIT,	/* waiting for pers->start() to finish */
-	MD_RESYNCING_REMOTE,	/* remote node is running resync thread */
+	MD_RECOVERY_CHECK,
+	/* recovery, or need to try it */
+	MD_RECOVERY_RECOVER,
+	/* reshape */
+	MD_RECOVERY_RESHAPE,
+	/* remote node is running resync thread */
+	MD_RESYNCING_REMOTE,
 };
 
 enum md_ro_state {
-- 
2.39.2


