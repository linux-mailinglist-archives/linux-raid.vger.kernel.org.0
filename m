Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C248A1A339C
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 13:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDIL4J (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 07:56:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:46764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIL4J (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 07:56:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55C8CAE30;
        Thu,  9 Apr 2020 11:56:08 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] md: remove redundant memalloc scope API usage
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     mhocko@suse.com, kent.overstreet@gmail.com,
        guoqing.jiang@cloud.ionos.com
References: <20200409115258.19330-1-colyli@suse.de>
 <20200409115258.19330-5-colyli@suse.de>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <74a9c926-abe4-ff05-4deb-bce7b42f4861@suse.de>
Date:   Thu, 9 Apr 2020 19:55:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409115258.19330-5-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/4/9 7:52 下午, colyli@suse.de wrote:
> From: Coly Li <colyli@suse.de>
> 
> In mddev_create_serial_pool(), memalloc scope APIs memalloc_noio_save()
> and memalloc_noio_restore() are used when allocating memory by calling
> mempool_create_kmalloc_pool(). After adding the memalloc scope APIs in
> raid array suspend context, it is unncessary to explicitly call them
> around mempool_create_kmalloc_pool() any longer.
> 
> This patch removes the redundant memalloc scope APIs in
> mddev_create_serial_pool().
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/md/md.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1a8e1bb3a7f4..ef29f49a0f51 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -229,11 +229,9 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>  	if (mddev->serial_info_pool == NULL) {
>  		unsigned int noio_flag;
		^^^^^^^^^^^^^^^^^^^^^^^ I will remove this one in v3 series.


Coly Li


>  
> -		noio_flag = memalloc_noio_save();
>  		mddev->serial_info_pool =
>  			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
>  						sizeof(struct serial_info));
> -		memalloc_noio_restore(noio_flag);
>  		if (!mddev->serial_info_pool) {
>  			rdevs_uninit_serial(mddev);
>  			pr_err("can't alloc memory pool for serialization\n");
> 
