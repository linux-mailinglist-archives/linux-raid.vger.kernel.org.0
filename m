Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006261987B
	for <lists+linux-raid@lfdr.de>; Fri,  4 Nov 2022 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKDNxg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 4 Nov 2022 09:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiKDNxe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 4 Nov 2022 09:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE229B
        for <linux-raid@vger.kernel.org>; Fri,  4 Nov 2022 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667569953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs7qnLWmNduuln4YxdLD8tGp5tRNl+uLeBhrRqXaZ0s=;
        b=PfDzI9v+XQ1rVSbEyS5/YQdnKvdULkGG33lYEMBrCOsggNo785xraeHQ3OD/d73ZUnGqv3
        qeHlQeSJAytTJ7gC9ZAhkiGOPeKP3lpe1tAbiVQxMFP5fkWULMg0YWh8Uz211HSmM4p+yj
        dw5eIKGtwTfi8YNhtUNKa67scA1Pojg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-2do-8YLmM12CQ4hCwJ6ylg-1; Fri, 04 Nov 2022 09:52:28 -0400
X-MC-Unique: 2do-8YLmM12CQ4hCwJ6ylg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6332085A583;
        Fri,  4 Nov 2022 13:52:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51E532166B26;
        Fri,  4 Nov 2022 13:52:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2A4DqR6n003344;
        Fri, 4 Nov 2022 09:52:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2A4DqRk3003340;
        Fri, 4 Nov 2022 09:52:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 4 Nov 2022 09:52:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     NeilBrown <neilb@suse.de>
cc:     Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH] md: fix a crash in mempool_free
In-Reply-To: <166753684502.19313.12105294223332649758@noble.neil.brown.name>
Message-ID: <alpine.LRH.2.21.2211040941112.19553@file01.intranet.prod.int.rdu2.redhat.com>
References: =?utf-8?q?=3Calpine=2ELRH=2E2=2E21=2E2211031121070=2E18305=40fil?= =?utf-8?q?e01=2Eintranet=2Eprod=2Eint=2Erdu2=2Eredhat=2Ecom=3E?= <166753684502.19313.12105294223332649758@noble.neil.brown.name>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On Fri, 4 Nov 2022, NeilBrown wrote:

> > ---
> >  drivers/md/md.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/drivers/md/md.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/md/md.c	2022-11-03 15:29:02.000000000 +0100
> > +++ linux-2.6/drivers/md/md.c	2022-11-03 15:33:17.000000000 +0100
> > @@ -509,13 +509,14 @@ static void md_end_flush(struct bio *bio
> >  	struct md_rdev *rdev = bio->bi_private;
> >  	struct mddev *mddev = rdev->mddev;
> >  
> > +	bio_put(bio);
> > +
> >  	rdev_dec_pending(rdev, mddev);
> >  
> >  	if (atomic_dec_and_test(&mddev->flush_pending)) {
> >  		/* The pre-request flush has finished */
> >  		queue_work(md_wq, &mddev->flush_work);
> >  	}
> > -	bio_put(bio);
> >  }
> >  
> >  static void md_submit_flush_data(struct work_struct *ws);
> > @@ -913,10 +914,11 @@ static void super_written(struct bio *bi
> >  	} else
> >  		clear_bit(LastDev, &rdev->flags);
> >  
> > +	bio_put(bio);
> > +
> >  	if (atomic_dec_and_test(&mddev->pending_writes))
> >  		wake_up(&mddev->sb_wait);
> >  	rdev_dec_pending(rdev, mddev);
> > -	bio_put(bio);
> >  }
> 
> Thanks. I think this is a clear improvement.
> I think it would be a little better if the rdev_dec_pending were also
> move up.
> Then both code fragments would be:
>   bio_put ; rdev_dec_pending ; atomic_dec_and_test
> 
> Thanks,
> NeilBrown

Yes, I'll send a second patch that moves rdev_dec_pending up too.

BTW. even this is theoretically incorrect:

> >     if (atomic_dec_and_test(&mddev->pending_writes))
> >             wake_up(&mddev->sb_wait);

Suppose that you execute atomic_dec_and_test and then there's a context 
switch to a process that destroys the md device and then there's a context 
switch back and you call "wake_up(&mddev->sb_wait)" on freed memory.

I think that we should use wait_var_event/wake_up_var instead of sb_wait. 
That will use preallocated hashed wait queues.

Mikulas

