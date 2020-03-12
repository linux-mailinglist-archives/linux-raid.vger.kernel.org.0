Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAEAC1827F7
	for <lists+linux-raid@lfdr.de>; Thu, 12 Mar 2020 05:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbgCLExw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Mar 2020 00:53:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37056 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgCLExw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Mar 2020 00:53:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id b3so4741495otp.4
        for <linux-raid@vger.kernel.org>; Wed, 11 Mar 2020 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=klcHwOWhllB7Tz6IM+6tTZs6ZYwFuHvHYT96jzoy3Tg=;
        b=Wu5ZUSfvYUs45ewb1yS+wMu2PLL66hakn+WQgIa2MHY68MHPhO2Hh61Y6Zxl0f2j9D
         7H61BM5kHPZYxp6e6iTap9UB2rcwuHiR6YrDGpCQxrx/gDZQkPvsNV8uFI1pnsklzRAr
         fQyQAN0wSjvhFM/TFAw13sVAlMn5MCyXkX0j5+igNDMVQQXOA4NBX9gza8v2YgHnWvjp
         sQX9OU/sbP5YgoQx/cSLmY9aECOtLrp59+xADlt7IUhdoyGw+abz8XFMY0jFurjufEuk
         5ovCdBQKol2n39f5JPN3GiEoWjiNixGjHNCr32/IZ7di5fmhVmbRjkPN//clUuRS+CU4
         hXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=klcHwOWhllB7Tz6IM+6tTZs6ZYwFuHvHYT96jzoy3Tg=;
        b=AdFoh+NaWKtEDg2I8kmuTzFE7ZvZ5rl1BeIjiEy8URu/npeo5vXFDHlMPwSUxuHcrv
         GZVLuHkvIH3ah3mWGe6CcyHavhJRWAz8gSjveualCF+hSJvjX6TRoMurc2rrxM42Dybb
         aJ0lnKnUYGCChKiEEtGjB9z2YOgXwRquoR3IC+/kTvVMIS2YiI3B0/U/xBRNX8VzXk0r
         8FxmJOKsM+fsB4t4YNYRF4ibkW/CINWvNAFpjUdA++fTdNT5NZAJY4Z44N+A/XyyLra7
         roa2DLUZcBv8Gpx2cbqjLsL9radge19bCIXEwxFc/PGP47Nx4unHc18/7e9u4RbUJQbt
         pukA==
X-Gm-Message-State: ANhLgQ1jR5Y4qLd1t5VVmsBmslSrHyTdUwx6+nw4PWHAR7EMYOPlK2Ui
        8tMhEeatEpetYsioN1sa1g0GBX+1
X-Google-Smtp-Source: ADFU+vvZtrjLdmHWvAQWe7BgTAdgr6pTY/hjs7YWSaxTR1VuYKTgWY4a7OfgeKKMa+/w6cMpyp1w2A==
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr5113302otm.92.1583988831045;
        Wed, 11 Mar 2020 21:53:51 -0700 (PDT)
Received: from [192.168.3.59] ([47.187.193.82])
        by smtp.googlemail.com with ESMTPSA id y13sm17990146otk.40.2020.03.11.21.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 21:53:50 -0700 (PDT)
Subject: Re: checkarray not running or emailing
To:     Leslie Rhorer <lesrhorer@att.net>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
 <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
From:   Ram Ramesh <rramesh2400@gmail.com>
Message-ID: <f4d8ab8d-90cb-e9d0-3b15-ceab881dfcc1@gmail.com>
Date:   Wed, 11 Mar 2020 23:53:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This may be a silly question, but is email working in your system?

I run debian, but a different version. Cron only sends me a message when 
something is wrong. I mean if checkarray failed, I get a message. If my 
array is degraded, I get a message. If everything is fine, no message. 
May be that is the standard. I am not the authority, but that is what is 
happening in my system.

I believe cron emails stdout+stderr of the command run. May be 
checkarray does not output anything in a successful run and therefore no 
email.

It is best to also query debian.user email: debian-user@lists.debian.org

Ramesh

On 3/11/20 8:41 PM, Leslie Rhorer wrote:
>     Aha! There it is, on both the old and new systems, so it probably 
> is running.  The question remains, "Why isn't it posting to email?"
>
> On 3/11/2020 7:50 AM, Brad Campbell wrote:
>> On 11/3/20 09:11, Leslie Rhorer wrote:
>>>      Is there seriously no one here who knows how checkarray was 
>>> launched in previous versions?
>>>
>>> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>>>>     I have upgraded 2 of my servers to Debian Buster, and now 
>>>> neither one seems to be running checkarray automatically.  In 
>>>> addition, when I run checkarray manually, it isn't sending update 
>>>> emails on the status of the job.  Actually, I have never been able 
>>>> to figure out how checkarray runs.  One my older servers, there 
>>>> doesn't seem to be anything in /etc/crontab, /etc/cron.monthly, 
>>>> /etc/init.d/, /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that 
>>>> would run checkarray.
>>>
>>
>> On mine it's in /etc/cron.d/mdadm
>>
>> brad@srv:/etc/cron.d$ cat mdadm
>> #
>> # cron.d/mdadm -- schedules periodic redundancy checks of MD devices
>> #
>> # Copyright © martin f. krafft <madduck@madduck.net>
>> # distributed under the terms of the Artistic Licence 2.0
>> #
>>
>> # By default, run at 00:57 on every Sunday, but do nothing unless the 
>> day of
>> # the month is less than or equal to 7. Thus, only run on the first 
>> Sunday of
>> # each month. crontab(5) sucks, unfortunately, in this regard; 
>> therefore this
>> # hack (see #380425).
>> 57 0 * * 0 root if [ -x /usr/share/mdadm/checkarray ] && [ $(date 
>> +\%d) -le 7 ]; then /usr/share/mdadm/checkarray --cron --all --idle 
>> --quiet; fi
>>
>> dpkg -L mdadm gave me a list of files and I just checked the cron 
>> entries.
>>
>> I don't run anything that recent, but Debian is Debian.
>>
>> Brad

