Return-Path: <linux-raid+bounces-1232-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4388D3B8
	for <lists+linux-raid@lfdr.de>; Wed, 27 Mar 2024 02:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D541C251D7
	for <lists+linux-raid@lfdr.de>; Wed, 27 Mar 2024 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1101BF3F;
	Wed, 27 Mar 2024 01:27:43 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188A3DAC0D;
	Wed, 27 Mar 2024 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502863; cv=none; b=rK5dCjPBykXGFtuLbAqPcdHG7S4gZSkdur9gKmziasOwjhEvJfivxsp0SoxF1k9IwGyeN0oBPxYDhA0dHgB+v+ntVZJ6+BQjKehgw++QWcDgi4p14eIS4qCr0AoxuZmHXkc2LSPp4XFXl7YlTfqCclMfqstQtwwh/dgMwlk0LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502863; c=relaxed/simple;
	bh=zVg5O3wsiJKYJ8Is9mWAxtglVlYiS8fSvcnUzjl61bE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAz9snt8NPsvtmUMgsg8byeGbcrqVYd7XhHI3ICjfzVbImzarEjZI+l94bfjIGqBAVDuNCX6pJ4hYXUZUu8i9icre3DW9/8Ml8/lSFySTVHpM9KfN81RqtpwwJ/vunk6t7CDaKnsiW2QC0q1Jy/w/czH0RZXeD6+4tceShCOEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 42R1RMuI3953510; Wed, 27 Mar 2024 10:27:22 +0900
X-Iguazu-Qid: 2rWgdkpBNqpP8I2LWS
X-Iguazu-QSIG: v=2; s=0; t=1711502842; q=2rWgdkpBNqpP8I2LWS; m=n1qdayTa9w8M4H4sPbw9HV/SO3esIlWbNi0a08j1J4U=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1123) id 42R1RLup3221249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Mar 2024 10:27:21 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id 0E4C62F014;
	Wed, 27 Mar 2024 10:27:21 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 66D5D1900001E1;
	Wed, 27 Mar 2024 10:14:54 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003LAAAAAA00642;
	 Wed, 27 Mar 2024 10:14:54 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 5B3EBA29C5E28;
	Wed, 27 Mar 2024 10:14:54 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 10:27:19 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Wed,
 27 Mar 2024 10:27:19 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, "song@kernel.org" <song@kernel.org>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai (C)"
	<yukuai3@huawei.com>
Subject: Re: [PATCH 00/11] md: avoid counter operation conflicts
Thread-Topic: [PATCH 00/11] md: avoid counter operation conflicts
Thread-Index: Adp/Y1jSZkz1OENpR0iwTWSI17JctP//rrSA//7ETZA=
Date: Wed, 27 Mar 2024 01:27:19 +0000
Message-ID: <481dc71231494b729b13dcc7392deb00@kioxia.com>
References: <a022f547c43e40e2b9f0aebb2bd0bfa8@kioxia.com>
 <140c7f16-4c2a-390a-7021-53d3723626ec@huaweicloud.com>
In-Reply-To: <140c7f16-4c2a-390a-7021-53d3723626ec@huaweicloud.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28276.001
x-tm-as-result: No-10--7.663500-8.000000
x-tmase-matchedrid: gIzQ6PxOy4OmagT1k9kBpu5i6weAmSDKKQNhMboqZlrGZbX3v50Wr423
	cEKfZk4cPzfUQuvyrgx/g7iVBplYS0xUhXAIWfA4uy1sIsdu6VLCw5dmm1Y3wFKFfeM8C6d1GNt
	H9cKwddYoeLEhOyw4QQS2kVlHSIV7i4F4IRlS0JJpR7+L0B6mE9DEMPvvoocvlLc3nRzXiU0uEy
	MxU5vQY30tCKdnhB58O5QxsrU10s/6C0ePs7A07fcUt5lc1lLgNedi3nDhxyNCPrpj5CJTkIoz9
	feK2Qv7yf3ziYviPcsK+6p60COouKvLg3ZiEGlBpmkSxX1HTig=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.663500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28276.001
x-tm-snts-smtp: AB5E7A0EA1609AA99F961EBC9FF6BC8D3D1D551E1553425C88D43C09FA601D152000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com

>> Currently, active_aligned_reads and nr_pending used as counters are atom=
ic types.
>> Therefore, when inc/dec in a multi-core results in conflicts.
>
> I don't uderstand what's the problem here, what's wrong with atomic
> types in a multi-core system?

Hi Kuai

This patch is not a fix for the problem, but an improvement.
This patch makes the counter inc/dec faster.

For the same reason, active_io was changed from atomic_t to percpu_ref.
https://marc.info/?l=3Dlinux-raid&m=3D167514225920879

Thanks,
Keisuke


