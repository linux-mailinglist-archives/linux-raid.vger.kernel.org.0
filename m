Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5B22D1AA
	for <lists+linux-raid@lfdr.de>; Sat, 25 Jul 2020 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXWPf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Jul 2020 18:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXWPf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Jul 2020 18:15:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27870C0619D3
        for <linux-raid@vger.kernel.org>; Fri, 24 Jul 2020 15:15:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mn17so6161335pjb.4
        for <linux-raid@vger.kernel.org>; Fri, 24 Jul 2020 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ggWHsBsOaJQ/c1sQiDUUlG00QesYETHltnnPxlhsj+k=;
        b=Ht6e3p5RuvRPvCeTpOEDVcQLEhvyZ14F7hcUbxb8ljvRX60Dx9KwSzkYFUqQGkgm5S
         i57csLQTu8LoiMcpdQgPG8eBDy+splQFYrDxeXCJ4tP61CDmyjxK+Nip2uX4IqnWF93i
         2wOTprKXRXzEjUSgEL5lQIqDCWHC5o1RyTHcFeh/eIVCSDWCqXfr9DtdiUiH3xs4Vw0+
         0K3afxnnN4rRIGE6tNcYLUDSoReUv6lXve/hheqaiH56YmKTM3XGaydrPP8haiho8b2c
         79nphIGfXeMq1ithNfJdFY9iRLBtNb+DUZssPyLA+QjMQcJaVlaUkEbnSjZqCT1sZXJY
         WiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ggWHsBsOaJQ/c1sQiDUUlG00QesYETHltnnPxlhsj+k=;
        b=k8mYjrw67rMeZc4KAdfzRcERLu8A5nPd1sWUfz5asj7nFqOUEdvM4XZhTDg7SWUJF1
         G+xG3lzSDL07JXO1aRPGw/s/zj8p0OTVpUeZLG81xq8yj7n6JOagzWNskXE0dBbsrcxv
         Vbt6bLJOtwILGKl1axjd7MTGRoGeeRNG+cWFMclx8hjVEgkFWIr5yxIwKWbGQm/KLv47
         acRljwqiHjs21Y5Y2V3xgJzOe/klag4JEwdd1nIY9KZfnZUzo7C+UQLSF1qoBpMRoFGX
         ipPjW9acTGAKNq3MRV7iU6fYRwOdysWMXs8SXErFKxrnkn2PObdKGJCcRU+HW1rzSZjd
         x/Yw==
X-Gm-Message-State: AOAM531PFBYVj8z0UcAauCLkZpIacUsneL/UWpn/0aWSXvEcIoRzhMv2
        1Amcl8sR8jaX2EuIy42WVhkMpA==
X-Google-Smtp-Source: ABdhPJwq+mdcNcAOqUgjDquLtGJo/2bQP4VdnprpHimLLiYUqo2uOvEHi2Fws+AjNmrt5mf6rxm8XQ==
X-Received: by 2002:a17:902:9a96:: with SMTP id w22mr10082851plp.172.1595628934211;
        Fri, 24 Jul 2020 15:15:34 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y27sm7656579pgc.56.2020.07.24.15.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 15:15:33 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200724
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>
References: <2C49144E-E8FF-4ECE-8897-F478AA1ED490@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b05708cf-aee0-7b46-6948-07085481a8e9@kernel.dk>
Date:   Fri, 24 Jul 2020 16:15:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2C49144E-E8FF-4ECE-8897-F478AA1ED490@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/24/20 4:12 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following changes for md-next on top of your 
> for-5.9/drivers branch. 

Pulled, thanks Song.

-- 
Jens Axboe

