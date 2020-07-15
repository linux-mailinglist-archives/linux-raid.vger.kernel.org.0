Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB5D220FD4
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGOOsq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgGOOsp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Jul 2020 10:48:45 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CBBC061755
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 07:48:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e18so2188836ilr.7
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tb/FJHhrvLGFb5mzl3RRQ0CDOJDEBqHmAEvT9hhYACs=;
        b=PyZInZGKeMvobYsrFamWU2iYZuTvEAUkXiHdRNgzepfRHWI6o+ixNebz+WRKJGeyhF
         UKBw+g7L8NPKCX5yyYkOfmT19nd53vvMD4sPZ4TgktnBBTFTh1zrvbhX3LeA0i8mFaX3
         ndZPDQuzBxYsnEtTqqveXQa+Xy7jvopzAPtqGcZOgyPLAGdPL21W4YUdVt7uwl7f49PC
         sfISgo45MXE1Hy4lPWwXrE7icC16+WEY72d7FQ1Yi7g93NrPGbiOGOpuib0VJoIG/LcD
         gFPDjuCitgvRTXCgpr1A22Y4l6V4eGulBzNRl2kwKo6EOtLk+1x/SPMvd+IGqHoyv3wC
         247Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tb/FJHhrvLGFb5mzl3RRQ0CDOJDEBqHmAEvT9hhYACs=;
        b=NV88WqsKrPT6b9zRnwduooXj3p24GUtXN5FIvuXszh7kd41pGJVMmU6cFUgD7RaFvV
         zNkBqPBjve0SYZfsRLu5XBiTebQfzPpijmYmb5NRYJxcnBMACridmRPd8z5hEb5OsCci
         mZcKwIh8/sVUIyqunkwFMO02/iTuK2LMbjcZciZDHl8g/AqjkFTRUFiUvHeKMF8gOpNJ
         3+nxn0T8iVOivO08L82TE2UpraQ7ZTHc+nHPdLq6RTS3sxI7tDFTUzlOt5IXIAFDrF2I
         XiiJEBNUkRDrD6WN+07ddiX5NNGkCe9b7LIXHEJ4WstJn5UqJ7C02I/ftvLx3Lw1Uhhk
         FLCg==
X-Gm-Message-State: AOAM531/2qXih7VAvRzFL7H3AIP33i0b1tXe/EgXqzXMnVpivzLvbjs5
        LJE0N8tXb3qaSBcQo2Lm/UJCGw==
X-Google-Smtp-Source: ABdhPJwf6MWoyhXrt5eWnCNpOQhvt187w80oQ7ZM2/rdGjk33wIBIH0gc5+/kNF0HW/PHqdtIoE9/w==
X-Received: by 2002:a92:48d5:: with SMTP id j82mr10801941ilg.167.1594824524675;
        Wed, 15 Jul 2020 07:48:44 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l10sm1159372ilc.52.2020.07.15.07.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:48:44 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200714
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Zhao Heming <heming.zhao@suse.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Colin Ian King <colin.king@canonical.com>
References: <FBE6B82B-E360-4EAF-999D-AFBC6BC5F058@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd6be000-262e-f215-f514-1f567394ac9d@kernel.dk>
Date:   Wed, 15 Jul 2020 08:48:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <FBE6B82B-E360-4EAF-999D-AFBC6BC5F058@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/15/20 12:53 AM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following changes for md-next on top of your for-5.9/drivers 
> branch. 

Pulled, thanks.

-- 
Jens Axboe

