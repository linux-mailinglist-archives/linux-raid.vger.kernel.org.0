Return-Path: <linux-raid+bounces-1500-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9414A8C9D78
	for <lists+linux-raid@lfdr.de>; Mon, 20 May 2024 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84A21C21DC5
	for <lists+linux-raid@lfdr.de>; Mon, 20 May 2024 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A85BAC1;
	Mon, 20 May 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="p8/2w1aH"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-108-mta235.mxroute.com (mail-108-mta235.mxroute.com [136.175.108.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2456757
	for <linux-raid@vger.kernel.org>; Mon, 20 May 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208711; cv=none; b=oszSXOHufMMEsfXUMVTYrg32mIU7JdCRuJGDM7FSTI3STB26BZTerLabSLPtPcXCi6KlAYNkvBdzLWfxwntZEgOOIloJqmRpd2ccc8/Yg88GFEfzsFbP4HOfEo0U9GPBWiiTF4kL1954u/j9eQGN+ERJMESygS+wc0RNo5foMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208711; c=relaxed/simple;
	bh=vSwLw09oJeePOsbI1H72eswYjkpje5c2G4YPiZSuBj8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=KM371ucuvheBBUX9Eh+cUuZFAg9fVMs5OLeSHOFz2uxC7VdNNhQah072gNtT/0gbiyl+3naFM6S4sqNuiz70xn3JJXGznkskqM6BIT5lDMflkqKW8KNCiz9qWEb5D7sPoiRgVfTYI/n+agaI8xx3nBoLfEGUfEy+7Dlv2VB2HCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=p8/2w1aH; arc=none smtp.client-ip=136.175.108.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta235.mxroute.com (ZoneMTA) with ESMTPSA id 18f95fdf437000efce.00c
 for <linux-raid@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 20 May 2024 12:33:19 +0000
X-Zone-Loop: 4463d99375d75c4e3034509f5424be55e0742e3266a8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
	From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JvDGKlHjtsOoT4fZ/bziidnM87mi6Drl2/H5bm2mPzM=; b=p8/2w1aHCYzDslMAYy93dwz2e6
	vhlqrwcwxLncKvNFqMHO0DIGCj2FoFfGaMEWE3b4t4Q7nj8MoPpAQR5gJXqIDGKW9SgWSpzUqqXyM
	aBGjVIdRkgPlHDCBUHijbXEBNemJq3Hw58aNQXcWDFuPZNojxf8yp0LLbmmIXuN1hcsgijmdaKcWx
	F3KBhhecUmCJibFnY0v0od58b9FdLWxV4MgPJef9Wqle9eiru+7jGkKzhZs1xJBktjiAvjtVGex0q
	Pib9myuR3eQ2cJd0dw43Rs6XrmL+M08qbepXVG0o286MdarM1LjoI+mFj0BON5kJLQKHjqmocyMth
	ZH0CT2jw==;
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
 <20240509011900.2694291-4-yukuai1@huaweicloud.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 song@kernel.org, xni@redhat.com, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH md-6.10 3/9] md: add new helpers for sync_action
Date: Mon, 20 May 2024 19:51:25 +0800
In-reply-to: <20240509011900.2694291-4-yukuai1@huaweicloud.com>
Message-ID: <v838ekaa.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org


On Thu 09 May 2024 at 09:18, Yu Kuai <yukuai1@huaweicloud.com> 
wrote:

> From: Yu Kuai <yukuai3@huawei.com>
>
> The new helpers will get current sync_action of the array, will 
> be used
> in later patches to make code cleaner.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 64 
>  +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/md.h |  3 +++
>  2 files changed, 67 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 00bbafcd27bb..48ec35342d1b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -69,6 +69,16 @@
>  #include "md-bitmap.h"
>  #include "md-cluster.h"
>
> +static char *action_name[NR_SYNC_ACTIONS] = {
>

Th array will not be modified, so:

static const char * const action_names[NR_SYNC_ACTIONS]

> +	[ACTION_RESYNC]		= "resync",
> +	[ACTION_RECOVER]	= "recover",
> +	[ACTION_CHECK]		= "check",
> +	[ACTION_REPAIR]		= "repair",
> +	[ACTION_RESHAPE]	= "reshape",
> +	[ACTION_FROZEN]		= "frozen",
> +	[ACTION_IDLE]		= "idle",
> +};
> +
>  /* pers_list is a list of registered personalities protected by 
>  pers_lock. */
>  static LIST_HEAD(pers_list);
>  static DEFINE_SPINLOCK(pers_lock);
> @@ -4867,6 +4877,60 @@ metadata_store(struct mddev *mddev, const 
> char *buf, size_t len)
>  static struct md_sysfs_entry md_metadata =
>  __ATTR_PREALLOC(metadata_version, S_IRUGO|S_IWUSR, 
>  metadata_show, metadata_store);
>
> +enum sync_action md_sync_action(struct mddev *mddev)
> +{
> +	unsigned long recovery = mddev->recovery;
> +
> +	/*
> +	 * frozen has the highest priority, means running sync_thread 
> will be
> +	 * stopped immediately, and no new sync_thread can start.
> +	 */
> +	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
> +		return ACTION_FROZEN;
> +
> +	/*
> +	 * idle means no sync_thread is running, and no new 
> sync_thread is
> +	 * requested.
> +	 */
> +	if (!test_bit(MD_RECOVERY_RUNNING, &recovery) &&
> +	    (!md_is_rdwr(mddev) || !test_bit(MD_RECOVERY_NEEDED, 
> &recovery)))
> +		return ACTION_IDLE;
My brain was lost sometimes looking into nested conditions of md 
code...
I agree with Xiao Ni's suggestion that more comments about the 
array
state should be added.

> +	if (test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
> +	    mddev->reshape_position != MaxSector)
> +		return ACTION_RESHAPE;
> +
> +	if (test_bit(MD_RECOVERY_RECOVER, &recovery))
> +		return ACTION_RECOVER;
> +
>
In action_show, MD_RECOVERY_SYNC is tested first then 
MD_RECOVERY_RECOVER.
After looking through the logic of MD_RECOVERY_RECOVER 
clear/set_bit, the
change is fine to me. However, better to follow old pattern unless 
there
have resons.


> +	if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
> +		if (test_bit(MD_RECOVERY_CHECK, &recovery))
> +			return ACTION_CHECK;
> +		if (test_bit(MD_RECOVERY_REQUESTED, &recovery))
> +			return ACTION_REPAIR;
> +		return ACTION_RESYNC;
> +	}
> +
> +	return ACTION_IDLE;
> +}
> +
> +enum sync_action md_sync_action_by_name(char *page)
> +{
> +	enum sync_action action;
> +
> +	for (action = 0; action < NR_SYNC_ACTIONS; ++action) {
> +		if (cmd_match(page, action_name[action]))
> +			return action;
> +	}
> +
> +	return NR_SYNC_ACTIONS;
> +}
> +
> +char *md_sync_action_name(enum sync_action action)
>

And 'const char *'

--
Su

> +{
> +	return action_name[action];
> +}
> +
>  static ssize_t
>  action_show(struct mddev *mddev, char *page)
>  {
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 2edad966f90a..72ca7a796df5 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -864,6 +864,9 @@ extern void md_unregister_thread(struct 
> mddev *mddev, struct md_thread __rcu **t
>  extern void md_wakeup_thread(struct md_thread __rcu *thread);
>  extern void md_check_recovery(struct mddev *mddev);
>  extern void md_reap_sync_thread(struct mddev *mddev);
> +extern enum sync_action md_sync_action(struct mddev *mddev);
> +extern enum sync_action md_sync_action_by_name(char *page);
> +extern char *md_sync_action_name(enum sync_action action);
>  extern bool md_write_start(struct mddev *mddev, struct bio 
>  *bi);
>  extern void md_write_inc(struct mddev *mddev, struct bio *bi);
>  extern void md_write_end(struct mddev *mddev);

