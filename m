Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703120C0C7
	for <lists+linux-raid@lfdr.de>; Sat, 27 Jun 2020 12:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgF0Kb4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 27 Jun 2020 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0Kbz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 27 Jun 2020 06:31:55 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07938C03E979
        for <linux-raid@vger.kernel.org>; Sat, 27 Jun 2020 03:31:55 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2C328BC193;
        Sat, 27 Jun 2020 10:31:48 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        corbet@lwn.net, song@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: LVM
Date:   Sat, 27 Jun 2020 12:31:38 +0200
Message-Id: <20200627103138.71885-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/admin-guide/device-mapper/dm-raid.rst  | 2 +-
 Documentation/admin-guide/device-mapper/dm-zoned.rst | 2 +-
 drivers/md/Kconfig                                   | 8 ++++----
 drivers/md/dm-crypt.c                                | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-raid.rst b/Documentation/admin-guide/device-mapper/dm-raid.rst
index 695a2ea1d1ae..7ef9fe63b3d4 100644
--- a/Documentation/admin-guide/device-mapper/dm-raid.rst
+++ b/Documentation/admin-guide/device-mapper/dm-raid.rst
@@ -71,7 +71,7 @@ The target is named "raid" and it accepts the following parameters::
   ============= ===============================================================
 
   Reference: Chapter 4 of
-  http://www.snia.org/sites/default/files/SNIA_DDF_Technical_Position_v2.0.pdf
+  https://www.snia.org/sites/default/files/SNIA_DDF_Technical_Position_v2.0.pdf
 
 <#raid_params>: The number of parameters that follow.
 
diff --git a/Documentation/admin-guide/device-mapper/dm-zoned.rst b/Documentation/admin-guide/device-mapper/dm-zoned.rst
index 553752ea2521..e635041351bc 100644
--- a/Documentation/admin-guide/device-mapper/dm-zoned.rst
+++ b/Documentation/admin-guide/device-mapper/dm-zoned.rst
@@ -14,7 +14,7 @@ host-aware zoned block devices.
 For a more detailed description of the zoned block device models and
 their constraints see (for SCSI devices):
 
-http://www.t10.org/drafts.htm#ZBC_Family
+https://www.t10.org/drafts.htm#ZBC_Family
 
 and (for ATA devices):
 
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 921888df6764..30ba3573626c 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -27,7 +27,7 @@ config BLK_DEV_MD
 
 	  More information about Software RAID on Linux is contained in the
 	  Software RAID mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>. There you will also learn
+	  <https://www.tldp.org/docs.html#howto>. There you will also learn
 	  where to get the supporting user space utilities raidtools.
 
 	  If unsure, say N.
@@ -71,7 +71,7 @@ config MD_RAID0
 
 	  Information about Software RAID on Linux is contained in the
 	  Software-RAID mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>. There you will also
+	  <https://www.tldp.org/docs.html#howto>. There you will also
 	  learn where to get the supporting user space utilities raidtools.
 
 	  To compile this as a module, choose M here: the module
@@ -93,7 +93,7 @@ config MD_RAID1
 
 	  Information about Software RAID on Linux is contained in the
 	  Software-RAID mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.  There you will also
+	  <https://www.tldp.org/docs.html#howto>.  There you will also
 	  learn where to get the supporting user space utilities raidtools.
 
 	  If you want to use such a RAID-1 set, say Y.  To compile this code
@@ -148,7 +148,7 @@ config MD_RAID456
 
 	  Information about Software RAID on Linux is contained in the
 	  Software-RAID mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>. There you will also
+	  <https://www.tldp.org/docs.html#howto>. There you will also
 	  learn where to get the supporting user space utilities raidtools.
 
 	  If you want to use such a RAID-4/RAID-5/RAID-6 set, say Y.  To
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 000ddfab5ba0..4704a16e637c 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -300,7 +300,7 @@ static struct crypto_aead *any_tfm_aead(struct crypt_config *cc)
  * elephant: The extended version of eboiv with additional Elephant diffuser
  *           used with Bitlocker CBC mode.
  *           This mode was used in older Windows systems
- *           http://download.microsoft.com/download/0/2/3/0238acaf-d3bf-4a6d-b3d6-0a0be4bbb36e/bitlockercipher200608.pdf
+ *           https://download.microsoft.com/download/0/2/3/0238acaf-d3bf-4a6d-b3d6-0a0be4bbb36e/bitlockercipher200608.pdf
  */
 
 static int crypt_iv_plain_gen(struct crypt_config *cc, u8 *iv,
-- 
2.27.0

