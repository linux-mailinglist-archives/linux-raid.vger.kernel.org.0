Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2832211C46A
	for <lists+linux-raid@lfdr.de>; Thu, 12 Dec 2019 04:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLLDuX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 22:50:23 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:44130 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfLLDuX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Dec 2019 22:50:23 -0500
Received: by mail-pj1-f51.google.com with SMTP id w5so423655pjh.11
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 19:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IrZENYe21/WJhbxZbAQLOgLQcfcKitNnofQUePCFcPA=;
        b=jOOJpuydpGj9uOirubfB6JQznyRPD7piSSuEqPEuMYcvplAy8hVf4z5zP4bG02iwRs
         SWLXbnzrIMIQn2/sM+HlNZHMy/s5zEc6NvPLTuaLC91p7DimRUFk05RqPm+DzQ6yRg+I
         PWl/6Jyx3OI9KgeGksD11EtKN2zyp3RiKIss08Ft9XqdINu0cSGSVrQQ942kLVp57VzP
         /Ci9uF8/ytOj2vk1pLQWxPMAw8fCcWvau7NFhJtbPQ+4aKUU+m/64OFsalytKPH4i8ef
         7TvdDteiOIc4l2DBCAE9Vj0TLAx+WcdDIWOTa6UVlNE3Pxv66ESDK8kPX/70AeOt+K2t
         UnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IrZENYe21/WJhbxZbAQLOgLQcfcKitNnofQUePCFcPA=;
        b=gdkf4AOEKZSt+p/rzDc9yNtdBeqvN7fRv0iXWa3+wxl8yYMHSZQ2vjvX1/h2J5XyoA
         C+xkw+Gata6yM7hwA5aC+aaEVYvAJX9YPKzeSVisJCUFBPOV47oIdBWVyO/0gRIx9qL/
         b/rBnUVieRQ7MYhbG7VLQbxp5RDwaS5R0tg/BJz/xLatWeTXgNrpmD6sWWPVfAtQ7ffD
         VO0QRgmz08jzQOpbzaP7bv98aCuzab9RATanVYZqeSkooqKB4QzoCGLQlM0bqN1ObIva
         9ZMd1kjDz1lw41cWyusWrjT06q9EuX4cc0ZDyTAReWynvYNEJ7MPHtAoMa9XhqqGDbNY
         ctAg==
X-Gm-Message-State: APjAAAX1AyHUQCrWv9A+0wkfJYKWXJf2iPwx8tHrxNTyOzr9d5naF7yu
        OueHWfZeTGCfI5uAuoTdny0/gTCL3PS/Tg==
X-Google-Smtp-Source: APXvYqyMS8mgvcphLUeDzkMDnykabgr/Lni/AoBt/It28HRX1Pq6xgyPgaFjfhDZZJjh+Vuls0K+5g==
X-Received: by 2002:a17:90a:804a:: with SMTP id e10mr7622976pjw.41.1576122621806;
        Wed, 11 Dec 2019 19:50:21 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s15sm4319911pgq.4.2019.12.11.19.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 19:50:21 -0800 (PST)
Subject: Re: [GIT PULL] md-fixes 20191211
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>
References: <D4EC2793-CDD7-44D7-9169-90129D7E8779@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bacc157a-a402-58fd-37b1-be9067bbfa31@kernel.dk>
Date:   Wed, 11 Dec 2019 20:50:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <D4EC2793-CDD7-44D7-9169-90129D7E8779@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/11/19 4:00 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following changes for md-fixes on top of your
> for-linus branch. 

Pulled, thanks Song.

-- 
Jens Axboe

