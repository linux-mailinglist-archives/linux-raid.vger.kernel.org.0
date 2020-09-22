Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D60273A70
	for <lists+linux-raid@lfdr.de>; Tue, 22 Sep 2020 07:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgIVF6L (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Sep 2020 01:58:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgIVF6L (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 22 Sep 2020 01:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600754290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SeE9F9QUZiKaTzmDNRzyuLIgX+1ztFrgnnH4nQd6lnE=;
        b=MBo9o7WHtcPaYD8mj39twmFr2rtWcdIA4Tp8PX4Us1v+XjZ09bPKapBKy8o9AADFQ4K/DC
        a5zgac5X7W8XKzveDdObEkzMHh+AqiKJyGbxZYBkKn3jvh3DpmEagyFHPf6vPyJYsADKi8
        fpLBgA7ZInII1tuC5n6kUixaizmXBBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-zBNG3bhRNc-c6pLnH27urw-1; Tue, 22 Sep 2020 01:58:08 -0400
X-MC-Unique: zBNG3bhRNc-c6pLnH27urw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED711005E65;
        Tue, 22 Sep 2020 05:58:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB0D5DA30;
        Tue, 22 Sep 2020 05:58:04 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org, songliubraving@fb.com
Cc:     lkp@intel.com, ncroxon@redhat.com
Subject: [PATCH 1/1] md/raid10: Change the return type of raid10_handle_discard to int
Date:   Tue, 22 Sep 2020 13:58:02 +0800
Message-Id: <1600754282-3982-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now the return type of raid10_handle_discard is bool. This is wrong.
Change the return type to int.

Reported-by: kernel test robot <lkp@intel.com>
fixes: 8f694215ae4c (md/raid10: improve raid10 discard request)
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 524344c..6401e6a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1591,7 +1591,7 @@ static void raid10_end_discard_request(struct bio *bio)
  * 2st, if the discard bio spans reshape progress, we use the old way to
  * handle discard bio
  */
-static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
+static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r10conf *conf = mddev->private;
 	struct geom *geo = &conf->geo;
-- 
2.7.5

