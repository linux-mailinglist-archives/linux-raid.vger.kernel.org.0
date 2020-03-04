Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9A179C61
	for <lists+linux-raid@lfdr.de>; Thu,  5 Mar 2020 00:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbgCDXZU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Mar 2020 18:25:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388548AbgCDXZR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Mar 2020 18:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583364316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8juafuY9nBxbQdXTOkQQGLh3mRvbcDsJuPyMUd6LN0=;
        b=DRLwErAqe8D1fUBfiuE7tvDYJTQtlvPk9Sldr4Ftw1/402+lIxM9AerPWDWnmGU88J87wI
        +A5EmwwCbcs791gyFsj/jWmzejZG8afUVO7n3sEmBPZZkheCEg/wuTze/bp7N1f73zF2q7
        UkhZl8Hovr3+bff3H4ogPzVXYnNmrSg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-6vFyphWnNBSAkHlQYGDDwA-1; Wed, 04 Mar 2020 18:25:13 -0500
X-MC-Unique: 6vFyphWnNBSAkHlQYGDDwA-1
Received: by mail-ed1-f71.google.com with SMTP id r26so2861069edl.5
        for <linux-raid@vger.kernel.org>; Wed, 04 Mar 2020 15:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8juafuY9nBxbQdXTOkQQGLh3mRvbcDsJuPyMUd6LN0=;
        b=DySyeD7wwTrZ01SdSyLK/00C2Otaspy7arVCylB4sL1fBJSTFQN512wbOsTrJ/aYfM
         VUjv4lFMzOkjGRcjQ/h5aAeJpw0MBSCmS9cbrVGWQQXLni/iHkhMfvsDXTI8RDRpeLwM
         CC9+ufc+C5J4Ukazwf3/Kqf2hkCxXMJmsZirDIRyIcyW2OvcLsHgJIaom9eGaa5hWXkG
         v8VcXoyhGc06zLnSaCK6GABnKbp1rsWqgcBDV33RJDjWql8amCxSLcCNBOZroHWDE5Lb
         mKfkTmbmavVQBS4pZJhL+k7NR7t4qlWXAQn6Lu85zHspjfL0A2ls1s6UiK/nZXCFU45M
         20Rw==
X-Gm-Message-State: ANhLgQ2y03Kmo9FLNyCvGgyOz5VT1pjPfIHgurS5etM/SM/gCjYKm7Qq
        dnvZRwfr13jl0T1sT0gWFk9pypfCKyQVhD2pF3VjlRwiDDI91jA1vlEyUrFV3wsaiq4bQs1AU/M
        BSE3MyIQ0t+E+pFsd71xPoPKijVaPYwJ/TP61ZQ==
X-Received: by 2002:aa7:cac4:: with SMTP id l4mr5308675edt.367.1583364311868;
        Wed, 04 Mar 2020 15:25:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtRn9VC83shY8XHTDzRhsN1U3qcWCfB7uMojQH5bbSmIYgKzcRcKNB9bk5ZyS5m8JegYhUQLyH/6undXUq6ODg=
X-Received: by 2002:aa7:cac4:: with SMTP id l4mr5308663edt.367.1583364311594;
 Wed, 04 Mar 2020 15:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20200223165724.23816-1-mcroce@redhat.com> <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
In-Reply-To: <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 5 Mar 2020 00:24:35 +0100
Message-ID: <CAGnkfhxAHctB9MHD0LzSk8uh4tEoF-hw+iwYAEdfeY_=g3NT2A@mail.gmail.com>
Subject: Re: [PATCH] block: refactor duplicated macros
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Mar 4, 2020 at 9:57 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Feb 23, 2020 at 9:04 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are defined
> > several times in different flavours across the whole tree.
> > Define them just once in a common header.
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  block/blk-lib.c                  |  2 +-
> >  drivers/block/brd.c              |  3 ---
> >  drivers/block/null_blk_main.c    |  4 ----
> >  drivers/block/zram/zram_drv.c    |  8 ++++----
> >  drivers/block/zram/zram_drv.h    |  2 --
> >  drivers/dax/super.c              |  2 +-
>
> For the dax change:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> However...
>
> [..]
> >  include/linux/blkdev.h           |  4 ++++
> [..]
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 053ea4b51988..b3c9be6906a0 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -910,6 +910,10 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> >  #define SECTOR_SIZE (1 << SECTOR_SHIFT)
> >  #endif
> >
> > +#define PAGE_SECTORS_SHIFT     (PAGE_SHIFT - SECTOR_SHIFT)
> > +#define PAGE_SECTORS           (1 << PAGE_SECTORS_SHIFT)
> > +#define SECTOR_MASK            (PAGE_SECTORS - 1)
> > +
>
> ...I think SECTOR_MASK is misnamed given it considers pages, and
> should probably match the polarity of PAGE_MASK, i.e.
>
> #define PAGE_SECTORS_MASK            (~(PAGE_SECTORS - 1))
>

Makes sense. I just kept the same value as in drivers/block/null_blk_main.c

-- 
Matteo Croce
per aspera ad upstream

