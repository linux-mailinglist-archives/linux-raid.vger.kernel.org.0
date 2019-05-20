Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4824018
	for <lists+linux-raid@lfdr.de>; Mon, 20 May 2019 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfETSO6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 May 2019 14:14:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44088 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfETSO6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 May 2019 14:14:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id w25so9375098qkj.11
        for <linux-raid@vger.kernel.org>; Mon, 20 May 2019 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRBnFpY6IqVHOmW1uG6a2IPztKNGgzYr1ZoaOgEbreE=;
        b=QpXX/jmyl+0WFlpOa/+GKOcjV6U5l1ut8oNpITEifJYjd+KexkvpgtnjBSv8s0xXUr
         O0WiWYIHMCUttIBoy+uuu/xr+t92hExx2CYi0LQZHumB9AxrDO4yGJmoo5Ny7ifca9nh
         dMUxAbcoL1+jHOlqIYr5W/ZMUSU/g8i98SMVsp+HktAez7wmX4tNd5p9N2wbaUfo/SJQ
         LCIjNYOz+5iJ8MFj/I/r+BDsdhr4Ynt8Ep71v4lTp8Jez01VQeg2NEba7m2n1pzdYpBW
         /KQ6Vs0/T5Hm5j/xSBkZ6bekUowMt1+k0+KwUjavgcsF0CwpemmnTL8f9vKHjkB96VI8
         8u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRBnFpY6IqVHOmW1uG6a2IPztKNGgzYr1ZoaOgEbreE=;
        b=TRj5Q0UHiSke3bHSY3purkhOHZrD0NgBsY2R84+8me2EUYk0ddmr5dJyliAZUObtK+
         Gk1J8uIt9KyrsYSu0AMFH15wR9riviQJsLx+WNLOdTiyDin7UlMGNX29bfPgcelpBVOD
         DzSnVGDnxXLgHdl6y5tEDpaZXBgdQjcuutedw0qeWAo7mFgGH9r2o0eoGXrwYEDGTaIt
         8RLUI3lASF8vpqLUTa9YTvlkXw3PMkdJBJU3wuYE3Fo9pGlKOYUivjPftLcnNcIwtLGV
         oeyGMxqgkeEPasCAm1jz3KbblEp1SkaKYinMgzyjRGDHPtZzoHFdiswgf7OV/P66fKVr
         +U+w==
X-Gm-Message-State: APjAAAVprrpAiRgxCL2WKdekTEmPAZwZG9uhNynudGYvEyRyVXrC2S3T
        bBVKsmOv3hcSa6gE0azs8GD60xpDhzg=
X-Google-Smtp-Source: APXvYqyy1or6Qj05pwUI+eSRk/SKHuHsDfoZAvQf0DzD7i/KRYRVePeDz8kCyYZvBIX2ZWWGPG45Fw==
X-Received: by 2002:a37:358:: with SMTP id 85mr58038100qkd.174.1558376096608;
        Mon, 20 May 2019 11:14:56 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a3:10fb::15b? ([2620:10d:c091:500::2:3880])
        by smtp.gmail.com with ESMTPSA id q10sm8433481qkm.12.2019.05.20.11.14.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 11:14:55 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] mdmon: fix wrong array state when disk fails during mdmon
 startup
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20190507140847.4776-1-artur.paszkiewicz@intel.com>
Message-ID: <51e6a17d-c79b-28c1-76b0-66513702312f@gmail.com>
Date:   Mon, 20 May 2019 14:14:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507140847.4776-1-artur.paszkiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/7/19 10:08 AM, Artur Paszkiewicz wrote:
> If a member drive disappears and is set faulty by the kernel during
> mdmon startup, after ss->load_container() but before manage_new(), mdmon
> will try to readd the faulty drive to the array and start rebuilding.
> Metadata on the active drive is updated, but the faulty drive is not
> removed from the array and is left in a "blocked" state and any write
> request to the array will block. If the faulty drive reappears in the
> system e.g. after a reboot, the array will not assemble because metadata
> on the drives will be incompatible (at least on imsm).
> 
> Fix this by adding a new option for sysfs_read(): "GET_DEVS_ALL". This
> is an extension for the "GET_DEVS" option and causes all member devices
> to be returned, even if the associated block device has been removed.
> Use this option in manage_new() to include the faulty device on the
> active_array's devices list. Mdmon will then properly remove the faulty
> device from the array and update the metadata to reflect the degraded
> state.
> 
> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

Looks reasonable!

Applied!

Thanks,
Jes

