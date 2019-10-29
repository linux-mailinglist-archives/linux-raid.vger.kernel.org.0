Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B861FE93B8
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 00:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfJ2XdS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 19:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfJ2XdS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 19:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D598B42A;
        Tue, 29 Oct 2019 23:33:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Wed, 30 Oct 2019 10:32:41 +1100
Subject: [PATCH 3/3] SUSE-mdadm_env.sh: handle MDADM_CHECK_DURATION
Cc:     linux-raid@vger.kernel.org
Message-ID: <157239196163.30065.2946798251081126246.stgit@noble.brown>
In-Reply-To: <157239190470.30065.4500556456316521334.stgit@noble.brown>
References: <157239190470.30065.4500556456316521334.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The suse sysconfig/mdadm allows MDADM_CHECK_DURATION
to be set, but it is currently ignored.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 systemd/SUSE-mdadm_env.sh |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/systemd/SUSE-mdadm_env.sh b/systemd/SUSE-mdadm_env.sh
index 10b2e749921c..c13b48ab3cb1 100644
--- a/systemd/SUSE-mdadm_env.sh
+++ b/systemd/SUSE-mdadm_env.sh
@@ -43,3 +43,6 @@ fi
 
 mkdir -p /run/sysconfig
 echo "MDADM_MONITOR_ARGS=$MDADM_RAIDDEVICES $MDADM_DELAY $MDADM_MAIL $MDADM_PROGRAM $MDADM_SCAN $MDADM_SEND_MAIL $MDADM_CONFIG" > /run/sysconfig/mdadm
+if [ -n "$MDADM_CHECK_DURATION" ]; then
+ echo "MDADM_CHECK_DURATION=$MDADM_CHECK_DURATION" >> /run/sysconfig/mdadm
+fi


