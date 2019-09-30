Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0FC284C
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfI3VKB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 17:10:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39466 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfI3VKB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 17:10:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id e1so2529937pgj.6
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMH0jK0yIIKx0N3r7ETJxQDpyXbQRUcPFE0jOwWnjz0=;
        b=d13p5ninDNv6+HSYvbQnwVskgtsO4TslGUtRAAaKa7bOLUfMJiBG9fTklZyO/iyJHP
         6kYmyjG7F4WOdQTvZ/XPeFPFcCw7pDKhMHtNPEmWVOy12EsxoXOYdH+Hhi30cNZ+isaM
         6Ui0Q6ZuluBtQLdQShI8o3nBqg/aS3gSY3mRnM6oQ/NyLHr9gvZ3dlNCHZe8xkKgihCs
         gDFI3X/7bNtevNox8ybf7FepxdTG1LrBNFiKKYpUgczCTusck9XikBvXk2BFLyTbWVin
         uzDXUIlv4asx5N2zcfWsWGx6FCZ6GT7xEwssNGa+kSqKpcXC64WDnBpy4fNkK/E2llxh
         46mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMH0jK0yIIKx0N3r7ETJxQDpyXbQRUcPFE0jOwWnjz0=;
        b=fV4CtfBnnmJ/QJOuUJiEo9mIadNpwi4VtJiw4SqkgJ2LjezH/p6kjLfbTVL2WzmMF1
         AjpnaZvjVhQ9weFU8KM6CDW+l9JNZcZyV/12VNY/98Z+p13DVk4dVgeADqXhp6hNM8bg
         ZUKG6+yuoHD7IS9dnBzyAXDnUrTKGAgoIWFFDEOC/ub7024hOJKy0kCjo8zA8OLeMWzP
         ByURXWwx+HEJWGdms+6/bqgViBesD/4j0TMFyhORPf5nE+dXjbxhFCgHBIMKXHh/AmQP
         UJmirqcSKiuBbqwQ9/p8NQgKfJoTzCLgKfZXI35MI2L8ANdz+LJnRrZBIXGD/WBXTviY
         KhgA==
X-Gm-Message-State: APjAAAXsphZ1UuNg6Soq2PPQOkuqYlKpOSMWCdiuUWHl2GcIpqyZdIk7
        rfRMQmZqj16efkzyYo9fngkzxcFSx7g=
X-Google-Smtp-Source: APXvYqy7IKtA5vy1ni4a7V89nfBlTzY/NlNgKu+II3SC4tgdRFWrws8Bfubr846p7O5LOMvvtto9YQ==
X-Received: by 2002:a17:90a:850c:: with SMTP id l12mr988210pjn.9.1569871954938;
        Mon, 30 Sep 2019 12:32:34 -0700 (PDT)
Received: from [172.19.249.239] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id u194sm4085291pgc.30.2019.09.30.12.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:32:34 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [RFC PATCH V3] mdadm/md.4: add the descriptions for bitmap sysfs
 nodes
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
References: <20190531021000.16971-1-gqjiang@suse.com>
Message-ID: <40446e46-2c64-f70b-7f2b-2a2ec2245dd1@gmail.com>
Date:   Mon, 30 Sep 2019 15:32:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190531021000.16971-1-gqjiang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/30/19 10:10 PM, Guoqing Jiang wrote:
> The sysfs nodes under bitmap are not recorded in md.4,
> add them based on md.rst and kernel source code.
> 
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
> ---
> V3 changes:
> 1. update the valid value range for backlog
> 
> V2 changes:
> 1. use the description for can_clear node from Neil
> 2. tweak descriptions for backlog, chunksize, location and metadata
> 
>   md.4 | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)

I completely missed this one, not sure why. I have applied it since I 
see Neil and Wol already provided feedback.

The part about "this can only be done calling ioctl xyz" should be an 
invitation to someone looking to get a patch upstream to add a sysfs 
hook for this :)

Cheers,
Jes
