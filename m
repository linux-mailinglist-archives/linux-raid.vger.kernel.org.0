Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97711E3F64
	for <lists+linux-raid@lfdr.de>; Fri, 25 Oct 2019 00:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfJXWcp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 18:32:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41330 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbfJXWcp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 24 Oct 2019 18:32:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so168157pgr.8
        for <linux-raid@vger.kernel.org>; Thu, 24 Oct 2019 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uWJEpFAU8GyMmZQYfwuKKPGG08uBbFAjaPlqhioLZRY=;
        b=WXuycdeXFDzZ1GdGwqEkwr+R9Vvi24XmsmddbxJEXCN7icHw/hmXDSYaPF0SaoQsNU
         dOlzN0EaxieCAWjT1jcCyrlD7OhdAWASrZegbmJ5x1OlAhDvIe/jh4ov+xp0u8SrCnmf
         39Zox/dJKe+2DcWim1Z/91zr8Gv3FWiwIBeuJDbSkPafSZwbgj3wz5vmbN83WKrF+EwE
         rq9PUN0+4KM2aMteDTXsXRvEmB/hCb0ScR/zdKD1yCIBlsZAc4CwTZrlMz+qS40p2+/K
         YC5VsRx8bpu4o626+AW2xCsupkn5pZQHfxPEuml1ML637mQJrnLK7hIAgvX4ZKKsWxJU
         STvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uWJEpFAU8GyMmZQYfwuKKPGG08uBbFAjaPlqhioLZRY=;
        b=RLG/col2ipHMc1JATLaDn0oqVJpbmwDPAZw3HDnZIKIjV13lXwgaiEsJWKTDSMUsGO
         gq8FIsB5mcxIlGDfu99RqmHyVZ2yeDNvbbSuV2b6JQGJmTEm4aBf0QHVCYmUdqcJnino
         yElnBjfSsw5LN6XwASdwpNieKhGSjCSn9jFfF7Jub6V+9V293UIJPK1V9gXtlPlD0sgl
         zo25AC5x04W7Wvsktxqh4Q4YJGX2i2RN/qKMQhlTwTxVKbkcVBamF0cf2NGxPtzvwKF9
         Hym7ykKXvLdDYCPIOy+/81Lf9zzpwb4oCWcJ42vLLD0B7lRAJwpHCM9t656MjgG9fFaI
         oAyA==
X-Gm-Message-State: APjAAAUwGMV17p7scIpyfY2MdJty28k/GXDWicxBJbWSRsrcLY+/lQEh
        rJr+KFRoxD5gm4HVbRO8uMUo0w==
X-Google-Smtp-Source: APXvYqyMzvFcNto9tC0VGw/zbjOmdoaXi1MUf7zO8zrgWQP0Ik2Guwe1H1E6uSvcCEJlqmSgoJdkNQ==
X-Received: by 2002:a17:90a:ad0c:: with SMTP id r12mr9976782pjq.1.1571956364887;
        Thu, 24 Oct 2019 15:32:44 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q3sm14282pgj.54.2019.10.24.15.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 15:32:44 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20191024
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Jeffery <djeffery@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Yufen Yu <yuyufen@huawei.com>, Xiao Ni <xni@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
References: <ED0B162E-09AC-420D-9620-849EAB38C195@fb.com>
 <d452324f-ce01-2220-0ea2-19f23e46dba2@kernel.dk>
 <F2681048-5B87-49A9-883D-FB892EF6831E@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea7bfbd6-628b-556e-8a0b-192228211134@kernel.dk>
Date:   Thu, 24 Oct 2019 16:32:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <F2681048-5B87-49A9-883D-FB892EF6831E@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/24/19 4:27 PM, Song Liu wrote:
> 
> 
>> On Oct 24, 2019, at 3:19 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/24/19 1:50 PM, Song Liu wrote:
>>> Hi Jens,
>>>
>>> Please consider pulling the following changes for md-next on top of your
>>> for-5.5/block branch.
>>
>> Would you mind rebasing this on top of for-5.5/drivers? Linus wanted me
>> to have stronger separation between the two, so...
>>
> 
> Sure! Please find updated request below.

Thanks, pulled!

-- 
Jens Axboe

