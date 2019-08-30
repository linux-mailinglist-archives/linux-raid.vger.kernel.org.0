Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB444A38CC
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH3OHW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 10:07:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40668 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfH3OHV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 30 Aug 2019 10:07:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so2258417edm.7
        for <linux-raid@vger.kernel.org>; Fri, 30 Aug 2019 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z1UMYfA2Pn+kNGiLwisK+AU8OkTbPkP8TBuaZmea8yk=;
        b=SQr7htAJ1TYFMVeCd4HAZP/OpELwTmp103cf60b2pBgPmBUM6/xMsJoXX/pDAzCc2n
         t8eOJVFqN65+Eg1USuIuQESYhtdxx1k1ETRX8joEdlqTr8ThtNnEqBXZEe32Nc+yFzVz
         Uw2eVbCx1/78NkXEWUooLQbYOUuVHS0UFg4Luugqwgb+MDWyXVx6zUqS9pqqDiWxKowa
         gCr6k5997Gv9v1aLPURi5NSsQfp0GwaID4xPKlEfFkEGHyCmtpZJrnksBE/MImnyzsgb
         Ob0y2r/lHrMjutbysKc3rL0URdJ3Bn4T8EovfbsOmFLwS5WmRzrg8Iq6aRwGnH5M7zeW
         Sqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z1UMYfA2Pn+kNGiLwisK+AU8OkTbPkP8TBuaZmea8yk=;
        b=ebz/m3BaNei9iusmYgaC9n5cJFEi8iVsLLt5XBXZrJIpMdynp31LiAYZu4qJRK63/j
         gQCk3qre+OC9g9wkURncycAlSrf62aqb3ZwuxPqSe4nDRBDngOjMOgcX7F9VZkS2A791
         ZZbgvyWhCNNObJfUDsCoWLRSe3ToQxi8xrW2IoggDhCLMxqx4fXmvhdP42uu0Epsqps1
         pXzYZQJaV+RX0vyEoU9rDGTMiPZlzk9JhJXLl8hd1lWYGKeAqFrHRavuFnr4Sg9wOfHd
         on5BpEHFq9yftFBlZ/cPyt8R1TkiScGAN1HVyHAjUyMKXNE/A8tzHOdBFa7jmUvvpyHE
         ha1w==
X-Gm-Message-State: APjAAAW51yKWIdAMQoHg1CYP9liadcZz7a+mgI1p2v3EX2rTS+twoFSu
        bpY4pQ9n5Rsp+n3W/4djQX0onoP4pdk=
X-Google-Smtp-Source: APXvYqzlAenrxg+mUCkGRdUav0dEnr69r75ebj2LndeTj8DOJz+WBrHLxLStcCOsI9/8GbKRUShOxw==
X-Received: by 2002:a05:6402:1214:: with SMTP id c20mr6072886edw.111.1567174039764;
        Fri, 30 Aug 2019 07:07:19 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:bd3e:de57:2010:1b? ([2001:1438:4010:2540:bd3e:de57:2010:1b])
        by smtp.gmail.com with ESMTPSA id a16sm807899ejr.10.2019.08.30.07.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 07:07:18 -0700 (PDT)
Subject: Re: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
 <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <59821fd6-4dff-9871-7a48-dc9e877449f8@cloud.ionos.com>
Date:   Fri, 30 Aug 2019 16:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 8/30/19 1:26 AM, Song Liu wrote:
>
>> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>
>> Hi Song,
>>
>> On 8/29/19 7:42 AM, Song Liu wrote:
>>> I read the code again, and now I am not sure whether we are fixing the issue.
>>> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTIVE.
>>> It only runs on other stripes in the batch, which should not have STRIPE_ACTIVE.
>>  From the original commit which introduced batch write, it has the description
>> which I think is align with your above sentence.
>>
>> "With below patch, we will automatically batch adjacent full stripe write
>> together. Such stripes will be added to the batch list. Only the first stripe
>> of the list will be put to handle_list and so run handle_stripe().".
>>
>> Could you point me related code which achieve the above purpose? Thanks.
> Do you mean which code makes sure the batched stripe will not be handled?
> This is done via properly maintain STRIPE_HANDLE bit.

Thanks, I will dig a little bit about it.

> Btw: do you have a solid repro of the WARNING message?

Unfortunately, no.

Thanks,
Guoqing
