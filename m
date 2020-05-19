Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2251D8C40
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgESA0T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 18 May 2020 20:26:19 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17142 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgESA0S (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 20:26:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589847976; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=eVuu+viJHg4zFJoVWSXqOI8zf85epNmAEpk6z7bkwXCKU4z0MndDu3TdRnwggMn4RkNqCsVdDQEnosWjAdLjhAA8y5O8JaHOJmb55Kw9TCaZ0ypTUlNnDPa4muwzKKZAUtXgW4w2sl7YT8EfXKGLAcPO5uWjcKcoBuIit+kCqiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589847976; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=d3gnLS98kYsOl/MwbFfZXoxPED1N3+zGiSnWMYnyTAE=; 
        b=CvrwVt0mOEUTz/g7NEkZH62RQswWUcNOijkBFWRF6aWC1CED7HU68PyxDYCVuBaofPiSuq3Cn0BY6w7tP69qwyrbHhCvgS9MkoEf6FJ9f3+vj8PArGX3PJpm67YhKHrUR9G1EG3uw20/kHxsnmY8c23a8+EE7vZhj9YwiU6zpCc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1589847973959485.40346000334637; Tue, 19 May 2020 02:26:13 +0200 (CEST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_V3_2/2=5d_restripe=3a_fix_ignoring_return_?=
 =?UTF-8?B?dmFsdWUgb2Yg4oCYcmVhZOKAmSBhbmQgbHNlZWs=?=
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org
References: <20200518215336.29000-1-guoqing.jiang@cloud.ionos.com>
 <20200518215336.29000-3-guoqing.jiang@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7ba82317-5747-8297-bf8f-1883483adfea@trained-monkey.org>
Date:   Mon, 18 May 2020 20:26:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518215336.29000-3-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 5:53 PM, Guoqing Jiang wrote:
> Got below error when run "make everything".
> 
> restripe.c: In function ‘test_stripes’:
> restripe.c:870:4: error: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Werror=unused-result]
>     read(source[i], stripes[i], chunk_size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by check the return value of ‘read’, and free memory
> in the failure case.
> 
> And check the return value of lseek as well per Jes's comment.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  restripe.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/restripe.c b/restripe.c
> index 31b07e8..86e1d00 100644
> --- a/restripe.c
> +++ b/restripe.c
> @@ -866,8 +866,16 @@ int test_stripes(int *source, unsigned long long *offsets,
>  		int disk;
>  
>  		for (i = 0 ; i < raid_disks ; i++) {
> -			lseek64(source[i], offsets[i]+start, 0);
> -			read(source[i], stripes[i], chunk_size);
> +			if ((lseek64(source[i], offsets[i]+start, 0) < 0) ||
> +			    (read(source[i], stripes[i], chunk_size) !=
> +			     chunk_size)) {
> +				free(q);
> +				free(p);
> +				free(blocks);
> +				free(stripes);
> +				free(stripe_buf);
> +				return -1;
> +			}
>  		}
>  		for (i = 0 ; i < data_disks ; i++) {
>  			int disk = geo_map(i, start/chunk_size, raid_disks,
> 

This is not the prettiest solution, would have been nicer to introduce a
cleanup handler at the end and just jumping to it.

That said, I have applied it since restripe.c is pretty ugly across the
board.

Thanks,
Jes


