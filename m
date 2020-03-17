Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59299189031
	for <lists+linux-raid@lfdr.de>; Tue, 17 Mar 2020 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQVQF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Mar 2020 17:16:05 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41587 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQVQF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Mar 2020 17:16:05 -0400
Received: by mail-pl1-f180.google.com with SMTP id t16so3145557plr.8
        for <linux-raid@vger.kernel.org>; Tue, 17 Mar 2020 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/VA8sgZdsWCEBZrnuSlX5AYUEcBbvM7cxBQ4mLDXJc=;
        b=ub9Jj6KW7pH5Xen8CaNlrXpxaN2KO0H6rKWT38RSLkWg64Al0YRAU3wjKWTi7fSEpo
         pG3UIA1aTjrLjBEbslJYRSSiYPDhBh/fKjNCr9dGLvB8fgZHAD759iyjmT22HFQIlMYW
         7kO2cugUNny3EnoFSiuMHwrCTN5i1Wcxi2pg31yQ8OTEVXt/oVKgwPBi+whJnP3bW+Fi
         WSyPyviI1gxJbtxGNr1pX+IDUSMfDzVNb1MKjA/hShEpHoJ+RqQaffjO7grm6076yngM
         WOYEbd5BFxO6eMuPE/dg5cFyX2QDzWisd7YbD096ba4FrLJHMKTCu/m4RamqZpXssshB
         DzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/VA8sgZdsWCEBZrnuSlX5AYUEcBbvM7cxBQ4mLDXJc=;
        b=AXoFjELemeTcFFFvHcUt02U2UV6F9jgvO4iMwzkstTIxrrmavUeLqo+JJHXgAbIx4e
         bs+CG8rsWdkNW5efA0vLRMsVwhpj31M7SMz2ytFQ2VG1Javh6IOK+pgLPEvgYL/rHnyg
         47cAxqfiAHpxXk4YUsIvHaXYHppjl4D9ZtCJPZtOgTjxtLH3i6Gehr10ze7/crJN+P3b
         xIY5DmNGO+17csW2xvHuOWuuxftPjAfRPBgX17Hiw0uhZNq7tjDhJPP9FrTyPNQWijIL
         vff/Ryn5QWQq7On9CT0brY7u3ogkBo8I5KOA99C493rboL2p0xSwL9lfbRfvQO8G3sru
         eEqQ==
X-Gm-Message-State: ANhLgQ1elj8Hz/PnU0YBMhz6B8DRgRFl+JIBVFCn0qGx10uvOlHlWzmQ
        fnnIvVMzUXvXC6gnLKCsX95WcQ==
X-Google-Smtp-Source: ADFU+vs9KoTf5Kd8FPH5rwdp0jqD+npSVIhsq99bMY+8PcHOcPy9orWKBnQBv0nHBwLFIZf3gc0JNQ==
X-Received: by 2002:a17:90a:630b:: with SMTP id e11mr1158816pjj.53.1584479763802;
        Tue, 17 Mar 2020 14:16:03 -0700 (PDT)
Received: from ?IPv6:2600:380:7716:41:c9df:ecd4:2029:3e1b? ([2600:380:7716:41:c9df:ecd4:2029:3e1b])
        by smtp.gmail.com with ESMTPSA id t1sm265214pjy.41.2020.03.17.14.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 14:16:03 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200317
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>, Guoqing Jiang <jgq516@gmail.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>
References: <7CD08FA9-5302-4885-98C5-CDF974CC225C@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e1074b42-63b9-e263-c7d0-66e5ac109be2@kernel.dk>
Date:   Tue, 17 Mar 2020 15:16:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7CD08FA9-5302-4885-98C5-CDF974CC225C@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/17/20 1:57 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following changes for md-next on top of your 
> for-5.7/drivers branch. 

Pulled, thanks.

-- 
Jens Axboe

