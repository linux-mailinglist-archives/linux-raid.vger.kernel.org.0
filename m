Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F9163E38
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 01:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGIXD6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 19:03:58 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:33127 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIXD6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 19:03:58 -0400
Received: by mail-wm1-f52.google.com with SMTP id h19so3427924wme.0
        for <linux-raid@vger.kernel.org>; Tue, 09 Jul 2019 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=87nGqJVXzGzjdJgkoRLBwDJ522il3KbEz2XqyNvHpS4=;
        b=FtpcRNHLPM86O/ieQMXM2tU17eacXYXNWDYqoRQBcTb6PukKMbm9c6VE410RN1qDhN
         fmUdkqpMHvC8T+SQ/fpG3kppaVLn9I5SbnsXT7bYdwgoJ9VThjn/vXYiDoPDcn4ltSd5
         CGfnzwtpGt2+iV4U5QbRjVxLhOYsp50ZArPYP2zpKWN4mT687K0vzI5Maw6AZz86em8Z
         k9M+qauRb6IAjWQ0hmgcif8wM4K6mk3r7Tae38Qixqkljq6l6HoORN/fY6nXV/16qsVK
         xuuITnvQXmXbgvBFTFcNQw+dP0BTpViDfN4osHoTg+dn4DOHF7rFxFmt6AasvlBTFIHk
         x8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=87nGqJVXzGzjdJgkoRLBwDJ522il3KbEz2XqyNvHpS4=;
        b=HUQvnCyeqhQyQC77GQcQ7jJQhBM1QUNEBVD5kWGdD5HSyr1MgGworORHH0SzQL5iiA
         CdU/XJbZU155EF3qRa41jwppac9Hr+hDfv3ELH0cAmZbVT+x7aqMcL2zI7N7PWXZmgvT
         NRlj3EWbHtfDXD0FESJj7kkSXBT5hndYi2nYWZNmDRz1xChPil3JFXbzIIxZjM2bmAXt
         yICoHr04cZxK15fUEjdFw5Qi81Yjn99eCzl1oL0pwhI8QGbAP6mwjSaFQ9w+d1lqDoFm
         SNb9qlbFMiO1JKJis025hjVZQfEhcR9VOR78Y8K9dg0+PdwujpKm0wxajJOthXcjIwlu
         8Fgw==
X-Gm-Message-State: APjAAAXM/rzxShruGkd7mtW0M8NQP/37FcfNP8zZnPxWmVw6Y//te15X
        pOuK9bUJOVryxbk+9epDaPnkjgXGbfY=
X-Google-Smtp-Source: APXvYqzQF+00X5yMoQt9Jw7PUY1D6XtpO5zNFxE8jzQwxqyOryw1t1NEoZavoESYg8eSogB/2QHDVA==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr1721201wml.77.1562713435617;
        Tue, 09 Jul 2019 16:03:55 -0700 (PDT)
Received: from [192.168.1.169] (94-33-52-126.static.clienti.tiscali.it. [94.33.52.126])
        by smtp.googlemail.com with ESMTPSA id b5sm172028wru.69.2019.07.09.16.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 16:03:55 -0700 (PDT)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
From:   Luca Lazzarin <luca.lazzarin@gmail.com>
Message-ID: <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
Date:   Wed, 10 Jul 2019 01:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5D25196A.9020606@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it-IT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/07/19 00:47, Wols Lists wrote:
> On 09/07/19 23:17, Luca Lazzarin wrote:
>> Hi all,
>>
>> actually a server of mine has a 2x1TB Raid 1 array.
>> The disks are becoming old and to avoid possible problems I would like
>> to replace them.
>>
>> Moving from 1TB of space to 2TB could be enough, but since I have to buy
>> the new disks I am considering different possibilities, which are:
>> 1) 2x2TB Raid 1 array;
>> 2) 3x2TB Raid 1 array;
>> 3) 3x1TB Raid 5 array;
>> 4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
>> probably are enough for the next 10 year);
>> 5) 4x1TB Raid 6 array.
>>
>> Which one, in your opinion, would the the best solution?
> What's the price difference between 1TB and 2TB drives? Significant, or
> not much? If the price difference isn't that much I'd go for the larger
> drives every time.
1TB costs 60 euro, 2TB costs 75 euro (WD Red), so the difference is not 
significant to me.
>> Thank you for your suggestions.
>>
> Do you have spare disks to back up on to? The problem with both raids 1
> and 5 is that if you have an error, you don't know which data is
> correct, unless you run a check-summing file system on top or something
> like that. At least with raid 6 you can run a repair utility that will
> try to correct your data.
The data is backed up every hour on a separate NAS (raid 1) and once a 
week on an external HD I bring home.
> Is speed important? raid 1 is probably best. I wouldn't run raid 1 over
> three disks - if you're thinking of that you're probably better off with
> raid 10.
>
> If you want more definite answers than this, though, you're going to
> have to provide more information about how the server is used - is it
> home or business, is speed or resilience more important, what do you
> actually want from the array? Each version has pros and cons.
The server is a business file server where my colleagues save their data 
and access the from their laptops.
Speed is not so much important, I prefer resilience, so the most 
important thing I would from the array is to prevent as much as possible 
data corruption and have a safe place where data is stored.
> Cheers,
> Wol

Thank you,
Luca

>
