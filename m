Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B176A4BA3D8
	for <lists+linux-raid@lfdr.de>; Thu, 17 Feb 2022 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiBQO6v (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 17 Feb 2022 09:58:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242275AbiBQO6u (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 17 Feb 2022 09:58:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2A17F100
        for <linux-raid@vger.kernel.org>; Thu, 17 Feb 2022 06:58:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F4E5219A0;
        Thu, 17 Feb 2022 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645109914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KJl8FcmH9vvBtPUz4mYHM8JrfOOz1URuhCEc1oEncV0=;
        b=s2h+BmftJjQO0DQFl87nhj4vDMbLY0YDX+6eR02ytinJSCiRUxqNJ3Oo/d8YkpFm89NtEy
        M+ZRiup0wvVojMI9OfTBPBh8eI4BZMxO7D5+ep0rKCPzS6npiKj2pPMZrPOdIln1HjOBel
        IUvFafzi6PRa7ab2+ut1+jdmJgcZWfs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4F1313C19;
        Thu, 17 Feb 2022 14:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VeGbLZliDmKwTQAAMHmgww
        (envelope-from <mwilck@suse.com>); Thu, 17 Feb 2022 14:58:33 +0000
From:   mwilck@suse.com
To:     Jes Sorensen <jsorensen@fb.com>, linux-raid@vger.kernel.org,
        Neil Brown <neilb@suse.com>,
        Peter Rajnoha <prajnoha@redhat.com>
Cc:     lvm-devel@redhat.com, Hannes Reinecke <hare@suse.de>,
        Heming Zhao <heming.zhao@suse.com>, Coly Li <colyli@suse.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2] udev-md-raid-assembly.rules: skip if DM_UDEV_DISABLE_OTHER_RULES_FLAG
Date:   Thu, 17 Feb 2022 15:58:29 +0100
Message-Id: <20220217145829.19227-1-mwilck@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

device-mapper sets the flag DM_UDEV_DISABLE_OTHER_RULES_FLAG to 1 for
devices which are unusable. They may be no set up yet, suspended, or
otherwise unusable (e.g. multipath maps without usable path). This
flag does not necessarily imply SYSTEMD_READY=0 and must therefore
be tested separately.

Signed-off-by: Martin Wilck <mwilck@suse.com>

---
Changes in v2:
 - Moved the check further up; DM_UDEV_DISABLE_OTHER_RULES_FLAG must
   be checked before ID_FS_TYPE to be effective

---
 udev-md-raid-assembly.rules | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/udev-md-raid-assembly.rules b/udev-md-raid-assembly.rules
index d668cdd..bc9679f 100644
--- a/udev-md-raid-assembly.rules
+++ b/udev-md-raid-assembly.rules
@@ -9,6 +9,9 @@ SUBSYSTEM!="block", GOTO="md_inc_end"
 
 # skip non-initialized devices
 ENV{SYSTEMD_READY}=="0", GOTO="md_inc_end"
+# device mapper sets DM_UDEV_DISABLE_OTHER_RULES_FLAG for devices which
+# aren't ready to use
+KERNEL=="dm-*", ENV{DM_UDEV_DISABLE_OTHER_RULES_FLAG}=="1", GOTO="md_inc_end"
 
 # handle potential components of arrays (the ones supported by md)
 ENV{ID_FS_TYPE}=="linux_raid_member", GOTO="md_inc"
-- 
2.35.1

