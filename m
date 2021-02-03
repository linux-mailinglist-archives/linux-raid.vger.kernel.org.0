Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8CA30DE8A
	for <lists+linux-raid@lfdr.de>; Wed,  3 Feb 2021 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhBCPpw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Feb 2021 10:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbhBCPpQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 3 Feb 2021 10:45:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F6C061573
        for <linux-raid@vger.kernel.org>; Wed,  3 Feb 2021 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8m9mRPPy6pLY5IGQ+IWax9+0MW186z/Z+EKnTol44GI=; b=Leh4bM1CYGUEaiDQXJsjgjseY/
        8dZIVfP7ePSbZzGToRSihW8R292G08pirfKz7zHjEUTpZsUcIGq19VqesyjnzKDBYLL7rEQyLK3GW
        LcEaJ7guGjmAUa1yu5cBqeuQoOWz3JzmBEk/VgSb4UyHdYRDU4jl3FhTRu0/f5U49ncWJaVP+jhhY
        IB/tqzON1R8ZMYq8fmDNYTd59uE+36s/UFfqWGWqtFOGoL96TPqmW3Ka5DErMSznpk9AF0LUREced
        4rK7a+vFp0ror2ijJWjetKQ8pTsqItGQomx+ssa+AutUMV8Rzd3RDHqgZuMyolWjGBEjTFFKBX0jw
        WYyoTSAQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7KKP-00H7GC-TS; Wed, 03 Feb 2021 15:44:26 +0000
Date:   Wed, 3 Feb 2021 15:44:25 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Xiao Ni <xni@redhat.com>
Cc:     songliubraving@fb.com, linux-raid@vger.kernel.org,
        matthew.ruffell@canonical.com, colyli@suse.de,
        guoqing.jiang@cloud.ionos.com, ncroxon@redhat.com
Subject: Re: [PATCH 1/5] md: add md_submit_discard_bio() for submitting
 discard bio
Message-ID: <20210203154425.GA4078626@infradead.org>
References: <1612359931-24209-1-git-send-email-xni@redhat.com>
 <1612359931-24209-2-git-send-email-xni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612359931-24209-2-git-send-email-xni@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Feb 03, 2021 at 09:45:27PM +0800, Xiao Ni wrote:
> +	if (__blkdev_issue_discard(rdev->bdev, start, size,
> +		GFP_NOIO, 0, &discard_bio) || !discard_bio)
> +		return;

Very odd indentation.  Normally this would be:

	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, 0,
			&discard_bio) || !discard_bio)
		return;

> +
> +	bio_chain(discard_bio, bio);
> +	bio_clone_blkg_association(discard_bio, bio);
> +	if (mddev->gendisk)
> +		trace_block_bio_remap(discard_bio,
> +				disk_devt(mddev->gendisk),
> +				bio->bi_iter.bi_sector);
> +	submit_bio_noacct(discard_bio);
> +}
> +EXPORT_SYMBOL(md_submit_discard_bio);

EXPORT_SYMBOL_GPL like all the other exports in md.c, please.

> +extern void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
> +			struct bio *bio, sector_t start, sector_t size);

no need for the extern.
