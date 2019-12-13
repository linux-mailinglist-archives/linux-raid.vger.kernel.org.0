Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3D11DEA9
	for <lists+linux-raid@lfdr.de>; Fri, 13 Dec 2019 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfLMHaW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Dec 2019 02:30:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfLMHaW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 13 Dec 2019 02:30:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA1D3AD73;
        Fri, 13 Dec 2019 07:30:20 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     jsorensen@fb.com, linux-raid@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wols Lists <antlists@youngman.org.uk>, Nix <nix@esperi.org.uk>
Subject: [PATCH v2] mdadm.8: add note information for raid0 growing operation
Date:   Fri, 13 Dec 2019 15:29:34 +0800
Message-Id: <20191213072934.99549-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When growing a raid0 device, if the new component disk size is not
big enough, the grow operation may fail due to lack of backup space.

The minimum backup space should be larger than
        LCM(old, new) * chunk-size * 2
Here LCM stands for Least Common Multiple calculation, old and new
are devices' numbers before and after the grow operation, "* 2" comes
from the fact that mdadm refuses to use more than half of a spare
device for backup space.

There are users reporting such failure when they grew a raid0 array
with small component disk. Neil Brown points out this is not a bug
and how the failure comes. This patch adds note information into
mdadm(8) man page in the Notes part of GROW MODE section, to explain
the minimum size requirement of new component disk size or external
backup size.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: NeilBrown <neilb@suse.de>
Cc: Jes Sorensen <jsorensen@fb.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Wols Lists <antlists@youngman.org.uk>
Cc: Nix <nix@esperi.org.uk>
---
 mdadm.8.in | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mdadm.8.in b/mdadm.8.in
index 9aec9f4..e5074c0 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -2727,6 +2727,14 @@ option and it is transparent for assembly feature.
 .IP \(bu 4
 Roaming between Windows(R) and Linux systems for IMSM metadata is not
 supported during grow process.
+.IP \(bu 4
+When growing a raid0 device, the new component disk size (or external
+backup size) should be larger than LCM(old, new) * chunk-size * 2. Here
+LCM stands for Least Common Multiple calculation, old and new are
+devices' numbers before and after the grow operation, "* 2" comes from
+the fact that mdadm refuses to use more than half of a spare device for
+backup space. 
+
 
 .SS SIZE CHANGES
 Normally when an array is built the "size" is taken from the smallest
-- 
2.16.4

