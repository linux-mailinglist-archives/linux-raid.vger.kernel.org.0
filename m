Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0A1AA9DA
	for <lists+linux-raid@lfdr.de>; Wed, 15 Apr 2020 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbgDOOXX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 10:23:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42439 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391929AbgDOOXH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Apr 2020 10:23:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id j2so7258wrs.9
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 07:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gr3ey1RVSkBz8rX1j6ts9xwnogaH3ibIsOLfG1pKzRM=;
        b=g8/GbBkbiEQi+d4CbdZOT53hHkZds9682EjAID7trivaN2WVNx26RqqVtzm8JJeyRZ
         eraVE0/fKVlIWC0uip0zCuTklipkY9avs6h5gTNDGTNz9herFmfX4ANcHV2qxYPrYToy
         1fWG27/HnRhQSUpZwprYgbudXpwt+0cmR4kJqORfdraytGZM/aLF1kwuOyL7uaM8+WNQ
         BQFZr1QHXfyBhMgxdS9lli277N/W8JvW9j9OlKO896VEnVGlkWIAXklc4qnPl8A53m0V
         aGkk+CGascIDS4XfbhhG8Xpqgak2771dfyjreoMhURibPptFkk2nRdjZyaajhjM+KmC6
         4kiQ==
X-Gm-Message-State: AGi0PubqhoOhYJd8pFsj9vrOUsLXkF+jv0GjyCJPS2Wl0k201DfVG9sv
        49jbeoQLoYoUgxiPQqhurLA=
X-Google-Smtp-Source: APiQypKKrFc2hicExjsQFyl/A7JWajrhfVO9JDoX0XdyPDeNHM2vepsrKdo7/q7I4D6DKL6hMEnOdg==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr11557958wrp.112.1586960585838;
        Wed, 15 Apr 2020 07:23:05 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id h2sm5240203wro.9.2020.04.15.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:23:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 16:23:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Coly Li <colyli@suse.de>, songliubraving@fb.com,
        linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
Message-ID: <20200415142303.GN4629@dhcp22.suse.cz>
References: <20200402081312.32709-1-colyli@suse.de>
 <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
 <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
 <204e9fd0-3712-4864-2bf5-38913511e658@cloud.ionos.com>
 <20200415114814.GJ4629@dhcp22.suse.cz>
 <a1e83cb5-366c-17a7-3a4b-9cd8a54c3b48@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e83cb5-366c-17a7-3a4b-9cd8a54c3b48@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed 15-04-20 16:10:08, Guoqing Jiang wrote:
> On 15.04.20 13:48, Michal Hocko wrote:
> > On Thu 09-04-20 23:38:13, Guoqing Jiang wrote:
> > [...]
> > > Not know memalloc_noio_{save,restore} well, but I guess it is better
> > > to use them to mark a small scope, just my two cents.
> > This would go against the intentio of the api. It is really meant to
> > define reclaim recursion problematic scope.
> 
> Well, in current proposal, the scope is just when
> scribble_allo/kvmalloc_array is called.
> 
> memalloc_noio_save
> scribble_allo/kvmalloc_array
> memalloc_noio_restore
> 
> With the new proposal, the marked scope would be bigger than current one
> since there
> are lots of places call mddev_suspend/resume.
> 
> mddev_suspend
> memalloc_noio_save
> ...
> memalloc_noio_restore
> mddev_resume
> 
> IMHO, if the current proposal works then what is the advantage to increase
> the scope.

The advantage is twofold. It serves the documentation purpose because it
is clear _what_ and _why_ is the actual allocation restricted context.
In this case mddev_{suspend,resume} because XYZ and you do not have to
care about __GFP_IO for _any_ allocation inside the scope.

> If all the callers of mddev_suspend/resume could suffer from the
> deadlock issue due to recursing fs io, then it is definitely need to
> use the new proposal.

Why some of them wouldn't? Isn't the mddev_suspend going to block any IO
on the device? The thing is that you cannot tell which devices the
allocator can issue IO for therefore GFP_NOIO is a global flag. Please
also note that the scope API is bound to a process context so it only
affects the current execution.
-- 
Michal Hocko
SUSE Labs
