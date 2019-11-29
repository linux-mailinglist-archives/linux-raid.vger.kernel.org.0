Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2D10D314
	for <lists+linux-raid@lfdr.de>; Fri, 29 Nov 2019 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfK2JO7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 Nov 2019 04:14:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2JO7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 29 Nov 2019 04:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575018898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2xRSEb1Q8igWzsPaAdFpDSchh5IB3+gcGiZlzmvxGxs=;
        b=fR8t8r9veSP2hDEQWOR1v9s7BfVhGfPXbtEC68sz9FccSXOMOdhbwsq9XLHALG1iAKO2DU
        PdYLlHf/y7jKxjfDkEYdTQbsJT4ZmMPqzisqFN2Y3gNeKBtQmdxHTAijdhU3P4VJap1gFf
        MhfzohEVWdQ1Fg89hLfOjGaweGcuIa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-O3jdRU5OP-yE7BnOirOpSw-1; Fri, 29 Nov 2019 04:14:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F41DD107ACFB;
        Fri, 29 Nov 2019 09:14:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F050119C5B;
        Fri, 29 Nov 2019 09:14:51 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes.sorensen@gmail.com
Cc:     artur.paszkiewicz@intel.com, linux-raid@vger.kernel.org
Subject: [PATCH 1/1] Remove unused code
Date:   Fri, 29 Nov 2019 17:14:47 +0800
Message-Id: <1575018887-5138-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: O3jdRU5OP-yE7BnOirOpSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 platform-intel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/platform-intel.h b/platform-intel.h
index 29c85f1..7cb370e 100644
--- a/platform-intel.h
+++ b/platform-intel.h
@@ -169,7 +169,6 @@ static inline int fls(int x)
 =09=09r -=3D 2;
 =09}
 =09if (!(x & 0x80000000u)) {
-=09=09x <<=3D 1;
 =09=09r -=3D 1;
 =09}
 =09return r;
--=20
2.7.5

