Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38F65D9D9
	for <lists+linux-raid@lfdr.de>; Wed,  4 Jan 2023 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbjADQam (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Jan 2023 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbjADQaP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Jan 2023 11:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC43F112
        for <linux-raid@vger.kernel.org>; Wed,  4 Jan 2023 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672849767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d2wUJ2NSu4jiVU3mXq/2ntNWReGSRun1gChvYEf8ovk=;
        b=AKYN4vbOCk5AGL0hIReipDID5EeWXk7rThJlTPQZ0g5M+S8gOhs2Vyj1epUwHzWrTeGImZ
        MoE7l8qZ+uunDbiQ7gZbmp33MREK6Bv8PGlUZ3BqXLC5Fl94dctxOek2RunI/PZSZWOGs9
        bdo6qiDm6zVjakqKSmfhV1Vh2sbehjU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-A6yA1NMBOUGrThebpUn86w-1; Wed, 04 Jan 2023 11:29:25 -0500
X-MC-Unique: A6yA1NMBOUGrThebpUn86w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A7D33C10232;
        Wed,  4 Jan 2023 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406492026D68;
        Wed,  4 Jan 2023 16:29:22 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes@trained-monkey.org
Cc:     pmenzel@molgen.mpg.de, ncroxon@redhat.com,
        linux-raid@vger.kernel.org
Subject: [PATCH v2 1/1] mdadm/udev: Don't handle change event on raw devices
Date:   Thu,  5 Jan 2023 00:29:20 +0800
Message-Id: <20230104162920.18172-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The raw devices are ready when add event happpens and the raid
can be assembled. So there is no need to handle change events.
And it can cause some inconvenient problems.

For example, the OS is installed on md0(/root) and md1(/home).
md0 and md1 are created on partitions. When it wants to re-install
OS, anaconda can't clear the storage configure. It deletes one
partition and does some jobs. The change event happens. Now
the raid device is assembled again. It can't delete the other
partitions.

So in this patch, we don't handle change event on raw devices
anymore.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 udev-md-raid-assembly.rules | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/udev-md-raid-assembly.rules b/udev-md-raid-assembly.rules
index 39b4344b8592..d4a7f0a5a049 100644
--- a/udev-md-raid-assembly.rules
+++ b/udev-md-raid-assembly.rules
@@ -11,6 +11,11 @@ SUBSYSTEM!="block", GOTO="md_inc_end"
 ENV{SYSTEMD_READY}=="0", GOTO="md_inc_end"
 
 # handle potential components of arrays (the ones supported by md)
+# For member devices which are md/dm devices, we don't need to
+# handle add event. Because md/dm devices need to do some init jobs.
+# Then the change event happens.
+# When adding md/dm devices, ID_FS_TYPE can only be linux_raid_member
+# after change event happens.
 ENV{ID_FS_TYPE}=="linux_raid_member", GOTO="md_inc"
 
 # "noiswmd" on kernel command line stops mdadm from handling
@@ -28,6 +33,9 @@ GOTO="md_inc_end"
 
 LABEL="md_inc"
 
+# Bare disks are ready when add event happens, the raid can be assembled.
+ACTION=="change", KERNEL!="dm-*|md*", GOTO="md_inc_end"
+
 # remember you can limit what gets auto/incrementally assembled by
 # mdadm.conf(5)'s 'AUTO' and selectively whitelist using 'ARRAY'
 ACTION!="remove", IMPORT{program}="BINDIR/mdadm --incremental --export $devnode --offroot $env{DEVLINKS}"
-- 
2.32.0 (Apple Git-132)

