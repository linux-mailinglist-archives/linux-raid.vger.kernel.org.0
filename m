Return-Path: <linux-raid+bounces-297-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6C8263E2
	for <lists+linux-raid@lfdr.de>; Sun,  7 Jan 2024 12:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89AA1C20D76
	for <lists+linux-raid@lfdr.de>; Sun,  7 Jan 2024 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F179D12E43;
	Sun,  7 Jan 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=newsletter.dpss.psy.unipd.it header.i=@newsletter.dpss.psy.unipd.it header.b="kWAdhWPj"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtprelay.unipd.it (bronze-hyde.cca.unipd.it [147.162.10.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0B12E48
	for <linux-raid@vger.kernel.org>; Sun,  7 Jan 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=newsletter.dpss.psy.unipd.it
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=newsletter.dpss.psy.unipd.it
Received: from mydoom.unipd.it (mydoom.unipd.it [147.162.10.8])
	by smtprelay.unipd.it (Postfix) with ESMTP id ECE289A7A
	for <linux-raid@vger.kernel.org>; Sun,  7 Jan 2024 12:23:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by localhost.unipd.it (Postfix) with ESMTP id EED241F33
	for <linux-raid@vger.kernel.org>; Sun,  7 Jan 2024 12:23:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at unipd.it
Received: from mydoom.unipd.it ([127.0.0.1])
	by localhost (unipd.it [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id jU1OwPUJNPcl for <linux-raid@vger.kernel.org>;
	Sun,  7 Jan 2024 12:22:59 +0100 (CET)
Received: from newsletter.dpss.psy.unipd.it (unknown [147.162.131.7])
	by mydoom.unipd.it (Postfix) with ESMTP id 65E9B1F32
	for <linux-raid@vger.kernel.org>; Sun,  7 Jan 2024 12:22:59 +0100 (CET)
Received: by newsletter.dpss.psy.unipd.it (Postfix, from userid 0)
	id 58FF120072; Sun,  7 Jan 2024 12:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=newsletter.dpss.psy.unipd.it; s=selector1; t=1704626580;
	bh=gKgpJB5nL4/l3B8d75sJM81oyKqtCy6vtTmVzS6Qguo=;
	h=Date:From:To:Subject:From;
	b=kWAdhWPjFgsVIGR5x6YYcuT4jihFPRtNgNhoolVV4rizcIFolmHpShc6hohXdCDyr
	 pdq4004yvUoPdEmQcDRYi4acvWpTYH9UNgFEUPBo/E1mNLmFSZpqukwx0WeUNfROJM
	 quLk6hF39X7ftxUndAvaglboXo4AIIlMtbCCduLVvw+TeoahrmizGpn9d9atEIywkv
	 bOpro/ZzLnQ9rZipIcZlWvNwX8eXHiZOrJNdkqgQvEx6Uj0UPPE2OnGtxy+KKnoStA
	 vlyUaHT62GBkB2Twhd9RyTSPpuiDtsaJ5x2PxG9ZiqxxAiVR54NBKt/crE7Y76DjE3
	 1pUo7C4XJR1iQ==
Date: Sun, 7 Jan 2024 12:23:00 +0100
From: Andrea Janna <andrea1@newsletter.dpss.psy.unipd.it>
To: linux-raid@vger.kernel.org
Subject: mdadm: --update=resync not understood for 1.x metadata
Message-ID: <ZZqJlCToUS3Qrl4J@bianca.dpss.psy.unipd.it>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After upgrading mdadm from released version mdadm-4.2 to the current git version the command
mdadm --assemble --update=resync
started failing with the error "mdadm: --update=resync not understood for 1.x metadata".
My array superblock version is 1.0.

I think this is a regression introduced by https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/commit/?id=7e8daba8b7937716dce8ea28298a4e2e72cb829e
This commit deleted the "else if (strcmp(update, "resync") == 0)" code block without replacing it with a switch case.

The following patch fixed the error for me.

diff --git a/super1.c b/super1.c
index dfde4629..6f23b9eb 100644
--- a/super1.c
+++ b/super1.c
@@ -1356,6 +1356,10 @@ static int update_super1(struct supertype *st, struct mdinfo *info,
 			__cpu_to_le16(info->disk.raid_disk);
 		break;
 	}
+	case UOPT_RESYNC:
+		/* make sure resync happens */
+		sb->resync_offset = 0;
+		break;
 	case UOPT_UUID:
 		copy_uuid(sb->set_uuid, info->uuid, super1.swapuuid);
 

Regards,
Andrea Janna

