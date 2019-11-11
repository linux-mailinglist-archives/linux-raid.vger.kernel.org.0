Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C943F77B0
	for <lists+linux-raid@lfdr.de>; Mon, 11 Nov 2019 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKPct (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 Nov 2019 10:32:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726832AbfKKPct (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 Nov 2019 10:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573486368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5k784BMrZ5EgyEqGRYbQSGdUC3hlLZKCwTPyryZhNJM=;
        b=QfDSHEZt1BQusLrTAc8zbxRCW7AtbDwPZ4XrPW2XUHLffvTSxQSNhypdKrcux9kh0GYoLu
        YlxF/ybNqvCntXZnf8TEvD8yj6CB+x8Bgk2yUqyU454jW2biR4VXRVm3z2vxP5fjxpL8M3
        KdPFamq0D4SlabTTTJt0fBzoeqmcuT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-GIo60OJxNsWzDQs8ajvYtA-1; Mon, 11 Nov 2019 10:32:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A668017E0;
        Mon, 11 Nov 2019 15:32:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-218.rdu2.redhat.com [10.10.121.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A836C28D0C;
        Mon, 11 Nov 2019 15:32:45 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, xni@redhat.com, ncroxon@redhat.com,
        loberman@redhat.com, djeffery@redhat.com, minlei@redhat.com,
        John Pittman <jpittman@redhat.com>
Subject: [PATCH] md/raid10: prevent access of uninitialized resync_pages offset
Date:   Mon, 11 Nov 2019 10:32:43 -0500
Message-Id: <20191111153243.9588-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GIo60OJxNsWzDQs8ajvYtA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Due to unneeded multiplication in the out_free_pages portion of
r10buf_pool_alloc(), when using a 3-copy raid10 layout, it is
possible to access a resync_pages offset that has not been
initialized.  This access translates into a crash of the system
within resync_free_pages() while passing a bad pointer to
put_page().  Remove the multiplication, preventing access to the
uninitialized area.

Fixes: f0250618361db ("md: raid10: don't use bio's vec table to manage resy=
nc pages")
Signed-off-by: John Pittman <jpittman@redhat.com>
Suggested-by: David Jeffery <djeffery@redhat.com>
---
 drivers/md/raid10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 299c7b1c9718..8a62c920bb65 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -191,7 +191,7 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags, void *=
data)
=20
 out_free_pages:
 =09while (--j >=3D 0)
-=09=09resync_free_pages(&rps[j * 2]);
+=09=09resync_free_pages(&rps[j]);
=20
 =09j =3D 0;
 out_free_bio:
--=20
2.17.2

