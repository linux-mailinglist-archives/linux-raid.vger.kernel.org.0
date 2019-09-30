Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F282C201A
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfI3LsG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 07:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfI3LsG (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Sep 2019 07:48:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D75118C8914;
        Mon, 30 Sep 2019 11:48:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3659B5D70D;
        Mon, 30 Sep 2019 11:48:02 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com, jes.sorensen@gmail.com,
        zlliu@suse.com
Subject: [mdadm PATCH 0/2] Fix two bugs of md cluster testing
Date:   Mon, 30 Sep 2019 19:47:58 +0800
Message-Id: <1569844080-5816-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 30 Sep 2019 11:48:06 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Xiao Ni (2):
  Init devlist as an array
  Don't need to check recovery after re-add when no I/O writes to raid

 clustermd_tests/02r1_Manage_re-add | 2 --
 clustermd_tests/func.sh            | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.5

