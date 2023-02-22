Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9619069FFB7
	for <lists+linux-raid@lfdr.de>; Thu, 23 Feb 2023 00:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBVXm2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Feb 2023 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBVXm1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Feb 2023 18:42:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D043644F
        for <linux-raid@vger.kernel.org>; Wed, 22 Feb 2023 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3nr1odw2yhsG1CY9OvKPbHpWq+NpRht/8C+2LGPg0I=; b=nFn4y7zCie18nr5IBm1DlylBy7
        AVbWLVAjYCGsz1tk8KlGXBayDHYaGlhokKcLieF2kolCz0JHrg5VkhRdOasNenUSPmpbUu9I6GEGP
        5Bi10I7whJRsmlc2VR2RE7bjEW8h9g6kiCxx7BPFNaEpYttM2dICIPbx5c0TUP7HAWEZseErTZUy7
        PW6rcMESaCEmIkqYt4kS0YivBwD/hWrCjQrJxcuSMnGbeNRAi4FxFQtYVCRklZiHInE7WpYZIqKOy
        chci7voEOREMYEl7qN39BQAXC0GfgzoKssJIXs4+Rd0SVePA0Ydb7VvTW3/BIG2ki6vMWdUQJu/v5
        OgKtdQgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUyki-00EScP-U8; Wed, 22 Feb 2023 23:42:24 +0000
Date:   Wed, 22 Feb 2023 15:42:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Xiao Ni <xni@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Sushma Kalakota <sushma.kalakota@intel.com>
Subject: Re: [PATCH v3 3/3] md: Use optimal I/O size for last bitmap page
Message-ID: <Y/aoYGITuKUHBkoC@infradead.org>
References: <20230222215828.225-1-jonathan.derrick@linux.dev>
 <20230222215828.225-4-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222215828.225-4-jonathan.derrick@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Feb 22, 2023 at 02:58:28PM -0700, Jonathan Derrick wrote:
> +	if (io_size != opt_size &&
> +	    start + opt_size / SECTOR_SIZE <= boundary)
> +		return opt_size;
> +	else if (start + io_size / SECTOR_SIZE <= boundary)

No need for an else after a return.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
