Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E98ADBCE
	for <lists+linux-raid@lfdr.de>; Mon,  9 Sep 2019 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfIIPJl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Sep 2019 11:09:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39095 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfIIPJl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Sep 2019 11:09:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id u6so13283696edq.6
        for <linux-raid@vger.kernel.org>; Mon, 09 Sep 2019 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPpg6MjOWY9aVuNUog2AYNFYHrh5+gfBMEDTJ9VI9vQ=;
        b=LtHy0hazvXAi8UmGM/9HIO2YlUjb42XCGeWQaweTJFAzQG9R/TORfyl0w6JKigsd0Z
         Ci5BeyrtXVrG61QXj9GZ1mso8RxDTP5zzAI67SXCexs8/1+BwhlDyDiqdun+zw+Wi0rH
         sfQ9x3E/kI/0Ib6emw13zX3I0nUmqIj8tUbstW7CsY7Q7sJdK21J3n3kSJej+ZJfWdAx
         vLLkY1yhcLrFJvLDXmHa+rw7LHlKCEUhA+gYAfSf+ei75BESzvw0aRdTigvVvrXqaL/E
         vmKzSnnUXQltTJJAILBrfZyIbm04fsLi1MFg1znQBoMBdqaFjevv/bE36PvJfHVko7Qg
         NKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPpg6MjOWY9aVuNUog2AYNFYHrh5+gfBMEDTJ9VI9vQ=;
        b=KECxo2Lq7SThOuiRWlTU69liBSdHJ5mSBqDpNN56jQiQLzD2EkrcUz8h1nnBd0ga8s
         K17PB/iZrI3Fz+V5oalAuQqMj/0J2UjixJ5GjQLK19oJxk3hBuDTAZrMJxOwQh9J2dSV
         ADcq3D9ubnLgocGV/Ji0VSzkSMe/eyAcYwkD+T92PrD9QvMJGastBYUrwUoA8Sr0RXxr
         1GRmkbRBfoWAbJH7HoyfWsoyvgsAvPdlsO9gdOxpAb2JVw5zIgAyxJTWEPDDeIFAtkzP
         zsas7X8u+AHRQfk/ofK/jGR2SygFMzEMyF8fUmMIW8y9kAVd4uxBtnVmExmURc5W1rQm
         TqLg==
X-Gm-Message-State: APjAAAXRBAENVgNj7Yj3HuLFcQifgS3sc/FlxpA8OVRMVotZgbyWxEG0
        MF3nCPfO0IYUJ0P2cCxwmOhizF1zbjg=
X-Google-Smtp-Source: APXvYqzHQ4I8rSAZoY6DzyOkNkX7YAbwFZuZg4HI54kLmOyjRNhpfwXaYgzkKqBBG/qX8zQSNP4rRw==
X-Received: by 2002:aa7:c0da:: with SMTP id j26mr25052509edp.40.1568041779340;
        Mon, 09 Sep 2019 08:09:39 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:d8:76cc:10d1:1b4d? ([2001:1438:4010:2540:d8:76cc:10d1:1b4d])
        by smtp.gmail.com with ESMTPSA id r5sm2883021edd.56.2019.09.09.08.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 08:09:38 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
To:     NeilBrown <neilb@suse.de>, Coly Li <colyli@suse.de>,
        Song Liu <songliubraving@fb.com>
Cc:     NeilBrown <neilb@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
 <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
 <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com>
 <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
 <87pnkaardl.fsf@notabene.neil.brown.name>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <02a0d884-0a7a-63ed-2987-f5d07b93491b@cloud.ionos.com>
Date:   Mon, 9 Sep 2019 17:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87pnkaardl.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 9/9/19 8:57 AM, NeilBrown wrote:
> 
> If the drives in a RAID0 are not all the same size, the array is
> divided into zones.
> The first zone covers all drives, to the size of the smallest.
> The second zone covers all drives larger than the smallest, up to
> the size of the second smallest - etc.
> 
> A change in Linux 3.14 unintentionally changed the layout for the
> second and subsequent zones.  All the correct data is still stored, but
> each chunk may be assigned to a different device than in pre-3.14 kernels.
> This can lead to data corruption.
> 
> It is not possible to determine what layout to use - it depends which
> kernel the data was written by.
> So we add a module parameter to allow the old (0) or new (1) layout to be
> specified, and refused to assemble an affected array if that parameter is
> not set.
> 
> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
> cc: stable@vger.kernel.org (3.14+)
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> This and the next patch are my proposal for how to address
> this problem.  I haven't actually tested .....
> 
> NeilBrown
> 
>   drivers/md/raid0.c | 28 +++++++++++++++++++++++++++-
>   drivers/md/raid0.h | 14 ++++++++++++++
>   2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index bf5cf184a260..a8888c12308a 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -19,6 +19,9 @@
>   #include "raid0.h"
>   #include "raid5.h"
>   
> +static int default_layout = -1;
> +module_param(default_layout, int, 0644);
> +
>   #define UNSUPPORTED_MDDEV_FLAGS		\
>   	((1L << MD_HAS_JOURNAL) |	\
>   	 (1L << MD_JOURNAL_CLEAN) |	\
> @@ -139,6 +142,19 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
>   	}
>   	pr_debug("md/raid0:%s: FINAL %d zones\n",
>   		 mdname(mddev), conf->nr_strip_zones);
> +
> +	if (conf->nr_strip_zones == 1) {
> +		conf->layout = RAID0_ORIG_LAYOUT;
> +	} else if (default_layout == RAID0_ORIG_LAYOUT ||
> +		   default_layout == RAID0_ALT_MULTIZONE_LAYOUT) {
> +		conf->layout = default_layout;
> +	} else {
> +		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
> +		       mdname(mddev));
> +		pr_err("md/raid0: please set raid.default_layout to 0 or 1\n");

Maybe "1 or 2" to align with the definition of below r0layout?

[snip]

> +enum r0layout {
> +	RAID0_ORIG_LAYOUT = 1,
> +	RAID0_ALT_MULTIZONE_LAYOUT = 2,
> +};
>   struct r0conf {
>   	struct strip_zone	*strip_zone;
>   	struct md_rdev		**devlist; /* lists of rdevs, pointed to
>   					    * by strip_zone->dev */
>   	int			nr_strip_zones;
> +	enum r0layout		layout;
>   };
>   
>   #endif
> 

Thanks,
Guoqing
