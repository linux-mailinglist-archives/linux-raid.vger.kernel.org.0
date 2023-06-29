Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB2742E23
	for <lists+linux-raid@lfdr.de>; Thu, 29 Jun 2023 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjF2UFq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Jun 2023 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjF2UFp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 29 Jun 2023 16:05:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D81FC0
        for <linux-raid@vger.kernel.org>; Thu, 29 Jun 2023 13:05:44 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77dcff76e35so17498639f.1
        for <linux-raid@vger.kernel.org>; Thu, 29 Jun 2023 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688069143; x=1690661143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4tq5eP75MWhv6841WPIqTGQTd0wmAvIyZR6YMM91cU=;
        b=kt4y6BEf8FjwOMV3pk/CMHocQI2zxrK/0DPy8nfGhKmxrGsb65ZnyBk+RzELx7IxdD
         04Ssa46bdvqfxULj03WxMa9fcLlxSY63jScz96ALYVx09vgtscokAI9SfKbVWv4H7PYj
         gyiiqBnpaQCX4E9KDfK1xQyoOQdI0XQF7unrkr6IlDkz4WUDKDAbUL8X/oBFXev85tpn
         aMDqQMNCAMTRTqS01YP3lvh4K737d+lAlgczZoU1zxUTUZmk8R5INS1HnSgkB6mHnQ/j
         AvGcSR7A01zpQXCkY/TiqTwvZ4zJmhORcCgYf0//mnUBMXqCkfX9vfyV2HBbLpc/oTYL
         scKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688069143; x=1690661143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4tq5eP75MWhv6841WPIqTGQTd0wmAvIyZR6YMM91cU=;
        b=cWiMKn8+NavRaAb7O7sa9Yjx9uI33+xAhozf3OGh3BB2u2Qny0QRO1TGptpw9gNRpl
         2s1FUBSao20cD6IM1v0LfvcRgp0Fz3VpP0/kWX9eXuR2QQytCWDpDdBUO6hg6l+kUYAy
         uZ22+ROXVQZ/wGek4iC8SlXGJ3+1xeGqu70lD8CdX6tzIsKOQyb6FOawqj6Z+8IwrGLT
         A7Q4H34RWoSD0mjkKeR42t/D+twFOsx7BtBLsy1M/EoPXP/fa+pv6G1GvMdDGMiurJ1c
         IS9ttf3W8MW3uVa60QnhdJZwcKLd4JfgzTh7s+/J8NKFw+Dcur4NdfDtbO6cuO+X16de
         CiBw==
X-Gm-Message-State: AC+VfDwrl7M0AjrhqhbNWu5EsbkeALx+s/1IvQLPpIFXRIM2CawjgUqU
        yjxYnQKd5Z9Fy0+Q2UyZT9HzDg==
X-Google-Smtp-Source: ACHHUZ7pGQ6LKbesXl3hlbRX1AckZ5mzpygexKjVW7CU51oKAJKLyAWwhk1jdwG4cE4v0XY9sALCiw==
X-Received: by 2002:a05:6602:3e94:b0:783:5df5:950d with SMTP id el20-20020a0566023e9400b007835df5950dmr579213iob.1.1688069143431;
        Thu, 29 Jun 2023 13:05:43 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t5-20020a02cca5000000b0042aca9978c6sm2865041jap.0.2023.06.29.13.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 13:05:42 -0700 (PDT)
Message-ID: <d6130a0c-5d91-b0a3-f6a9-d1fa6edbba92@kernel.dk>
Date:   Thu, 29 Jun 2023 14:05:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: mainline build failure due to 8295efbe68c0 ("md/raid1-10: factor
 out a helper to submit normal write")
Content-Language: en-US
To:     Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ZJ2H5FWuo9oDMgPm@debian>
 <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
 <13abe42f-2f5f-cbaf-21b8-baa4516963aa@leemhuis.info>
 <CAPhsuW4Wf+PLDCZ7JpHzVT81ubj1Y6MCyLm-BWcVmB1jRqYEGg@mail.gmail.com>
 <CAPhsuW7VK6O6RKQTAcAVk4XxUzNALUW5nKMnMFkm3pW+4F23yw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPhsuW7VK6O6RKQTAcAVk4XxUzNALUW5nKMnMFkm3pW+4F23yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The late branch will go out some time next week.


On 6/29/23 9:56?AM, Song Liu wrote:
> Oops, didn't really add Jens in the previous email.
> 
> Add Jens now.
> 
> On Thu, Jun 29, 2023 at 8:55?AM Song Liu <song@kernel.org> wrote:
>>
>> + Jens,
>>
>> On Thu, Jun 29, 2023 at 7:10?AM Linux regression tracking (Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> On 29.06.23 15:56, Yu Kuai wrote:
>>>>
>>>> ? 2023/06/29 21:32, Sudip Mukherjee (Codethink) ??:
>>>>> The latest mainline kernel branch fails to build x86_64, arm64 and arm
>>>>> allmodconfig
>>>
>>> Thx for the report.
>>>
>>>> Thanks for the testing, which branch are you testing?
>>>>
>>>> This problem is already fixed in latest mainline kernel:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b5a99602b74bbfa655be509c615181dd95b0719e
>>
>> Hi Jens,
>>
>> The fix is in the for-6.5/block-late branch.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.5/block-late&id=b5a99602b74bbfa655be509c615181dd95b0719e
>>
>> Would you send a pull request with it? Or would you prefer
>> some other solution for the issue?
>>
>> AFAICT, it will fix clang build with RANDSTRUCT.
>>
>> Thanks,
>> Song
>>
>>>
>>> And thx for the reply. :-D
>>>
>>> FWIW, that fix afaics is still in -next and hasn't reached mainline yet.
>>> But I guess that will change within a few days.
>>>
>>>>> #regzbot introduced: 8295efbe68c080047e98d9c0eb5cb933b238a8cb
>>>
>>> #regzbot fix: b5a99602b74bbfa6
>>> #regzbot dup-of: https://lore.kernel.org/all/ZJ2M4yqnOCqqGWH0@debian/
>>> #regzbot ignore-activity
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.

-- 
Jens Axboe

