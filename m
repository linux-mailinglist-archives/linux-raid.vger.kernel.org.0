Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70B8AB49
	for <lists+linux-raid@lfdr.de>; Tue, 13 Aug 2019 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLXhF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Aug 2019 19:37:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfHLXhE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 12 Aug 2019 19:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB9B489AC0
        for <linux-raid@vger.kernel.org>; Mon, 12 Aug 2019 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E23919C4F;
        Mon, 12 Aug 2019 23:37:02 +0000 (UTC)
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        heinzm@redhat.com
References: <20190812153039.13604-1-ncroxon@redhat.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
Date:   Tue, 13 Aug 2019 07:37:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190812153039.13604-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 12 Aug 2019 23:37:04 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 08/12/2019 11:30 PM, Nigel Croxon wrote:
> Often limits can be changed by admin. When discussing such things
> it helps if you can provide "self-sustained" facts. Also
> sometimes the admin thinks he changed a limit, but it did not
> take effect for some reason or he changed the wrong thing.
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>   drivers/md/raid5.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 522398f61eea..e2b58b58018b 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2566,8 +2566,8 @@ static void raid5_end_read_request(struct bio * bi, int error)
>   				bdn);
>   		} else if (atomic_read(&rdev->read_errors)
>   			 > conf->max_nr_stripes)
> -			pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
> -			       mdname(conf->mddev), bdn);
> +			pr_warn("md/raid:%s: Too many read errors (%d), failing device %s.\n",
> +			       mdname(conf->mddev), conf->max_nr_stripes, bdn);
>   		else
>   			retry = 1;
>   		if (set_bad && test_bit(In_sync, &rdev->flags)

Hi Nigel

Is it better to print rdev->read_errors too? So it can know the error 
numbers and the max nr stripes

Regards
Xiao
