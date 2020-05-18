Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB291D8030
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERRci (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgERRci (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 13:32:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C0C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 10:32:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so325769wmj.3
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VY0+0YxsqiSnystLX4rBUz7MWxaOPoWaeFsrU/0HnJw=;
        b=T32EcMLeT42mGZlQnEiVwyQDlkFgDwvw9c28M43vO8AiVu4EQWXwD2oW6U7qyvtQrD
         BDmoUnN+T6HahSRIM3AzOvfEhMRlAFXTXpJQ3dHVzKnsRBjjoRaaf+gxBdfVC5Bp/Sts
         MNFy3SuWF9a83X2WRRl2o4zFZbNz2qBSe9VALXqsX4vsyD0ut9+RprxRG6b1LAirHW0/
         8pK5JlJbzRq7ADVEy+/QSUZjoyejSpyP7MiQRm9Ix7zh7urHXXDqXUQCK1DgFOZfLFG5
         ChfoBpHsqBLCtBU637aVZoGug1OLaai3HtbgoWgmf584GBZmQspQcH+KWBsC/5kXocAB
         etjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VY0+0YxsqiSnystLX4rBUz7MWxaOPoWaeFsrU/0HnJw=;
        b=SBW1DOmQzg5GG1pg6L5VULt3Gg8ecWCq1rkUWoZbGe2onmhaXmJ854B6jYMYQ/QJwW
         MKJsFEszde8LDoQ2HtyCAM2bSgEHABG0Ye3z3YTguVl1BTirwFwHe9fhtgp/+NRfoBsR
         QdioaKpHRKRIVZn5FYk0+5U3HtEXmpbkblOEg0r004fqNNfXjzFZCO6PYYEYm7WQ5egA
         YyaQ3aVJ/dGq5EZMk1Q/b//nn+L+hBk7Bej9qtYdU1NLdHGowVJ2MnjKsu3noixt8INt
         d0H34u8qjnrLPdD2qKqXbamXjWh6L5dYCEWqclVSBugZp4BNlq9eJFWBY7VvpUqIhSUm
         f1/g==
X-Gm-Message-State: AOAM531QOAYVo7AFlnAKfn4Is6i8Kt48yGgE3HihmLBPiLpItvWMxPNs
        eXcKtfylBlgmdiew0ePOpiVnaiy/Im8CcA==
X-Google-Smtp-Source: ABdhPJzCKIyhHuDztuq/Rhvv/nx51bNZrlerzu5WsVyOeNUCmc/H8rdlknLfAeMRLa6YjqVMmKDpPQ==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr417508wmy.119.1589823154972;
        Mon, 18 May 2020 10:32:34 -0700 (PDT)
Received: from ?IPv6:2001:16b8:483d:6b00:e80e:f5df:f780:7d57? ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id t7sm17090599wrq.39.2020.05.18.10.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:32:34 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
 <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
Date:   Mon, 18 May 2020 19:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 7:22 PM, Jes Sorensen wrote:
> On 5/15/20 9:40 AM, Guoqing Jiang wrote:
>> Got below error when run "make everything".
>>
>> restripe.c: In function ‘test_stripes’:
>> restripe.c:870:4: error: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Werror=unused-result]
>>      read(source[i], stripes[i], chunk_size);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fix it by set the return value of ‘read’ to diskP, which should be
>> harmless since diskP will be set again before it is used.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   restripe.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/restripe.c b/restripe.c
>> index 31b07e8..21c90f5 100644
>> --- a/restripe.c
>> +++ b/restripe.c
>> @@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long *offsets,
>>   
>>   		for (i = 0 ; i < raid_disks ; i++) {
>>   			lseek64(source[i], offsets[i]+start, 0);
>> -			read(source[i], stripes[i], chunk_size);
>> +			/*
>> +			 * To resolve "ignoring return value of ‘read’", it
>> +			 * should be harmless since diskP will be again later.
>> +			 */
>> +			diskP = read(source[i], stripes[i], chunk_size);
> It doesn't complain on Fedora 32, however checking the return value of
> lseek64 and read is a good thing.
>
> However what you have done is to just masking the return value and
> throwing it away, is not OK. Please do it properly.

Yes, it is used to suppress the warning. And set the return value to a 
new variable
could cause unused-but-set-variable, not sure if there is better way now.

Thanks,
Guoqing
