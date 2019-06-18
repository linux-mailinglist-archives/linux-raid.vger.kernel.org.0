Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45D4AB3A
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfFRTxc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 15:53:32 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34416 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRTxb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 15:53:31 -0400
Received: by mail-ed1-f50.google.com with SMTP id s49so23512981edb.1
        for <linux-raid@vger.kernel.org>; Tue, 18 Jun 2019 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IQvD+22XeYnYT4Zoo9LJU70Jo9Q+YCBwqTepMrcgtbY=;
        b=ZS7N2FGA5ApQoxuABGTf2oNS9ev2c3l4SvPtxZvVEPBoIJZs7zNmDn1Rd8dZwKMvtc
         aPzwhLYVTJs6AphkJA+WxAzbfhJucJcwC0UVsUVOsBawfv5GgKc6T1PFO1V0R78X+Aqd
         ohPSpHuh682RS8Zb6/TGiMK3NMJ51yUTkqslgnOnI+kILXCSrVvGmpG7V2cfpK1767By
         CGguTsiL+0uwkw47ztpbD5jXbhJTBEWhQ2/WHxLNm0ics22XXlvTz3kWk+hCeg/UKJAW
         gXA9OSc8WZRBVfThwD0UqGcSZYOlEhzkgm4z2I6Xrl8H4jFijrm71SZs1OWpklDmyf9f
         Gdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IQvD+22XeYnYT4Zoo9LJU70Jo9Q+YCBwqTepMrcgtbY=;
        b=e1s6AgXsQd2OowlimDv15ueT1ENBJFxfoOMy2FkLJa5MYJB2IZoQc5w6/kxltH0X2X
         +uh76B/VE5pZKqJ8KLrd6mBm2BOf+i8D99KJwzOsqG3m68r5gpw2PuyBuD8oYlMb+4ph
         9PzOOQklXYZM6O+JAk4wdJmOXgjYFJcb3jFiC37eZwEZjgo+N+OvB3EJHezVVtgaTvJ5
         9k6GP0uRLa7Dqrj7am5/yOCL8jsB/u3du5PvejL1G9nUzuHnvcvmJZaOFIRblt9LOwX8
         jf72uBI3KbtrySYDK1LwJRTr6y2vDaV8OPrLkYBNoJK8NEWvaMP8Z3SSdq6r1HcmaV5y
         nl1Q==
X-Gm-Message-State: APjAAAXbs53IVnn6KnlhCw50XOtfGHfIxt+XWVfjjKWK+39/7yOut+96
        w9no39fdKDqelOp3K8FM6bR5zw==
X-Google-Smtp-Source: APXvYqyCyOnwXB651pKK+ovyqzgNpu7vgdQ3ta2oxyUYF0ntAGSWM+0Sshq101HMBhi+p7wgnUW+Ag==
X-Received: by 2002:a50:86dc:: with SMTP id 28mr100266027edu.132.1560887610126;
        Tue, 18 Jun 2019 12:53:30 -0700 (PDT)
Received: from [192.168.0.115] (xd520f250.cust.hiper.dk. [213.32.242.80])
        by smtp.gmail.com with ESMTPSA id k21sm2831694ejk.86.2019.06.18.12.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 12:53:29 -0700 (PDT)
Subject: Re: [GIT PULL] md fixes 20190618
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
References: <D941D6D8-65E9-42F8-91D4-78129823F742@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef85a8fc-73d3-1413-3d0e-2e36c24e427d@kernel.dk>
Date:   Tue, 18 Jun 2019 13:53:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <D941D6D8-65E9-42F8-91D4-78129823F742@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/18/19 9:20 AM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following fix for md on top of your for-linus
> branch.

Pulled, thanks.

-- 
Jens Axboe

