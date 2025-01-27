Return-Path: <linux-raid+bounces-3559-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A4A1D350
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jan 2025 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B283A309C
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jan 2025 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8B1FDA9E;
	Mon, 27 Jan 2025 09:25:53 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E033C9
	for <linux-raid@vger.kernel.org>; Mon, 27 Jan 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969953; cv=none; b=Ot55pQglKcaTiZArNTpMmnXM7FXJJTHmL2WawkoJceI/tEVAFdldeb2TqKivv6DIFiObgqju6lZoq83ldd8aWO0x8qhtbMn01F/K51XPJod8szsf4M6NujF0SJaNMErH2Frn2Y8QC0wumxEH8D4e0EfkCCpdkdT5JNfm4RvrYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969953; c=relaxed/simple;
	bh=R0HxaB7B82WqI6tJ+G+8trNha5eNbkAUDG+MUT0SXwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpaZS57Vcd0ESMUoU0AD/ThJ5GWKdT8/ZsTnz6/vFQMlC6zyOSe7ZjGUPQFtj55gDHFyj3JRIAjUhetzdU6bDaboP0KGYlSfepEbuHTvV/S72LQxe2UGJ/9lEh0cKFipU1wcFwh01+KAix9N1ut3+mPVPFehHaBBCu+yaYdASh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: from mtkaczyk-private-dev (unknown [31.7.42.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 48E42C4CED2;
	Mon, 27 Jan 2025 09:25:51 +0000 (UTC)
Date: Mon, 27 Jan 2025 10:25:47 +0100
From: Mariusz Tkaczyk <mtkaczyk@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-raid@vger.kernel.org, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC mdadm/master] mdadm: add support for new lockless
 bitmap
Message-ID: <20250127102547.60a62a4c@mtkaczyk-private-dev>
In-Reply-To: <20250126082714.1588025-1-yukuai1@huaweicloud.com>
References: <20250126082714.1588025-1-yukuai1@huaweicloud.com>
Organization: Linux development
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jan 2025 16:27:14 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> A new major number 6 is used for the new bitmap.
> 
> Noted that for the kernel that doesn't support lockless bitmap, create
> such array will fail:
> 
> md0: invalid bitmap file superblock: unrecognized superblock version.
Hi Kuai,

Please go ahead and create branch on mdadm repo for lockness bitmap
implementation and keep your changes there. This is for sure not ready
and cannot be merged yet to main so sending it is not needed.

What do you think?
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  Create.c | 5 ++++-
>  Grow.c   | 3 ++-
>  bitmap.h | 1 +
>  mdadm.c  | 9 ++++++++-
>  mdadm.h  | 1 +
>  super1.c | 9 +++++++++
>  6 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Create.c b/Create.c
> index fd6c9215..105d15e0 100644
> --- a/Create.c
> +++ b/Create.c
> @@ -541,6 +541,8 @@ int Create(struct supertype *st, struct
> mddev_ident *ident, int subdevs, pr_err("At least 2 nodes are needed
> for cluster-md\n"); return 1;
>  		}
> +	} else if (s->btype == BitmapLockless) {
> +		major_num = BITMAP_MAJOR_LOCKLESS;
>  	}
>  
>  	memset(&info, 0, sizeof(info));
> @@ -1182,7 +1184,8 @@ int Create(struct supertype *st, struct
> mddev_ident *ident, int subdevs,
>  	 * to stop another mdadm from finding and using those
> devices. */
>  
> -	if (s->btype == BitmapInternal || s->btype == BitmapCluster)
> {
> +	if (s->btype == BitmapInternal || s->btype == BitmapCluster
> ||
> +	    s->btype == BitmapLockless) {

This is asking to be moved to common helper function. Is is repeated 3
times at least so please consider (not sure about naming):

bool is_bitmap_supported(int btype) {
	if (btype == BitmapInternal || btype == BitmapCluster ||
	    btype == BitmapLockless)
		return true;
	return false;
}
Just a nit.

