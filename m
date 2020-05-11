Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677CF1CE742
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgEKVQj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEKVQj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 17:16:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276FC061A0C
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 14:16:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g14so7810134wme.1
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FAFHgWnww6y7ilNVjM1Wj/7u4l8DrkYIaUTd40fDIW4=;
        b=FfJ2UZR0hkLqZcTvaqH3lD423kzlKKkytlgBR9XeAqw4JZVOB4aS1It91+25rLXll8
         9KKLftmDRGy1Gp96RO8kesqXt4Sm13qLnjEh2O18lNb7wLouesvY+zOG9E1lf5sWIL4P
         q5w0mKvluUt/wStYu8lc5M/4pOwFU3rRAb5gpueD7su7VEDakAjpdPqKXBhfjlHAxYhm
         eq1uDeXv6dvphdxRtqvp3ZapaZNOID99PtxCRnPTHzC3MPKz69klzqv0v9+3S7kXykiR
         BeqOG8zDbe09kDW+rBopTr8saAKuJ5KE9Qf7kf415nq460INza/Oajuew6qOitJblYnB
         59vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FAFHgWnww6y7ilNVjM1Wj/7u4l8DrkYIaUTd40fDIW4=;
        b=jiIW9c1cj6kJfk1aFoHp7LFYc2VkyQWng8kRUnIY7xzM96R7h0ESlKwyFPEr5+ojEU
         LbnLE+9XS9E+yCKU2MmbaRKuzM5NrM6v6VOEMEdta/C6w2z47Z3EGY2AB6YWGgabGluR
         j8Q2G6mjIjRUmeiDjPfe0FFSloAev2HuCrS9/SeBwSHckX+WVj6/ZYv5HuYiph9fJo3K
         VYj7LlyZwqiz6Z1uX8nnbeTt5ayauP5jzC/fJpwJ5Mk19qquftd1TGLsuXIv6hm35gWA
         nKwtYZXHnbimwhVXymNE5kMqFnIAJXswqhBeTvkHoCnqPUsNlHl2jNqYuso4ZY7h2fYK
         QE2A==
X-Gm-Message-State: AGi0PuZqButRarp7xVZfXOROxY1Wns07C5BBCzfnzop2QIe7zwyxRsYn
        09qi4iV5iwCD/b1dmj5U8+hBD58uxQLAqA==
X-Google-Smtp-Source: APiQypK7NvRZcCOHfHBgY9V0cpx+9vTb+aM4f02mPL2u56ZnErFBzQzOVlLdiNv1hDnQQe6IBrJZqg==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr36204251wmh.180.1589231796796;
        Mon, 11 May 2020 14:16:36 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48ab:c500:e80e:f5df:f780:7d57? ([2001:16b8:48ab:c500:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id z132sm27223988wmc.29.2020.05.11.14.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 14:16:36 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
 <59cd0b9f-b8ac-87c1-bc7e-fd290284a772@cloud.ionos.com>
Message-ID: <d350c913-0ec6-c1a2-fb41-1fa0dec6632f@cloud.ionos.com>
Date:   Mon, 11 May 2020 23:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <59cd0b9f-b8ac-87c1-bc7e-fd290284a772@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/11/20 11:12 PM, Guoqing Jiang wrote:
> On 5/11/20 10:53 PM, Giuseppe Bilotta wrote:
>> Hello Piergiorgio,
>>
>> On Mon, May 11, 2020 at 6:15 PM Piergiorgio Sartor
>> <piergiorgio.sartor@nexgo.de> wrote:
>>> Hi again!
>>>
>>> I made a quick test.
>>> I disabled the lock / unlock in raid6check.
>>>
>>> With lock / unlock, I get around 1.2MB/sec
>>> per device component, with ~13% CPU load.
>>> Wihtout lock / unlock, I get around 15.5MB/sec
>>> per device component, with ~30% CPU load.
>>>
>>> So, it seems the lock / unlock mechanism is
>>> quite expensive.
>>>
>>> I'm not sure what's the best solution, since
>>> we still need to avoid race conditions.
>>>
>>> Any suggestion is welcome!
>> Would it be possible/effective to lock multiple stripes at once? Lock,
>> say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
>> internals, but if locking is O(1) on the number of stripes (at least
>> if they are consecutive), this would help reduce (potentially by a
>> factor of 8 or 16) the costs of the locks/unlocks at the expense of
>> longer locks and their influence on external I/O.
>>
>
> Hmm, maybe something like.
>
> check_stripes
>
>     -> mddev_suspend
>
>     while (whole_stripe_num--) {
>         check each stripe
>     }
>
>     -> mddev_resume
>
>
> Then just need to call suspend/resume once.

But basically, the array can't process any new requests when checking is 
in progress ...

Guoqing
