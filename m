Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97633E87F
	for <lists+linux-raid@lfdr.de>; Wed, 17 Mar 2021 05:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCQEiB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Mar 2021 00:38:01 -0400
Received: from mail.snapdragon.cc ([103.26.41.109]:37894 "EHLO
        mail.snapdragon.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQEiA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 17 Mar 2021 00:38:00 -0400
Received: by mail.snapdragon.cc (Postfix, from userid 65534)
        id EC9AD19E0448; Wed, 17 Mar 2021 04:37:54 +0000 (UTC)
From:   Manuel Riel <manu@snapdragon.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=snapdragon.cc;
        s=default; t=1615955874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hv9952StmTKGHcH1kUljNiQd9kzt41vsqcMmd/H+9Bk=;
        b=AmAjY8Za4UvDF6j9KQ41dXxYBQlirxKBX3W6Lz2LOgX05C5+8rxb8TxMl9LHnuy6CGjnd/
        Nh66b8MusAbpjjS7+Xed7m4xubizoXblctCae6lcmE3sBkJof1Ji4Qhh2eRRGrvljvBoKR
        IUVKyVaQ3rVRXifIYC8dnOTR5TnZwc4=
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [PATCH] md: warn about using another MD array as write journal
Message-Id: <DAEB6C2F-3AE0-4EBE-8775-7C6292F8749A@snapdragon.cc>
Date:   Wed, 17 Mar 2021 12:37:52 +0800
Cc:     Vojtech Myslivec <vojtech@xmyslivec.cz>
To:     Linux-RAID <linux-raid@vger.kernel.org>, Song Liu <song@kernel.org>
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

To follow up on a previous discussion[1] about stuck RAIDs, I'd like to =
propose adding a warning
about this to the relevant docs. Specifically users shouldn't add other =
MD arrays as journal device.

Ideally mdadm would check for this, but having it in the docs is useful =
too.

1: =
https://lore.kernel.org/linux-btrfs/d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@x=
myslivec.cz/

---

diff --git a/Documentation/driver-api/md/raid5-cache.rst =
b/Documentation/driver-api/md/raid5-cache.rst
index d7a15f44a..128044018 100644
--- a/Documentation/driver-api/md/raid5-cache.rst
+++ b/Documentation/driver-api/md/raid5-cache.rst
@@ -17,7 +17,10 @@ And switch it back to write-through mode by::
        echo "write-through" > /sys/block/md0/md/journal_mode

 In both modes, all writes to the array will hit cache disk first. This =
means
-the cache disk must be fast and sustainable.
+the cache disk must be fast and sustainable. The cache disk also can't =
be
+another MD RAID array, since such a nested setup can cause problems =
when
+assembling an array or lead to the primary array getting stuck during
+operation.

 write-through mode
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
