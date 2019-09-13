Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D21B26FF
	for <lists+linux-raid@lfdr.de>; Fri, 13 Sep 2019 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfIMVCs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Sep 2019 17:02:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35976 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfIMVCr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Sep 2019 17:02:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id j191so5330740pgd.3
        for <linux-raid@vger.kernel.org>; Fri, 13 Sep 2019 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YO/zO4TQMB3lo3lgviV9U28xOfKts/iwUYuNs7nPdCs=;
        b=cZ2kJiZa9iKa6JeHqUYHOhCWLVk41GIQS8U2bcOYasRwc/qDciqMzdngkhGfAmuowD
         nzlz8pooun1tw7bvWZt/FxnzRTuC3DrDXY0MmafOm9cpm2smM2ARCeX5EOon9nbvkoWr
         ZRLpLsXHVAOl4pAfDYbxF9yfoQHD3T6XJOGOftrXl1Egc0TVeWIW8Y6ilNIjfUMcgGKu
         3YXM0Ee7w+A20LWaKoJ2icUHMxMCsEXRyL/kDOP+Ock3Aa2nnPHlOF03eLVRJWRgKDnq
         kpJdDbVKzCsk5ADrHI+P/+zah3VSf/mtudDIvoOGGFmzKIRv7qp81gRcEc76miR7oa0K
         LHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YO/zO4TQMB3lo3lgviV9U28xOfKts/iwUYuNs7nPdCs=;
        b=Y1k3CetIdrt4PH3811xNVC/jdAZfoyh4He0E4U8/WHwNzBmKSKOtnAQ75jd5lc/BkJ
         /dOxOLtKI2tuNrj2KP2P7H4pL6Sr2prCb7Vk/t2S4TtxZax048F9rG3QyvyoU8ivKU5O
         ju5FMiph2ZW7TF1j4V7Tr+CF8suOtjmn5ME3cP61ZdjL4p+Oa/B/XCUvN0UuFY5yN3WA
         w5xBxRB1Be9F5sbTagjcIyw6LbTOKBMXqoqJfaezfkiR3jqGs7kus077WGM4Y9urYQB5
         QuoE7CDrnd5Noswt3O0Y0xX1Z4kII/GeDSkuv835IH+TcGzZqo5vPAjGKbKnLXGlmjcS
         jvMw==
X-Gm-Message-State: APjAAAXpJhGL/7hBgR5D2cCXRqZAP46NQdAcUbGJBrFNoj9huVOTngm0
        4pm9POny53USf42aYxF9kZNuQw==
X-Google-Smtp-Source: APXvYqzpHyec4+utXXZFeHOxtlVgDoPmMXsoawkvxcJlduZI415XE3l/5yatOaZ4NS0mn947oId4lA==
X-Received: by 2002:a62:d4:: with SMTP id 203mr57582047pfa.210.1568408566106;
        Fri, 13 Sep 2019 14:02:46 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:4d1e:aad2:f066:c964? ([2605:e000:100e:83a1:4d1e:aad2:f066:c964])
        by smtp.gmail.com with ESMTPSA id l62sm48477528pfl.167.2019.09.13.14.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 14:02:45 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20190913
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <jgq516@gmail.com>, NeilBrown <neilb@suse.de>,
        Nigel Croxon <ncroxon@redhat.com>
References: <B718A96B-0D25-46EB-815E-31ADD6007F17@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <699b84a7-b0e1-7231-f1ef-dec4c5b40758@kernel.dk>
Date:   Fri, 13 Sep 2019 15:02:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B718A96B-0D25-46EB-815E-31ADD6007F17@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/13/19 2:20 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md-next on top of your
> for-5.4/block branch.
> 
> Thanks!
> Song
> 
> ============================== 8< =============================
> 
> The following changes since commit 21fa1004ff5d749c90cef77525b73a49ef5583dc:
> 
>    Merge branch 'nvme-5.4' of git://git.infradead.org/nvme into for-5.4/block (2019-09-12 11:19:43 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
> 
> for you to fetch changes up to 067df25c83902e2950ef24fed713f0fa38282f34:
> 
>    raid5: use bio_end_sector in r5_next_bio (2019-09-13 13:14:43 -0700)
> 
> ----------------------------------------------------------------
> Guoqing Jiang (3):
>        raid5: don't set STRIPE_HANDLE to stripe which is in batch list
>        raid5: remove STRIPE_OPS_REQ_PENDING
>        raid5: use bio_end_sector in r5_next_bio
> 
> NeilBrown (2):
>        md/raid0: avoid RAID0 data corruption due to layout confusion.
>        md: add feature flag MD_FEATURE_RAID0_LAYOUT
> 
> Nigel Croxon (1):
>        raid5: don't increment read_errors on EILSEQ return
> 
>   drivers/md/md.c                | 13 +++++++++++++
>   drivers/md/raid0.c             | 35 ++++++++++++++++++++++++++++++++++-
>   drivers/md/raid0.h             | 14 ++++++++++++++
>   drivers/md/raid5.c             |  7 ++++---
>   drivers/md/raid5.h             |  5 +----
>   include/uapi/linux/raid/md_p.h |  2 ++
>   6 files changed, 68 insertions(+), 8 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

