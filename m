Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3301D4458
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 06:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgEOET2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 00:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgEOET1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 15 May 2020 00:19:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89797C061A0C;
        Thu, 14 May 2020 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sEV2Dcb/vxjuVh6b2+vt3K/ZxF+r4H+loOY/Rcz7Jfs=; b=B+hdZiy3fTXn2Mq/d0DoC+/mOU
        O7aStKnfUbQOLviXcQAC1xrirMK/uwB39WFmDo6picuEgYmTQnVmUuZ0qd+ATNk8Ub9VtzaevKA8S
        AlqLvhorITqZJxUgDvRru+uRCk2j/rq3sFKAt3lJYCiM6Mtzleodx+LGlLL9FYrEh7yTFzAk/USVu
        oKizsjcZPJmBV6EEqOODHagdmMRMMc+pX7Q9xMcRpg9puDRmNx6DJAQ57vRz41Q6bXAawywEeqx0U
        ORQwc7NJ+AHpY5tIt0VCfmpRxpMRzYYA6L9uxji4uekEAN5RXxZwP2+7psdx2ejVJ1Yy/NufRZqQ/
        dSkO3VcA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZRoa-0006Is-Ic; Fri, 15 May 2020 04:19:16 +0000
Date:   Thu, 14 May 2020 21:19:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] block: use sectors_to_npage() and PAGE_SECTORS
 to clean up code
Message-ID: <20200515041916.GE16070@bombadil.infradead.org>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
 <20200507075100.1779-8-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507075100.1779-8-thunder.leizhen@huawei.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 07, 2020 at 03:50:57PM +0800, Zhen Lei wrote:
> +++ b/block/blk-settings.c
> @@ -150,7 +150,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  	unsigned int max_sectors;
>  
>  	if ((max_hw_sectors << 9) < PAGE_SIZE) {
> -		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
> +		max_hw_sectors = PAGE_SECTORS;

Surely this should be:

	if (max_hw_sectors < PAGE_SECTORS) {
		max_hw_sectors = PAGE_SECTORS;

... no?

> -	page = read_mapping_page(mapping,
> -			(pgoff_t)(n >> (PAGE_SHIFT - 9)), NULL);
> +	page = read_mapping_page(mapping, (pgoff_t)sectors_to_npage(n), NULL);

... again, get the type right, and you won't need the cast.

