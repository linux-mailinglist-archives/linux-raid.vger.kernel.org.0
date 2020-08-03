Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5423A5A3
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 14:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgHCMjr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Aug 2020 08:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgHCMje (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 3 Aug 2020 08:39:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F85C06174A
        for <linux-raid@vger.kernel.org>; Mon,  3 Aug 2020 05:39:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bh1so7506349plb.12
        for <linux-raid@vger.kernel.org>; Mon, 03 Aug 2020 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwXNgi3ay3v6eJN/JWoNuzdOPBIzIzGDIyy3068bhsM=;
        b=cYN4uruF4hQy0vCRWmhOMeaa3xbkyO9sr57dCo/zGFYOZnBVwTD2Gi5G9yIO9CmWq4
         0dJWYNc7RcdDz5Lf6qN0OFSniSb5CGTpLOAJnJSB34Ca8C8ZK5OsHt3kBLKoLXu+F0RK
         PIjffm7pquJa48VsDaiU6t9jBq0hGflPv5q3McOjZckj3Od/8cEzEDZp+RUUB3xTDqiq
         9WH4NDmPqkSHmOwZ94LeXefZwSjAw8Da0TT4XaxkH5vh2PezxtQ4b/sVeOwZlKwkknLl
         v7/PZukE0lwKgGMk8K4cZqTM4dedMMOVOz2GhPMxEjIAZWuw8LMOLJD8egniczdVW7HC
         nOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwXNgi3ay3v6eJN/JWoNuzdOPBIzIzGDIyy3068bhsM=;
        b=U+sJ6P9KDJUmEecojRpYXvvt7Qsq42QHnIWFGFJHsMKoUXO3NRgyLykWUTuk+kBWyH
         7/hf6GJejInQLh7YVkG0XDWkY7RHIq2Zk1nR5bCPCFhNQXApdMrR8A8MXNveESWsXqbi
         0czB10F0Is+mPRAi+PpfvX9SigEQoYaFRFwTjhtAaDvl5SpP06NcVkiKNcPqz9Yvt0ug
         RWRt38zDlLvFAsJPVmbM4DJPTue4R4p+Ci/rmrQHviNsajIBaO2bwmjXw6xy04H6kLXV
         fGMPfA9kEbYQQacjdF73Ug65L1l2kbRIzopQo5wg1T96lWZEevpZEPVuye4KS0/uTx8x
         y/kA==
X-Gm-Message-State: AOAM530Y6SrYqTvtOGdJWb6604nwpH/SICPqogfhHp3t4wyM88WZCAwX
        sDiWMz+qPXnyiG7QH1AfhgNeT4oZXRI=
X-Google-Smtp-Source: ABdhPJwCG97mDJr8k37Frp21XY7CIUNpj7Mn7lpi0Jb3M2QPUkd5JPDNnkP9qnECRJTMmF1hLqMVRQ==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1mr4833681plb.118.1596458374262;
        Mon, 03 Aug 2020 05:39:34 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o2sm19391815pfh.160.2020.08.03.05.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 05:39:33 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200802
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Xiao Ni <xni@redhat.com>,
        ChangSyun Peng <allenpeng@synology.com>,
        Sebastian Parschauer <s.parschauer@gmx.de>
References: <1B094166-6B2F-4181-B389-8C5B564CD485@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c363cf1-a61d-aede-492a-cef2f0b28e6e@kernel.dk>
Date:   Mon, 3 Aug 2020 06:39:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1B094166-6B2F-4181-B389-8C5B564CD485@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/3/20 12:59 AM, Song Liu wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

Pulled, thanks.

-- 
Jens Axboe

