Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700444D046F
	for <lists+linux-raid@lfdr.de>; Mon,  7 Mar 2022 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiCGQq6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 7 Mar 2022 11:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiCGQq6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 7 Mar 2022 11:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 818B1939BF
        for <linux-raid@vger.kernel.org>; Mon,  7 Mar 2022 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646671562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQIljNs+HnPVBhwvccBM/a6HAzcLYmbphJvQWks4uMk=;
        b=HNIe1T6oOSriGVYjjaHNwLA05IZ5gf7xwKHMAP9Dj2XvIEyKMV/joaI9IwqOaaMMUY83vI
        slwNn7YhQ+tGRgW2pvfB4JLpEOTqBrEnl5thVl94fupoe4EmNSnrojSKLkhSS+7xp3heKZ
        kSmkFAXC4GbYNIXKTcDK9wgQOyG84dM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-Cwm0Jt2FMwqGzubJvP-fww-1; Mon, 07 Mar 2022 11:46:01 -0500
X-MC-Unique: Cwm0Jt2FMwqGzubJvP-fww-1
Received: by mail-qk1-f198.google.com with SMTP id m6-20020a37a306000000b0067b189190c3so3322376qke.20
        for <linux-raid@vger.kernel.org>; Mon, 07 Mar 2022 08:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQIljNs+HnPVBhwvccBM/a6HAzcLYmbphJvQWks4uMk=;
        b=AAKOc7no/jKsPsGRYPun+vbp/eD9xc/CWD71/4SX+G/mLeySqQdXKiQshD7yXqDMZ1
         DCDehJ/qqSF07Fchews+wPEpbe+/LA+Vj5j8FD22Ao7X/HbjIaDXoDf1Txiet5sA5zdv
         a/bgz7djqxzy+DklqNDIQNHtHNYNRDRNPyLr3TD4BkomWbqvbImc8/dY2RPXtAdL7Wu7
         vYIQel3tUTH4H75XrMwfW13ZL66gXNboXXOdzHQLibxfSRRxGZnoX/yKl6J3b3f9lKUD
         YH6ELcvRLI/ZcIunOZtplyDaUCP+X93t4yyYfSe7LFKZDxxmAEXj67MipIkPDV7i5JHl
         xrJw==
X-Gm-Message-State: AOAM531WqShpsqYGas6GHPf0LX6aFHwMy+IZEjhjq0gjoP4s+d3abFpZ
        WqxgVXOZUTPRgPKEByUA0Ly9dsH8H182kD7EsmL+ux3l6J8bXQ/6PQHQt7qOWgBF3cVCYNnqe5V
        F9tsdlVtyXNf6GcEgxYXv
X-Received: by 2002:a37:a281:0:b0:67b:3c17:ffdb with SMTP id l123-20020a37a281000000b0067b3c17ffdbmr1804604qke.105.1646671559890;
        Mon, 07 Mar 2022 08:45:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJowvkQ9JuNtYI6Fa6y2uE4tce9y9q4q4RqiB5JwP0KtCgDOCEZhmREbXaLeegbAPRVmOsKQ==
X-Received: by 2002:a37:a281:0:b0:67b:3c17:ffdb with SMTP id l123-20020a37a281000000b0067b3c17ffdbmr1804582qke.105.1646671559585;
        Mon, 07 Mar 2022 08:45:59 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bp15-20020a05620a458f00b00663835ca7f2sm6239574qkb.14.2022.03.07.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:45:59 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:45:53 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-raid@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Song Liu <song@kernel.org>
Subject: Re: remove bio_devname
Message-ID: <YiY2wUVIz3NXIjlc@redhat.com>
References: <20220304180105.409765-1-hch@lst.de>
 <164666057398.15541.7415780807920631127.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164666057398.15541.7415780807920631127.b4-ty@kernel.dk>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Mar 07 2022 at  8:42P -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On Fri, 4 Mar 2022 19:00:55 +0100, Christoph Hellwig wrote:
> > this series removes the bio_devname helper and just switches all users
> > to use the %pg format string directly.
> > 
> > Diffstat
> >  block/bio.c               |    6 ------
> >  block/blk-core.c          |   25 +++++++------------------
> >  drivers/block/pktcdvd.c   |    9 +--------
> >  drivers/md/dm-crypt.c     |   10 ++++------
> >  drivers/md/dm-integrity.c |    5 ++---
> >  drivers/md/md-multipath.c |    9 ++++-----
> >  drivers/md/raid1.c        |    5 ++---
> >  drivers/md/raid5-ppl.c    |   13 ++++---------
> >  fs/ext4/page-io.c         |    5 ++---
> >  include/linux/bio.h       |    2 --
> >  10 files changed, 26 insertions(+), 63 deletions(-)
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/10] block: fix and cleanup bio_check_ro
>         commit: 57e95e4670d1126c103305bcf34a9442f49f6d6a
> [02/10] block: remove handle_bad_sector
>         commit: ad740780bbc2fe37856f944dbbaff07aac9db9e3
> [03/10] pktcdvd: remove a pointless debug check in pkt_submit_bio
>         commit: 47c426d5241795cfcd9be748c44d1b2e2987ce70


> [04/10] dm-crypt: stop using bio_devname
>         commit: 66671719650085f92fd460d2a356c33f9198dd35
> [05/10] dm-integrity: stop using bio_devname
>         commit: 0a806cfde82fcd1fb856864e33d17c68d1b51dee
> [06/10] md-multipath: stop using bio_devname

I had already picked these 2 up.. but happy to drop them.

>         commit: ee1925bd834418218c782c94e889f826d40b14d5
> [07/10] raid1: stop using bio_devname
>         commit: ac483eb375fa4a815a515945a5456086c197430e
> [08/10] raid5-ppl: stop using bio_devname
>         commit: c7dec4623c9cde20dad8de319d177ed6aa382aaa
> [09/10] ext4: stop using bio_devname
>         commit: 734294e47a2ec48fd25dcf2d96cdf2c6c6740c00
> [10/10] block: remove bio_devname
>         commit: 97939610b893de068c82c347d06319cd231a4602

I also picked up 2 previous patches from hch too:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.18&id=977ff73e64151d94811f4ba905419c90573f63e1
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.18&id=385411ffba0c3305491346b98ba4d2cd8063f002

Should those go through block too? Or is there no plan to remove
bdevname()?

Thanks,
Mike

