Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB962343C3
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jul 2020 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgGaJ4E (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jul 2020 05:56:04 -0400
Received: from mail.synology.com ([211.23.38.101]:59390 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732196AbgGaJ4E (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 31 Jul 2020 05:56:04 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2020 05:56:03 EDT
Received: from localhost.localdomain (unknown [10.17.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 18847CE782BF;
        Fri, 31 Jul 2020 17:50:11 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1596189011; bh=PA5QdutyYc2ZH4SXSufhrGUjGcYxBnUZ1CsTlJ3UvA0=;
        h=From:To:Cc:Subject:Date;
        b=lId1YLu8wjOxSVoLYVbnmrv6h1eC+lMQWMHxzgDJTPwGSVaOCdjLYOuTbn6FoK2mM
         q69hr9sB4ZYE6VSJI4JBis/ngCno3A+O7QNJiUqgp/HrcC3Tq/bLeeTe0MpSl6n6vu
         PIkyqn3J3qnkRvbC5QGDfzSy5nQDqNhsQdRuSUuk=
From:   allenpeng <allenpeng@synology.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, ChangSyun Peng <allenpeng@synology.com>
Subject: [PATCH 0/2] Fix RCW bug and allow degraded raid6 do rmw
Date:   Fri, 31 Jul 2020 17:49:58 +0800
Message-Id: <1596188998-2994-1-git-send-email-allenpeng@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: ChangSyun Peng <allenpeng@synology.com>

This patch fix io stuck in force reconstruct-write degraded raid5
problem and allow degraded raid6 do rmw.

ChangSyun Peng (2):
  md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
  md/raid5: Allow degraded raid6 to do rmw

 drivers/md/raid5.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.7.4

