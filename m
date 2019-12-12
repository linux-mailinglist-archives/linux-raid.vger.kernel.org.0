Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC21711C34F
	for <lists+linux-raid@lfdr.de>; Thu, 12 Dec 2019 03:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfLLCil (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 21:38:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbfLLCil (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Dec 2019 21:38:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 61DD0CEB9DF116608816;
        Thu, 12 Dec 2019 10:38:39 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 10:38:29 +0800
Subject: Re: [PATCH] md-bitmap: small cleanups
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <songliubraving@fb.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        <linux-raid@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>, <guiyao@huawei.com>
References: <b0701f30-5df9-059e-95f1-74a887782528@huawei.com>
Message-ID: <f684ec06-cb01-b296-33bd-0e429af01077@huawei.com>
Date:   Thu, 12 Dec 2019 10:38:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b0701f30-5df9-059e-95f1-74a887782528@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Friendly ping...

On 2019/12/7 11:00, liuzhiqiang (I) wrote:
> 
> In md_bitmap_unplug, bitmap->storage.filemap is double checked.
> 
> In md_bitmap_daemon_work, bitmap->storage.filemap should be checked
> before reference.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/md/md-bitmap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 3ad18246fcb3..9860062bdc1e 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1019,8 +1019,6 @@ void md_bitmap_unplug(struct bitmap *bitmap)
>  	/* look at each page to see if there are any set bits that need to be
>  	 * flushed out to disk */
>  	for (i = 0; i < bitmap->storage.file_pages; i++) {
> -		if (!bitmap->storage.filemap)
> -			return;
>  		dirty = test_and_clear_page_attr(bitmap, i, BITMAP_PAGE_DIRTY);
>  		need_write = test_and_clear_page_attr(bitmap, i,
>  						      BITMAP_PAGE_NEEDWRITE);
> @@ -1338,7 +1336,8 @@ void md_bitmap_daemon_work(struct mddev *mddev)
>  				   BITMAP_PAGE_DIRTY))
>  			/* bitmap_unplug will handle the rest */
>  			break;
> -		if (test_and_clear_page_attr(bitmap, j,
> +		if (bitmap->storage.filemap &&
> +		    test_and_clear_page_attr(bitmap, j,
>  					     BITMAP_PAGE_NEEDWRITE)) {
>  			write_page(bitmap, bitmap->storage.filemap[j], 0);
>  		}
> 

