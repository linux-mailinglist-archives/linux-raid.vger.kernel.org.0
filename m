Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A359184A36
	for <lists+linux-raid@lfdr.de>; Fri, 13 Mar 2020 16:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCMPHc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Mar 2020 11:07:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39676 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgCMPHc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Mar 2020 11:07:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id df19so6076669edb.6
        for <linux-raid@vger.kernel.org>; Fri, 13 Mar 2020 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lu4KWW1BxSgLh7mcOu8OPZNeZ294z5ch0S7N0Dph7Uw=;
        b=MWxdMu9cBbp/w7FMP9nzHw+RgvI0cySztA+lEaJsg+/FUtZ/9fcXYLx8aACN2RETmq
         5NYlf8cUk28dBNIF72lqx7QmnJUpeI6ARSUjzIj8HdooUgI7ZfgAfyXRUZuL8HHV15Yd
         BQ6hQqzYO93/31oRg/RWEHMSrhqu4fZoA/WIVfL2dmdbL70ZzYQKHAbi+f9lN/lxLmnE
         QOgrYKvju2pOa82CmWZPnUqjo5djzUG98VHxfEC1azWTUAFw0cf0rxSdCPgQAkdYisKq
         G6k/SBNGiEt9uUEBg2BqCqqT7LxoVrEZUqiKmfJqxD3wMbSyYNG75dG/M/4POy8IScJw
         nwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lu4KWW1BxSgLh7mcOu8OPZNeZ294z5ch0S7N0Dph7Uw=;
        b=XB4BpGOXdof1JuyxxV0RsGBYYsQAqERwKd3xEbg7mKn8S3zZ5Oba+aRIzBJyXJKtqm
         YM/zb4NLB2uAcsWRfGJ+8yQUqEDgzXtA4hUUbV1MWICJi84z7aHHgU4zrMSgmpHcnFbx
         rSRYkuOUFGquCyRpaHR16wWu6OWZGfw16+rR2bJR4V01jhn2dx9D4YKRj/uWg95uU2SR
         AVf/EeIdIYJp6K7iB+mS5CYSqoj1F+8edf5C+ZP+qUbRz9NgR+t4m0M2z1NQt86jg7Xy
         WhA4Ks1REavpawQr8zUB1pYJLsj5cANPNQEgT8eNVM71YlFxBktIknxsLWXx62mnhzWI
         JBqA==
X-Gm-Message-State: ANhLgQ1sbK27/X6lxsLV7s/pmPXifjQwiUYhYArND4t7vuyOskwmuwsg
        1BHVrXcIMDybsmkpyiXQMPcz6+5QOOk=
X-Google-Smtp-Source: ADFU+vuAmV0d/x/33R3mYMVRQxCFNdsT07bEdqmukBq+a2PWOXGs8SOzhJygkeYRO2g7X8AfO8OpLg==
X-Received: by 2002:a17:906:f75b:: with SMTP id jp27mr11948943ejb.229.1584112050034;
        Fri, 13 Mar 2020 08:07:30 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48b9:5d00:55b0:6e1e:26ab:27a5? ([2001:16b8:48b9:5d00:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id y4sm3228875ejm.77.2020.03.13.08.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 08:07:29 -0700 (PDT)
Subject: Re: [PATCH] Detail: show correct bitmap info for cluster raid device
To:     Lidong Zhong <lidong.zhong@suse.com>, jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
References: <20200313090504.13058-1-lidong.zhong@suse.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <80a59a8e-c23e-4343-d930-4ac71399a50c@cloud.ionos.com>
Date:   Fri, 13 Mar 2020 16:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313090504.13058-1-lidong.zhong@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Lidong,

On 3/13/20 10:05 AM, Lidong Zhong wrote:
> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
> ---
>   Detail.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Detail.c b/Detail.c
> index 832485f..39fce29 100644
> --- a/Detail.c
> +++ b/Detail.c
> @@ -468,7 +468,9 @@ int Detail(char *dev, struct context *c)
>   		if (ioctl(fd, GET_BITMAP_FILE, &bmf) == 0 && bmf.pathname[0]) {
>   			printf("     Intent Bitmap : %s\n", bmf.pathname);
>   			printf("\n");
> -		} else if (array.state & (1<<MD_SB_BITMAP_PRESENT))
> +		} else if (array.state & (1<<MD_SB_CLUSTERED))
> +			printf("     Intent Bitmap : Clustered\n\n");

Better to use "Internal (Clustered)" since it is a special internal bitmap.
Anyway, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Cheers,
Guoqing
