Return-Path: <linux-raid+bounces-1-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C313C7F22A9
	for <lists+linux-raid@lfdr.de>; Tue, 21 Nov 2023 01:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B706B21764
	for <lists+linux-raid@lfdr.de>; Tue, 21 Nov 2023 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885017EC;
	Tue, 21 Nov 2023 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s1mc6Sz/"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE117CA
	for <linux-raid@vger.kernel.org>; Tue, 21 Nov 2023 00:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41409C433C8;
	Tue, 21 Nov 2023 00:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528306;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=s1mc6Sz/taECsK4TChdetESoMDgDifHzWLza7y++yTfWOvgTf89yXuwvAxDsv4LF0
	 LoeNDs3ccaf2DaMHDKAJJYT20avrgGDuMyUh34rlov0rg0/9URnD22Dq/fL0Ihi/Xg
	 tVPu447EuoUgriWqFW8ep47ksIJ48KukfWTUO6lk=
Date: Mon, 20 Nov 2023 19:58:25 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-raid@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-merciful-celadon-dog-eec89a@nitro>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

