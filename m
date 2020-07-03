Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F792136D6
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgGCI6z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jul 2020 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgGCI6y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jul 2020 04:58:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8847C08C5C1
        for <linux-raid@vger.kernel.org>; Fri,  3 Jul 2020 01:58:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so27018906edq.8
        for <linux-raid@vger.kernel.org>; Fri, 03 Jul 2020 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7uq7M2M6BhC16IMxN3X9JhLLDjigCU4Wg1H6NGI2JGw=;
        b=gUCvfQF22DcJ3RtZ2lR6+eiXsaztjg2CXcRLW1IbVf9qHSZkj5BLScEwa2NTk3dmHS
         OEgDEC49te3BuiJNk1o7i27V7I3vKLAXeA05XXReWTTHG3U5ZZCMNM2lowfCL8Wf7gax
         q4RTli67/kgzdXCJ5ARKw8iTriSyzhR0hT14bXi6BeH0WmO6KLf/uezKNB2ttgmqt7E0
         13VvQjl+141b9rYVkZeoWNPjBNzkrwXg69Pin9wcEwghAC9Xa2/nLITQI0i7LHg8WS6Y
         neLdguNnnYiLi6iDJ3vMfW6kN7/uH2mQ3T8YGX8EeH9CDJKjwbVUwuA8NQAbbXu1zCQd
         nDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7uq7M2M6BhC16IMxN3X9JhLLDjigCU4Wg1H6NGI2JGw=;
        b=N/+Wij6B1eWub1OCcSCnKrb5RBVaMeXE5pvB7ED8WsbZRrSdmA4NRnlTrchIkodDlF
         DkYCo5O/cywDWGhHuGUtaueFLIETnzPSZVPYJe4BY7I8bU0HRUbB1NfdvETwp9dpDhHJ
         FaZ6sYyNpawTmRPbonAGibsYJqvRTI+tMJ6xvgUcv66wxbIKU0lEVpT0v8TFS3UTCeTZ
         75ucr78E6bw4sKzwMmfcJ6FiuxHK7ighO26CgEkrl4VofiJHzbNdEGMDk/4J7iNeM6VM
         Hua/G8PK9gwWeGmqAFk5QF+W4Dd8YTYFLYMjAgHBR8SzSnMKjZJY4dW6dql/NatmG9B2
         +TRA==
X-Gm-Message-State: AOAM5327QyXAoyhA6cBXTfPn70RXxie2ct1x0U9m0UnqjNobltQpbazd
        OgtkLqS4mG1/TaWn44eOgEFhSmUwxInqu9LQ
X-Google-Smtp-Source: ABdhPJxKFmGEO5fsobzbis18IJrR1/2UMhIeS3ZXdf1u4zyenarYmNQ6uk7K4uvUD5XZDlwqHPHTFg==
X-Received: by 2002:a50:bb48:: with SMTP id y66mr35519566ede.147.1593766733243;
        Fri, 03 Jul 2020 01:58:53 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:60ce:5ee7:9c1b:dbd8? ([2001:1438:4010:2540:60ce:5ee7:9c1b:dbd8])
        by smtp.gmail.com with ESMTPSA id ce15sm8785548ejc.86.2020.07.03.01.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 01:58:52 -0700 (PDT)
Subject: Re: [PATCH v3] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200702142926.4419-1-artur.paszkiewicz@intel.com>
 <CAPhsuW5eMPMH1HcMXi67Ci0rbWhVyiuLodVZB_oaGbrR7abTJQ@mail.gmail.com>
 <aea49756-c6f6-a4a3-3e23-9928e0878c80@cloud.ionos.com>
 <cf1b6354-3c97-a2e3-2f7b-d5c15205bb6a@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <6e99d7a2-9048-1265-533f-cb9493181b22@cloud.ionos.com>
Date:   Fri, 3 Jul 2020 10:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cf1b6354-3c97-a2e3-2f7b-d5c15205bb6a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/3/20 10:50 AM, Artur Paszkiewicz wrote:
> On 7/3/20 10:33 AM, Guoqing Jiang wrote:
>> On 7/2/20 11:25 PM, Song Liu wrote:
>>> I run quick test with this. Seems it only adds proper statistics to
>>> raid5 array, but
>>> not to raid0 array. Is this expected?
> Oh, sorry about that. Of course it should work.
>
>> Because bio_endio is not called, and it is same for linear and faulty.
>> I think we have to  clone bio for them ..., then it is better to do the
>> job in the personality layer.
> It's not that bad actually. The issue is simply because those
> personalities change the original bio's bi_disk and then
> bio_end_io_acct() uses a different gendisk. So I think we can either use
> disk_{start,end}_io_acct() instead of bio_{start,end}_io_acct(), or
> change bio->bi_disk back to mddev->gendisk before calling
> bio_end_io_acct(). I prefer the first option. What do you think?

I am fine with either of them, though currently the only caller of
disk_start_io_acct is bio_start_io_acct :-)

Thanks,
Guoqing
