Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FCE93B6
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 00:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJ2XdI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 19:33:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfJ2XdI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 19:33:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0379B433;
        Tue, 29 Oct 2019 23:33:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Wed, 30 Oct 2019 10:32:41 +1100
Subject: [PATCH 1/3] mdcheck: when mdcheck_start is enabled,
 enable mdcheck_continue too.
Cc:     linux-raid@vger.kernel.org
Message-ID: <157239196159.30065.6966341508048270813.stgit@noble.brown>
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

mdcheck_continue continues a regular array scan that was started by
mdcheck_start.
mdcheck_start will ensure that mdcheck_continue is active.
Howver if you reboot after a check has started, but before it finishes,
then mdcheck_continue won't cause it to continue, because nothing
starts it on boot.

So add an install option for mdcheck_contine, and make sure it
gets enabled when mdcheck_start is enabled.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 systemd/mdcheck_continue.timer |    2 ++
 systemd/mdcheck_start.timer    |    1 +
 2 files changed, 3 insertions(+)

diff --git a/systemd/mdcheck_continue.timer b/systemd/mdcheck_continue.timer
index 3ccfd7858a3f..dba1074c1f44 100644
--- a/systemd/mdcheck_continue.timer
+++ b/systemd/mdcheck_continue.timer
@@ -11,3 +11,5 @@ Description=MD array scrubbing - continuation
 [Timer]
 OnCalendar= 1:05:00
 
+[Install]
+WantedBy= mdmonitor.service
diff --git a/systemd/mdcheck_start.timer b/systemd/mdcheck_start.timer
index 64807362d649..9e7e02ab7333 100644
--- a/systemd/mdcheck_start.timer
+++ b/systemd/mdcheck_start.timer
@@ -13,3 +13,4 @@ OnCalendar=Sun *-*-1..7 1:00:00
 
 [Install]
 WantedBy= mdmonitor.service
+Also= mdcheck_continue.timer


