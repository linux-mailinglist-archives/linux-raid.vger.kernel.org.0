Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA81A74A0
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406588AbgDNHZN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406587AbgDNHZL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Apr 2020 03:25:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A71C0A3BDC
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 00:25:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ca21so13377749edb.7
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=VViBEFAsmiZszekuN8QcvpcbzWlnzRjZu+fvzPFoyyI=;
        b=NV5qX8uKvg/DYZd45gwa+eTVdfhbsGWEjT+6SzXqE1WnqGCFZyXXyiL+nw14h8vsM8
         KWYwPYkGBZlJQxeAP/ivL3v+w8mbWADV5KnLrz/a2tolDdlGueWGSvh5wWl+iVDwZKTg
         2kkqonicfBcyP/jMyCZsTNZrRhj2MgPbD1ytCMcKuNkq6q0SijcHa/aUXoeFfMytQ4/n
         NoEF/NiVQ8jfaSG+c7DYkHx+9/KjsCwUeBA2Ggp0hJ4Sy1+Jnz5ldsvFnOk0RaxDBL1Q
         0mPUSuBU0jw3tDd7U0P9VqpCOLY2HG7Uvw3S5+IxAeey43jN9G4zT6x5Yd3RUbWIeqlI
         lFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VViBEFAsmiZszekuN8QcvpcbzWlnzRjZu+fvzPFoyyI=;
        b=n2bFBVI3bxPgcMbZ1CqVK1GHiHqcgqhk8+i4ioBT9wu+HTjqA0FVrFnQUVUxSqVjXa
         IcL8/FHGAcebDe/VMZrS9iybR6nmb8Kt764ugu+/A+FVsAyvwxRvmL9hk+JthFIeRxxw
         pGTq68873XTfkEgEfdD2X7MmUX/zfKad8Nuig/8q14z2wo4XSKALP4qug0vdI1+Tc/iQ
         CQ7wnnoRIYBNEJaFKPn1Unhpvz4kCIRMpu24VAlObXb3r1rzL9tYVCDr2yvksjC6Zz27
         4wlFhJet8Waaq/RDgp8U6ZsNz0N3YN9qleei2VPMsfAGAF14qz1uyY3udooxyQQSjmi1
         W9hQ==
X-Gm-Message-State: AGi0PubWu3523Rwi8rnJ6PEd71S1L3NXDFJL9tBtkJMe3HIPnVRtrFTC
        EbJ4hUDHKG/QfYDnyUNdToWJMa7+nlU=
X-Google-Smtp-Source: APiQypLrdzGSBTzLTsCEFEKo6MMbjeWzM7/JOAQOA+AbzMS9lGTRtJd3LJoP/KYtimG3K/ROLh7xtQ==
X-Received: by 2002:a17:906:348d:: with SMTP id g13mr13245426ejb.374.1586849109208;
        Tue, 14 Apr 2020 00:25:09 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4871:9b00:34d4:fc5b:d862:dbd2? ([2001:16b8:4871:9b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id u13sm1616018edi.82.2020.04.14.00.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:25:08 -0700 (PDT)
Subject: Re: [PATCH] Detail: adding sync status for cluster device
To:     Lidong Zhong <lidong.zhong@suse.com>, jes@trained-monkey.org,
        linux-raid@vger.kernel.org
References: <20200413144128.26177-1-lidong.zhong@suse.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <bcd5713f-d2e8-d358-17c9-323f9c125d1b@cloud.ionos.com>
Date:   Tue, 14 Apr 2020 09:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200413144128.26177-1-lidong.zhong@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13.04.20 16:41, Lidong Zhong wrote:
> On the node with /proc/mdstat is
>
> Personalities : [raid1]
> md0 : active raid1 sdb[4] sdc[3] sdd[2]
>        1046528 blocks super 1.2 [3/2] [UU_]
>          recover=REMOTE
>        bitmap: 1/1 pages [4KB], 65536KB chunk
>
> the 'State' of 'mdadm -Q -D' is accordingly

Maybe rephrase it a little bit, something like.

"Let's change the 'State' of 'mdadm -Q -D' accordingly "

Just FYI.

> State : clean, degraded
> With this patch, it will be
> State : clean, degraded, recovering (REMOTE)
>
> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
> ---
>   Detail.c | 9 ++++++---
>   mdadm.h  | 3 ++-
>   mdstat.c | 2 ++
>   3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Detail.c b/Detail.c
> index 832485f..03d5e04 100644
> --- a/Detail.c
> +++ b/Detail.c
> @@ -496,17 +496,20 @@ int Detail(char *dev, struct context *c)
>   			} else
>   				arrayst = "active";
>   
> -			printf("             State : %s%s%s%s%s%s \n",
> +			printf("             State : %s%s%s%s%s%s%s \n",
>   			       arrayst, st,
>   			       (!e || (e->percent < 0 &&
>   				       e->percent != RESYNC_PENDING &&
> -				       e->percent != RESYNC_DELAYED)) ?
> +				       e->percent != RESYNC_DELAYED &&
> +				       e->percent != RESYNC_REMOTE)) ?
>   			       "" : sync_action[e->resync],
>   			       larray_size ? "": ", Not Started",
>   			       (e && e->percent == RESYNC_DELAYED) ?
>   			       " (DELAYED)": "",
>   			       (e && e->percent == RESYNC_PENDING) ?
> -			       " (PENDING)": "");
> +			       " (PENDING)": "",
> +			       (e && e->percent == RESYNC_REMOTE) ?
> +			       " (REMOTE)": "");
>   		} else if (inactive && !is_container) {
>   			printf("             State : inactive\n");
>   		}
> diff --git a/mdadm.h b/mdadm.h
> index d94569f..399478b 100644
> --- a/mdadm.h
> +++ b/mdadm.h
> @@ -1815,7 +1815,8 @@ enum r0layout {
>   #define RESYNC_NONE -1
>   #define RESYNC_DELAYED -2
>   #define RESYNC_PENDING -3
> -#define RESYNC_UNKNOWN -4
> +#define RESYNC_REMOTE  -4
> +#define RESYNC_UNKNOWN -5
>   
>   /* When using "GET_DISK_INFO" it isn't certain how high
>    * we need to check.  So we impose an absolute limit of
> diff --git a/mdstat.c b/mdstat.c
> index 7e600d0..20577a3 100644
> --- a/mdstat.c
> +++ b/mdstat.c
> @@ -257,6 +257,8 @@ struct mdstat_ent *mdstat_read(int hold, int start)
>   					ent->percent = RESYNC_DELAYED;
>   				if (l > 8 && strcmp(w+l-8, "=PENDING") == 0)
>   					ent->percent = RESYNC_PENDING;
> +				if (l > 7 && strcmp(w+l-7, "=REMOTE") == 0)
> +					ent->percent = RESYNC_REMOTE;
>   			} else if (ent->percent == RESYNC_NONE &&
>   				   w[0] >= '0' &&
>   				   w[0] <= '9' &&

Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks,
Guoqing
