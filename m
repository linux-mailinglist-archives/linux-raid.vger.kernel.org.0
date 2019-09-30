Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA5C201B
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfI3LsL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 07:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfI3LsL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Sep 2019 07:48:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9D2483F42;
        Mon, 30 Sep 2019 11:48:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C40555D6D0;
        Mon, 30 Sep 2019 11:48:06 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com, jes.sorensen@gmail.com,
        zlliu@suse.com
Subject: [mdadm PATCH 1/2] Init devlist as an array
Date:   Mon, 30 Sep 2019 19:47:59 +0800
Message-Id: <1569844080-5816-2-git-send-email-xni@redhat.com>
In-Reply-To: <1569844080-5816-1-git-send-email-xni@redhat.com>
References: <1569844080-5816-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 30 Sep 2019 11:48:11 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

devlist is an string. It will change to an array if there is disk that
is sbd disk. If one device is sbd, it runs devlist=().
This line code changes devlist from a string to an array. If there is
no sbd device, it can't run this line code. So it will still be a string.
The later codes need an array, rather than an string. So init devlist
as an array to fix this problem.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 clustermd_tests/func.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/clustermd_tests/func.sh b/clustermd_tests/func.sh
index 642cc96..801d604 100644
--- a/clustermd_tests/func.sh
+++ b/clustermd_tests/func.sh
@@ -39,6 +39,9 @@ fetch_devlist()
 		devlist=($(ls /dev/disk/by-path/*$ISCSI_ID*))
 	fi
 	# sbd disk cannot use in testing
+	# Init devlist as an array
+	i=''
+	devlist=(${devlist[@]#$i})
 	for i in ${devlist[@]}
 	do
 		sbd -d $i dump &> /dev/null
-- 
2.7.5

