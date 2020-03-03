Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B6178236
	for <lists+linux-raid@lfdr.de>; Tue,  3 Mar 2020 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgCCSOx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Mar 2020 13:14:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41423 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgCCSOx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Mar 2020 13:14:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id l21so3548186qtr.8
        for <linux-raid@vger.kernel.org>; Tue, 03 Mar 2020 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9SiGW0Rl4g6zlhOMX3YQem6x4VUh0hNVQsUNGpoXdxY=;
        b=J6HstaAeNhiFeHccpBn3lINJyc6TX6haoV/MABA2vVjezGt6cbZut4VkhJZXFrj+A/
         FGb/H1ybD+RfMc54Qw7YLjDm8hZOPKpFs7BT+rZtQkUSEr85uISyNpyYTdO5qWMi5AYs
         ikiNbzRxHqx/vkFCYQ6M3sVflleOC/gXctMhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9SiGW0Rl4g6zlhOMX3YQem6x4VUh0hNVQsUNGpoXdxY=;
        b=bcwcbkLOx+Yt/sRPU0avrot2hE8x6Tw0wbhJDUo2D/e7+ldWFzNYwWF2BPVCem7XIA
         F6wlReutkycw+x9q2paPrdbrxy6mGphAjRVpUf4GyJ5DXHAChrewFFymTa5+/DVaQBfy
         kRX6JSg69fydG2tiMJrwkZsMf797BHSIoqbFPu2KQxxbi7hwbKxoZGV3arMX76avqZNk
         dW2ZTXCNO00+iefW2KgK1JzYUZ4wG/FZnPmFAZMQi5NLj8aSPi+0DP7R/dWR4GH36dkv
         U5mJR5V76+wYvgCheX/FeWP0DcULbmTV+sBZ7w2NcVigGW9qnBjrfWtwgtDXruzX/Eu9
         +uwg==
X-Gm-Message-State: ANhLgQ07OB/BlcUJgA3xmqY50YXp9YwPn5InlA2vZEuQzK99mu93N2Ub
        9d7T2o8PHIgDnVrV4uheviip+4u3Qtw=
X-Google-Smtp-Source: ADFU+vt81pjFpiSUOHh1MxBHO91mDDvsNFwRO79k60Zrtlp2iQe7ycZ9sHgXo37l0TkvejWCbuq9Yg==
X-Received: by 2002:ac8:7592:: with SMTP id s18mr5526654qtq.8.1583259291919;
        Tue, 03 Mar 2020 10:14:51 -0800 (PST)
Received: from gravicappa.gravicappa.info (pool-71-184-111-109.bstnma.fios.verizon.net. [71.184.111.109])
        by smtp.gmail.com with ESMTPSA id t6sm12487215qke.57.2020.03.03.10.14.51
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 10:14:51 -0800 (PST)
From:   Vitaly Mayatskikh <vmayatskikh@digitalocean.com>
To:     linux-raid@vger.kernel.org
Subject: [PATCH 1/1] md/raid10: avoid deadlock on recovery.
Date:   Tue,  3 Mar 2020 13:14:40 -0500
Message-Id: <1583259280-124995-2-git-send-email-vmayatskikh@digitalocean.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583259280-124995-1-git-send-email-vmayatskikh@digitalocean.com>
References: <1583259280-124995-1-git-send-email-vmayatskikh@digitalocean.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When disk failure happens and the array has a spare drive, resync thread
kicks in and starts to refill the spare. However it may get blocked by
a retry thread that resubmits failed IO to a mirror and itself can get
blocked on a barrier raised by the resync thread.

Signed-off-by: Vitaly Mayatskikh <vmayatskikh@digitalocean.com>
---
 drivers/md/raid10.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ec136e4..f1a8e26 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -980,6 +980,7 @@ static void wait_barrier(struct r10conf *conf)
 {
 	spin_lock_irq(&conf->resync_lock);
 	if (conf->barrier) {
+		struct bio_list *bio_list = current->bio_list;
 		conf->nr_waiting++;
 		/* Wait for the barrier to drop.
 		 * However if there are already pending
@@ -994,9 +995,16 @@ static void wait_barrier(struct r10conf *conf)
 		wait_event_lock_irq(conf->wait_barrier,
 				    !conf->barrier ||
 				    (atomic_read(&conf->nr_pending) &&
-				     current->bio_list &&
-				     (!bio_list_empty(&current->bio_list[0]) ||
-				      !bio_list_empty(&current->bio_list[1]))),
+				     bio_list &&
+				     (!bio_list_empty(&bio_list[0]) ||
+				      !bio_list_empty(&bio_list[1]))) ||
+				     /* move on if recovery thread is
+				      * blocked by us
+				      */
+				     (conf->mddev->thread->tsk == current &&
+				      test_bit(MD_RECOVERY_RUNNING,
+					       &conf->mddev->recovery) &&
+				      conf->nr_queued > 0),
 				    conf->resync_lock);
 		conf->nr_waiting--;
 		if (!conf->nr_waiting)
-- 
1.8.3.1

