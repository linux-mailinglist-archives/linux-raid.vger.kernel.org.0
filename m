Return-Path: <linux-raid+bounces-4062-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB6BA9EAB7
	for <lists+linux-raid@lfdr.de>; Mon, 28 Apr 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AA31773C0
	for <lists+linux-raid@lfdr.de>; Mon, 28 Apr 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7225E46C;
	Mon, 28 Apr 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5Zpg+0i"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36471DE4C8
	for <linux-raid@vger.kernel.org>; Mon, 28 Apr 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828814; cv=none; b=oTlpmY8C/P44PpPmVfKqr9M7nzFYrnmo6jY95OEX4jC0dvTEt24k+YX4a1cWKm5I1RV7mmIEr7fD5tpja6vKh9mbO4elNEZyol0zF3Cl4S8a+28K6cdpQP/sFHp02RByS0TGypQy4zgnKO+IY1rINV3jVUPrZrhQocr2nLnNUcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828814; c=relaxed/simple;
	bh=DNwsHNw1cWU2scjzaFjU1n5zn0eV+VEASsgtXn9HNbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9B3BbGbLRFgYurrn0feoqNMTihXOjTo/wY/Ss6chVaVR7nXz396lCWlcCMsI5NcyIOuUOKe9udb0cDZjqnjMEM4gmN7FxEwcfAGNQLxcJdT8SfQYQZN+KhBnVzwlvonxsk0cQ7c+AY8O9RfpU4HAk2dRCCghB6qJl3aFFeOs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5Zpg+0i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745828811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5GKza0TV47Q8PdXUiqZTwaXQvxP3AzXrmiNZ38NF6ls=;
	b=g5Zpg+0iLcNdke51n/POmnx3H2p8zsm/0oKcsjHOJAX5RC2u/njxx2Q9BKCOKLGorjjT7D
	MxvJxnBjSGcW+Z7QOCh0LcThZkZDE078zMQQGBOaRjSac7cIC5YCq85nhvphY9OefNJk97
	Vw0JUe7G53WxI3kRG8aQJkx+hXx4ATg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-_Rpj0q_lMQGP89S5ljGgNQ-1; Mon,
 28 Apr 2025 04:26:49 -0400
X-MC-Unique: _Rpj0q_lMQGP89S5ljGgNQ-1
X-Mimecast-MFC-AGG-ID: _Rpj0q_lMQGP89S5ljGgNQ_1745828808
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0160C180087A;
	Mon, 28 Apr 2025 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3009D18001DA;
	Mon, 28 Apr 2025 08:26:43 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: linux-raid@vger.kernel.org
Cc: song@kernel.org,
	yukuai1@huaweicloud.com,
	ncroxon@redhat.com,
	mtkaczyk@kernel.org
Subject: [PATCH RFC 0/3] md: call del_gendisk in sync way
Date: Mon, 28 Apr 2025 16:26:38 +0800
Message-Id: <20250428082641.45027-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch clears some flags and counters related stopping an array
and calls del_gendisk in sync way.

This patch set can cause a deadlock when stopping imsm raid1, I'm
investigating this deadlock problem to resovle this.

Xiao Ni (3):
  md: replace MD_DELETED with MD_CLOSING
  md: replace ->openers with ->active
  md: call del_gendisk in sync way

 drivers/md/md.c | 67 ++++++++++++++++++++++---------------------------
 drivers/md/md.h | 13 ----------
 2 files changed, 30 insertions(+), 50 deletions(-)

-- 
2.32.0 (Apple Git-132)


