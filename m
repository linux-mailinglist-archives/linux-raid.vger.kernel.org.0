Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1C1C3FCC
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgEDQ1w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 12:27:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40178 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728158AbgEDQ1w (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 12:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588609671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8sPMtKgW3PIyY0KRS2/SV1HFDrwTpMyUc6LcL6Zo/bc=;
        b=LIvNrP3hZQIfDYvvAPekbDx/taGaYqPGQeo/4gT5XZdqJrErv3OBvhyDLZJUqlGZiM2l+x
        tJs4q6rmOKAEZlHUvofrD/BsXERqUmBrmydbmMB1iPcw8jGuOLdckbCwFpph/zFNYt/Vcg
        sinLIZ2jvtcr9wsNsMkrJ6Ni2qdR5tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-GOtRlSh8PUejIZaI4c_0cA-1; Mon, 04 May 2020 12:27:47 -0400
X-MC-Unique: GOtRlSh8PUejIZaI4c_0cA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA2D718FF660;
        Mon,  4 May 2020 16:27:46 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77DBD2C25B;
        Mon,  4 May 2020 16:27:46 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     jes@trained-monkey.org, linux-raid@vger.kernel.org
Subject: [PATCH] clean up meaning of small typo
Date:   Mon,  4 May 2020 12:27:45 -0400
Message-Id: <20200504162745.22665-1-ncroxon@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Clean up the typo which leads to wrong understanding.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 mdadm.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 5d00faf..484644e 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -2872,7 +2872,7 @@ operation, as described below under LAYOUT CHANGES.
=20
 .SS CHUNK-SIZE AND LAYOUT CHANGES
=20
-Changing the chunk-size of layout without also changing the number of
+Changing the chunk-size or layout without also changing the number of
 devices as the same time will involve re-writing all blocks in-place.
 To ensure against data loss in the case of a crash, a
 .B --backup-file
--=20
2.20.1

