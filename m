Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544851994AF
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgCaLFV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 07:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:32902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbgCaLFV (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 31 Mar 2020 07:05:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F5E8AF4D;
        Tue, 31 Mar 2020 11:05:20 +0000 (UTC)
Subject: Re: [PATCH] raid5: use kmalloc_array() for GFP_NOIO flag
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200330154010.113469-1-colyli@suse.de>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <191a9178-cd26-9de5-f0d3-64db9436d533@suse.de>
Date:   Tue, 31 Mar 2020 19:05:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330154010.113469-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/3/30 11:40 下午, Coly Li wrote:
> Commit b330e6a49dc3 ("md: convert to kvmalloc") uses kvmalloc_array()
> to allocate memory with GFP_NOIO flag in resize_chunks() via function
> scribble_alloc(),
> 2269	err = scribble_alloc(percpu, new_disks,
> 2270			     new_sectors / STRIPE_SECTORS,
> 2271			     GFP_NOIO);
> 
> Indeed kvmalloc() inside kvmalloc_array() does not accept non GFP_KERNEL
> compatible flags, it means GFP_NOIO will make kvmalloc_node() call
> kmalloc_node() instead, which is not the above listed code wants.
> 
> For md raid1 and raid10 code, such allocation just simply calls
> kmalloc_array(), which is enough and works fine. This patch removes
> the misleading kvmalloc_array() and simply uses kmalloc_array() as
> md raid1 and raid10 code do.
> 
> Fixes: b330e6a49dc3 ("md: convert to kvmalloc")
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> ---
>  drivers/md/raid5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index ba00e9877f02..dda2701290bf 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2235,7 +2235,7 @@ static int scribble_alloc(struct raid5_percpu *percpu,
>  		sizeof(addr_conv_t) * (num+2);
>  	void *scribble;
>  
> -	scribble = kvmalloc_array(cnt, obj_size, flags);
> +	scribble = kmalloc_array(cnt, obj_size, flags);
>  	if (!scribble)
>  		return -ENOMEM;
>  
> 

I will post another version to use memalloc_noio_save()/restore() scope
APIs. Please ignore this patch.

Thanks.
-- 

Coly Li
