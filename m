Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36DE16A4F9
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 12:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBXLeY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 06:34:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:37746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbgBXLeY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 24 Feb 2020 06:34:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0581AE2A;
        Mon, 24 Feb 2020 11:34:22 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-raid@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Petr Vorel <pvorel@suse.cz>,
        NeilBrown <neilb@suse.de>, Jes Sorensen <jsorensen@fb.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wols Lists <antlists@youngman.org.uk>, Nix <nix@esperi.org.uk>
Subject: [PATCH v2 1/1] mdadm.8: add note information for raid0 growing operation
Date:   Mon, 24 Feb 2020 12:34:09 +0100
Message-Id: <20200224113409.11137-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Coly Li <colyli@suse.de>

When growing a raid0 device, if the new component disk size is not
big enough, the grow operation may fail due to lack of backup space.

The minimum backup space should be larger than:
 LCM(old, new) * chunk-size * 2

where LCM() is the least common multiple of the old and new count of
component disks, and "* 2" comes from the fact that mdadm refuses to
use more than half of a spare device for backup space.

There are users reporting such failure when they grew a raid0 array
with small component disk. Neil Brown points out this is not a bug
and how the failure comes. This patch adds note information into
mdadm(8) man page in the Notes part of GROW MODE section to explain
the minimum size requirement of new component disk size or external
backup size.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Cc: NeilBrown <neilb@suse.de>
Cc: Jes Sorensen <jsorensen@fb.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Wols Lists <antlists@youngman.org.uk>
Cc: Nix <nix@esperi.org.uk>
Signed-off-by: Coly Li <colyli@suse.de>
---
Hi,

Coly haven't sent v2, but it's already prepared in openSUSE package [1],
therefore sending it on his behalf.

Kind regards,
Petr

[1] https://build.opensuse.org/package/view_file/Base:System/mdadm/1002-mdadm.8-add-note-information-for-raid0-growing-opera.patch?expand=1

 mdadm.8.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mdadm.8.in b/mdadm.8.in
index 5d00faf..a3494a1 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -2768,6 +2768,12 @@ option and it is transparent for assembly feature.
 .IP \(bu 4
 Roaming between Windows(R) and Linux systems for IMSM metadata is not
 supported during grow process.
+.IP \(bu 4
+When growing a raid0 device, the new component disk size (or external
+backup size) should be larger than LCM(old, new) * chunk-size * 2,
+where LCM() is the least common multiple of the old and new count of
+component disks, and "* 2" comes from the fact that mdadm refuses to
+use more than half of a spare device for backup space.
 
 .SS SIZE CHANGES
 Normally when an array is built the "size" is taken from the smallest
-- 
2.25.1

