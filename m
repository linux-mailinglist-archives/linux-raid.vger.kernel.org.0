Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7F1ABB95
	for <lists+linux-raid@lfdr.de>; Thu, 16 Apr 2020 10:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502865AbgDPIqA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Apr 2020 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502829AbgDPIps (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Apr 2020 04:45:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45BFC061A0C
        for <linux-raid@vger.kernel.org>; Thu, 16 Apr 2020 01:45:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t14so3782541wrw.12
        for <linux-raid@vger.kernel.org>; Thu, 16 Apr 2020 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nWaT5yW2P16B41lPSVuhr81H7f8qbfdX5Dr3oLLHnPQ=;
        b=MQHtCESyxfnFNbar8AfiskcVcahpd9X8gMIucl9MHas+Xws0GXHbWtlUDfoPfqkZUS
         njPJoyVz/SJVhSjLVjaNvY2UYHIN8ZHtj6CA3NNgX2ZptAsEjRUY/2y9MqPMjGMxcTvN
         DYTubngZkakGJfk/EdlJ4Asd7MbZsEHbLn+VBS+h6RsTBBtIKCgruyIPeyuwiOqNEYP2
         3MEr7b+Q0KhBAvyuhatBQQCtBPR60ncdwUDoGuOq7ZOPU/otfiQbh/AtReMqgxIZJzjk
         N50Sq6yY7KL5o2XtrFM5ySyD7+KSGyZyPIoCAkyc9Im+GekQo5l6ax/SHPqY8oF65hVJ
         QCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nWaT5yW2P16B41lPSVuhr81H7f8qbfdX5Dr3oLLHnPQ=;
        b=ZGNk7gAbiLOk8MYXGKjE6i5ibh0wZoIDSuFUqwOw5+Nqn2MdgTzY81yr7e2lLKxmEg
         nk9NlRHC5KbKMix6P+ZU8ISItkTuKi6TmWRUmcOLJcRYWRuaTlHtCQ9WJ+lCqXhpEGvJ
         b2oibSt/p4eW0pZwoSASKeQZcOsfwqfGrZk6RbGIRC6Yj9Uy73CiLQaywH54vC/rGQbq
         VJFu/bFSnLaGPUdhs3Z7H21JV/cntb9d/9TLAfYEo8ArHPLsHkoVK4vH7xsWJdGZb59R
         Ar3nH3LJbPZpWFjLl57ENcSWZhTYlv7UXIzEK5FnXop/uLYJ7rPRjOlwJTt4JI8qQa95
         q+6A==
X-Gm-Message-State: AGi0Puam9ibVIzqTgI/6CdVtihKjigBiwc2zp+2+SsrmUEtK6HzqyDaW
        KiAXMa8SnnmQVj1zo92KyzR6cegZEKs=
X-Google-Smtp-Source: APiQypI1ZDaVZK9446aW0vLNauPbfnbaGbe2NIte6vuwaPx1OqPaczfFuRY4UPUsSgVSiws5ZGPdAQ==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr27043818wrw.351.1587026740173;
        Thu, 16 Apr 2020 01:45:40 -0700 (PDT)
Received: from ?IPv6:2001:16b8:489a:be00:34d4:fc5b:d862:dbd2? ([2001:16b8:489a:be00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id t20sm2907155wmi.2.2020.04.16.01.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 01:45:39 -0700 (PDT)
Subject: Re: [PATCH] Assemble: print error message if mdadm fails assembling
 with --uuid option
To:     jes@trained-monkey.org
References: <20190416160817.10526-1-gi-oh.kim@cloud.ionos.com>
 <CA+res+ThMMp0HDfECEwbt-L+F0MD77hKe0TvN+AwPF1c9REYDg@mail.gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <261f11dd-9532-75dd-b068-87d04de5feb6@cloud.ionos.com>
Date:   Thu, 16 Apr 2020 10:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+res+ThMMp0HDfECEwbt-L+F0MD77hKe0TvN+AwPF1c9REYDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,

Could you consider to merge this one before release 4.2?

Thanks,
Guoqing

> Subject: [PATCH] Assemble: print error message if mdadm fails
> assembling with --uuid option
> To: <linux-raid@vger.kernel.org>
> Cc: <neilb@suse.com>, <jsorensen@fb.com>,
> <jinpu.wang@cloud.ionos.com>, Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
>
> When mdadm tries to assemble one working device and one zeroed-out device,
> it failed but print successful message because there is --uuid option.
>
> Following script always reproduce it.
>
> dd if=/dev/zero of=/dev/ram0 oflag=direct
> dd if=/dev/zero of=/dev/ram1 oflag=direct
> ./mdadm -C /dev/md111 -e 1.2 --uuid="12345678:12345678:12345678:12345678" \
>      -l1 -n2 /dev/ram0 /dev/ram1
> ./mdadm -S /dev/md111
> dd if=/dev/zero of=/dev/ram1 oflag=direct
> ./mdadm -A /dev/md111 --uuid="12345678:12345678:12345678:12345678" \
>      /dev/ram0 /dev/ram1
>
> Following is message from mdadm.
>
> mdadm: No super block found on /dev/ram1 (Expected magic a92b4efc, got 00000000)
> mdadm: no RAID superblock on /dev/ram1
> mdadm: /dev/md111 assembled from 1 drive - need all 2 to start it (use
> --run to insist).
>
> The mdadm say that it assembled but mdadm does not create /dev/md111.
> The message is wrong.
>
> After applying this patch, mdadm reports error correctly as following.
>
> mdadm: No super block found on /dev/ram1 (Expected magic a92b4efc, got 00000000)
> mdadm: no RAID superblock on /dev/ram1
> mdadm: /dev/ram1 has no superblock - assembly aborted
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> ---
>   Assemble.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Assemble.c b/Assemble.c
> index 420c7b3..c1542f9 100644
> --- a/Assemble.c
> +++ b/Assemble.c
> @@ -269,7 +269,7 @@ static int select_devices(struct mddev_dev *devlist,
>                          if (auto_assem || !inargv)
>                                  /* Ignore unrecognised devices during
> auto-assembly */
>                                  goto loop;
> -                       if (ident->uuid_set || ident->name[0] ||
> +                       if (ident->name[0] ||
>                              ident->super_minor != UnSet)
>                                  /* Ignore unrecognised device if looking for
>                                   * specific array */
> --
> 2.19.1

