Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022ED534EA5
	for <lists+linux-raid@lfdr.de>; Thu, 26 May 2022 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiEZLxm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 May 2022 07:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiEZLxm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 26 May 2022 07:53:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8EDD0280;
        Thu, 26 May 2022 04:53:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3AF6521A18;
        Thu, 26 May 2022 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653566020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auqJ6PaB+ZD9Fx16q8TjHflpK31Qk9mptp15/0/O1xk=;
        b=ltuVrpu4i/EO+evjI7NGg8RZJcyxhhyKcJ4WNjS4eqOV15HATtONiRdNK7dD18pNZilQzM
        KL4Asz3/Ei0uxlvybIaaBoQU2lUtV0K88JAU7HgFwKS41ESj/wQK4vpGONYOszHZ205pxQ
        UAXcvo23EWTBVQJSZH/OP6gU3B2z/Kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653566020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auqJ6PaB+ZD9Fx16q8TjHflpK31Qk9mptp15/0/O1xk=;
        b=IuXzplGM7Pl6/SWMHnLdpvd2WznZVWFe8TnGfxlQxClw91KFgrIbA3znaMfcv/lXe0067k
        f9xfLdWH9tjISFAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1AE0A2C141;
        Thu, 26 May 2022 11:53:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AD1ECA0632; Thu, 26 May 2022 13:53:36 +0200 (CEST)
Date:   Thu, 26 May 2022 13:53:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Song Liu <song@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Subject: Re: [Update PATCH V3] md: don't unregister sync_thread with
 reconfig_mutex held
Message-ID: <20220526115336.2whsfdcuqwfzk5fk@quack3.lan>
References: <141b4110-767e-7670-21d5-6a5f636d1207@linux.dev>
 <CAPhsuW6U3g-Xikbw4mAJOH1-kN42rYHLiq_ocv==436azhm33g@mail.gmail.com>
 <b4244eab-d9e2-20a0-ebce-1a96e8fadb91@deltatee.com>
 <836b2a93-65be-8d6c-8610-18373b88f86d@molgen.mpg.de>
 <5b0584a3-c128-cb53-7c8a-63744c60c667@linux.dev>
 <4edc9468-d195-6937-f550-211bccbd6756@molgen.mpg.de>
 <954f9c33-7801-b6d2-65e3-9e5237905886@linux.dev>
 <82a08e9c-e3f4-4eb6-cb06-58b96c0f01a8@deltatee.com>
 <775d6734-2b08-21a8-a093-f750d31ce6ce@linux.dev>
 <ae6d294a-e9ec-a81d-6085-a9341ed8a470@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6d294a-e9ec-a81d-6085-a9341ed8a470@deltatee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

[Added couple of CCs since this seems to be an issue in the generic block
layer]

On Wed 25-05-22 12:22:06, Logan Gunthorpe wrote:
> On 2022-05-25 03:04, Guoqing Jiang wrote:
> > I would prefer to focus on block tree or md tree. With latest block tree
> > (commit 44d8538d7e7dbee7246acda3b706c8134d15b9cb), I get below
> > similar issue as Donald reported, it happened with the cmd (which did
> > work with 5.12 kernel).
> > 
> > vm79:~/mdadm> sudo ./test --dev=loop --tests=05r1-add-internalbitmap
> 
> Ok, so this test passes for me, but my VM was not running with bfq. It
> also seems we have layers upon layers of different bugs to untangle.
> Perhaps you can try the tests with bfq disabled to make progress on the
> other regression I reported.
> 
> If I enable bfq and set the loop devices to the bfq scheduler, then I
> hit the same bug as you and Donald. It's clearly a NULL pointer
> de-reference in the bfq code, which seems to be triggered on the
> partition read after mdadm opens a block device (not sure if it's the md
> device or the loop device but I suspect the latter seeing it's not going
> through any md code).
> 
> Simplifying things down a bit, the null pointer dereference can be
> triggered by creating an md device with loop devices that have bfq
> scheduler set:
> 
>   mdadm --create --run /dev/md0 --level=1 -n2 /dev/loop0 /dev/loop1
> 
> The crash occurs in bfq_bio_bfqg() with blkg_to_bfqg() returning NULL.
> It's hard to trace where the NULL comes from in there -- the code is a
> bit complex.
> 
> I've found that the bfq bug exists in current md-next (42b805af102) but
> did not trigger in the base tag of v5.18-rc3. Bisecting revealed the bug
> was introduced by:
> 
>   4e54a2493e58 ("bfq: Get rid of __bio_blkcg() usage")
> 
> Reverting that commit and the next commit (075a53b7) on top of md-next
> was confirmed to fix the bug.
> 
> I've copied Jan, Jens and Paolo who can hopefully help with this. A
> cleaned up stack trace follows this email for their benefit.

So I've debugged this. The crash happens on the very first bio submitted to
the md0 device. The problem is that this bio gets remapped to loop0 - this
happens through bio_alloc_clone() -> __bio_clone() which ends up calling
bio_clone_blkg_association(). Now the resulting bio is inconsistent - it's
dst_bio->bi_bdev is pointing to loop0 while dst_bio->bi_blkg is pointing to
blkcg_gq associated with md0 request queue. And this breaks BFQ because
when this bio is inserted to loop0 request queue, BFQ looks at
bio->bi_blkg->q (it is a bit more complex than that but this is the gist
of the problem), expects its data there but BFQ is not initialized for md0
request_queue.

Now I think this is a bug in __bio_clone() but the inconsistency in the bio
is very much what we asked bio_clone_blkg_association() to do so maybe I'm
missing something and bios that are associated with one bdev but pointing
to blkg of another bdev are fine and controllers are supposed to handle
that (although I'm not sure how should they do that). So I'm asking here
before I just go and delete bio_clone_blkg_association() from
__bio_clone()...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
