Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD6C006C
	for <lists+linux-raid@lfdr.de>; Fri, 27 Sep 2019 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfI0Hum (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Sep 2019 03:50:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38161 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfI0Hum (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 27 Sep 2019 03:50:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id l21so1505304edr.5
        for <linux-raid@vger.kernel.org>; Fri, 27 Sep 2019 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h/UcW4S5I6yp7Esz3GTpHspwjrTFQP9oXcmlGhg81CY=;
        b=hPibMgcxi3VKtDS/AXAfH92EFxSTf46u8179Hp6VA0xZ8rW17e9zu/WtfXqJFeceqm
         VdsacxIKBCa8Flfu21wNafeZg5w9Ln4P5vEa0o6KsuK8gfW3bQchQefliifAnvJi0qnL
         1V4cInvYehp1IOpVINa6zGsRA2jtinVaXBLl862KwhgERotkYDeeO/YCDTpzQCMdFTaH
         AXV/SMXnmp5UsUvlInoQnrDiiShpnEcGZUsV1XsBDnMNZHIWWfi9Qn2J3T+ZjAxfFYp4
         sgVGzk3BXerkZlwp9g1U+BXixQzifMPMt9JAo8SRsTFSv00HWJ7Qm5lV31u7qo+FvqrW
         +mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/UcW4S5I6yp7Esz3GTpHspwjrTFQP9oXcmlGhg81CY=;
        b=hqbhaSWclp5cdazN9CLxyL1VrB1wXC1IAGHwF8wmleAKNVhKQGaD3IudkUmvn72dDv
         Y2pBNi9s5cz6b6IQH4EhWNvYDgr7SFhr5VOvkm6KGcTNb6x49/oPdMO31IkOeXnV0HIp
         H7/z6ZfyNpYa4m20z4I3pF2gO4VGE7CSg8YkUe9+y7KErswb0c2lZS+kqkQg6spcbIMK
         OAVFpXMbiOHLFsxqCm5nvryZRygLZk8cX6YiDx5V/kRbhr/dwD9tvdYH2yCYZe3MxxDD
         3TZv8pROZ1ihYFG3MRoWXc3IXWwXH2/htdq3Ed7ThHGuPGhMteqVzPXCMscheIXz9B1/
         yb4w==
X-Gm-Message-State: APjAAAVb0Fb+7rv2SxfYp+1m4EgQfYZiqfGE8VBQt8OGcUavF/Ily1Oi
        F/ddPC5EicttOXO/aOaC49r0Lpho1H0=
X-Google-Smtp-Source: APXvYqx1mBGGYzH5DpufHA7vAkVKMFWC8BCtXeMagjIAWxSRtB6J5ySKR7khkOaguD8YhlcgGYQ+kQ==
X-Received: by 2002:a50:9f42:: with SMTP id b60mr3088528edf.192.1569570640383;
        Fri, 27 Sep 2019 00:50:40 -0700 (PDT)
Received: from [192.168.1.101] ([85.184.169.251])
        by smtp.gmail.com with ESMTPSA id b7sm356568eda.67.2019.09.27.00.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 00:50:39 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH,v2] mdadm: check value returned by snprintf against errors
To:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
Cc:     "Smolinski, Krzysztof" <krzysztof.smolinski@intel.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Dabrowski, Mariusz" <mariusz.dabrowski@intel.com>
References: <20190816090617.12679-1-krzysztof.smolinski@intel.com>
 <d540ec64-ffb2-dab1-c792-f088594330c2@gmail.com>
 <14012545.AkVXcDBcQu@mtkaczyk-devel.igk.intel.com>
Message-ID: <5af61a91-33bb-ce00-378d-0b5eb844a137@gmail.com>
Date:   Fri, 27 Sep 2019 03:50:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <14012545.AkVXcDBcQu@mtkaczyk-devel.igk.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Mariusz,

Sorry for the silence. I got the access sorted, but I have been 
traveling since Linux Plumbers. I will be back home on Monday so feel 
free to fire away and I'll do my best to catch up when I am back.

Cheers,
Jes

On 9/24/19 8:15 AM, Tkaczyk, Mariusz wrote:
> Hi Jes,
> 
> Did you setup new key? We had some patches to send upstream.
> Also, some patches are waiting for your feedback.
> 
> Please let me know when you will be ready.
> 
> Thanks,
> Mariusz
> 
> On Friday, August 16, 2019 4:08:38 PM CEST Jes Sorensen wrote:
>> On 8/16/19 5:06 AM, Krzysztof Smolinski wrote:
>>> GCC 8 checks possible truncation during snprintf more strictly
>>> than GCC 7 which result in compilation errors. To fix this
>>> problem checking result of snprintf against errors has been added.
>>>
>>> Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
>>> ---
>>>
>>>   sysfs.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> Applied thanks!
>>
>> Note my ubi key fried itself so I need to setup a new one before I can
>> push to kernel.org.
>>
>> I am glad to see some of this addressed, but the problem is much bigger.
>> We need to fixup super-intel.c to build with gcc 9, not just gcc 8. I
>> did a bunch of stuff, but the bigger problems remain. I am not a huge
>> fan of just hiding it via typecasts, I'd like to see a proper solution.
>>
>> Cheers,
>> Jes
> 
> 
> 
> 

