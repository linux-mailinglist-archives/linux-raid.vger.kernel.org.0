Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D833E98678
	for <lists+linux-raid@lfdr.de>; Wed, 21 Aug 2019 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfHUVSs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 17:18:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39564 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfHUVSr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Aug 2019 17:18:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so2276835pfn.6
        for <linux-raid@vger.kernel.org>; Wed, 21 Aug 2019 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J1frb19d7zPY9aoxx3wLALqq/9XzCczMwouYRJ1Hly8=;
        b=myrpBCWP9q5LhhtHCeaUihbRok8fTZHi/YdZxcGNAmRXXxcNEIneMvab0Jv2yO+Roy
         s4KIj330XytgJCF1vzs86qzJYz1iDf/TDOp7CsW5izRh1NIP3XeZvl7ARY21jQHRi90V
         bdRecnlf4bAECvYAk07hE+EE5sO2rfCaaTRM0p7XjOpsrBPa5w+wyITqfAwnlPCyvgvW
         9eGHZBonu6eflzXKQ07yuA0M/RSpy9M1O1tP104RIatWfJ9dG19nA6Yj8+dMNHlcElrp
         2icsAzG9aUspcxM59HwNkJdndGHO0U7jjvccI+rLVx1vvGptmVQCqmc7nlxWliP7hMoz
         ehmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1frb19d7zPY9aoxx3wLALqq/9XzCczMwouYRJ1Hly8=;
        b=LmjVTwXcgd7pz+Fx6y8Jn/Bcodtwr+RoB3Qx0bG4XyNOk1G/3fwlRVk+DXgcRqgZAK
         55k+YH5rOpjUvJwc+VX6GUrk60Nx5BwLSYYGMm7VaZl65g9v3dL5h6G837DMR+VyiEEF
         ctqbfgctJ6aceZQztb1z6cwlNcgt4S9O8xxIqFR8DRUz8392B83hNowqMJY2hka0hFIu
         QOVbJ63NJr8BqzKdlbwluvzq4y+jvqMebptoeOlb36tb+RAJLJnY/n+fMIL2yQR5jA+3
         GM2o5jnuwBLreAW4NVZ1K05lTKsQBKrlMgsXqCUvsaYbdk6anQp0GJcJ6tZ8i/YZ94Vz
         PSvg==
X-Gm-Message-State: APjAAAUHWHD5jFEKrxfH6AzasyVSRvpEZRmS5mV5XECHmhNpCoNMaqFJ
        wZjUufSko/nM5Bc/4JOqzYdKig==
X-Google-Smtp-Source: APXvYqzLcatO+b+Lw7D/FqhYp+BM7HsRGf14XlcYOz3lvTPO9WUqEDFXhxQ/dwkAX4fQXTGYgx4LiA==
X-Received: by 2002:a17:90a:a611:: with SMTP id c17mr2064625pjq.17.1566422327008;
        Wed, 21 Aug 2019 14:18:47 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id c26sm22343120pfr.172.2019.08.21.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 14:18:46 -0700 (PDT)
Subject: Re: [PATCH] md: update MAINTAINERS info
To:     Song Liu <songliubraving@fb.com>, linux-raid@vger.kernel.org
Cc:     NeilBrown <neilb@suse.com>
References: <20190821184525.1459041-1-songliubraving@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51398ca1-44de-3b80-6381-54f594b6c251@kernel.dk>
Date:   Wed, 21 Aug 2019 15:18:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821184525.1459041-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/21/19 12:45 PM, Song Liu wrote:
> I haven't been reviewing patches for md in the past few months. So I
    ^^^^^^^

have?

> guess I should just be the maintainer.

I'm fine with it. Neil?

-- 
Jens Axboe

