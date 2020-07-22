Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313E222A097
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbgGVUMZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbgGVUMZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jul 2020 16:12:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0013C0619DC
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 13:12:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a14so1872346pfi.2
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q2VM37gVtkfvaAh1Ihubpz9teDBq5u+GzBdC1l6zTxo=;
        b=DMbk0i7+Y2dNnEyn4r9Apdo7KYeU+f2yYGCFgQAimWxYSpq12o7o8LYV5i+C+jQ2ee
         Xrcr9O2GpFApIbgtUO2LOEENIjSy+c0b8hke7YLVvPYjfdAB4U2AdWafc8snjx3rbbTU
         AlfI5XLRrAF76mZZbZZD7IcsQwEB3w4R3xtb5wabCi4HKQRNi+GLwUbG9eDX3FEdR6GD
         bYdz8jCWlOxmfQMnpIUDNDfDn6cN7KOIB/HyGzLQlh13wHRFukz5h0TMc0nhpRCEAi+G
         qo4iviy0GaPR5GIpKs11m5PR1PbNZKSub/+BdU1pwmBnssyN5tJXq/YUtD0Boj8aIUn7
         xFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2VM37gVtkfvaAh1Ihubpz9teDBq5u+GzBdC1l6zTxo=;
        b=KCjXGQLdRwNRF/v+l4wV+C+/h4ZOJNncXCA0dnOU09e4aA/gTrsDFadZ43rYD8Vcfx
         iXF8diHDaYasCNDMeb9X/GZDK+ZEG6NTMvTsSArvd4TqcIzdcPL8U5b0bXIoWSYuyuHs
         Dk8dBoCjghAADt0DQHroKYF8Z8mjob0Z0f7GGrOQd9UNOCoXV+O7ePD3P3g2+Ay4iaKF
         h3mO8YWelnM6tg9EGyns33bQTWpKn+woJTWz5AGz9sKiyyWWt+pd47GdeHkzJCpDS1O0
         UxHf866mVuP6Hz2BceuSwv7XfQ4vqlicvdQLx/SOl28v3GL4mPEMgp/1jFgLoJIMyQ5c
         uMIA==
X-Gm-Message-State: AOAM532gGaSVe6Jn2ZFbXUbhq4O5tNDsllyddx6t3Iz1EszWQUzNlyVB
        3PTRtr5HxWeQbDl0y5wDkvZZo6f3L5QB+w==
X-Google-Smtp-Source: ABdhPJxY1NBTTRWTCYllgGes6mqIDd9wXjHxHmNGsgex3zXZvxORx6PbFYjTmxjp3IGT77Ogt4QgQA==
X-Received: by 2002:a62:3583:: with SMTP id c125mr1169792pfa.158.1595448744125;
        Wed, 22 Jul 2020 13:12:24 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q14sm476062pgk.86.2020.07.22.13.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 13:12:23 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200722
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Vitaly Mayatskikh <vmayatskikh@digitalocean.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhao Heming <heming.zhao@suse.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <62A334F9-B486-4101-9803-AD72B4D5F66F@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <608e248a-b565-6f9d-0724-49d7b058f9c3@kernel.dk>
Date:   Wed, 22 Jul 2020 14:12:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62A334F9-B486-4101-9803-AD72B4D5F66F@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/22/20 12:54 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following changes for md-next on top of your 
> for-5.9/drivers branch. 

Pulled, thanks Song.

-- 
Jens Axboe

