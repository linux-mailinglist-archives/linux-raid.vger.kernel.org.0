Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83D230537
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgG1IV7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgG1IV6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 04:21:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F48C061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 01:21:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gg18so16385241ejb.6
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eYtY6gQyPFqRw7iL7YytbJaQ8zUIJLXrqeqNfXr3B9c=;
        b=VnWSh033y/y/QJvCK+BSqb/RTtyNSuWL3VIYpbUWrM3VObMCAOuRIYUfd+wHgrHSQq
         Y6XSzdxGNuSp7ehLQOyGW/JW8Sp3mBTho2zpi9Lj0i8uOjUw2YcoJqkb5eflLGIReANV
         SJPycnZNym17eCClGHCIoPbyXEoLw2QrIWHl//4a5XUxi8AiCL5LnJTWbq9Rhi2ePPmY
         aGEsqBEdhwQRxEXs1Fh945LJJ3y+e+qlWNQth2ELOU81g7y7MNsWhQaYRR8FCO0cOvLi
         FkTJLbfIr4SiRX9TK6EPUoPk5+nSGMtZ80Em9Mcg/H8skn5/1HyPbf/vpFjJJXCIgFmK
         inTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eYtY6gQyPFqRw7iL7YytbJaQ8zUIJLXrqeqNfXr3B9c=;
        b=bKM/Q29eRXqyZ7wWGB6pMD/lW8ny7/lLMQ/AoSzf82dsYL5GKciNePlxIaoG5mL8ow
         VTaEvi1zgyICbxmBN9xaU59jY8j8IMy00ozlGc1xQLL4IEB9tb83EXKgWPcmM6yLo73/
         nN7nqWhH3iqSd0LLVVu+1VVELr2KNzrUeIv9VLsFCVsecNx14oxp2Nn+Q6Wg+rdHxhXN
         x14OW+aX9bL2rJZGiGZqpDzbzQf/oClGMs9w9RAaW2it2LmKHZO63JuMS3cNzKnGjMz3
         HybXuJLqJI0j41pH+G5Rj5iQeBf0dsJtA1qO4qZbBbIptNflc+lhaZnM1roF/nqjZrUk
         2aug==
X-Gm-Message-State: AOAM533GLfddvyFua6FJbPuWrCKggWdm+CXp006Ih9b1FUH4X4wubFOO
        biJXV1gLxFpJN8A58NMTvQ2X8pwXMSHP6A==
X-Google-Smtp-Source: ABdhPJyD6W3tJw3hy4DeKLN5v/64PqJqqPq9jb8ItVPTXIxmBlo0nm5rGxIlp4GHsrsXiGXNpkNyMQ==
X-Received: by 2002:a17:906:8417:: with SMTP id n23mr23931562ejx.192.1595924515905;
        Tue, 28 Jul 2020 01:21:55 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:34cb:1cd0:d3a5:9c35? ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id g6sm8680213ejz.19.2020.07.28.01.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 01:21:55 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] Move codes related with submitting discard bio
 into one function
To:     Xiao Ni <xni@redhat.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
References: <1595920703-6125-1-git-send-email-xni@redhat.com>
 <1595920703-6125-2-git-send-email-xni@redhat.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <407c8e78-93d0-5347-1056-192613fff708@cloud.ionos.com>
Date:   Tue, 28 Jul 2020 10:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595920703-6125-2-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Xiao,

Better to add a prefix before subject like "md" ...", the same to other 
patches.

On 7/28/20 9:18 AM, Xiao Ni wrote:
> These codes can be used in raid10. So we can move these codes into
> md.c. raid0 and raid10 can share these codes.
>
> Reviewed-by: Coly Li <colyli@suse.de>
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>   drivers/md/md.c    | 22 ++++++++++++++++++++++
>   drivers/md/md.h    |  3 +++
>   drivers/md/raid0.c | 15 ++-------------
>   3 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 07e5b67..2b8f654 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8559,6 +8559,28 @@ void md_write_end(struct mddev *mddev)
>   
>   EXPORT_SYMBOL(md_write_end);
>   

Could you add comment before the function to inform it is used by raid0 
and raid10?

> +void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
> +				struct bio *bio,
> +				sector_t dev_start, sector_t dev_end)

Thanks,
Guoqing
