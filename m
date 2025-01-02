Return-Path: <linux-raid+bounces-3382-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14C9FF8F2
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jan 2025 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEF418825C7
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jan 2025 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75911917EE;
	Thu,  2 Jan 2025 11:49:10 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from harvie.cz (harvie.cz [77.87.242.242])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFAAA95E
	for <linux-raid@vger.kernel.org>; Thu,  2 Jan 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.87.242.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735818550; cv=none; b=EJ9VOU5i31EFBtZEa6E2VcUXXXP6UzZstE3EY0YnJ5DO6sToI0v59cjB/kFzbpJqaiB/lrnouyBZrabshvM5nC/5ipfepEsWnwmSPF76Nsrr8u4Z46G/GwcRv5zK78RXlBuu8R5ikru7rIMDLCoVQVaU8pzXRt5Rpc9hTXF5mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735818550; c=relaxed/simple;
	bh=k1ACSBOvubrlLpMn1i429xDO8nCIdp0KYm4IgC033mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ1qgRSMXcC+Lo8JLtagcovuUbzKCYfVMix4ncjlXsu2ZKPEcxq1iPYsUyirTjfUVUO5tY4qH4En0okTOdIPOjd2k2+SDMbEXhbzbbP+6gmeDvwkAGM28FD84nOgXUAp+DuKCxjG3N9qpcj5GEjXYokgZxngTfmMzqEWM1XabyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=77.87.242.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by harvie.cz (Postfix) with ESMTPSA id 4EC7F180187;
	Thu,  2 Jan 2025 12:49:00 +0100 (CET)
From: Tomas Mudrunka <tomas.mudrunka@gmail.com>
To: yukuai1@huaweicloud.com
Cc: linux-raid@vger.kernel.org,
	mtkaczyk@kernel.org,
	song@kernel.org,
	tomas.mudrunka@gmail.com,
	yukuai3@huawei.com,
	yukuai@kernel.org
Subject: Re: [PATCH] Export MDRAID bitmap on disk structure in UAPI header file
Date: Thu,  2 Jan 2025 12:48:44 +0100
Message-ID: <20250102114844.633313-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <b541044b-7550-313d-4252-1a13068c2fd7@huaweicloud.com>
References: <b541044b-7550-313d-4252-1a13068c2fd7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Just curious, what you guys do for filesystems like ext4/xfs, and
> they just define the same structure in user-space tools.
>
> looks like your tool do support to create ext4 images, and it's using
> ext4's use-space tools directly. If it's true, do you consider to use
> mdadm directly?
>
> Thanks,
> Kuai

Yes, we do use external tools when possible. It is not possible with mdadm.
Mdadm cannot create disk image of MD RAID array. Kernel does this.
We want/need purely userspace generator, so we don't have to care about
permissions, losetup, kernel-side mdraid runtime, etc... We just want
to generate valid image without involving kernel in any way.
I was using mdadm before switching to genimage and it adds complexity of
handling all the edge cases of kernel states.
Mkfs.ext4 can create image without involving kernel, mdadm cannot, it always
instructs kernel to create the metadata for it when creating array.

In my opinion we should decide whether it makes sense for kernel to export
the structures in header file and either provide all of them, or provide none.
That might be valid reasoning to say every userspace program should include
its own definitions of structures. But providing half does not make any sense.

I wonder if mdadm needs some of definitions that i have omitted from UAPI.

Tom

