Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD301D8B3F
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgERWtS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 18:49:18 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:55576
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgERWtS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 18 May 2020 18:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sam-hurst.co.uk; s=20191106;
        h=message-id:date:subject:cc:to:from:from;
        bh=uCbOttJ2jPGK+3d70c1hi/23WlE/Tyjxn8t+pzC0v5Q=;
        b=c6+AGJDkPB/MdDvDQOMdvsdrJxRHgaiqGcqXuBywZq46rxmkqIUSQ8HPEsMJJli3fQ9Mjv2EiVMAd
         LjMCPV0/HAFQWhMNtpmx9dFM+NiKDe3pjN/Yun3KNgYjOLeuM6PfEhjhxbF0vN2GvIrnwnAkcthRwc
         CgQAhDi5HL5kC4ws+5SHwSPBGrSbvop6UeZwU6CONuBnHpk2/d3X49BZsUnwOHwVrDjivSVzfPKlhs
         TrbAsVDSgpP6f2KI0Rg95v+64/N7AjUkp8VP85t3AJtBnS2pFLUrv5kJnsyWJ/jYWjGAbLkdGArWls
         2fjyP0vKWEsnxWE89geeYylyeNQNhPg==
X-HalOne-Cookie: 79b1eeef6fef26be40a6b25e02951d5ae5fbf3a2
X-HalOne-ID: c9b28baf-9959-11ea-873c-d0431ea8a290
Received: from localhost.localdomain (82-69-64-9.dsl.in-addr.zen.co.uk [82.69.64.9])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c9b28baf-9959-11ea-873c-d0431ea8a290;
        Mon, 18 May 2020 22:49:15 +0000 (UTC)
From:   Sam Hurst <sam@sam-hurst.co.uk>
To:     linux-raid@vger.kernel.org
Cc:     Sam Hurst <sam@sam-hurst.co.uk>
Subject: [PATCH] [PATCH] Add sector suffix to mdadm --data-offset manpage
Date:   Mon, 18 May 2020 23:49:08 +0100
Message-Id: <20200518224908.2457-1-sam@sam-hurst.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Signed-off-by: Sam Hurst <sam@sam-hurst.co.uk>
---
 mdadm.8.in | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 9e7cb96..c997be4 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -857,8 +857,9 @@ an array which was originally created using a different version of
 which computed a different offset.
 
 Setting the offset explicitly over-rides the default.  The value given
-is in Kilobytes unless a suffix of 'K', 'M', 'G' or 'T' is used to explicitly
-indicate Kilobytes, Megabytes, Gigabytes or Terabytes respectively.
+is in Kilobytes unless a suffix of 'K', 'M', 'G', 'T' or 's' is used to
+explicitly indicate Kilobytes, Megabytes, Gigabytes, Terabytes or sectors
+respectively.
 
 Since Linux 3.4,
 .B \-\-data\-offset
-- 
2.17.1

