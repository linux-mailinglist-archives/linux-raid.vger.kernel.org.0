Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDDF7B908
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 07:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfGaF3l (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 31 Jul 2019 01:29:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfGaF3l (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 31 Jul 2019 01:29:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38BF1AE0C;
        Wed, 31 Jul 2019 05:29:40 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     jes.sorensen@gmail.com, linux-raid@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>
Subject: [PATCH v2 2/2] udev: add --no-devices option for calling 'mdadm --detail'
Date:   Wed, 31 Jul 2019 13:29:30 +0800
Message-Id: <20190731052930.108303-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190731052930.108303-1-colyli@suse.de>
References: <20190731052930.108303-1-colyli@suse.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When creating symlink of a md raid device, the detailed information of
component disks are unnecessary for rule udev-md-raid-arrays.rules. For
md raid devices with huge number of component disks (e.g. 1500 DASD
disks), the detail information of component devices can be very large
and exceed udev monitor's on-stack message buffer.

This patch adds '--no-devices' option when calling mdadm by,
IMPORT{program}="BINDIR/mdadm --detail --no-devices --export $devnode"

Now the detailed output won't include component disks information,
and the error message "invalid message length" reported by systemd can
be removed.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: NeilBrown <neilb@suse.com>
---
 udev-md-raid-arrays.rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/udev-md-raid-arrays.rules b/udev-md-raid-arrays.rules
index 5b99d58..d391665 100644
--- a/udev-md-raid-arrays.rules
+++ b/udev-md-raid-arrays.rules
@@ -17,7 +17,7 @@ TEST!="md/array_state", ENV{SYSTEMD_READY}="0", GOTO="md_end"
 ATTR{md/array_state}=="|clear|inactive", ENV{SYSTEMD_READY}="0", GOTO="md_end"
 LABEL="md_ignore_state"
 
-IMPORT{program}="BINDIR/mdadm --detail --export $devnode"
+IMPORT{program}="BINDIR/mdadm --detail --no-devices --export $devnode"
 ENV{DEVTYPE}=="disk", ENV{MD_NAME}=="?*", SYMLINK+="disk/by-id/md-name-$env{MD_NAME}", OPTIONS+="string_escape=replace"
 ENV{DEVTYPE}=="disk", ENV{MD_UUID}=="?*", SYMLINK+="disk/by-id/md-uuid-$env{MD_UUID}"
 ENV{DEVTYPE}=="disk", ENV{MD_DEVNAME}=="?*", SYMLINK+="md/$env{MD_DEVNAME}"
-- 
2.16.4

