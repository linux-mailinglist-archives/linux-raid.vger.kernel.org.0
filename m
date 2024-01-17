Return-Path: <linux-raid+bounces-364-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5390830C92
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jan 2024 19:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367C2B244D5
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jan 2024 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA32377A;
	Wed, 17 Jan 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfcZ45Ei"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCD23763
	for <linux-raid@vger.kernel.org>; Wed, 17 Jan 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515425; cv=none; b=HClD7WRImqx8js7VurhLMCwrd8vLjgCGw5plnqDlv1aJZgXpGu0x+6qUKnArL3wmIpflj+KMDHlf7H1aeNN/fW3NbQVO2SJSzSML1Pe6X8vBrjZUv+exxCra7Q4JQRG2FNE/PZf8DhELADmz7YIqliG7w8/XtDdxtC/Mw6JC4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515425; c=relaxed/simple;
	bh=/Bwqt2zwkQo2RSJqt7glIplObBcQMf/piC86phvvbqY=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Received:Date:From:To:cc:Subject:Message-ID:MIME-Version:
	 Content-Type:X-Scanned-By; b=hLfo8qtZ9MpDi/aAgOJtKqZvrxtl1vGqItZFMXlxhNU/30Aj1IxaNddIqvFgpQgkfrJA8QzmUxVrVGR2LzAPID1UZArrQ6zKbiCQQEVV+jdHMSgVfi4BbkhCS52WuXEC5WGQrgZmWuTpr1W4xEb7HWjNlxJfotWYq++B71ztd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfcZ45Ei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705515422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=01qOeuTtwuT4QtrnMlATRFjFhlWBZPmNAkzB3btIlGQ=;
	b=dfcZ45EibNHxQ8lmLLA0XvL9C0tbPIykyesKCNwcAMqNTdN4zQYmj+hLjF8HinKTBGvM3E
	2ARSHYBp5u0ZZBIyiKM8Rfc6vk1lcGAxpV7U4QYnPZIjv76QPiTD2Sm0TuDP58dK3EbHWZ
	67/1IUq8fjwgqjb7KFP3N7DovfcugI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-WV5SPFb7MeqCa2ruMUcvLQ-1; Wed, 17 Jan 2024 13:16:58 -0500
X-MC-Unique: WV5SPFb7MeqCa2ruMUcvLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22602185A781;
	Wed, 17 Jan 2024 18:16:58 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12EF71BDB1;
	Wed, 17 Jan 2024 18:16:57 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D8FF630C039C; Wed, 17 Jan 2024 18:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D25D13FB50;
	Wed, 17 Jan 2024 19:16:57 +0100 (CET)
Date: Wed, 17 Jan 2024 19:16:57 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>, 
    David Jeffery <djeffery@redhat.com>, Li Nan <linan122@huawei.com>
cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
    Mike Snitzer <msnitzer@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>, 
    Benjamin Marzinski <bmarzins@redhat.com>
Subject: [PATCH 0/7] MD fixes for the LVM2 testsuite
Message-ID: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi

Here I'm sending MD patches that fix the LVM2 testsuite for the kernels 
6.7 and 6.8. The testsuite was broken in the 6.6 -> 6.7 window, there are 
multiple tests that deadlock.

I fixed some of the bugs. And I reverted some patches that claim to be 
fixing bugs but they break the testsuite.

I'd like to ask you - please, next time when you are going to commit 
something into the MD subsystem, download the LVM2 package from 
git://sourceware.org/git/lvm2.git and run the testsuite ("./configure && 
make && make check") to make sure that your bugfix doesn't introduce 
another bug. You can run a specific test with the "T" parameter - for 
example "make check T=shell/integrity-caching.sh"

Mikulas


