Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8369CE3F4B
	for <lists+linux-raid@lfdr.de>; Fri, 25 Oct 2019 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbfJXWT6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 18:19:58 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:45073 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfJXWT4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 24 Oct 2019 18:19:56 -0400
Received: by mail-pf1-f177.google.com with SMTP id x28so148568pfi.12
        for <linux-raid@vger.kernel.org>; Thu, 24 Oct 2019 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mY4UWCCDVK1Iki6WSKhVVS0oGhySWYH0lrGJCw4y6F0=;
        b=SqUyxLF5Z7IvM6PSpRG/uq36y5+1z9Hl8NrND863JSddHCUeRWkLJpCMF5hywS20WY
         YaVeXaUIfKTwyNSi0vcon2KLBAUD4j86WXdzxF65/M9gAwbqJmxZ58zn8k8y/LvDhOMQ
         m81RM/cbeDHnyVFfgGR0Gp4sJHN2O/fny0Sic6p8gRL20OC59bkC3LADb7oFnyMVFA9n
         IKyP/hIGF43ok9ntBl3vw0tJdU+uHfVGbSLV6mMhU8RZ8Y3n2R74qGipF2O8yodbcP6r
         IpVgBYn02Sx9KJDjNhuc0EW7LC1AaX/sF754bJazlkxLFCsfx5e59gvzxjIq1EO/khHL
         BICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mY4UWCCDVK1Iki6WSKhVVS0oGhySWYH0lrGJCw4y6F0=;
        b=O4AeZ8odA4SoT6W4BXRRAUtS5aoEssZz8ZTufLtAwdGxmdXrj/03Xs/jvPAJIcfKnK
         PrZfodI7S1FyeSor6eRoBXx3DsgVY84qAyJLBm/LTloM7q8OqFBlsm/0zdG8rls3aAxh
         IOJlLd2zE2/XUMorYjHv4Snu/FgyQfFZGN1ITsdCyHdYPoJfktY//euckHevrqlxlGmo
         5q5ZuOoiRvIZjsd1dZ6f/QSD2kKyXLyRIBCb/NG0uhurM95Mvh2fzutrpufFQkvcw2gD
         cfQxFyxH22Az8PlhYTKcQxJFmazi3DvqN/Hb7M62LZw5BR+Qc6T+AYyPWLYTCVfDzYrC
         3RRA==
X-Gm-Message-State: APjAAAVc57wQgGSwsZ3XiPYYFOAfXoi195prvEnLM6TF4Ec8q1GSXh45
        /elHNMuoz+dx7ZvEh04qWCB/Dw==
X-Google-Smtp-Source: APXvYqxX/2m3FqHNhPcp2dlkZUtwqDniTKLISGlh0xfWQ5SepFdh3vbzDHNZE14KhkZxQblUy8Idqw==
X-Received: by 2002:aa7:8583:: with SMTP id w3mr280631pfn.129.1571955595243;
        Thu, 24 Oct 2019 15:19:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r30sm28742992pfl.42.2019.10.24.15.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 15:19:54 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20191024
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Jeffery <djeffery@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Yufen Yu <yuyufen@huawei.com>, Xiao Ni <xni@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
References: <ED0B162E-09AC-420D-9620-849EAB38C195@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d452324f-ce01-2220-0ea2-19f23e46dba2@kernel.dk>
Date:   Thu, 24 Oct 2019 16:19:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ED0B162E-09AC-420D-9620-849EAB38C195@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/24/19 1:50 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md-next on top of your
> for-5.5/block branch.

Would you mind rebasing this on top of for-5.5/drivers? Linus wanted me
to have stronger separation between the two, so...

-- 
Jens Axboe

