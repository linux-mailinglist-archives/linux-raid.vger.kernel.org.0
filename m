Return-Path: <linux-raid+bounces-1020-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB886D397
	for <lists+linux-raid@lfdr.de>; Thu, 29 Feb 2024 20:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052B91C20919
	for <lists+linux-raid@lfdr.de>; Thu, 29 Feb 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6813C9FA;
	Thu, 29 Feb 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqn2avuP"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8494134411
	for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235963; cv=none; b=RxIlWpjwA89EIPGNyyQg5ou4PW4SY0SseHjJq22D31GN4dkJoU+RMzY0BZVUvCIdkI3Eojmc3PckZifQ6/8ln71dXT36S+Gl9OT96IzJDEN3xhzTGUhkhie2HuG16fjR75T36xytSkNwPxMbDlCtdnCv5Pd226h4ij5HXq1w3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235963; c=relaxed/simple;
	bh=OvKUEdnO8L2K5f9IpH5QMWuRaGLNyrqss0DWAU3Lq/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuU2IibKxkZmD/a1M96VmyRbJVVKkFBrKj5mH9lhpJCOFzHl2629TtmYjhvqXthopzJG9pKULgiBtlNY8bWchXs764DBYUFdX6EgSKDOJG+x1xj4mpLBlYbup9N+twUzCyl0NNgIxW66ZtlI1j94pnRM5H9AaZjIkWxTjTKLSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqn2avuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620B1C43390
	for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709235963;
	bh=OvKUEdnO8L2K5f9IpH5QMWuRaGLNyrqss0DWAU3Lq/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cqn2avuPausg/XC1gr9jlQuYGULmxDhBhj1PU+O2qNMQRDgRlPalnZxDKuGoT3AAM
	 12Kd+fUvOeICiN41W06yI5B76VAUttGVWX6Pt+2KPGZk+nWQRWArtcTBFTnfgOqX7+
	 +nL3+E3sTZGOmSJ5fQHc/k4Hi7FOqVZcEDf5SxThI3TUrvCRH1JICfp6+HmtHmCFwl
	 mvs++0f8O6uEtaesFlN3TI/qQ7TIbQHbhbTK40hRUzEKi6oUrpZHO0FAo21a57Xx9k
	 bLweEvc9GwznY6slOIZ3OnIPDhdqL7OWjv4zylm2W3p2hdngBCM6qJ5dyb9fbT51XT
	 SfLYihEbmMTfQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131c21314fso1688044e87.2
        for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 11:46:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/ttcUmzfX1EPSoYo9hThne/VmmGfd8JuoRp8Ax+rP7Bt5Jer+CyQ0qzNKe7/xmL1XmG7qDlds7o+qGt+04XfJdtlEQgdOJnWOzA==
X-Gm-Message-State: AOJu0YyqWlxVgYs5p5Keu/NN/kyyGg2iNfa81GCE8ilvd1gEDe1PP1QA
	UNzfa8+vUrm4CmqM+AsP0+4mGmthjTlUwznHSAgiOPE/tVQFVxRvSYQsgcizdaDvfBkIR36/IWT
	+YBy+AS5mkVxqY0hyAeW8ryl7iiw=
X-Google-Smtp-Source: AGHT+IGQRqHs8z4w556k2fp2sUhXn3lSooMAZq5rRq1k8P3YGWBx5hzJw8uuFWYAjxcpypm/ZXP+mSxhevFuWOl16J8=
X-Received: by 2002:a05:6512:acc:b0:512:c9bc:f491 with SMTP id
 n12-20020a0565120acc00b00512c9bcf491mr3146836lfu.47.1709235961603; Thu, 29
 Feb 2024 11:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154941.99557-1-xni@redhat.com> <ZeDdYLdWav6yWWwo@infradead.org>
In-Reply-To: <ZeDdYLdWav6yWWwo@infradead.org>
From: Song Liu <song@kernel.org>
Date: Thu, 29 Feb 2024 11:45:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6UCv=u3Pt8W+P7iyYGMhzLuVd9N6kMaOpSovYCiOQD2w@mail.gmail.com>
Message-ID: <CAPhsuW6UCv=u3Pt8W+P7iyYGMhzLuVd9N6kMaOpSovYCiOQD2w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix dmraid regression bugs
To: Christoph Hellwig <hch@infradead.org>
Cc: Xiao Ni <xni@redhat.com>, yukuai1@huaweicloud.com, bmarzins@redhat.com, 
	heinzm@redhat.com, snitzer@kernel.org, ncroxon@redhat.com, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:39=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> If I rund this on the md/md-6.9-for-hch branch all the hangs I was
> previously seeing in the lvm2 test suite are gone.  Still a bunchof
> failures, though:
>
> ### 427 tests: 284 passed, 127 skipped, 0 timed out, 3 warned, 13 failed

Yes, this set fixes the issues we are seeing with lvm2 tests. However,
it triggers some other issue. I am looking into it.

Thanks,
Song

