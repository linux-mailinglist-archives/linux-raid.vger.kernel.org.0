Return-Path: <linux-raid+bounces-1186-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD28803CD
	for <lists+linux-raid@lfdr.de>; Tue, 19 Mar 2024 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D06D1F232A8
	for <lists+linux-raid@lfdr.de>; Tue, 19 Mar 2024 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A262D39851;
	Tue, 19 Mar 2024 17:43:38 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E48381D1
	for <linux-raid@vger.kernel.org>; Tue, 19 Mar 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870218; cv=none; b=tRKRVpTBPTUNZecuOrvUdcjFbR/QCti2V3XPGRvFBPdjxS40pEZs//91Cy8c+bItMAKsUFehfyTZwE4lhAg+MF3tAijR87zAhouxd+KysU1k5shYs+/MNMQ+qYUxrAUGBkKYDBrA/92smhWc0VRYnIiU56ohR4d9NZEmZJZtKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870218; c=relaxed/simple;
	bh=XwjV1ONnhw54lBb8Ub8ulIUlclmCOyoIQO4wJ3cVGJY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FLr36IdOl1G74boV0mWZD2yCGV5d77N9P/MfLQzJ2G2Qo+34WmtCaYAVnpbxxnHZb8C3x2PBqy7D6OYoVVeMIPsu3QUtSOylw+nqnhCrk9AxQ7xD4Kh1WU1LJrIPhmKTFT5ZJkGgG/YDzwMFhY6MEEj58Y1F+HCR3XQQLBogpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reinelt.co.at; spf=pass smtp.mailfrom=reinelt.co.at; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reinelt.co.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reinelt.co.at
Received: from artus.reinelt.local (unknown [91.113.221.42])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4TzfG85VmZzRnDC
	for <linux-raid@vger.kernel.org>; Tue, 19 Mar 2024 18:43:28 +0100 (CET)
Message-ID: <58c66b62d0da6e5173d7f313aca27cd325aa0afb.camel@reinelt.co.at>
Subject: Re: heavy IO on nearly idle RAID1
From: Michael Reinelt <michael@reinelt.co.at>
To: linux-raid@vger.kernel.org
Date: Tue, 19 Mar 2024 18:43:28 +0100
In-Reply-To: <CAAMCDecDjUyLJi7QP9cmxOQfnsJdzbYDv70Ed0uB8uuf2Ry6-Q@mail.gmail.com>
References: <a0b4ad1c053bd2be00a962ff769955ac6c3da6cd.camel@reinelt.co.at>
	 <abae1cb3-2ab1-d6cb-5c31-3714f81ef930@huaweicloud.com>
	 <d26f7e96192abbbebd39448afe9a45e2fdd63d21.camel@reinelt.co.at>
	 <ae0328a65c8a8df66dee1779036a941d2efd8902.camel@reinelt.co.at>
	 <CAAMCDecDjUyLJi7QP9cmxOQfnsJdzbYDv70Ed0uB8uuf2Ry6-Q@mail.gmail.com>
Disposition-Notification-To: michael@reinelt.co.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Good Point, thanks!

but I doubt that:

- I see heavy flickering of the USB Drive LED
- the system has a very bad "responsiveness", it kind of "freezes" very oft=
en

none of these I see neither with Kernel 6.1 nor with 6.6 / UAS disabled

Michael


--=20
Michael Reinelt <michael@reinelt.co.at>
Ringsiedlung 75
A-8111 Gratwein-Stra=C3=9Fengel
+43 676 3079941

