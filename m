Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB172094
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfGWUQu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jul 2019 16:16:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38485 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfGWUQu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jul 2019 16:16:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so18222914wmj.3
        for <linux-raid@vger.kernel.org>; Tue, 23 Jul 2019 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2WsgsmBVjLzoPVMUZCkvAGx6o9mQZXx0m7kqx4DdgZA=;
        b=Y1mYUPxJ4gYeAmETeT0tceNEkr3Ys366jweDbzw2IZYuD3Qsk0EfpwPJ9b3NiD4EBP
         mTbYJzYuGoolByAl4al9TlEC6OSCFD7HpOjouRt6LDNhhIviU0XRHrFO+7yFvyWZO+Er
         20AqNXP3FXAN1AUcbSJs+/kHSoZe7brdIFmRM9JisMWKgbPZH5XDGawvWm4CXAvQ5xMN
         sqqIleHrJgDK0tgLhmNkrqEXySpJ3bD6agLNPLCEVmwggi+xxjTHbyi7GnroAUFKgPBP
         AnTQPzl/xeUPeAsDgQGO/0fWw1BS5FJUoeBP+Cg41QicVxNg95kPRfhVcP2m8eT/f0EK
         ZDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2WsgsmBVjLzoPVMUZCkvAGx6o9mQZXx0m7kqx4DdgZA=;
        b=s5DedwuP44Z6KjaJHe5z5q6Yh1iakrcFfj8miwvlN5E14y2SJTW0uQRwDDnSuwfG+8
         9yQf5fxcI0F8g0RGb7kpjHYidR3QmcACb8xz57hefRLSeJd/652Pvb1H0czEbWpiE+Cn
         nGiK/PsAJVDxOuyjm2elA5/gqPtfliXCMQPHwMknQzMFnO7krFxG6ZhtZxPhb86Jfdl/
         3329kEcNtwUK3xogVYHs5MB2T/68+hL/1PU5MXPrX+oxcXR19gAobbKZJqAsbCejG5pJ
         bcvaYWfg7eVrVuJucMUoxdldTUz43Z+5mdWAtJ79+n9JLU3sgao4ccTu/AlTS3teKDtZ
         U6IQ==
X-Gm-Message-State: APjAAAXVs1oUl203buNev3JUai225rwqS59qAWlyS6VpwWrTNUtDeLZ6
        eTnow8B8N5rERPwgStbVcCw4e5y2uvg=
X-Google-Smtp-Source: APXvYqyu24ceDfVC02J386rpg3+tPgXo0cFqX7CCP8Gkkj1P2B+uF2wcRjWmePxpbb9ZVqZ1bXxMqg==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr67573212wmc.168.1563913007571;
        Tue, 23 Jul 2019 13:16:47 -0700 (PDT)
Received: from [192.168.1.169] (94-33-52-126.static.clienti.tiscali.it. [94.33.52.126])
        by smtp.googlemail.com with ESMTPSA id f2sm37154628wrq.48.2019.07.23.13.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:16:46 -0700 (PDT)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Xiao Ni <xni@redhat.com>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
 <5D25A4A4.2000609@youngman.org.uk>
 <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
 <20190710173354.GA5523@lazy.lzy>
From:   Luca Lazzarin <luca.lazzarin@gmail.com>
Message-ID: <08871cf8-8ae7-cde1-7b45-0d75fe42026e@gmail.com>
Date:   Tue, 23 Jul 2019 22:16:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190710173354.GA5523@lazy.lzy>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it-IT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thank you all for your suggestiong.

I'll probably choose RAID6.

On 10/07/19 19:33, Piergiorgio Sartor wrote:
> On Wed, Jul 10, 2019 at 04:46:35PM +0800, Xiao Ni wrote:
> [...]
>> Yes. I learned about this from this article
>> https://securitypitfalls.wordpress.com/2018/05/08/raid-doesnt-work/
>> As this article pointed, raid6 has problem to support this. The patch which
>> I sent recent should fix this problem.
> Interesting article.
>
> In any case, RAID-6 offers a way to find this
> type of unreported errors, albeit pro-actively.
>
> "raid6check" implementents the considerations
> of H. Peter Anvin in the paper:
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/hpa/raid6.pdf
>
> Silent errors can be detected, in which drive,
> if one only is present (per stripe).
>
> bye,
>

