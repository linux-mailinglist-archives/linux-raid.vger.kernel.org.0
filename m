Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4427A224AA4
	for <lists+linux-raid@lfdr.de>; Sat, 18 Jul 2020 12:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgGRKds (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 18 Jul 2020 06:33:48 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36581 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgGRKdr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sat, 18 Jul 2020 06:33:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 39A5A58A;
        Sat, 18 Jul 2020 06:33:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 18 Jul 2020 06:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ml1.net; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=AKvLNlKfyC64yhrrrVqcCj/EHE
        mdjv8PGUfdpHjjMkQ=; b=EI8M20hDqXwYyEQkom0WMFMkgqj45MoqLbq5g1+58F
        hzl1QVDmdGMLeCkvg94YBQJdM7o2N0eAt17eJlgSXiI3O6kqrwbjGpMj0KrSMmNO
        idJZKYYAZfAwjPQi2TwKPryC6i54OFVFnZ5+pyc2nqkuCYl2bEL6TBdWWXUleLKH
        Oe8Ju5xeOI6FTDqNwGrpIJILvmPFrtpeA0WuP9/LL5jI58txxI6Qk9yMTpZyvKHw
        kqR+IWd1PEE2CwPVvuNWpUYjSHrde0SDzFYmACWnyzvnLcMdVFKR/Mb8KYUrhdD6
        Ifezp0WvDYiFzHne6+wV6KmZHMQMWY7l1GX+XXIAM73Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AKvLNlKfyC64yhrrr
        VqcCj/EHEmdjv8PGUfdpHjjMkQ=; b=qmhJ4706mVcDd+HX5aUmK6Ytd2vmMQ9O+
        27QE3cbN9SKHAl+roIe4M0mYoiGNUm77yLOWYmVKFleK1gdatBxZ48npWJJRFvSF
        7jhGD0r735aohidQvtTKUiSdSqROnyUlQYEFUOZ87Trj9EOnkregE/QvDpFvwBOG
        lyx697/AS4MawfyiP/J5XXPICwPFuWp7m39bcV+M9juHZEapDI9+g6iBxb1qbvbB
        vioIBigLBTrdM5EE1o3023xrqde4VFwlZX3+ZE8Op7mmHTU7NUCQ/IncM5W7q9oi
        Pp2pH9OV9CmC1m8vfWCKJvC8g2f6L5Yi2Q8AtD3hMqa7vEs7sgltg==
X-ME-Sender: <xms:CdASX12bG6z9-HpwsGNykqq1DLFk6lejJHitm0IjCMc4BkGKLgBjMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeghihhnshhtohhnucghvghinhgvrhhtuceofihinhhsthhonhesmhhl
    uddrnhgvtheqnecuggftrfgrthhtvghrnhepgfdtgeevffegledufeehgffgieefudejje
    ejfeeifeeujeeuffefvdeifeehveehnecukfhppeejhedrjedvrdduheehrddvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhnshhtoh
    hnsehmlhdurdhnvght
X-ME-Proxy: <xmx:CdASX8HQCD2MzNdMmUacLkFLZUcbEQyvkyYjUHjXCW2JV-K0pJSTcA>
    <xmx:CdASX16gmq8V7K9slKmomaWc3ThLoN1nEUI78F88LTXvDgLWk3ptmA>
    <xmx:CdASXy0odlBtti9xd2cYWhoo4371SgPWWACLTvoPHKnl-tXcMQStDw>
    <xmx:CdASX8Q0zxgYZ1pRDh8BCDM70KhQ8T_opiXg-d_OBlDkhtDvBNhuoQ>
Received: from snowcrash.winny (c-75-72-155-21.hsd1.wi.comcast.net [75.72.155.21])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BA05328005A;
        Sat, 18 Jul 2020 06:33:45 -0400 (EDT)
From:   Winston Weinert <winston@ml1.net>
To:     linux-raid@vger.kernel.org
Cc:     Winston Weinert <winston@ml1.net>
Subject: [PATCH] mdadm/md.4: update path to in-kernel-tree documentation
Date:   Sat, 18 Jul 2020 05:33:15 -0500
Message-Id: <20200718103314.14549-1-winston@ml1.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Documentation/md.txt was renamed to Documentation/admin/guide/md.rst
in linux commit 9d85025b0418163fae079c9ba8f8445212de8568 (Oct 26,
2016).
---
 md.4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/md.4 b/md.4
index 0712af2..aecff38 100644
--- a/md.4
+++ b/md.4
@@ -1061,7 +1061,7 @@ which contains various files for providing access to information about
 the array.
 
 This interface is documented more fully in the file
-.B Documentation/md.txt
+.B Documentation/admin-guide/md.rst
 which is distributed with the kernel sources.  That file should be
 consulted for full documentation.  The following are just a selection
 of attribute files that are available.
-- 
2.26.2

