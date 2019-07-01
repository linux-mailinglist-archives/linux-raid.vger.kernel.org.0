Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90EE17C9A
	for <lists+linux-raid@lfdr.de>; Wed,  8 May 2019 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfEHOwi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 10:52:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42032 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfEHOwf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 May 2019 10:52:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id d4so743454qkc.9
        for <linux-raid@vger.kernel.org>; Wed, 08 May 2019 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oR87S8WBYmHgl5a+7jWu2q8y1uPVcvlNQs6xTyZfoBs=;
        b=HSJkz+W7UbsM6YFJBlNG8zvAh7hXOdrJWjz0mQIEFX/UdESqZFDUMXnGjqtFr/+ssW
         19UhvMqM6laGrt+bZZhu8l3WzIbsgCapA4BOujeCEPmEnsy4k1TqEY4x6iFS6bguvM33
         q1A217OVdC5ooInkdp92II0oGwFQgbB/2Of33Df5MC4mmk6mpQeariwavEJEWwxrZdpo
         +nOP8vjuM31eB5tBBlHBuKp7DMXbSZl640vQP8iERWmh62mawe2mMn2A5zbXcQB2oDoz
         BW0JNow5oreIEqQzvxkqK+eULht1xMjYpn9iJ2BWvycLe9GetJQYHS3hsGbi0pH+1VEj
         9Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oR87S8WBYmHgl5a+7jWu2q8y1uPVcvlNQs6xTyZfoBs=;
        b=fEUxjbqzr6tPnDC6DmaoW5hNsCq9f9nTDt00+tm4G7Di0WXP9r6aymu0eCJQdiV84i
         aJsSMsEYAyXT6CjmcVTQyNN6omxVcBLMoLxHLcTpsHXCog8kl1tLR59RFGodk2SBlYkR
         I7uc8TGhlT8CAUka3ZMHGaDMxnWgxXqLzJ8t/jWRH3Q3+aiclbXfwfVV3rs4q9LMhsfF
         QsERrsSmRjIubhqDMOuuTL/kEkiLNqcmd8Z0xC87OK7LL3RfgYJiDtaLAepRz7VV0HPJ
         +9vJRBKtarQArKOnOb8dgHmEqQPJatcIl+Pgy11st4Xo9ShORQMbyfUIj60xsTxRtIxA
         K0Pg==
X-Gm-Message-State: APjAAAVLunyFkHBmIqEuLmgQfHfbbAeuLGk6MHrOzfb/bFKtnJ6kJyzR
        Rm6iOAw0d4h4JfbiqYAHUgdgHQ==
X-Google-Smtp-Source: APXvYqyRQBj5ZqXJ0cyRTp/xjLuwux0kH0/Bh97mjgL0YlcRfvD+8QdfWTSo2QE570g+M8jw0/i+mQ==
X-Received: by 2002:a05:620a:166e:: with SMTP id d14mr1999024qko.11.1557327154295;
        Wed, 08 May 2019 07:52:34 -0700 (PDT)
Received: from [192.168.1.10] (201-92-248-20.dsl.telesp.net.br. [201.92.248.20])
        by smtp.gmail.com with ESMTPSA id d127sm8866496qkf.8.2019.05.08.07.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:52:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Wols Lists <antlists@youngman.org.uk>,
        Song Liu <liu.song.a23@gmail.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>, kernel@gpiccoli.net,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
References: <20190430223722.20845-1-gpiccoli@canonical.com>
 <20190430223722.20845-2-gpiccoli@canonical.com>
 <CAPhsuW4SeUhNOJJkEf9wcLjbbc9qX0=C8zqbyCtC7Q8fdL91hw@mail.gmail.com>
 <c8721ba3-5d38-7906-5049-e2b16e967ecf@canonical.com>
 <CAPhsuW6ahmkUhCgns=9WHPXSvYefB0Gmr1oB7gdZiD86sKyHFg@mail.gmail.com>
 <5CD2A172.4010302@youngman.org.uk>
From:   "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Message-ID: <0ad36b2f-ec36-6930-b587-da0526613567@gpiccoli.net>
Date:   Wed, 8 May 2019 11:52:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5CD2A172.4010302@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/8/19 6:29 AM, Wols Lists wrote:
> On 06/05/19 22:07, Song Liu wrote:
>> Could you please run a quick test with raid5? I am wondering whether
>> some race condition could get us into similar crash. If we cannot easily
>> trigger the bug, we can process with this version.
> 
> Bear in mind I just read the list and write documentation, but ...
> 
> My gut feeling is that if it can theoretically happen for all raid
> modes, it should be fixed for all raid modes. What happens if code
> changes elsewhere and suddenly it really does happen for say raid-5?
> 
> On the other hand, if fixing it in md.c only gets tested for raid-0, how
> do we know it will actually work for other raids if they do suddenly
> start falling through.

Hi, I understand your concern. But all other raid levels contains 
failure-event mechanisms. For example, in all my tests with raid5 or 
raid1, it first complained the device was removed, then it failed in 
super_written() when no other available device was present.
On the other hand, raid0 does "blind-writes": it just selects the device 
in which that bio should be written (given the stripe math) and change 
the bio's device, sending it back via generic_make_request(). It's 
dummy, but not in a bad way, but rather for performance reasons. It has 
no "intelligence" for failures, as all other raid levels.

That said, we could fix md.c for all raid levels, but I personally think 
it's a bazooka shot, only raid0 shows consistently this issue.

> 
> Academic purity versus engineering practicality :-)

Heheh you have good points here! Thanks for the input =)
Cheers,


Guilherme


> 
> Cheers,
> Wol
> 
