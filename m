Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0368C1CE72F
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEKVMh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEKVMh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 17:12:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5FEC061A0C
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 14:12:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 50so12256225wrc.11
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IDTEr2rk2BHAVKS7F5W3mPRL7Pdr8jH7K74SqILTX7E=;
        b=NG2GyUWVMuHFr8ZNZdorBBEI7G3YhSvFF9OW/XNhmSyTwtgDQvBEao+AMdlY1oMHav
         VXKoAlqdcNXxKSnTrov4KwrKEW0kmxGgppG70WWzZip970i8d0x7BEzO4M1lpvSq4pgg
         qU7bFXWBPdgoR/SfqvGp0KI1GDj5O8uPoBZOlm2ommQb1fELiAxDKQdu7sp8PVi9U+4n
         tlmVKgm8tTxO5Ao5V/t3Me0Ly/PUqeMPbky85R5bNae+d+fDkF4StdxAToWfrpqnY3wZ
         hP2q48DPA/DRNfAiBfMG2q4z9+X83Zkn8soGl59GP7BlFG4rv/TsSQMFxIcazsi5hrfw
         nYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IDTEr2rk2BHAVKS7F5W3mPRL7Pdr8jH7K74SqILTX7E=;
        b=PWkKA/EmM3RPIpFq8as7OAQoU9Mg3zLM7L0SO+1eJNTw2hC5vSBWQLEkIGh5ISrMi8
         evkwVOV///yNqk5za6a6fzLVm1AoSzfvocUyNsYqVWSRqa3eBWS0OCx7YKJg64XMeb6p
         YMYtanmvev82s2OJ0D0/+c57+NgjYskgI+oaJ3ZvSW9wQImGCdWQp2ARsM+/djoWcXbP
         MGgkt8CtfBKo/ax1bKD9dsngxV6GJQuICcbakXE6mEbuPNYUA+4qQVdUVcykOLjoG1VA
         zYc2ADWaG7TvILJMlM8S+B7C0tFS/Nu/PFmiSMWjJSovy6NIBe6BwIp1m5UMlqjc2yGL
         HVNA==
X-Gm-Message-State: AGi0PuZg8TonO2nkc2klTWT3k+R658Byyabxovu1tfpkAP7MwxSMezRa
        cYx8mpty80u9ZdVp3WBuUpdl6yfdOSJGbg==
X-Google-Smtp-Source: APiQypLgyu/NGf/7zabJsfYpg65DGHZ/jUi0N/MOSN1FAdel7yApUgNoIryy89153HOL0x/K1WG+wg==
X-Received: by 2002:adf:e28c:: with SMTP id v12mr23208395wri.157.1589231554575;
        Mon, 11 May 2020 14:12:34 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48ab:c500:e80e:f5df:f780:7d57? ([2001:16b8:48ab:c500:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id h137sm37007452wme.0.2020.05.11.14.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 14:12:33 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <59cd0b9f-b8ac-87c1-bc7e-fd290284a772@cloud.ionos.com>
Date:   Mon, 11 May 2020 23:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/11/20 10:53 PM, Giuseppe Bilotta wrote:
> Hello Piergiorgio,
>
> On Mon, May 11, 2020 at 6:15 PM Piergiorgio Sartor
> <piergiorgio.sartor@nexgo.de> wrote:
>> Hi again!
>>
>> I made a quick test.
>> I disabled the lock / unlock in raid6check.
>>
>> With lock / unlock, I get around 1.2MB/sec
>> per device component, with ~13% CPU load.
>> Wihtout lock / unlock, I get around 15.5MB/sec
>> per device component, with ~30% CPU load.
>>
>> So, it seems the lock / unlock mechanism is
>> quite expensive.
>>
>> I'm not sure what's the best solution, since
>> we still need to avoid race conditions.
>>
>> Any suggestion is welcome!
> Would it be possible/effective to lock multiple stripes at once? Lock,
> say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
> internals, but if locking is O(1) on the number of stripes (at least
> if they are consecutive), this would help reduce (potentially by a
> factor of 8 or 16) the costs of the locks/unlocks at the expense of
> longer locks and their influence on external I/O.
>

Hmm, maybe something like.

check_stripes
	
	-> mddev_suspend
	
	while (whole_stripe_num--) {
		check each stripe
	}
	
	-> mddev_resume


Then just need to call suspend/resume once.

Thanks,
Guoqing
