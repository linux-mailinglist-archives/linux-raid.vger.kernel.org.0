Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED120AE6A
	for <lists+linux-raid@lfdr.de>; Fri, 26 Jun 2020 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgFZI2h (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 26 Jun 2020 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZI2h (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 26 Jun 2020 04:28:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B3C08C5C1
        for <linux-raid@vger.kernel.org>; Fri, 26 Jun 2020 01:28:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id mb16so8549166ejb.4
        for <linux-raid@vger.kernel.org>; Fri, 26 Jun 2020 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P/0aOHBoDfj+7LhWBQveCRZn8to5Jyh8HdemG9DGO5M=;
        b=fD6ipPfUnelhdTxkptIh9nr/I2a1aZmsV8A8qdTxbDL76I9TtqW+4CG5h5CZKB2Ay8
         NdJ9WOWnVVLGSa+85KnaKTILmL4sWD3LqIfGBs7MMsLJT5oyuNkytwHSQnaUFKZJD3mb
         EEpq88Knov5yS8tHcn9qGdm5sGRwX/6aw1IY3nRNt1AZjrDAAgiJ8v80oiWtWVBUO/4j
         2q7Iqxa2Q9MQSqYDhMeW+zu8/DLrlNAbUwaUi4wCSqziy2GOrnNsPc/dWvxA9Gj5nDZE
         jVQkZgcSlsg6zwNyemnPdH+N2an//VOC8hAajuUU20/S5lzyoARzJJkWmNcyNnpceqxt
         AYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P/0aOHBoDfj+7LhWBQveCRZn8to5Jyh8HdemG9DGO5M=;
        b=sx2ELOlCGliL2id+7D4Aq2xSOchacRjQjqqSVYROUYdV2LA1KQjXs9MMqlCEyNoCgL
         nDLnnF39wk8tqMizt0uaOBkXka4ASdSMv0irw7EtMvfzuvrXix0H/V7omS7Tw+RGErF4
         Zq8/vSu4a0ANLQlBKzFwgpKec043ccsNNRZhALDs6Uh8gU3IqGd9UqSLwxgLvce2KqiU
         Lavq0iTz/JROO4iT4kIHVXJBNi22MCc5tPFQ2uVxepd0TaHJl/zwJy08I1Vay1WtSsuV
         vR6qUbxYMESWgPDoG3/eAPUvyKSkntORSDX9Gre3AtLB3Fyz5fTyKPqKVMeErBfltMLH
         Jp4g==
X-Gm-Message-State: AOAM530/uvAV98C06K5EO20HX82yxLSyBzTW8IUomtaxQD4anLtMynjk
        r3L9bCDHYAnpE9J5jeHFzlngojA0fIoMKQ==
X-Google-Smtp-Source: ABdhPJzak2xQBjNIE6pJDstgdT/NywfTkB67lLrIdrWFUBB2gNH1EtzZ60lnVtdLPpNbv1qrY8yLeQ==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr718887ejc.430.1593160115428;
        Fri, 26 Jun 2020 01:28:35 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2c7e:3133:c079:e098? ([2001:1438:4010:2540:2c7e:3133:c079:e098])
        by smtp.gmail.com with ESMTPSA id f17sm6382463ejr.71.2020.06.26.01.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 01:28:34 -0700 (PDT)
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>, Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
 <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
 <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b9f00119-3abf-7130-5f9c-23fa0a1cf2bc@cloud.ionos.com>
Date:   Fri, 26 Jun 2020 10:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 5/14/20 1:07 PM, Michal Soltys wrote:
> On 5/13/20 6:17 PM, Song Liu wrote:
>>>>
>>>> Are these captured back to back? I am asking because they showed 
>>>> different
>>>> "Events" number.
>>>
>>> Nah, they were captured between reboots. Back to back all event 
>>> fields show identical value (at 56291 now).
>>>
>>>>
>>>> Also, when mdadm -A hangs, could you please capture /proc/$(pidof 
>>>> mdadm)/stack ?
>>>>
>>>
>>> The output is empty:
>>>
>>> xs22:/☠ ps -eF fww | grep mdadm
>>> root     10332  9362 97   740  1884  25 12:47 pts/1    R+ 6:59  |   
>>> \_ mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdi1 
>>> /dev/sdg1 /dev/sdj1 /dev/sdh1
>>> xs22:/☠ cd /proc/10332
>>> xs22:/proc/10332☠ cat stack
>>> xs22:/proc/10332☠
>>
>> Hmm... Could you please share the strace output of "mdadm -A" 
>> command? Like
>>
>> strace mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/xxx ...
>>
>> Thanks,
>> Song
>
> I did one more thing - ran cat on that stack in another terminal every 
> 0.1 seconds, this is what was found:
>
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
> cat: /proc//stack: No such file or directory
> [<0>] submit_bio_wait+0x5b/0x80
> [<0>] r5l_recovery_read_page+0x1b6/0x200 [raid456]
> [<0>] r5l_recovery_verify_data_checksum+0x19/0x70 [raid456]
> [<0>] r5l_start+0x99e/0xe70 [raid456]
> [<0>] md_start.part.48+0x2e/0x50 [md_mod]
> [<0>] do_md_run+0x64/0x100 [md_mod]
> [<0>] md_ioctl+0xe7d/0x17d0 [md_mod]
> [<0>] blkdev_ioctl+0x4d0/0xa00
> [<0>] block_ioctl+0x39/0x40
> [<0>] do_vfs_ioctl+0xa4/0x630
> [<0>] ksys_ioctl+0x60/0x90
> [<0>] __x64_sys_ioctl+0x16/0x20
> [<0>] do_syscall_64+0x52/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> cat: /proc//stack: No such file or directory
> [<0>] submit_bio_wait+0x5b/0x80

Just FYI. I recalled that long sync IO could fire the warning in 
submit_bio_wait.
Have you applied the commit de6a78b601c5 ("block: Prevent hung_check
firing during long sync IO")?

Thanks,
Guoqing
