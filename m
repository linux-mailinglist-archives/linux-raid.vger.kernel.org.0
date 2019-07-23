Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2331720D8
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 22:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbfGWUet (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jul 2019 16:34:49 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37883 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfGWUet (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jul 2019 16:34:49 -0400
Received: by mail-wm1-f43.google.com with SMTP id f17so39600218wme.2
        for <linux-raid@vger.kernel.org>; Tue, 23 Jul 2019 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lR7YcApkdgd1ZOPcqdL62zC4nG/DvjWSnXdTisM//Pw=;
        b=dQH3WTa53i08CdXRHwjWRj7uQEsqs5TOr/wj5/fRkjjaSzXE95e16UAxs3RIRwhOc9
         M+8R4lIDzgT/9eSoziVHDBHLyKJj1YLTM/Z0R4dk00s6/Quvsl+pTtcX2pkbhMFLrLbY
         LgiS5rJGNNFkQo4ZIqcCo3N7Zt9xBdmBWKtYIELiQy4mPdiS+RIBFgfUPJdPSxijFPaG
         S78rshuBDlmlZNRX+X9XohMrPRzHhJUAnKIfgk0BwnN8vak9WhqnjwRQvsE0zRe+UFQI
         jFCDOIw81DsKSb9Y8ke71bfb18MHwrCY/EHxc2yYpurU1/1gsqUsckWydPz7/00e5lgM
         OxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lR7YcApkdgd1ZOPcqdL62zC4nG/DvjWSnXdTisM//Pw=;
        b=WxRtUnBgWNqYHT/Ejs6+jsh9/4Mwrl0dbFn5FaxikiCCaCxV5QKlZ+Zmxngw/PmfEV
         TiHg8PrthObnjjGZenE7rIxZlDVm6WpAD4D2TzmP8gLWySo0x4VnXzHa7mUy64Dt/qIn
         iFfBqirW+wZBoacogV/zkiwPTyH9cMiay0kVVlNiU0+E+VudLhy6XZDVyrypgXSz1QyW
         1+KnG/G3RwhABfntz7y837Iy4CKGFV6PqJpSy2jam5j0CLz5zbxwUNxym0WmdGdg1keF
         fuzgIxaFBFgokZAGMOslu6ZWV9RVypq15vixiYtGKKo7VvKWtvShjH2L5vviAAbfozeh
         ZFzA==
X-Gm-Message-State: APjAAAWz30z7t3lR8yZRADjeV32J6PBczPBH18X6iL4dI/C9paKcyk0r
        uT9Nc7KoPNpS+n143HY6VTYqiItgN5Q=
X-Google-Smtp-Source: APXvYqxMbET3nvGn8KPTi1KNTFVf77ohSV7/l+KqTAOJDDIvDlYoehmpoYVU1yi6fLmqI6Exaai07g==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr18086889wmf.47.1563914087238;
        Tue, 23 Jul 2019 13:34:47 -0700 (PDT)
Received: from [192.168.1.169] (94-33-52-126.static.clienti.tiscali.it. [94.33.52.126])
        by smtp.googlemail.com with ESMTPSA id x20sm98108338wrg.10.2019.07.23.13.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:34:46 -0700 (PDT)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Wol's lists <antlists@youngman.org.uk>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Xiao Ni <xni@redhat.com>
Cc:     linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
 <5D25A4A4.2000609@youngman.org.uk>
 <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
 <20190710173354.GA5523@lazy.lzy>
 <08871cf8-8ae7-cde1-7b45-0d75fe42026e@gmail.com>
 <1a8b3284-1338-9165-6359-5fdc71430b22@youngman.org.uk>
From:   Luca Lazzarin <luca.lazzarin@gmail.com>
Message-ID: <6359befe-4287-8ca1-b411-5dd907c9e262@gmail.com>
Date:   Tue, 23 Jul 2019 22:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1a8b3284-1338-9165-6359-5fdc71430b22@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it-IT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I do not know it. Could you please link me to some infos?

Why do you suggest it?
I mean, which benefits will it give to me?

Thanks :-)

On 23/07/19 22:30, Wol's lists wrote:
> On 23/07/2019 21:16, Luca Lazzarin wrote:
>> Thank you all for your suggestiong.
>>
>> I'll probably choose RAID6.
>
> Any chance of putting it on top of dm-integrity? If you do can you 
> post about it (seeing as it's new), but it sounds like it's something 
> all raids should have.
>
> Cheers,
> Wol


