Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C521545D
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jul 2020 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgGFJJa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jul 2020 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJJa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jul 2020 05:09:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDEBC061794
        for <linux-raid@vger.kernel.org>; Mon,  6 Jul 2020 02:09:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so34102978edy.7
        for <linux-raid@vger.kernel.org>; Mon, 06 Jul 2020 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6xg1feNOVDA2uzgZqtN+dwTl9itDY0zxl+/OrGwsoGA=;
        b=CyG0+qX5O8JsKw48k1kxGVgSj6IJVCThBnQN55n8b7DLNHA1/1drOwWV4G5PHF8NYK
         t6y1mE1W0m1VQob5X3asb5LobAwfu+4/XDbaS9f1O6FVNohYW4nKM0ucnHTdRxvdlYN4
         xu8QyIslLeu47RvuuAE/Yp28FHXGOLfnZZzTi/kA0w9idw1YB4dC6wfzqns8Q8BzKCH4
         s0rNU6oAp8DV64ehTg1lJb7hugHAiXoGtz/wV2FBdwvlS/nBtvAynPPfE6n81ENQGlYJ
         rcxfk9BZfaBH4m+zXGeTsbODhxE6VE1qr9wftOgRF0Cv6vp6TujwLXoga+ex9pmN//Cr
         zyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6xg1feNOVDA2uzgZqtN+dwTl9itDY0zxl+/OrGwsoGA=;
        b=aZ6RVJT9QpQJx+jWvyyS3JPXBFiMHyfXhp9fWoGA+0+wA+ZRwc5FjKEB6dIrsiEEEp
         ft3mkcPLn3K9GoBgwTHzbzXYhozppi/BJc1FnEIGNsJ3DyeVwAIufVB9nJ4PShJjmn5W
         OuT8ravNhvrqM4axxkfzDk1PDNK1wOdxl+ytQlLNMzhLDcKXN1gdMCW41V+gFNs+XbPi
         ufSO1vRE9jfGevQ+Z3+yXdpDV3vwETkC1WsL+npmAMeVwdWAVLo4zUL+sC5FB2mBSnQk
         fIQC4+NKEKOGF9DVo3VKqv0x76QkYtIwl6TAuQ2CGNBu73RrGi9Im2fK/CpYnt9k08t3
         +gkA==
X-Gm-Message-State: AOAM5313gRQ++IM/43ZW2qLyfvt2WjY6UzH/MkgyI7gblTUwh642tMAg
        u8VfJYplb2J0hFsbi/9V+qaWgg==
X-Google-Smtp-Source: ABdhPJyozNADNelIXWk4aIxJrZ00bV4n44TgQc6xm0EfJzmxBrES3TTBOjnuLI3cQYBS2SAslX3K0A==
X-Received: by 2002:a50:dacf:: with SMTP id s15mr57037750edj.136.1594026568402;
        Mon, 06 Jul 2020 02:09:28 -0700 (PDT)
Received: from ?IPv6:2001:16b8:485d:8000:587:bfc1:3ea4:c2f6? ([2001:16b8:485d:8000:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id e8sm15925473eja.101.2020.07.06.02.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 02:09:27 -0700 (PDT)
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com, houtao1@huawei.com
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <20200702120628.777303-2-yuyufen@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <84277307-fc0a-44e2-8564-699651a7ff47@cloud.ionos.com>
Date:   Mon, 6 Jul 2020 11:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702120628.777303-2-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/2/20 2:06 PM, Yufen Yu wrote:
> @@ -2509,10 +2532,11 @@ static void raid5_end_read_request(struct bio * bi)
>   			 */
>   			pr_info_ratelimited(
>   				"md/raid:%s: read error corrected (%lu sectors at %llu on %s)\n",
> -				mdname(conf->mddev), STRIPE_SECTORS,
> +				mdname(conf->mddev),
> +				conf->stripe_sectors,

The conf->stripe_sectors is printed with %lu format.

> ot allow a suitable chunk size */
>   		return ERR_PTR(-EINVAL);
>   
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index f90e0704bed9..e36cf71e8465 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -472,32 +472,12 @@ struct disk_info {
>    */
>   
>   #define NR_STRIPES		256
> -#define STRIPE_SIZE		PAGE_SIZE
> -#define STRIPE_SHIFT		(PAGE_SHIFT - 9)
> -#define STRIPE_SECTORS		(STRIPE_SIZE>>9)
>   #define	IO_THRESHOLD		1
>   #define BYPASS_THRESHOLD	1
>   #define NR_HASH			(PAGE_SIZE / sizeof(struct hlist_head))
>   #define HASH_MASK		(NR_HASH - 1)
>   #define MAX_STRIPE_BATCH	8
>   

[...]

> 	return NULL;
> -}
> -
>   /* NOTE NR_STRIPE_HASH_LOCKS must remain below 64.
>    * This is because we sometimes take all the spinlocks
>    * and creating that much locking depth can cause
> @@ -574,6 +554,9 @@ struct r5conf {
>   	int			raid_disks;
>   	int			max_nr_stripes;
>   	int			min_nr_stripes;
> +	unsigned int	stripe_size;
> +	unsigned int	stripe_shift;
> +	unsigned int	stripe_sectors;

So you need to define it with "unsigned long".

Also, I am wondering if it is cleaner with something like below.

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8dea4398b191..984eea97e77c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6918,6 +6918,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
         conf = kzalloc(sizeof(struct r5conf), GFP_KERNEL);
         if (conf == NULL)
                 goto abort;
+       r5conf_set_size(conf, PAGE_SIZE);
         INIT_LIST_HEAD(&conf->free_list);
         INIT_LIST_HEAD(&conf->pending_list);
         conf->pending_data = kcalloc(PENDING_IO_MAX,
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index f90e0704bed9..04fc4c514d54 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -471,10 +471,13 @@ struct disk_info {
   * Stripe cache
   */

+static unsigned long stripe_size = PAGE_SIZE;
+static unsigned long stripe_shift = PAGE_SHIFT - 9;
+static unsigned long stripe_sectors = PAGE_SIZE>>9;
  #define NR_STRIPES             256
-#define STRIPE_SIZE            PAGE_SIZE
-#define STRIPE_SHIFT           (PAGE_SHIFT - 9)
-#define STRIPE_SECTORS         (STRIPE_SIZE>>9)
+#define STRIPE_SIZE            stripe_size
+#define STRIPE_SHIFT           stripe_shift
+#define STRIPE_SECTORS         stripe_sectors
  #define        IO_THRESHOLD            1
  #define BYPASS_THRESHOLD       1
  #define NR_HASH                        (PAGE_SIZE / sizeof(struct 
hlist_head))
@@ -574,6 +577,9 @@ struct r5conf {
         int                     raid_disks;
         int                     max_nr_stripes;
         int                     min_nr_stripes;
+       unsigned long           stripe_size;
+       unsigned long           stripe_shift;
+       unsigned long           stripe_sectors;

         /* reshape_progress is the leading edge of a 'reshape'
          * It has value MaxSector when no reshape is happening
@@ -690,6 +696,12 @@ struct r5conf {
         struct r5pending_data   *next_pending_data;
  };

+static inline void r5conf_set_size(struct r5conf *conf, unsigned long size)
+{
+       stripe_size = conf->stripe_size = size;
+       stripe_shift = conf->stripe_shift = ilog2(size) - 9;
+       stripe_sectors = conf->stripe_sectors = size >> 9;
+}

  /*
   * Our supported algorithms

Thanks,
Guoqing
