Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF67227AC2
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jul 2020 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgGUIfP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jul 2020 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUIfP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 Jul 2020 04:35:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5DC061794
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 01:35:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so20836525ejb.2
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pBL0XsLjfXLY4KE6P3j+A7rK6D5P3aiBYZ8YBpbLaJA=;
        b=PvyP643QJaMj8mTwrqcXSBZAxB+7htuyz4Qe9iwbdrCKV5FZgs/Hzd6u8uLI3BRATl
         JH+VkH8TK6QGNVDtwxOZvet1NCAKSo4qA/epHMGQz8x70yFBKUsOmWvk+4WhNJ/XWZQP
         NCYdXFf2xvG7AXJj0Njf8pptcPStRGZHDbrU+BPSfIn2v5s26t9nAzkZdeyWn5Fjwf5U
         LKp4OaB6RaBWdDAtHL22HrCv/zYJg9Pb6sNeizEFP9Nb+mlIIDQBKIl6rca6lJi+FaPj
         jmGsp5L4KN4FkwsUnOhQuLzYzur2ruhHjRSpSR3hOyHAZvzb9MOBBUJYe6V90WfC5fti
         FtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pBL0XsLjfXLY4KE6P3j+A7rK6D5P3aiBYZ8YBpbLaJA=;
        b=AYR8ab0GE6dp3Cj32sNeR2eOvYNppiTdCZwGvWww+prNlPdbEhkRZXbioCVUyu893k
         wHO924+n9CvegcQzi8031GZJ8CbL/3+C0BHk94noai3K1XDClC3pFKdhb0cLlXrk/IXO
         P3nQKzGTnYBtvg8w94enLPzvlbPRNGn8ab43X1qSdW9kgE9EZslxO79L8Uk3NmIxNFPa
         OjA4De1rdObK41yoR9V3psR/mSYEEIhD4VftGDhYfjyTxvXvYVwpKyaFHT02e8ts7piv
         UKkzdh2uZaEIH4LiGB9sHN03hW6MkheiVtXomMRjd4sk67oEPLbRCna5nOmlru8byNSl
         cbJw==
X-Gm-Message-State: AOAM532LiuMzMwHt/aRIxQiffISNLnPxrdUk43wLgRCJSttk+4aFLV81
        2yY3tAPyYHhdbpoI0jkTtTdIWHH+pewrqA==
X-Google-Smtp-Source: ABdhPJwZMgZCvLdohdr1ytb8dGmPsdcsuBiO7DERFj96+Vyrj0LjHOcN5rjci48zEmN6DZp47d8CWQ==
X-Received: by 2002:a17:906:57c5:: with SMTP id u5mr23455999ejr.311.1595320513716;
        Tue, 21 Jul 2020 01:35:13 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:95e4:6f22:52e4:7012? ([2001:1438:4010:2540:95e4:6f22:52e4:7012])
        by smtp.gmail.com with ESMTPSA id v24sm16691100eds.71.2020.07.21.01.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:35:13 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] md-cluster: fix safemode_delay value when
 converting to clustered bitmap
To:     Zhao Heming <heming.zhao@suse.com>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com, song@kernel.org
References: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
 <1595268533-7040-2-git-send-email-heming.zhao@suse.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <8f122dea-2a4a-4523-653f-fe6fc2842653@cloud.ionos.com>
Date:   Tue, 21 Jul 2020 10:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1595268533-7040-2-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/20/20 8:08 PM, Zhao Heming wrote:
> When array convert to clustered bitmap, the safe_mode_delay doesn't
> clean and vice versa. the /sys/block/mdX/md/safe_mode_delay keep original
> value after changing bitmap type. In safe_delay_store(), the code forbids
> setting mddev->safemode_delay when array is clustered. So in cluster-md
> env, the expected safemode_delay value should be 0.
>
> Reproducible steps:
> ```
> node1 # mdadm --zero-superblock /dev/sd{b,c,d}
> node1 # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
> node1 # cat /sys/block/md0/md/safe_mode_delay
> 0.204
> node1 # mdadm -G /dev/md0 -b none
> node1 # mdadm --grow /dev/md0 --bitmap=clustered
> node1 # cat /sys/block/md0/md/safe_mode_delay
> 0.204  <== doesn't change, should ZERO for cluster-md
>
> node1 # mdadm --zero-superblock /dev/sd{b,c,d}
> node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
> node1 # cat /sys/block/md0/md/safe_mode_delay
> 0.000
> node1 # mdadm -G /dev/md0 -b none
> node1 # cat /sys/block/md0/md/safe_mode_delay
> 0.000  <== doesn't change, should default value
> ```
>
> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
> ---
>   drivers/md/md.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f567f536b529..1bde3df3fa18 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -101,6 +101,8 @@ static void mddev_detach(struct mddev *mddev);
>    * count by 2 for every hour elapsed between read errors.
>    */
>   #define MD_DEFAULT_MAX_CORRECTED_READ_ERRORS 20
> +/* Default safemode delay: 200 msec */
> +#define DEFAULT_SAFEMODE_DELAY ((200 * HZ)/1000 +1)
>   /*
>    * Current RAID-1,4,5 parallel reconstruction 'guaranteed speed limit'
>    * is 1000 KB/sec, so the extra system load does not show up that much.
> @@ -5982,7 +5984,7 @@ int md_run(struct mddev *mddev)
>   	if (mddev_is_clustered(mddev))
>   		mddev->safemode_delay = 0;
>   	else
> -		mddev->safemode_delay = (200 * HZ)/1000 +1; /* 200 msec delay */
> +		mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
>   	mddev->in_sync = 1;
>   	smp_wmb();
>   	spin_lock(&mddev->lock);
> @@ -7361,6 +7363,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
>   
>   				mddev->bitmap_info.nodes = 0;
>   				md_cluster_ops->leave(mddev);
> +				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
>   			}

Not about the patch itself, just confuse about the meaning of 
safemode_delay.
As safemode_delay represents 200 ms delay, but md_write_end has this.

                 /* The roundup() ensures this only performs locking once
                  * every ->safemode_delay *jiffies*
                  */
                 mod_timer(&mddev->safemode_timer,
                           roundup(jiffies, mddev->safemode_delay) +
                           mddev->safemode_delay);

And the second argument in mod_timer() means "new timeout in jiffies",
does the above need to convert from ms to jiffies? Am I miss something?

Thanks,
Guoqing
