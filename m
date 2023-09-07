Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CD797BD9
	for <lists+linux-raid@lfdr.de>; Thu,  7 Sep 2023 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjIGS3e (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Sep 2023 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjIGS31 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Sep 2023 14:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2231BC5
        for <linux-raid@vger.kernel.org>; Thu,  7 Sep 2023 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694111295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GhWLW/J+wF3IfDCX1bJmdtWkTTbZeKmfcEYf9lSNTG8=;
        b=ZPPKPLmvJ+FIN4hR+abMrkjwqBZOejCAaVjlxoM24iF3Axv3o78yAW2ZeyW7f5vzgBP4/U
        TsKAK0LM5mQ2og+OBFR643xqcahzuMA6Rcw599MsK2obMyvfAlEAACqVJICUEY+BqQluCa
        TY3lM+AnJvSFJMMZ2x2Hxj90nS3llFA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-pNXXqe3aNl2osN5XkK3-5g-1; Thu, 07 Sep 2023 04:57:48 -0400
X-MC-Unique: pNXXqe3aNl2osN5XkK3-5g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A09F21C29781;
        Thu,  7 Sep 2023 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54AB4493110;
        Thu,  7 Sep 2023 08:57:45 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 1/1] mdadm/tests: Fix regular expression failure
Date:   Thu,  7 Sep 2023 16:57:44 +0800
Message-Id: <20230907085744.18967-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The test fails because of the regular expression.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 tests/06name | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/06name b/tests/06name
index 4d5e824d3e0e..86eaab69e3a1 100644
--- a/tests/06name
+++ b/tests/06name
@@ -3,8 +3,8 @@ set -x
 # create an array with a name
 
 mdadm -CR $md0 -l0 -n2 --metadata=1 --name="Fred" $dev0 $dev1
-mdadm -E $dev0 | grep 'Name : [^:]*:Fred ' > /dev/null || exit 1
-mdadm -D $md0 | grep 'Name : [^:]*:Fred ' > /dev/null || exit 1
+mdadm -E $dev0 | grep 'Name : Fred' > /dev/null || exit 1
+mdadm -D $md0 | grep 'Name : Fred' > /dev/null || exit 1
 mdadm -S $md0
 
 mdadm -A $md0 --name="Fred" $devlist
-- 
2.32.0 (Apple Git-132)

