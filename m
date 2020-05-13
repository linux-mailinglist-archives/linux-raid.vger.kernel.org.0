Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE221D1454
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgEMNQ5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 09:16:57 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56121 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733258AbgEMNQ5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 09:16:57 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 766F12002EE00;
        Wed, 13 May 2020 15:16:54 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Jes Sorensen <Jes.Sorensen@gmail.com>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, linux-raid@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] mdcheck: Log when done
Date:   Wed, 13 May 2020 15:16:46 +0200
Message-Id: <20200513131646.16357-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Donald Buczek <buczek@molgen.mpg.de>

Currently mdcheck (when called with `--duration`) logs only the
beginning of the check, the pausing and the continuation but not the
completion.

So, log the completion, too, so that it can be determined how long the
raid check took.

    2020-05-08T18:00:02+02:00 deadpool root: mdcheck start checking /dev/md0
    2020-05-08T18:00:02+02:00 deadpool root: mdcheck start checking /dev/md1
    2020-05-09T15:32:04+02:00 deadpool root: mdcheck finished checking /dev/md1
    2020-05-09T17:38:04+02:00 deadpool root: mdcheck finished checking /dev/md0

Cc: linux-raid@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 misc/mdcheck | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc/mdcheck b/misc/mdcheck
index 42d4094..700c3e2 100644
--- a/misc/mdcheck
+++ b/misc/mdcheck
@@ -125,11 +125,13 @@ do
 	do
 		eval fl=\$MD_${i}_fl
 		eval sys=\$MD_${i}_sys
+		eval dev=\$MD_${i}_dev
 
 		if [ -z "$fl" ]; then continue; fi
 
 		if [ "`cat $sys/md/sync_action`" != 'check' ]
 		then
+			logger -p daemon.info mdcheck finished checking $dev
 			eval MD_${i}_fl=
 			rm -f $fl
 			continue;
-- 
2.26.2

