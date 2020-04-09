Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B357F1A368A
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDIPFX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 11:05:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33944 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgDIPFW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Apr 2020 11:05:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so12343690wrl.1
        for <linux-raid@vger.kernel.org>; Thu, 09 Apr 2020 08:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GZYM993l9uhD+/USvGJK9CAqwnlDkzwYG3GTqOD0H2A=;
        b=Df4cpqti6yyhiblhUMIt9h+x+8jlDohh5AKxO6IKm+96KEksNSKGN9w+yRWiuF1iOJ
         Y2UlvOOhi4UJnyEfr+5NujDH+FrRuA0TJEChwhMXvyOsqfrgo7KO/igjo0Tb/Q+0VJzp
         iOr+8G2WZ3sxY/BAhTHC6CrtFUEFOh26oZjwesMStpDvIylKwMVkMK1uY96/jIl9b0ZW
         QE0iGcKHkkFfhq3OGQqw2yshtYLlqJn8jjWwUAtol1DN07SNcjEa/1m3CPe3kI6pZ87e
         S+Z16wTOE6MlXtkAHZpTXFCjgX82da5XqDU8VvUApDzADtUepvDmdVT+czTtYSZ/ddG3
         uOFQ==
X-Gm-Message-State: AGi0PuZTXmmvHDXZa47wHoRwQMeSX4n++f7XJx60N/i1TXqi9pbiF4NZ
        Ow6KfhkB3QeMAXNahLnl2Rg=
X-Google-Smtp-Source: APiQypIjuKhz9fjthi4mugnn5TmbK1Lso+nCElvn5YCtUxqOFPFb8+YqXIXKNPN/83Hcl1V/xXNp6Q==
X-Received: by 2002:adf:e811:: with SMTP id o17mr6359101wrm.390.1586444722121;
        Thu, 09 Apr 2020 08:05:22 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id i2sm40387017wrx.22.2020.04.09.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:05:21 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:05:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     colyli@suse.de
Cc:     songliubraving@fb.com, linux-raid@vger.kernel.org,
        kent.overstreet@gmail.com, guoqing.jiang@cloud.ionos.com
Subject: Re: [PATCH v3 1/4] md: use memalloc scope APIs in
 mddev_suspend()/mddev_resume()
Message-ID: <20200409150518.GN18386@dhcp22.suse.cz>
References: <20200409141723.24447-1-colyli@suse.de>
 <20200409141723.24447-2-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409141723.24447-2-colyli@suse.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu 09-04-20 22:17:20, colyli@suse.de wrote:
> From: Coly Li <colyli@suse.de>
> 
> In raid5.c:resize_chunk(), scribble_alloc() is called with GFP_NOIO
> flag, then it is sent into kvmalloc_array() inside scribble_alloc().
> 
> The problem is kvmalloc_array() eventually calls kvmalloc_node() which
> does not accept non GFP_KERNEL compatible flag like GFP_NOIO, then
> kmalloc_node() is called indeed to allocate physically continuous
> pages. When system memory is under heavy pressure, and the requesting
> size is large, there is high probability that allocating continueous
> pages will fail.
> 
> But simply using GFP_KERNEL flag to call kvmalloc_array() is also
> progblematic. In the code path where scribble_alloc() is called, the
> raid array is suspended, if kvmalloc_node() triggers memory reclaim I/Os
> and such I/Os go back to the suspend raid array, deadlock will happen.
> 
> What is desired here is to allocate non-physically (a.k.a virtually)
> continuous pages and avoid memory reclaim I/Os. Michal Hocko suggests
> to use the mmealloc sceope APIs to restrict memory reclaim I/O in
> allocating context, specifically to call memalloc_noio_save() when
> suspend the raid array and to call memalloc_noio_restore() when
> resume the raid array.
> 
> This patch adds the memalloc scope APIs in mddev_suspend() and
> mddev_resume(), to restrict memory reclaim I/Os during the raid array
> is suspended. The benifit of adding the memalloc scope API in the
> unified entry point mddev_suspend()/mddev_resume() is, no matter which
> md raid array type (personality), we are sure the deadlock by recursive
> memory reclaim I/O won't happen on the suspending context.

I am not familiar with the mdraid code so I cannot really judge the
correctness here but if mddev_suspend really acts as a potential reclaim
recursion deadlock entry then this is the right way to use the API.
Essentially all the allocations in that scope will have an implicit NOIO
semantic.

Thing to be careful about is the make sure that mddev_suspend cannot
be nested. And also that there are no callers of scribble_alloc outside
of mddev_suspend scope which would be reclaim deadlock prone. If they
are their scope should be handled in the similar way.

Thanks!
-- 
Michal Hocko
SUSE Labs
