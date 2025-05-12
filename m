Return-Path: <linux-raid+bounces-4175-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB5AB2ECC
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 07:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3321897082
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E7254869;
	Mon, 12 May 2025 05:18:16 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451F19F13F;
	Mon, 12 May 2025 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027095; cv=none; b=AF8XbsSywLO2LQcUd/kUvPpRyW7S3JudGX/DOizQK5P26S6ibdAbO01XzsZyTULfaUWqfFlYjlOnWCxbYnE+xMfeZ6jj9hpddPEqIcFwuyH+o2cw/XsMeAb1gSWn7gLM9aHyCFSQNqEvAfEKKXJT+IKcDa82CJV4V6GtykvOfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027095; c=relaxed/simple;
	bh=Ej/a7v/K7U+hJlzJKjwPAuBL4nUfF+9ukHY7kkKc1b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPhgkG06qMimsyOBwbI3x9uZsM7p1XU8CJ+TPXp7MPzFIauWs+FCVkjTZdlKkdyZ665XWvGB+uBCAlYWP/bkFINEcoipFBTt6kaZVfDMDPgdJj4lcJFSKhJmN3/DEu5b/9z/7ZCzx/a2bEttBo8kVMs6Cc89TUKzyD6BtlbzUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A806D68AA6; Mon, 12 May 2025 07:18:10 +0200 (CEST)
Date: Mon, 12 May 2025 07:18:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, xni@redhat.com, colyli@kernel.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
	yukuai3@huawei.com, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC md-6.16 v3 17/19] md/md-llbitmap: implement all
 bitmap operations
Message-ID: <20250512051810.GB1667@lst.de>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com> <20250512011927.2809400-18-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512011927.2809400-18-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 12, 2025 at 09:19:25AM +0800, Yu Kuai wrote:
> And following APIs that are not needed:
>  - llbitmap_write_all, used in old bitmap to mark all pages need
>  writeback;
>  - llbitmap_daemon_work, used in old bitmap, llbitmap use timer to
>    trigger daemon;
>  - llbitmap_cond_end_sync, use to end sync for completed sectors(TODO,
>    don't affect functionality)
> And following APIs that are not supported:
>  - llbitmap_start_behind_write
>  - llbitmap_end_behind_write
>  - llbitmap_wait_behind_writes
>  - llbitmap_sync_with_cluster
>  - llbitmap_get_from_slot
>  - llbitmap_copy_from_slot
>  - llbitmap_set_pages
>  - llbitmap_free

Please just make these optional instead of implementing stubs.

