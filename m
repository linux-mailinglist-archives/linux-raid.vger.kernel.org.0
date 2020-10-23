Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C3296B38
	for <lists+linux-raid@lfdr.de>; Fri, 23 Oct 2020 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376092AbgJWI3a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 23 Oct 2020 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375737AbgJWI33 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 23 Oct 2020 04:29:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4AC0613CE;
        Fri, 23 Oct 2020 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5aZPshIdzYGdOyeUaVThuatYClUPIqWMANiMs5m6ywA=; b=r3jTgQk+GfQ6Hx0b/c0vTrdVhN
        9uGnyvOKocl2KWwpmv/Xi+BPfdgpjfav5jCSdAnMDUVBLEhCjI81pSsId/BZEQoLeGku+SksbPy7Q
        LJY47mE+ptCJfWTKM/HV7SzJrj383ul1bpZsVzUovCsvw7dCwZFOQ6qgNN/VKJGyhCupMGJ5I6/74
        A+D62bGn/9uUbIkrO6n8cPO8xblOSYq0U3NbjkxCJcji1ygq396b9Fo59eTPiNOA7CJvCTyLjlBaO
        3DldTbrN6kkO3UpAwqf1bQMLRaxXn5PLqRvKh+UqWU5jpU6Bg/3oC2h6QipENF1uqGTGqKVE113Kp
        yyzQ+dhw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVsRz-00044z-Pb; Fri, 23 Oct 2020 08:29:27 +0000
Date:   Fri, 23 Oct 2020 09:29:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christopher Unkel <cunkel@drivescale.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/3] md: align superblock writes to physical blocks
Message-ID: <20201023082927.GA15144@infradead.org>
References: <20201023033130.11354-1-cunkel@drivescale.com>
 <20201023033130.11354-2-cunkel@drivescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023033130.11354-2-cunkel@drivescale.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> +	/* Respect physical block size if feasible. */
> +	bmask = queue_physical_block_size(rdev->bdev->bd_disk->queue)-1;
> +	if (!((rdev->sb_start * 512) & bmask) && (rdev->sb_size & bmask)) {
> +		int candidate_size = (rdev->sb_size | bmask) + 1;
> +
> +		if (minor_version) {
> +			int sectors = candidate_size / 512;
> +
> +			if (rdev->data_offset >= sb_start + sectors
> +			    && rdev->new_data_offset >= sb_start + sectors)

Linux coding style wants operators before the continuing line.

> +				rdev->sb_size = candidate_size;
> +		} else if (bmask <= 4095)
> +			rdev->sb_size = candidate_size;
> +	}

I also think this code would benefit from being factored into a helper.
