Return-Path: <linux-raid+bounces-4118-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C84AADF03
	for <lists+linux-raid@lfdr.de>; Wed,  7 May 2025 14:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCD99A3C1E
	for <lists+linux-raid@lfdr.de>; Wed,  7 May 2025 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE325F783;
	Wed,  7 May 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5Rp7Hqu"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BA25EF85
	for <linux-raid@vger.kernel.org>; Wed,  7 May 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620413; cv=none; b=DaMlhNUTupIHJKORSYdle3Rw8JtkfcOsKn9T3+xcdwQPghnXqSpf1qTQL8uafxldgDIzo2PGaxk2e/y9knr+FT8PJNdjEoHxZJIxmCKB2dWnYGVpRIy3EhPcj8g7Jw8RBNL2tXU9iE1rmMXdaieFAKoM1326QZdbZazRCA/gbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620413; c=relaxed/simple;
	bh=a8ZNTC+T29/RLzU7R0EqW/xCkzXah8cEo/SXPGkp45A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=chEGWhrLtpyBEJEGjwfdfVQP8V5PN+dkRH2NanibwhPNoj7r6Ul4GBtU1v/efJmTfC1Pgb63XxDmWGB2X2KLO5KhsvO/rEKNufd2VhI7RKWEcgPCQxs4Kc3W1svFxCjjKosFl4UI2+NrmMD+RHVTq+AcD/Tv6xjI5FqanPrwSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5Rp7Hqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746620410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=csu71ru98toOUlFXxh38IbPFscDsNRI8CV50Lbsxhq0=;
	b=X5Rp7HquReYPY/KzoW3cpgzmshRt8D12sFd/D9aYnu1CoIyV6scr7dpeVLoUQMhzaOpgq9
	zndQ1qfBdsUEXqM5mD8yVsC4V+4+Wc/jjz3coUIg4+pRqkJET/vXhs2H7suVXohbODOMVg
	98iZ9kMA1nbbq38iIeo6tRMDICg0bu0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-dsVOkdl_M9m7T-ezf_srzQ-1; Wed,
 07 May 2025 08:20:09 -0400
X-MC-Unique: dsVOkdl_M9m7T-ezf_srzQ-1
X-Mimecast-MFC-AGG-ID: dsVOkdl_M9m7T-ezf_srzQ_1746620408
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E9241800ECB;
	Wed,  7 May 2025 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFA94195605A;
	Wed,  7 May 2025 12:20:05 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: linux-raid@vger.kernel.org
Cc: mtkaczyk@kernel.org,
	ncroxon@redhat.com
Subject: [PATCH 0/3] mdadm: minor fixes
Date: Wed,  7 May 2025 20:19:59 +0800
Message-Id: <20250507122002.20826-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

There are some building errors and regression bug.
The PR is at https://github.com/md-raid-utilities/mdadm/pull/178

Xiao Ni (3):
  mdadm: use standard libc nftw
  mdadm: fix building errors
  mdadm: add attribute nonstring for signature

 lib.c            | 22 ----------------------
 platform-intel.h |  2 +-
 super-ddf.c      |  9 +++++----
 super-intel.c    |  3 ++-
 4 files changed, 8 insertions(+), 28 deletions(-)

-- 
2.32.0 (Apple Git-132)


