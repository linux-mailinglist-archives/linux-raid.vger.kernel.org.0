Return-Path: <linux-raid+bounces-1061-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B786EBD3
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 23:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2E028AAEA
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E859169;
	Fri,  1 Mar 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIdOno/5"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F25822F
	for <linux-raid@vger.kernel.org>; Fri,  1 Mar 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332098; cv=none; b=JY73tO7tFevCLpmXuqzjIv58uuy5fKLJ/jaWBGm2AZxsXlK9YbHoE4HkqUy/EVoyxXACSwc1GNm5BbfPlF4QmWQMQ3KtPgqwHcbz0zrEMgE7ZDOz7YnKT9qBGFgigZfc8z7oPYoRmRD9AmTHhcozmPooGT98XDJ1glF0zU0u5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332098; c=relaxed/simple;
	bh=LTNQ8bBXVVn44KSD7jnmWex4tETOHydeEvSX1XwWOFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWJQaADR69nTGXz2Bsg2tu9BOPIip6Uw19AmmppEiyHCKwucXZNshr0zSaABIYkA9Fg0W4zzImzAPD/D2wT+H7iayf6OvSGBM7tS4/5yddCpKpqzi9F4TM4YjaNtJIVMb+d95lRIgN3ZOXGA9UT3+ZSsRKvaMY4TqtgRLwVn41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIdOno/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAD5C43394
	for <linux-raid@vger.kernel.org>; Fri,  1 Mar 2024 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709332097;
	bh=LTNQ8bBXVVn44KSD7jnmWex4tETOHydeEvSX1XwWOFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MIdOno/5syUTsn3RW9NpNXA+gVfL+/4NgeVfiE+1ZDENJcusLpKG/TfoxCk73dCZB
	 MGCe/o8zH+ekE8ooQI3J0PeBDMZvD54FUoVIXIuEOIX2zugcJEZIJaAM1nMgEm91Jo
	 GbC3OCtEt8dA1pM22eICqt6XaK86v/9rsfdYy7ODwvtw/NHzlhD3tb8oz/barelg/o
	 klx4BF3IGyCr6JR4CcUmwqFQHS6RllZVoQk7TZtgnXUlPOX/HDjjjMeGecsOMHJslV
	 pKxs2MI68xvHw+at+Y0zK6/6cdG1Jy4Tn+znFaamjaXxvoDUiXCDu+n0G74McAMd/A
	 GKzb9mJiBnaRw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131c0691feso3227505e87.1
        for <linux-raid@vger.kernel.org>; Fri, 01 Mar 2024 14:28:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq4zKcFZAv8jA10w4xMLT+xei8CoFVe2gtfuIpe5Vr7fqe+32cEhlwLtsffifCnFVhQ9dVu0ayo1njctLSF9Acc2aIkBYAqq3Z8A==
X-Gm-Message-State: AOJu0Yy4mXsKk+7wMXgB3W8B+9vRKATjarZD8Imy/0S+Wh07veGBZ8hV
	gksck0Lka18FpFlFG3cIRTJgXiW+51K5zq7YXdZOlTWu8ZXo2Weh/EUdQ2TKTXh7HambrfogGgZ
	1o0uxhHciR0CbqEe+42WKD2yKZwI=
X-Google-Smtp-Source: AGHT+IFRZogsDVsrgxjCseMwMbjKKu0I9OC6QXd4aY+eeDC6WiwXWQmzxd5nOf9c74Ozjdd2Wf63ZDiiaUK+ZI1oCJA=
X-Received: by 2002:a05:6512:78e:b0:513:28c9:a653 with SMTP id
 x14-20020a056512078e00b0051328c9a653mr1818924lfr.31.1709332095681; Fri, 01
 Mar 2024 14:28:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301152128.13465-1-xni@redhat.com>
In-Reply-To: <20240301152128.13465-1-xni@redhat.com>
From: Song Liu <song@kernel.org>
Date: Fri, 1 Mar 2024 14:28:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6ywzQ9oXUHt=2MN6kngWCvtGxOPffnzV=OHDs_01RGLg@mail.gmail.com>
Message-ID: <CAPhsuW6ywzQ9oXUHt=2MN6kngWCvtGxOPffnzV=OHDs_01RGLg@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] Fix dmraid regression bugs
To: Xiao Ni <xni@redhat.com>
Cc: yukuai1@huaweicloud.com, bmarzins@redhat.com, heinzm@redhat.com, 
	snitzer@kernel.org, ncroxon@redhat.com, linux-raid@vger.kernel.org, 
	dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 7:21=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
>
> Hi all
>
> This patch set tries to fix dmraid regression problems we face
> recently. This patch is based on song's md-6.8 branch.
>
> This patch set has four patches. The first two patches revert two patches=
.
> The third one and the fourth one resolve deadlock problems.
>
> I have run lvm2 regression test 5 times. There are 4 failed cases:
> shell/dmsetup-integrity-keys.sh
> shell/lvresize-fs-crypt.sh
> shell/pvck-dump.sh
> shell/select-report.sh
>
> And lvconvert-raid-reshape.sh can fail sometimes. But it fails in 6.6
> kernel too. So it can return back to the same state with 6.6 kernel.
>
> V2:
> It doesn't revert commit 82ec0ae59d02
> ("md: Make sure md_do_sync() will set MD_RECOVERY_DONE")
> It doesn't clear MD_RECOVERY_WAIT before stopping dmraid
> Re-write patch01 comment

Unfortunately, I am still seeing the same deadlock in the reboot tests
with two arrays. OTOH, Yu Kuai's version doesn't have this issue.
I think we will ship that patch set.

Thanks for your kind work on this issue.
Song

