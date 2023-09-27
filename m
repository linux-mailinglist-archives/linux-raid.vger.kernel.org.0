Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451237AF8A3
	for <lists+linux-raid@lfdr.de>; Wed, 27 Sep 2023 05:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjI0D2B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 26 Sep 2023 23:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjI0D0A (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 26 Sep 2023 23:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EBA49C7
        for <linux-raid@vger.kernel.org>; Tue, 26 Sep 2023 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695783153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbF9o1dGWgkhjxgkD3eyJO3yBeZMx8mROyoWiuSQgW4=;
        b=GifaHW8GySxrv3iXwGWBBF7nllytAyyzNAWByTrH/OF6VZCTke0J6f6cReNcxKt5vUho8S
        NLQNWTYEWY8hOXQ/fVnCe+NcEu4chX+APLJzullNFbtpd5z8aN3wyKQvBQnu5+b6fPuoWR
        AOfd2SP4/oa7NhlP0JnP7I1kjuU1Rks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-Sti8OqHkM0udXn1PUWLD3g-1; Tue, 26 Sep 2023 22:52:32 -0400
X-MC-Unique: Sti8OqHkM0udXn1PUWLD3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A649729AB401;
        Wed, 27 Sep 2023 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 200E42156702;
        Wed, 27 Sep 2023 02:52:29 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 4/4] mdadm: Print version to stdout
Date:   Wed, 27 Sep 2023 10:52:19 +0800
Message-Id: <20230927025219.49915-5-xni@redhat.com>
In-Reply-To: <20230927025219.49915-1-xni@redhat.com>
References: <20230927025219.49915-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The version information is not error information. Print it
to stdout.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 mdadm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mdadm.c b/mdadm.c
index 076b45e030b3..0b8854baf1aa 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -128,7 +128,7 @@ int main(int argc, char *argv[])
 			continue;
 
 		case 'V':
-			fputs(Version, stderr);
+			fputs(Version, stdout);
 			exit(0);
 
 		case 'v': c.verbose++;
-- 
2.32.0 (Apple Git-132)

