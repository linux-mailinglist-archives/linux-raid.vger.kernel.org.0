Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58C1D83DB
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgERSIH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbgERSIF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 14:08:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D965C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 11:08:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so12896640wre.13
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z/8qu0+fVdCOUF1G6MLc53d1E1fDvJ2y1mxIHzBXXuk=;
        b=Qm1bTBPgOHuQGDO4jY9CoCe+4QErW7ugBJGJtLofCS/Nm78nTkGqu77GQgBGkK0KI5
         /x4DBp7fnl0O3LQ+++doAnwNVWJW5F561PUsjqJgm/7nvk3NudEariZpS4yOyKPmFZre
         Aqcocu6x1Ol1l9pT1y8Iko1uO2BImd+GdEiRFZb6EfIKhrKwNsZryf1MEJZNpQz5EJQZ
         a9UVvSmvajwY5MRGfSu1tuxUe3UJIqTgFslYm64Sderm4fIPzAPO/5N7jZOtjiLLWiIM
         ok+nQeTBIZBlMsi6Q3jsC/3LekoOajshANqRIJN4MtoPzSEyD9dgmYZbkrEtmIhGyJBs
         3UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z/8qu0+fVdCOUF1G6MLc53d1E1fDvJ2y1mxIHzBXXuk=;
        b=pkPSnOXMDEKi3MKKqVTu/JUwtmztwc5PVgu72vLvVsQXi5ilrT2wHJpA41FKMG8gTO
         7nZSgEhewuKXUmNDw4LRuUrnLLhM3ALqL4cXtP8VU9ReE7my4Ca92ytS1MHcXCApJs5+
         ZsDie/m2hO4CirxSepK2ZWoFrRko3bgdwbcwCxrz3lbHr0ulXuyz61BS8FrfHPJG7+cM
         eEsCtrnFUbKqjkER7FQh8yVY9egJlLu7rmfjen7Em242pJbi+k1L14ds/OvH7mgNxgHk
         f+2mNAgiR1UenfgxkWehc1udb3xZERwGiy1+sJeeSy4ZLkhCwHawakTMOLb+gKXYDKhv
         pefQ==
X-Gm-Message-State: AOAM531Ch8CDLhrNKhxHxBQ/XErsQKJCEvBZPgal83NTVYGydGJGVEoS
        1CmWkSxBoiOl7/DWmGEJmuN1TmcE/Igegw==
X-Google-Smtp-Source: ABdhPJydajKejXqVXmZchUQAeshbfO49Wr1eB5AWCyeCL/fgYgNmaohlO2vyASpK27PXrQdQU4hBTA==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr21932079wrj.187.1589825283724;
        Mon, 18 May 2020 11:08:03 -0700 (PDT)
Received: from ?IPv6:2001:16b8:483d:6b00:e80e:f5df:f780:7d57? ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id t14sm13510076wrs.1.2020.05.18.11.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 11:08:03 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
 <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
 <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
 <01676778-bfc2-46d4-112b-ee16ef4cbcc1@trained-monkey.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <6bd3cb34-1339-9e1b-1f57-07ef62a70818@cloud.ionos.com>
Date:   Mon, 18 May 2020 20:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <01676778-bfc2-46d4-112b-ee16ef4cbcc1@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 7:50 PM, Jes Sorensen wrote:
> On 5/18/20 1:32 PM, Guoqing Jiang wrote:
>> On 5/18/20 7:22 PM, Jes Sorensen wrote:
>>> On 5/15/20 9:40 AM, Guoqing Jiang wrote:
>>>> Got below error when run "make everything".
>>>>
>>>> restripe.c: In function ‘test_stripes’:
>>>> restripe.c:870:4: error: ignoring return value of ‘read’, declared
>>>> with attribute warn_unused_result [-Werror=unused-result]
>>>>       read(source[i], stripes[i], chunk_size);
>>>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Fix it by set the return value of ‘read’ to diskP, which should be
>>>> harmless since diskP will be set again before it is used.
>>>>
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>> ---
>>>>    restripe.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/restripe.c b/restripe.c
>>>> index 31b07e8..21c90f5 100644
>>>> --- a/restripe.c
>>>> +++ b/restripe.c
>>>> @@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long
>>>> *offsets,
>>>>              for (i = 0 ; i < raid_disks ; i++) {
>>>>                lseek64(source[i], offsets[i]+start, 0);
>>>> -            read(source[i], stripes[i], chunk_size);
>>>> +            /*
>>>> +             * To resolve "ignoring return value of ‘read’", it
>>>> +             * should be harmless since diskP will be again later.
>>>> +             */
>>>> +            diskP = read(source[i], stripes[i], chunk_size);
>>> It doesn't complain on Fedora 32, however checking the return value of
>>> lseek64 and read is a good thing.
>>>
>>> However what you have done is to just masking the return value and
>>> throwing it away, is not OK. Please do it properly.
>> Yes, it is used to suppress the warning. And set the return value to a
>> new variable
>> could cause unused-but-set-variable, not sure if there is better way now.
> The correct way is to check the return values and take appropriate
> action if an error is returned.

Thanks, just find other places in restripe.c has check like this.

"read(source[dnum], buf+disk * chunk_size, chunk_size) != chunk_size)

Will send below changes if it is ok.

diff --git a/restripe.c b/restripe.c
index 31b07e8..48c6506 100644
--- a/restripe.c
+++ b/restripe.c
@@ -867,7 +867,15 @@ int test_stripes(int *source, unsigned long long 
*offsets,

                 for (i = 0 ; i < raid_disks ; i++) {
                         lseek64(source[i], offsets[i]+start, 0);
-                       read(source[i], stripes[i], chunk_size);
+                       if (read(source[i], stripes[i], chunk_size) !=
+                           chunk_size) {
+                               free(q);
+                               free(p);
+                               free(blocks);
+                               free(stripes);
+                               free(stripe_buf);
+                               return -1;
+                       }
                 }

Thanks,
Guoqing
