Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862D5210C77
	for <lists+linux-raid@lfdr.de>; Wed,  1 Jul 2020 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgGANnd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Jul 2020 09:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgGANnc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 Jul 2020 09:43:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383DC08C5C1
        for <linux-raid@vger.kernel.org>; Wed,  1 Jul 2020 06:43:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k71so7495884pje.0
        for <linux-raid@vger.kernel.org>; Wed, 01 Jul 2020 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mp3kZB+WljYlToUgRKHu/jMatrXibHPg1FspuaVdS+E=;
        b=dYwQW22jG+1U/8wxe99npchEcHOVVxkAEfKn6EBHer8enDnZPRaJ5nzspLL5jxwR7E
         8c6AvaHExACDpMcSpNKAKYnhHPOqDFAuRaNYxN8Hxrsw/QZbGOrdK0NOggJHl9AxSJgs
         BdPFufpE696CTqP0ZSQJiMeB/Vf1M790yE0S6UfvzUcW/2LK3Cll1WaQxPF72JBBNiAi
         uNmww608IStODIzkXWWB+ivDstxmDBFHqxk0XqSa0PCNUdKh4Ts6OZk4XhvUDLi977z9
         tRq/B+DQOlpjSRZ9yIK6lLqMnhcWWTEtAYB9JXJiCaKrLlWYMNjb0yZxPI5ky8TpWAqd
         O5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mp3kZB+WljYlToUgRKHu/jMatrXibHPg1FspuaVdS+E=;
        b=OIZ3m9TNRWyW7clQyejCkTXSuFrFy5ZoHLrQx49tYOQsVdP9xNeIrgC5uITxclpOtY
         +2FxcE8Gss3Qfj5d91AhLoeBKKwLyovSLTjkq6BHUf3oy0bRZaVT2QzuJq40poPTNdzG
         zf/5v40XFGeBSGAmMMjitFbqlgqm/uLxTZ1jB1q/OmRiHvLCB+tNZ1UlznogFLBQA23y
         6F6ZLmfAT4vBb60jD4rRJyaVdr91IuFRBWQIWkeeoP+RhGa3v4gw6Zw8+hh4cauGMoQM
         wt7sSCIJVJ0sgT0GebPgjHvZGJot5keK4xrfSATdXspR3wLl2pNBeMxQ/DlKnl5HRNm1
         ljSQ==
X-Gm-Message-State: AOAM532i8GTmd0ilJfeQ7tnmBoFBMH6MfsGTcsz2gVSzbJm+UfQBxRpM
        MmYsK5YYmV6hkZrABlaFWa0xng==
X-Google-Smtp-Source: ABdhPJwvetMLus+odkxVKs2TAwFJf3HuNkqQjK/vuqbHNuGPdXyOvoQGErv/SGur7kel3VcwfskpPQ==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr14712438plk.313.1593611011686;
        Wed, 01 Jul 2020 06:43:31 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:64c1:67b1:df51:2fa8? ([2605:e000:100e:8c61:64c1:67b1:df51:2fa8])
        by smtp.gmail.com with ESMTPSA id g4sm5868990pfi.68.2020.07.01.06.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:43:31 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org
References: <20200701085947.3354405-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bffb89d5-b51a-5f5a-15f4-b891f1f053ef@kernel.dk>
Date:   Wed, 1 Jul 2020 07:43:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/1/20 2:59 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the make_request_fn method into block_device_operations
> with the much more descriptive ->submit_bio name.  It then also gives
> generic_make_request a more descriptive name, and further optimize the
> path to issue to blk-mq, removing the need for the direct_make_request
> bypass.

Thanks, I'll try this again.

-- 
Jens Axboe

