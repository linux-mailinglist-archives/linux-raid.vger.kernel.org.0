Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0120EFF8
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jun 2020 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgF3Hzu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jun 2020 03:55:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730223AbgF3Hzu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jun 2020 03:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593503749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=0r0oMPGb6DG7iioztitCtow6HVu9FmDjdH53sts4dtY=;
        b=DyOz5ZCaTrrbd6uP7Y3Lfj/+ZHNmWm0sJB5g+7OXjl367C37ZVKg7dsuasSjhKHb/fX+3I
        yswiyKOGYNm3svz5cwvgaJ0RJVlWiCiCUDSHN5hgKTPynnqnyo8bSRXhOHYU2/LCkS17nG
        Qd9hb1EXKRaz0lJDhpHzc50uOFQR2+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-IW4qXV_-NdWDUuBjv7alGQ-1; Tue, 30 Jun 2020 03:55:47 -0400
X-MC-Unique: IW4qXV_-NdWDUuBjv7alGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C6EA8015F3;
        Tue, 30 Jun 2020 07:55:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A939C74183;
        Tue, 30 Jun 2020 07:55:44 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, ncroxon@redhat.com
Subject: [PATCH 2/2] Don't need to reset superblock start address for super1.0
Date:   Tue, 30 Jun 2020 15:55:37 +0800
Message-Id: <1593503737-5067-3-git-send-email-xni@redhat.com>
In-Reply-To: <1593503737-5067-1-git-send-email-xni@redhat.com>
References: <1593503737-5067-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The superblock start address doesn't change after creating raid device. It always at the end
of the device(end_pos-8*2).

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d2c5984..9de9c0e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2209,7 +2209,6 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 
 		if (!num_sectors || num_sectors > max_sectors)
 			num_sectors = max_sectors;
-		rdev->sb_start = sb_start;
 	}
 	sb = page_address(rdev->sb_page);
 	sb->data_size = cpu_to_le64(num_sectors);
-- 
2.7.5

