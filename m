Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5809F39D
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfH0T6H (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 15:58:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44925 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfH0T6G (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 27 Aug 2019 15:58:06 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so945555iog.11
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84OL0CYpWzw0cH2OJ80//UxGf3LN5WQVq18GIdJ6HeI=;
        b=o4suheXUOOr4per7YsVovHFyx+VvEFGuNS7bqjXxC0SB94oMGmqf1B5etwub/I78mv
         g5NDTJ9oWibKd4FntKTosK5308HaXc7rpNehsOR8WNbBGI8fWMiJuqyzoUMW41LUhi+4
         ZURo/9mO2s05xPuzfieNIY3GOX9n9MO4z6KyOTnPOngvOmE8UG7POCtIh8+oh3EzvyJo
         ogE++I8y9Aw9EFyzZJebFZXHVzaA9AI5bbjdcGqL0PvdqS/d7nCs/M9z+9092dw1NUY3
         Fr0UE+snqABk1qfEezY3WqjwQoulO2+b+fzA0rov7wJskaN1RhmDCiX2n6Vy4WGPymDX
         nZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84OL0CYpWzw0cH2OJ80//UxGf3LN5WQVq18GIdJ6HeI=;
        b=ZDtm4t5kshPaJYM5uClF7R8tYRfu+DcYZEKP/lsQ/axKMJqFPHEazLdFn+VGccIm1J
         RPgVvU6RZoWvDwzaend7w5T85UWLSAFuDNTM29w4ozsE52U8NrqXUaPCkVsjqs6FYXSI
         FAGNNVkFLL9m7HUgZxkq+26nJ1IU6L5Fj9qaXhJ7N3orZUClh0e+LyDvkzwVr30Lrr/4
         WaIXz16+J94vB8P1/SmrjqKywrW8IcweVxmZ+fvmI/+8/6J0QdtGrd0UODB6Z+H5m/j7
         4YhXj8RDq9wCYaalE39jnUfTdiNjvwowyPeGnU8RsBmffSJ/MVI4UUv8myAFkiJEB14W
         C/0g==
X-Gm-Message-State: APjAAAXJSsitL2OsEdmLu5H5P8nykMw5ljCOdY/Jx/TLgadhxeWb3mI0
        VfOP3OBICcivfHTKZEoH++/mEg==
X-Google-Smtp-Source: APXvYqyNXOer8Wyh+hcsW6jQgD6GHh8Tw/lDabucEARu5zhB1M/0wnpAtAu2ESoIB0W6wbK1GIBlSQ==
X-Received: by 2002:a02:c012:: with SMTP id y18mr561241jai.85.1566935885798;
        Tue, 27 Aug 2019 12:58:05 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m67sm163729iof.21.2019.08.27.12.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 12:58:04 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20190827
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     NeilBrown <neilb@suse.com>, Nigel Croxon <ncroxon@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
References: <D4B2FC6B-6939-4EFB-A8A6-9105C04AFAFB@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43e21a6d-b1e5-b91d-9320-2b90bd230cab@kernel.dk>
Date:   Tue, 27 Aug 2019 13:58:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <D4B2FC6B-6939-4EFB-A8A6-9105C04AFAFB@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/27/19 1:47 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following patches for md on top of your for-5.4/block
> branch.
> 
> Thanks,
> Song
> 
> 
> 
> The following changes since commit 97b27821b4854ca744946dae32a3f2fd55bcd5bc:
> 
>    writeback, memcg: Implement foreign dirty flushing (2019-08-27 09:22:38 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
> 
> for you to fetch changes up to 0009fad033370802de75e4cedab54f4d86450e22:
> 
>    raid5 improve too many read errors msg by adding limits (2019-08-27 12:36:37 -0700)
> 
> ----------------------------------------------------------------
> NeilBrown (2):
>        md: only call set_in_sync() when it is expected to succeed.
>        md: don't report active array_state until after revalidate_disk() completes.
> 
> Nigel Croxon (1):
>        raid5 improve too many read errors msg by adding limits

You've cut the bottom part of this off, which is a bit problematic as I
always verify that the diffstat matches between what you send and what
I pull.

-- 
Jens Axboe

