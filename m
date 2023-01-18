Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4318A6718F3
	for <lists+linux-raid@lfdr.de>; Wed, 18 Jan 2023 11:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjARK1l (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Jan 2023 05:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjARK0n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 18 Jan 2023 05:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E77D674
        for <linux-raid@vger.kernel.org>; Wed, 18 Jan 2023 01:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674034230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOaITmrYu7jw4n+0WZE1cf7PZxeG7N9OdyTzUWvcPrA=;
        b=FoBz/1SJFauKWEAUDxuN7Vt7MMtZni42Ov8T64eS/SZV0BlDW4hZ262Ha2WvWNCPwGraWO
        WjiI9+a5I21ShwcXc1Ae4rW2mpJjtYLkWMsum9Hz2ZeKy2N07opLUP4A8yxkN+3Zk0KrcK
        hJ0ShMQ+0NG1en1rfTjvuTGDh52thC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-8xPH--E6MIijnjMawTnR8Q-1; Wed, 18 Jan 2023 04:30:28 -0500
X-MC-Unique: 8xPH--E6MIijnjMawTnR8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 144E585CBE2;
        Wed, 18 Jan 2023 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 527602166B26;
        Wed, 18 Jan 2023 09:30:24 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, ming.lei@redhat.com,
        ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH 4/4] Free writes_pending in md_stop
Date:   Wed, 18 Jan 2023 17:30:08 +0800
Message-Id: <20230118093008.67170-5-xni@redhat.com>
In-Reply-To: <20230118093008.67170-1-xni@redhat.com>
References: <20230118093008.67170-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

dm raid calls md_stop to stop the raid device. It needs to
free the writes_pending here.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b1b1d6f98247..d471fc952afa 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6266,6 +6266,7 @@ void md_stop(struct mddev *mddev)
 	 */
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
+	percpu_ref_exit(&mddev->writes_pending);
 	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
-- 
2.32.0 (Apple Git-132)

