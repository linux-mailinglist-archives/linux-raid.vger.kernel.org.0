Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE8C201C
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfI3LsP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 07:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfI3LsP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Sep 2019 07:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5882859FB;
        Mon, 30 Sep 2019 11:48:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B5F15D6D0;
        Mon, 30 Sep 2019 11:48:12 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com, jes.sorensen@gmail.com,
        zlliu@suse.com
Subject: [mdadm PATCH 2/2] Don't need to check recovery after re-add when no I/O writes to raid
Date:   Mon, 30 Sep 2019 19:48:00 +0800
Message-Id: <1569844080-5816-3-git-send-email-xni@redhat.com>
In-Reply-To: <1569844080-5816-1-git-send-email-xni@redhat.com>
References: <1569844080-5816-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 30 Sep 2019 11:48:14 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If there is no write I/O between removing member disk and re-add it, there is no
recovery after re-adding member disk.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 clustermd_tests/02r1_Manage_re-add | 2 --
 1 file changed, 2 deletions(-)

diff --git a/clustermd_tests/02r1_Manage_re-add b/clustermd_tests/02r1_Manage_re-add
index dd9c416..d0d13e5 100644
--- a/clustermd_tests/02r1_Manage_re-add
+++ b/clustermd_tests/02r1_Manage_re-add
@@ -9,8 +9,6 @@ check all state UU
 check all dmesg
 mdadm --manage $md0 --fail $dev0 --remove $dev0
 mdadm --manage $md0 --re-add $dev0
-check $NODE1 recovery
-check all wait
 check all state UU
 check all dmesg
 stop_md all $md0
-- 
2.7.5

