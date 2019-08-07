Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80B6852F9
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2019 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfHGS15 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Aug 2019 14:27:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38018 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbfHGS15 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Aug 2019 14:27:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so3424672plt.5
        for <linux-raid@vger.kernel.org>; Wed, 07 Aug 2019 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yxqFikm+raH6Mw+5MSz56q7hyv/Q2E3BjnTc+h+hMKg=;
        b=fLEBtwtD/cRQaxUwRZvUKNZh5Tb/ij6d08WPgGZap5eSKKbFDaH7QroegH9iQZOiYu
         vBWBPCeVxiVkUTc5QE8tLSiK+DqNjc46vRuSmlyqYUKEjGMXirS9XYg8VW1mlQcDWVvz
         fK+e9T0zx2xqy4M9BXfphEd2fUBZUJqYxqXlnxXKENm6HuHzd2m4mpPTWLIcfUIa9K9o
         k1M51J919oYNFPnfVWgEt95lIS2OgG4/9sy1/fQylpm5j8vXrc4ebTnFa3sGaMY5P6i7
         vLBEJq8QUQ8BffLmlQ3FlGoBDAeMvWCBbYaax56hm9/ebha/L1M4qMstxnWenAEq0FdT
         pYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yxqFikm+raH6Mw+5MSz56q7hyv/Q2E3BjnTc+h+hMKg=;
        b=hOMnwwSsIiZyCmaQZwPkmiQBjlKVkstwZtU7ymfcIrgb34czlo8CjZlJGqHhH8zDXG
         1Ro4cp3ASshIu8XJ/fEebppOs4n7a5kJn3bVhJDaMFwDJ77uRyCUcNN0SUZSz4jNQ2MX
         +qd4krsqK1nfURySi7fauaWl3INdjQcn3Rx0tA7ASfcdW4YD/yNUQGAT9r4BF/PEH/ED
         AdKYrds0sYDYrbx0hIa7tIbAuOyaNm7RCh1gXGbpO9ir42Um1GKhoT8j3yEKNnXQDQYd
         phxpCSG72qEOvj0FPkEowbrzm1uU23NlCs66gzk66p8xu0hDzK5KGB1kv22O+ijGmEEq
         mZgA==
X-Gm-Message-State: APjAAAXAtaecxx+rfDlyiG694eALuR25QWgW3vXS0Djyt1lBJn59N6CL
        WZF9aOffye9B+qxfNFGqOOhOvw==
X-Google-Smtp-Source: APXvYqyyi2wc8HhzIYFysju67q1UTie+2ONRYlen3WA05ndHZ9rmYjxDEblz1UILFMZ0kTPiJzmq4Q==
X-Received: by 2002:a62:fb15:: with SMTP id x21mr11045658pfm.233.1565202476527;
        Wed, 07 Aug 2019 11:27:56 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:8dfd:af83:2:106a? ([2605:e000:100e:83a1:8dfd:af83:2:106a])
        by smtp.gmail.com with ESMTPSA id q126sm97318490pfq.123.2019.08.07.11.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:27:55 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20190807
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        Xiao Ni <xni@redhat.com>, Yufen Yu <yuyufen@huawei.com>
References: <5EF8F057-3ADB-41D5-855B-0FBAE7A43E6D@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <764cd191-b5d9-14d4-5bb5-d42793752e10@kernel.dk>
Date:   Wed, 7 Aug 2019 11:27:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5EF8F057-3ADB-41D5-855B-0FBAE7A43E6D@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/7/19 10:39 AM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md on top of your
> for-5.4/block branch.
> 
> Thanks,
> Song
> 
> 
> The following changes since commit 00ec4f3039a9e36cbccd1aea82d06c77c440a51c:
> 
>    block: stop exporting bio_map_kern (2019-08-06 08:20:10 -0600)
> 
> are available in the Git repository at:
> 
>    https://github.com/liu-song-6/linux.git md-next

Pulled, but nudge nudge on using signed tags for security. I brought
this up once before.

-- 
Jens Axboe

