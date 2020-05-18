Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360B81D8033
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgERRd6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgERRd5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 13:33:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA2C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 10:33:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so323009wmb.4
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mbBiDnvi1QHic7u2XHdXs3X/8TvkN588xU69B+27Y38=;
        b=dAUIlDps4Wb6tgBP5WYEIcGnPDemSfjqH9j1MuvR5CmFomzoMFeIIF20uUB+2O1ieT
         uiZHnMwvRHmApCgs11nIC3ZCNoccstunCZkj2h+BMAyztxlK+XR+6M0iqA94lRJ5iStq
         stOgpT7ME3yZ5Cq/BmROmw/SEyHIeE49cUq+hHRfMJKAxuoLpoigrbbmZBwhYKHuphLw
         WP/PIBUvr49AR8xDtJ0i8+GJEBzy2mInRz7LpA7wtdqyujSI7Y9NGrnD9j58oHWCxj28
         p/N+MkxwJCmeoejKD6pU/KaPF7vKpWrUL03WSVWD+jiMVu0fmdkISRui1Cxep0qLb+q7
         mABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mbBiDnvi1QHic7u2XHdXs3X/8TvkN588xU69B+27Y38=;
        b=nVUYzLct+WcDl/nLmW1kMzap46rvQboGvJVARHrYI0qbibPAtjKlZykJdtpC7E4xNJ
         dIW3Y8p1E7EZ6eVSY2/MjV/Xh6epOtCH1qS2Ip5K6j98LhOmYudS6EqExlx18mTsFIj8
         2jCCmz4/Q1gR6kpuW4p2ub9ngGz2Zu9RHdUiH2MEoF/oLDYuQhHI2++8Mmo1QhQWW1pg
         P7D8cyZa/qmuGOLcnyDd2Wwte+4jejZhRLxmXD/2u9NfP6B68JrL2U7QB2EvRrMArGoC
         fholKYK5KaRVm1vBHSoE+VPTkt9U+UU3d5P9UjJY27UgAzQY2/nskh+oyUaJQ8KO/CJ5
         cGuw==
X-Gm-Message-State: AOAM533po5oYZ3TRNKa5Fus/vA7wdG2PSN2UzU9rEcUV0YKdVvb+LXeR
        LQANEKEt2cUr7feahe2dJhnwOQ==
X-Google-Smtp-Source: ABdhPJwtCLALrtiMiSl+lnVdarxpRDmvY+A0XhZsRqSWKWOlZpx+g21kj+CT03bP+6WwaPY73naYHA==
X-Received: by 2002:a1c:dd8b:: with SMTP id u133mr454019wmg.108.1589823235223;
        Mon, 18 May 2020 10:33:55 -0700 (PDT)
Received: from ?IPv6:2001:16b8:483d:6b00:e80e:f5df:f780:7d57? ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id i4sm12894730wrv.23.2020.05.18.10.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:33:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] uuid.c: split uuid stuffs from util.c
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     linux-raid@vger.kernel.org,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Wolfgang Denk <wd@denx.de>
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-2-guoqing.jiang@cloud.ionos.com>
 <c06c34ec-c3f7-7abb-c1eb-642c52b04d63@trained-monkey.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <73b11fab-8d8a-443a-27fd-ea698e576558@cloud.ionos.com>
Date:   Mon, 18 May 2020 19:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c06c34ec-c3f7-7abb-c1eb-642c52b04d63@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 7:18 PM, Jes Sorensen wrote:
> On 5/15/20 9:40 AM, Guoqing Jiang wrote:
>> Currently, 'make raid6check' is build broken since commit b06815989
>> ("mdadm: load default sysfs attributes after assemblation").
>>
>> /usr/bin/ld: sysfs.o: in function `sysfsline':
>> sysfs.c:(.text+0x2707): undefined reference to `parse_uuid'
>> /usr/bin/ld: sysfs.c:(.text+0x271a): undefined reference to `uuid_zero'
>> /usr/bin/ld: sysfs.c:(.text+0x2721): undefined reference to `uuid_zero'
>>
>> Apparently, the compile of mdadm or raid6check are coupled with uuid
>> functions inside util.c. However, we can't just add util.o to CHECK_OBJS
>> which raid6check is needed, because it caused other worse problems.
>>
>> So, let's introduce a uuid.c file which is indenpended file to fix the
>> problem, all the contents are splitted from util.c.
>>
>> Cc: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
>> Cc: Wolfgang Denk <wd@denx.de>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   Makefile |  6 ++--
>>   util.c   | 87 -----------------------------------------------------
>>   uuid.c   | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 95 insertions(+), 90 deletions(-)
>>   create mode 100644 uuid.c
> I am fine with this change, but uuid.c needs to respect the license
> header that was in util.c

Ok, will copy it from util.c instead of just the below comment.

+/*
+ * Splited from util.c, so uuid.c shares the same copyright of it,
+ */
+


Thanks,
Guoqing

