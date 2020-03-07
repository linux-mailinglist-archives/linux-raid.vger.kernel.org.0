Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5AA17CF59
	for <lists+linux-raid@lfdr.de>; Sat,  7 Mar 2020 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGQ46 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 7 Mar 2020 11:56:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40193 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGQ46 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 7 Mar 2020 11:56:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id p2so5156256wrw.7
        for <linux-raid@vger.kernel.org>; Sat, 07 Mar 2020 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j/eNqKwhHIIQxyzQvjCBRKA/rz5BXmt8QzI5N2KcAyE=;
        b=M7Cabhi+C+sIpuemf28MbXXLNQQt6NbJVkZbir6+EmaAw170/yqkp5RBtxHXAcsEWq
         lJfTZvRUFfijL3EOAUMaLrv4Gt19W2puTrjK/I0BD8Wwf2MDtmhRqtfIcwo5LTwhd88x
         XHxp5xli+JXvBHcrh7Dd7dtTa8on7kl8u9Oajh3LV+idPcvFzuuAcN0Qv/USBUeRFzta
         6T3D/83Tb5GBt2np7v8fPxHbCDJvnZRGWnOp0RDMwu8FHzB24bhxCsjaGb5f5A+BI9+Y
         2ztjJhxfr/JmJn7OoO+a1pyWPjmGa1whu2trQYEVkJarIDrbMbjsnXpM95bwI1L85bGB
         aUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j/eNqKwhHIIQxyzQvjCBRKA/rz5BXmt8QzI5N2KcAyE=;
        b=q1AYf8zNb+5UbcDqi16w4SyBaTdJPz7ut8/2dh/lhEFmfJ85PVCHQDNJA/cVXVkIPV
         GqyL4s4NfaL2Rl5bURT/D/zygkxASlGthepQBLQgWgaIpHG3h7L/flWw6gnUIIEUX5PL
         G2e++QZtSK20qxsq5tvKCM8dZzsZv9ljQf3BfpCPXxsBTfH5KemZEx3x3rg9s6BaN7R6
         /2PA2f4fM3So5aru3nkCNR48KeGj8Y9h+GA/gUJlsGNLn1FClaeSOXohoESWCoVK+WDZ
         UhwTSvriw6l2HoP2MR7/iR/yYILD0h3LzEyOofSxbovwYDvHPGL4eq49EpaZ+co3O9m0
         hQAw==
X-Gm-Message-State: ANhLgQ0khlIY0Als03eFlAZxffm66/TXEeoS/JM4xwTREp2sy9dB0sZS
        l9J2UD3gn00fYpV1uFUFHW3W+ycOaMAtLg==
X-Google-Smtp-Source: ADFU+vvazcc7RsIlz+x8htr4ZdFCR8p6thi/Q6Zi+k7ggaR8MmLfoxn8/47G8UKRdnrAPQ/GS2yFWQ==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr10872219wrr.66.1583600216169;
        Sat, 07 Mar 2020 08:56:56 -0800 (PST)
Received: from ?IPv6:2001:16b8:48da:7800:6c10:d25c:c338:a50f? ([2001:16b8:48da:7800:6c10:d25c:c338:a50f])
        by smtp.gmail.com with ESMTPSA id j14sm53988834wrn.32.2020.03.07.08.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 08:56:55 -0800 (PST)
Subject: Re: [PATCH] md: check arrays is suspended in mddev_detach before call
 quiesce operations
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20200211101004.2993-1-guoqing.jiang@gmx.us>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <3be8072d-cecc-d61c-6509-5094b1b24191@cloud.ionos.com>
Date:   Sat, 7 Mar 2020 17:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211101004.2993-1-guoqing.jiang@gmx.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Ping ...

On 2/11/20 11:10 AM, Guoqing Jiang wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Don't call quiesce(1) and quiesce(0) if array is already suspended,
> otherwise in level_store, the array is writable after mddev_detach
> in below part though the intention is to make array writable after
> resume.
> 
> 	mddev_suspend(mddev);
> 	mddev_detach(mddev);
> 	...
> 	mddev_resume(mddev);
> 
> And it also causes calltrace as follows in [1].
> 
> [48005.653834] WARNING: CPU: 1 PID: 45380 at kernel/kthread.c:510 kthread_=
> park+0x77/0x90
> [...]
> [48005.653976] CPU: 1 PID: 45380 Comm: mdadm Tainted: G           OE     5=
> .4.10-arch1-1 #1
> [48005.653979] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M=
> ./J4105-ITX, BIOS P1.40 08/06/2018
> [48005.653984] RIP: 0010:kthread_park+0x77/0x90
> [48005.654015] Call Trace:
> [48005.654039]  r5l_quiesce+0x3c/0x70 [raid456]
> [48005.654052]  raid5_quiesce+0x228/0x2e0 [raid456]
> [48005.654073]  mddev_detach+0x30/0x70 [md_mod]
> [48005.654090]  level_store+0x202/0x670 [md_mod]
> [48005.654099]  ? security_capable+0x40/0x60
> [48005.654114]  md_attr_store+0x7b/0xc0 [md_mod]
> [48005.654123]  kernfs_fop_write+0xce/0x1b0
> [48005.654132]  vfs_write+0xb6/0x1a0
> [48005.654138]  ksys_write+0x67/0xe0
> [48005.654146]  do_syscall_64+0x4e/0x140
> [48005.654155]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [48005.654161] RIP: 0033:0x7fa0c8737497
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D206161
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> =2D--
>   drivers/md/md.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index d3212d61e660..92c626b506d6 100644
> =2D-- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6076,7 +6076,7 @@ EXPORT_SYMBOL_GPL(md_stop_writes);
>   static void mddev_detach(struct mddev *mddev)
>   {
>   	md_bitmap_wait_behind_writes(mddev);
> -	if (mddev->pers && mddev->pers->quiesce) {
> +	if (mddev->pers && mddev->pers->quiesce && !mddev->suspended) {
>   		mddev->pers->quiesce(mddev, 1);
>   		mddev->pers->quiesce(mddev, 0);
>   	}
> =2D-
> 2.17.1
> 
