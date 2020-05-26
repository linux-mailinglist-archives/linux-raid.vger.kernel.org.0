Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB921C5518
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEEMKt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728660AbgEEMKt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 08:10:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F4C061A10;
        Tue,  5 May 2020 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1l+GyMaj5ngxaPJrqDJo+9L5X5yBFW27xzweVKqFpAY=; b=XofyCUGf4B51GP0D9K0P/MUgA7
        UGOcsycb32rFn1/tzyeuK2C5kl5aYTYhR1hdA34qBj/CdaW8k9iixBLYFY1sMvapHKF7iCI/n9hMd
        u0SRCb5VsvLPvl0vktX+FILSgqLXmyjjSJT0X7kFECt0s5Y3ROakGlMBwvc4P3ejUTKHEf5Qn5REw
        UjcgW3pE4VET0u7df/2+upNK6NoXV7hFAItPFqhsWfLrAle0s4jgm4Z48lwsDDt5LLxQ8o7EkIocX
        ROnL+X96xrqizbaX5XyQd5YVngRdYa9+0I2meVfsRw9wy3/Nb3qmzTPy4QOe0awkhVC2cQ2wZzu7v
        YIbh/Rag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVwPL-0004tR-Mq; Tue, 05 May 2020 12:10:43 +0000
Date:   Tue, 5 May 2020 05:10:43 -0700
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
Subject: Re: [PATCH 1/4] block: Move SECTORS_PER_PAGE and
 SECTORS_PER_PAGE_SHIFT definitions into <linux/blkdev.h>
Message-ID: <20200505121043.GG16070@bombadil.infradead.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
 <20200505115543.1660-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505115543.1660-2-thunder.leizhen@huawei.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 05, 2020 at 07:55:40PM +0800, Zhen Lei wrote:
> +#ifndef SECTORS_PER_PAGE_SHIFT
> +#define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
> +#endif
> +#ifndef SECTORS_PER_PAGE
> +#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
>  #endif

I find SECTORS_PER_PAGE_SHIFT quite hard to read.  I had a quick skim
of your other patches, and it seems to me that we could replace
'<< SECTORS_PER_PAGE_SHIFT' with '* SECTORS_PER_PAGE' and it would be
more readable in every case.
