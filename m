Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6826A012
	for <lists+linux-raid@lfdr.de>; Tue, 15 Sep 2020 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOHqY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Sep 2020 03:46:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbgIOHpJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Sep 2020 03:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600155899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9wjHp1jMiYI8TOhmbjxXJIuS85T3wAliI4DXXuRLxEU=;
        b=NcKimivBv1iVIERw8Ej0KgVmbdSgZaiM/LwUfoRipJ1IsxgMksdmW0wsmzmtWcTCj7rLIw
        cG4ggs3Bzsg14uro3tnnuZQfS0Ank+ugfbyzQ0gywcBJ9wiEAPWY/ZjpFT1N0KWhjonEP5
        fxhhJFJsV+s2DEc0AnOyx3qFf4QgIgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-VtYSMEL9O_KN1LiQRqf1rA-1; Tue, 15 Sep 2020 03:44:55 -0400
X-MC-Unique: VtYSMEL9O_KN1LiQRqf1rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ACBF425CF;
        Tue, 15 Sep 2020 07:44:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-36.pek2.redhat.com [10.72.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBDBD19C4F;
        Tue, 15 Sep 2020 07:44:51 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes@trained-monkey.org, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, antmbox@youngman.org.uk
Subject: [PATCH V2 2/2] Don't create bitmap for raid5 with journal disk
Date:   Tue, 15 Sep 2020 15:44:42 +0800
Message-Id: <1600155882-4488-3-git-send-email-xni@redhat.com>
In-Reply-To: <1600155882-4488-1-git-send-email-xni@redhat.com>
References: <1600155882-4488-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Journal disk and bitmap can't exist at the same time. It needs to check if the raid
has a journal disk when creating bitmap.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 Create.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Create.c b/Create.c
index 6f84e5b..0efa19c 100644
--- a/Create.c
+++ b/Create.c
@@ -542,6 +542,7 @@ int Create(struct supertype *st, char *mddev,
 	if (!s->bitmap_file &&
 	    s->level >= 1 &&
 	    st->ss->add_internal_bitmap &&
+	    s->journaldisks == 0 &&
 	    (s->consistency_policy != CONSISTENCY_POLICY_RESYNC &&
 	     s->consistency_policy != CONSISTENCY_POLICY_PPL) &&
 	    (s->write_behind || s->size > 100*1024*1024ULL)) {
-- 
2.7.5

