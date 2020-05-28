Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E51E64A3
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbgE1Owd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 10:52:33 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:60127 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391329AbgE1Owc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 10:52:32 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 12FD32002EE32;
        Thu, 28 May 2020 16:52:29 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org
Subject: [PATCH v2] Use more secure HTTPS URLs
Date:   Thu, 28 May 2020 16:52:24 +0200
Message-Id: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

All URLs in the source are available over HTTPS, so convert all URLs to
HTTPS with the command below.

    git grep -l 'http://' | xargs sed -i 's,http://,https://,g'

Revert the changes to announcement files `ANNOUNCE-*` as requested by
the maintainer.

Cc: linux-raid@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 external-reshape-design.txt      | 2 +-
 mdadm.8.in                       | 6 +++---
 mdadm.spec                       | 4 ++--
 raid6check.8                     | 2 +-
 restripe.c                       | 2 +-
 udev-md-raid-safe-timeouts.rules | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/external-reshape-design.txt b/external-reshape-design.txt
index 10c57cc..e4cf4e1 100644
--- a/external-reshape-design.txt
+++ b/external-reshape-design.txt
@@ -277,4 +277,4 @@ sync_action
 
 ...
 
-[1]: Linux kernel design patterns - part 3, Neil Brown http://lwn.net/Articles/336262/
+[1]: Linux kernel design patterns - part 3, Neil Brown https://lwn.net/Articles/336262/
diff --git a/mdadm.8.in b/mdadm.8.in
index 9e7cb96..7f32762 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -367,7 +367,7 @@ Use the Intel(R) Matrix Storage Manager metadata format.  This creates a
 which is managed in a similar manner to DDF, and is supported by an
 option-rom on some platforms:
 .IP
-.B http://www.intel.com/design/chipsets/matrixstorage_sb.htm
+.B https://www.intel.com/design/chipsets/matrixstorage_sb.htm
 .PP
 .RE
 
@@ -3407,7 +3407,7 @@ was previously known as
 For further information on mdadm usage, MD and the various levels of
 RAID, see:
 .IP
-.B http://raid.wiki.kernel.org/
+.B https://raid.wiki.kernel.org/
 .PP
 (based upon Jakob \(/Ostergaard's Software\-RAID.HOWTO)
 .PP
@@ -3415,7 +3415,7 @@ The latest version of
 .I mdadm
 should always be available from
 .IP
-.B http://www.kernel.org/pub/linux/utils/raid/mdadm/
+.B https://www.kernel.org/pub/linux/utils/raid/mdadm/
 .PP
 Related man pages:
 .PP
diff --git a/mdadm.spec b/mdadm.spec
index 1c66894..506ea33 100644
--- a/mdadm.spec
+++ b/mdadm.spec
@@ -2,8 +2,8 @@ Summary:     mdadm is used for controlling Linux md devices (aka RAID arrays)
 Name:        mdadm
 Version:     4.1
 Release:     1
-Source:      http://www.kernel.org/pub/linux/utils/raid/mdadm/mdadm-%{version}.tar.gz
-URL:         http://neil.brown.name/blog/mdadm
+Source:      https://www.kernel.org/pub/linux/utils/raid/mdadm/mdadm-%{version}.tar.gz
+URL:         https://neil.brown.name/blog/mdadm
 License:     GPL
 Group:       Utilities/System
 BuildRoot:   %{_tmppath}/%{name}-root
diff --git a/raid6check.8 b/raid6check.8
index 5003343..8999ca8 100644
--- a/raid6check.8
+++ b/raid6check.8
@@ -86,7 +86,7 @@ The latest version of
 .I raid6check
 should always be available from
 .IP
-.B http://www.kernel.org/pub/linux/utils/raid/mdadm/
+.B https://www.kernel.org/pub/linux/utils/raid/mdadm/
 .PP
 Related man pages:
 .PP
diff --git a/restripe.c b/restripe.c
index 31b07e8..2aecdb8 100644
--- a/restripe.c
+++ b/restripe.c
@@ -333,7 +333,7 @@ void make_tables(void)
 
 	/* Compute log and inverse log */
 	/* Modified code from:
-	 *    http://web.eecs.utk.edu/~plank/plank/papers/CS-96-332.html
+	 *    https://web.eecs.utk.edu/~plank/plank/papers/CS-96-332.html
 	 */
 	b = 1;
 	raid6_gflog[0] = 0;
diff --git a/udev-md-raid-safe-timeouts.rules b/udev-md-raid-safe-timeouts.rules
index 13c23d8..12bdcaa 100644
--- a/udev-md-raid-safe-timeouts.rules
+++ b/udev-md-raid-safe-timeouts.rules
@@ -13,7 +13,7 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with mdraid-safe-timeouts.  If not, see
-# <http://www.gnu.org/licenses/>.
+# <https://www.gnu.org/licenses/>.
 
 # This file causes block devices with Linux RAID (mdadm) signatures to
 # attempt to set safe timeouts for the drives involved
-- 
2.26.2

