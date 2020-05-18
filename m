Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE91D7FFD
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgERRWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 18 May 2020 13:22:44 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17144 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRWo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 13:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589822560; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=E6FN83Csxi5n4MiSaBvBIYgg5gCWYVUjMFGeuBqNCzkRwkkqv0bZnxe3U0fuhDY2egQvyYtjBl0Im5dae8tn33h5asDp5tx06g16oaHCLnWiZdtd3vheWwgWb7iOurapr7pZd7AhdbK0SzQ68KJ9V8wxzRG/t1GWQjgH2Bb0MeU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589822560; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jHjeTkPFF4G4je9nddldkg++oG1CyzTIOCdrnOre4Ng=; 
        b=L3k+9SE0So1nhjK07ZBH6iFk1mVxktZcOUYDybKDEK39zqfr81K6NOb8R1QZAshfbumRM6alkKpe7GXSd2SfayJeeolDgdwP4YOTQsm7utY00oogtBzp1ucW4M1P2kiz/XkfkDAB4omF8+MwF2YZ29AoR45mkZ9BkkyBicx2Zl0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1589822558176391.5499239306856; Mon, 18 May 2020 19:22:38 +0200 (CEST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
Date:   Mon, 18 May 2020 13:22:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/15/20 9:40 AM, Guoqing Jiang wrote:
> Got below error when run "make everything".
> 
> restripe.c: In function ‘test_stripes’:
> restripe.c:870:4: error: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Werror=unused-result]
>     read(source[i], stripes[i], chunk_size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by set the return value of ‘read’ to diskP, which should be
> harmless since diskP will be set again before it is used.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  restripe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/restripe.c b/restripe.c
> index 31b07e8..21c90f5 100644
> --- a/restripe.c
> +++ b/restripe.c
> @@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long *offsets,
>  
>  		for (i = 0 ; i < raid_disks ; i++) {
>  			lseek64(source[i], offsets[i]+start, 0);
> -			read(source[i], stripes[i], chunk_size);
> +			/*
> +			 * To resolve "ignoring return value of ‘read’", it
> +			 * should be harmless since diskP will be again later.
> +			 */
> +			diskP = read(source[i], stripes[i], chunk_size);

It doesn't complain on Fedora 32, however checking the return value of
lseek64 and read is a good thing.

However what you have done is to just masking the return value and
throwing it away, is not OK. Please do it properly.

Thanks,
Jes


