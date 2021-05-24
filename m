Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE538E284
	for <lists+linux-raid@lfdr.de>; Mon, 24 May 2021 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhEXIr3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 May 2021 04:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhEXIr2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 May 2021 04:47:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC22C061574
        for <linux-raid@vger.kernel.org>; Mon, 24 May 2021 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4jd9MvMJExekmMK1F/mKb5naFnho9TV0zd6QNUaDE30=; b=W/qhBD3TpLHFJwC7Actn2CCy2t
        yqiJgtomZ4ytSDknqCPnMtJGX1NbKVfxVQc29rAD5f1oJZq7aycLRtFGHOcSrJI/v8ChTgtqTftH9
        Mu2Q17iHXfWq36N/KPsSncSDxld05+FRgAMiIvJ0lJPqNgYQD/RAfsFKNkpUf4c/YP9k6dyfKSb4j
        3u9SF7i5xosRE6NgnltVeWPzYkV4IR3ZcN7AOuBBmscO2yw8ac6K1ZgT0tXRR7fcLUNJCwNuckDzN
        IKF7iy+/Op9j1I5bjScaUkQEDj9MLlT/8ajQa/rV0HCxBgA7cCfPHY9U0+mJ3uIS6yO7WYM/Oq2qz
        O7KNWtEA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ll6DI-002BmY-2H; Mon, 24 May 2021 08:45:28 +0000
Date:   Mon, 24 May 2021 09:45:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        artur.paszkiewicz@intel.com
Subject: Re: [PATCH V2 2/7] md: add accounting_bio for raid0 and raid5
Message-ID: <YKtnqNRcJV2xj/Mf@infradead.org>
References: <20210521005521.713106-1-jiangguoqing@kylinos.cn>
 <20210521005521.713106-3-jiangguoqing@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521005521.713106-3-jiangguoqing@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, May 21, 2021 at 08:55:16AM +0800, Guoqing Jiang wrote:
> Let's introduce accounting_bio which checks if md needs clone the bio
> for accounting.
> 
> And add relevant function to raid0 and raid5 given both don't have
> their own clone infrastrure, also checks if it is split bio.

Please don't add another indirect call in the I/O submission fast path.
With Spectre mitigations these are really slow, and also are hard to
follow.

I think moving the call to allocate the accounting bio clone entirely
into the personalities is probably the cleanest approach without any
of these downsides.
