Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1831510F471
	for <lists+linux-raid@lfdr.de>; Tue,  3 Dec 2019 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCBSD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 20:18:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbfLCBSC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 20:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575335881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7oDj8udHrZtIG3Zgipc1/FEEXeOz/FEpcr2/vhvsd4=;
        b=Tpcc4iM+jiTEmFWwHz+pCDG6xw268MTP0qupf0Yndfdxc0cK20QvWhVzfYrok+sNx195Jr
        LBMPhBIjNIK0bXkTf4NIJ/aEPDQ+pIMdQ+Yj44gkQ+E8DwnXtD3knDDt+0Ys05JsEZS2dR
        +5q5PJAj1bdlw/PhcCGs2sYEEW85Tpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-oKIaVQ4UOYqxIdEKBG6uPw-1; Mon, 02 Dec 2019 20:17:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7882E8017DF;
        Tue,  3 Dec 2019 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC0E05C541;
        Tue,  3 Dec 2019 01:17:54 +0000 (UTC)
Subject: Re: [PATCH] raid5: need to set STRIPE_HANDLE for batch head
To:     jgq516@gmail.com, linux-raid@vger.kernel.org
Cc:     liu.song.a23@gmail.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20191127165750.21317-1-guoqing.jiang@cloud.ionos.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <2ab18390-7d0d-0b97-65f6-170ea0bf6e32@redhat.com>
Date:   Tue, 3 Dec 2019 09:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191127165750.21317-1-guoqing.jiang@cloud.ionos.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: oKIaVQ4UOYqxIdEKBG6uPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/28/2019 12:57 AM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> With commit 6ce220dd2f8ea71d6afc29b9a7524c12e39f374a ("raid5: don't set
> STRIPE_HANDLE to stripe which is in batch list"), we don't want to set
> STRIPE_HANDLE flag for sh which is already in batch list.
>
> However, the stripe which is the head of batch list should set this flag,
> otherwise panic could happen inside init_stripe at BUG_ON(sh->batch_head),
> it is reproducible with raid5 on top of nvdimm devices per Xiao oberserved.
>
> Thanks for Xiao's effort to verify the change.
>
> Fixes: 6ce220dd2f8ea ("raid5: don't set STRIPE_HANDLE to stripe which is in batch list")
> Reported-by: Xiao Ni <xni@redhat.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>   drivers/md/raid5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index f0fc538bfe59..d4d3b67ffbba 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5726,7 +5726,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   				do_flush = false;
>   			}
>   
> -			if (!sh->batch_head)
> +			if (!sh->batch_head || sh == sh->batch_head)
>   				set_bit(STRIPE_HANDLE, &sh->state);
>   			clear_bit(STRIPE_DELAYED, &sh->state);
>   			if ((!sh->batch_head || sh == sh->batch_head) &&

Tested-by: Xiao Ni <xni@redhat.com>

