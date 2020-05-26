Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE901C5EBF
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgEERZX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729199AbgEERZX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 13:25:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2FC061A0F;
        Tue,  5 May 2020 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YxvvGR/vhOw4v98ZqlbbGMF6Ldqy0REYQuhYbCnAaPM=; b=exxQx5pQ2uugq+dUB7Jv1Aw+QB
        wYH8ARG/d9mqLuyLjjSG28V3/XmroRtH1Lg/WH/Ww99MdIx5yfgH25yNnhr1Xm+qApVr+PnkesnBo
        aT+4QkBGhHIZxLr7V/QJ2C038AFmwQt3KlQxXs2ysMg71e9rwxESgOzh0j++KyyIOFsGdTpwdUkZA
        7/k/aQCCLK8aUNjWK2y+llcA5gp5SCtA1s1SVDUpcPlzt1f4njFiF7CIVjIUITMFl61meIEulH0IJ
        IMNwWQkvjonlIsfQxWuVg6j6yc55YQKT5B94chB/3VZe0cPpWjUdnVkYIgA5wWYOZ+QgB33iumgVj
        jHgRw+OA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jW1Jo-00088X-Tj; Tue, 05 May 2020 17:25:20 +0000
Date:   Tue, 5 May 2020 10:25:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/swap: use SECTORS_PER_PAGE_SHIFT to clean up code
Message-ID: <20200505172520.GI16070@bombadil.infradead.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
 <20200505115543.1660-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505115543.1660-3-thunder.leizhen@huawei.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 05, 2020 at 07:55:41PM +0800, Zhen Lei wrote:
> +++ b/mm/swapfile.c
> @@ -177,8 +177,8 @@ static int discard_swap(struct swap_info_struct *si)
>  
>  	/* Do not discard the swap header page! */
>  	se = first_se(si);
> -	start_block = (se->start_block + 1) << (PAGE_SHIFT - 9);
> -	nr_blocks = ((sector_t)se->nr_pages - 1) << (PAGE_SHIFT - 9);
> +	start_block = (se->start_block + 1) << SECTORS_PER_PAGE_SHIFT;
> +	nr_blocks = ((sector_t)se->nr_pages - 1) << SECTORS_PER_PAGE_SHIFT;

Thinking about this some more, wouldn't this look better?

	start_block = page_sectors(se->start_block + 1);
	nr_block = page_sectors(se->nr_pages - 1);

