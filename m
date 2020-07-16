Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C32221B9A
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 06:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgGPEys (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 00:54:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48426 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgGPEyr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 00:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594875299; x=1626411299;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CUbgUokEVUENlVpeQP+uZNac9TqhplB0kjYXEyFVh5M=;
  b=ZIXpRi8EHW97M9YvwubEDChWQRueSJQzQgi2mX1ia1OdHggur4GPwByf
   fSSlRwEy3RSXC69JHbpKZkIGiaOUGww1cDaVMvEAQMvpD/QDTf8W/juv1
   mcV9Mz6xDC7RyIcuG7aL62uUIPDQJHcm/z7fGhvar5wJmNPn86+mIEE/t
   WzATXHlx1aeh++C1QO11thRAwbBdWXVAl2Rp4LyWUxX5c2Urbk0METIaE
   a+syMOPuJaM+zntdYvic4IWJsQ24iN35F1ihEaebxmsqcf3OOvowCE6zP
   QHiBCFUv3Wg4ZrpoDPKXrNTOi9H1dQW/jzBGghwwQryjAfkmBCYGnwqsY
   g==;
IronPort-SDR: yd5MwV7q9cVltNJ5r8I/VpKxhrPjGOeZodxgDj5yZQpOY/anGjaTHKzVMbyo/Xd1PzZDM/K0/4
 j9IvoHhor1rQ6W1q+gHS/xiDGGwe8943a5UQXUF3If46DZaXbj4nnP6mii0G/Cx0wFtAkWlNK2
 p5CbTZRxyafEZFvzR813t6OuA/J/Pq6B3ENweiQFd08Lw/S81W85coONnShPmtmUnCRrFgfu2l
 7LooOjF/z9VO+POipsbWCxyC+kA9WDDe/fReytzLOXXrIg0iiV01kdyjds9HpKoijTGiRwsG5P
 aQ0=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="245613385"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 12:54:59 +0800
IronPort-SDR: pKf9K4lr7NRZW/7baMeL6be58kKZd05z6OY3q//BDYtCdIErEbPAee4HtxT/rq9jkl5oh36Luf
 CY7VBx7b2i0eqFpIvwoTGQ4yLr5ynBPyU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 21:42:38 -0700
IronPort-SDR: 9HqPi17n/7/MjrEsjfu2F9wY+wUmKmZhmnqxKn83K8CoSS0CFDGpymlMZx8zeWW/2sf5dVOJHa
 P5aSrIYuwPWA==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 21:54:46 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 4/4] md: raid10: Fix compilation warning
Date:   Thu, 16 Jul 2020 13:54:43 +0900
Message-Id: <20200716045443.662056-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716045443.662056-1-damien.lemoal@wdc.com>
References: <20200716045443.662056-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Remove the if statement around the call to sysfs_link_rdev() in
raid10_start_reshape() to avoid the compilation warning:

warning: suggest braces around empty body in an ‘if’ statement

when compiling with W=1.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/raid10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 2c47474fa69d..14b1ba732cd7 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4307,8 +4307,8 @@ static int raid10_start_reshape(struct mddev *mddev)
 					else
 						rdev->recovery_offset = 0;
 
-					if (sysfs_link_rdev(mddev, rdev))
-						/* Failure here  is OK */;
+					/* Failure here is OK */
+					sysfs_link_rdev(mddev, rdev);
 				}
 			} else if (rdev->raid_disk >= conf->prev.raid_disks
 				   && !test_bit(Faulty, &rdev->flags)) {
-- 
2.26.2

