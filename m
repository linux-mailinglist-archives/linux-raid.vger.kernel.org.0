Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A285229945
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgGVNeH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 09:34:07 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43195 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgGVNeH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 09:34:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 925BF4D5;
        Wed, 22 Jul 2020 09:34:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Jul 2020 09:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ml1.net; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=P20JpV5Lxsdx1
        +kGCJGoqFEGVeZkkkKslySxkN7sw28=; b=XMQ2zJKl9+9P/yzzkKTOpRMGwrbVL
        Vc9JtLKJYXIJz/ghnd/ho02/pq7QxDYmGWuqjkGW9vQ7bQOhAxLTkbI7Rwg6y3c/
        WDQSP0zknI8mfugK9AkR8fSj6jrDY83jPHcqp25YZZn1rp0Mzkc6Ttg7vctS625t
        8cMiJz5b40nm0x4B0SfsNu0SJ6bRmc+JOuMT7dzvuMrSwvNp01DvjP+5hmYpYBTK
        px/wzsAH1p59moJ+RzBy/Fr7ZTxomjmws/bNxh21hzSJA70s6pPZMloJkwfrirT0
        ZI5tm9lmKDuC14dfjCXqpUkFg3xJNpfTnWd23BA0VEdVRt5unrcGp+F8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=P20JpV5Lxsdx1+kGCJGoqFEGVeZkkkKslySxkN7sw28=; b=vOfCKJ5y
        YKv+g7U1x6yORqiOon4sTDWeiMll/MKURT0M3poxoRg3cx4NgOmzThdZ+RUtRe+j
        8l8wWrs+rDoVofHjFLbXsn4y63HX+ch/vfOj0GZuhD6OmYRSdURpV3tzNj3WbecQ
        4iT+qI2N0WswWu683cn0Xk+NoBSptf5jISAmiSoYwKSwvj0WeBLQgrY48LHqEe3t
        4d1eAYnPH9RFfKSR+nKKpZgXK8Q0rDzTQr8BKocCpehXauFFYjij3sZ/WM58hkS5
        MlyNrhVyW6trXaYWtuHcYtMMDcvU6OHva9l3O867AperJ1giD87mzsN7t9B0ug1v
        uc8D+Cak7BSZkg==
X-ME-Sender: <xms:TkAYXylbgFNjoVo1A-rq5YB7ZWN_nF3NZb5giMfKgCjvm2ceGN004Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeghihhnshhtohhnucghvghinhgvrhhtuceofihinhhsthhonhes
    mhhluddrnhgvtheqnecuggftrfgrthhtvghrnhepieduleeuleevtdetffdufffhgeeihf
    dvueelhfeiteefieejudelueffgeevgefgnecukfhppeejhedrjedvrdduheehrddvuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhnsh
    htohhnsehmlhdurdhnvght
X-ME-Proxy: <xmx:TkAYX53CT79CJVvH1ov1S_y-ZvpvLFfN8Owiw_exkmBs4rlXTcYAPg>
    <xmx:TkAYXwpD66OaO2jT0MMKRkAcP9VoKrZjC9XFFwwnnhW_fEgLnrSWhg>
    <xmx:TkAYX2nzgecPWgVqW77cwzBCLmUG-7-qGu3TpkzgGJV2f2pCtOJ6cA>
    <xmx:TkAYXxjMnEaxoRoWx85UmulgFpCi8TUN62co5bi7vYQomnqAlLq-Pw>
Received: from snowcrash.winny (c-75-72-155-21.hsd1.wi.comcast.net [75.72.155.21])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91C0730600A3;
        Wed, 22 Jul 2020 09:34:05 -0400 (EDT)
From:   Winston Weinert <winston@ml1.net>
To:     linux-raid@vger.kernel.org
Cc:     Jes Sorensen <jes@trained-monkey.org>,
        Winston Weinert <winston@ml1.net>
Subject: [PATCH v2] mdadm/md.4: update path to in-kernel-tree documentation
Date:   Wed, 22 Jul 2020 08:33:22 -0500
Message-Id: <20200722133321.8512-1-winston@ml1.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718103314.14549-1-winstonml1.net>
References: <20200718103314.14549-1-winstonml1.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Documentation/md.txt was renamed to Documentation/admin-guide/md.rst
in linux commit 9d85025b0418163fae079c9ba8f8445212de8568 (Oct 26,
2016).

Signed-off-by: Winston Weinert <winston@ml1.net>
---
I am sending this updated patch which includes a sign-off, fixes a
commit message typo, and CC's Jes Sorensen. I hope it is up to
standards.

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

