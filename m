Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC51D89C5
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgERVHA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 18 May 2020 17:07:00 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17166 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERVHA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 17:07:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589836015; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=AplPG+TnfFPAVShknusey/lU5jGIpiNdDO3J5CELNICGwEAx8lGjH0bJBBoJw+stSApI/iyoCzHgEfa5cmDktqJIoeWGd8WQsKMBUvQkrspvbdTNga/I58o82eYZMv9yTsytS1RuSIOsU0eNYIdlj0Wi2G9g0VpXfvvBj65A+h4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589836015; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KqvZHgg0c7+hHDd6PNEHdY+dPFJrMdT+1F8UgDeObKY=; 
        b=km+MuFE4bqsbi3Y7O6nR+XYo45LNNI8a0CqGa3HmfQd6mzZwNKD8aiIjgc6ch26aAgbOf9o8d/eCXGWFIiU3sG5lYYODbRADFg64VzyaIqvL8r5bjKUeJEf2nM428SV8qHO54YvAI8gBXm/hiA0xHqFPSGTGHkuk5/i81fYn56w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1589836014221490.156558194729; Mon, 18 May 2020 23:06:54 +0200 (CEST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
 <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
 <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
 <01676778-bfc2-46d4-112b-ee16ef4cbcc1@trained-monkey.org>
 <6bd3cb34-1339-9e1b-1f57-07ef62a70818@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <8671d1fb-1b59-cebf-e1f1-09490856e02b@trained-monkey.org>
Date:   Mon, 18 May 2020 17:06:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6bd3cb34-1339-9e1b-1f57-07ef62a70818@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 2:08 PM, Guoqing Jiang wrote:
> On 5/18/20 7:50 PM, Jes Sorensen wrote:
>> On 5/18/20 1:32 PM, Guoqing Jiang wrote:
>>> On 5/18/20 7:22 PM, Jes Sorensen wrote:
>>>> On 5/15/20 9:40 AM, Guoqing Jiang wrote:
>>>>> Got below error when run "make everything".
>>>>>
>>>>> restripe.c: In function ‘test_stripes’:
>>>>> restripe.c:870:4: error: ignoring return value of ‘read’, declared
>>>>> with attribute warn_unused_result [-Werror=unused-result]
>>>>>       read(source[i], stripes[i], chunk_size);
>>>>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> Fix it by set the return value of ‘read’ to diskP, which should be
>>>>> harmless since diskP will be set again before it is used.
>>>>>
>>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>>> ---
>>>>>    restripe.c | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/restripe.c b/restripe.c
>>>>> index 31b07e8..21c90f5 100644
>>>>> --- a/restripe.c
>>>>> +++ b/restripe.c
>>>>> @@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long
>>>>> *offsets,
>>>>>              for (i = 0 ; i < raid_disks ; i++) {
>>>>>                lseek64(source[i], offsets[i]+start, 0);
>>>>> -            read(source[i], stripes[i], chunk_size);
>>>>> +            /*
>>>>> +             * To resolve "ignoring return value of ‘read’", it
>>>>> +             * should be harmless since diskP will be again later.
>>>>> +             */
>>>>> +            diskP = read(source[i], stripes[i], chunk_size);
>>>> It doesn't complain on Fedora 32, however checking the return value of
>>>> lseek64 and read is a good thing.
>>>>
>>>> However what you have done is to just masking the return value and
>>>> throwing it away, is not OK. Please do it properly.
>>> Yes, it is used to suppress the warning. And set the return value to a
>>> new variable
>>> could cause unused-but-set-variable, not sure if there is better way
>>> now.
>> The correct way is to check the return values and take appropriate
>> action if an error is returned.
> 
> Thanks, just find other places in restripe.c has check like this.
> 
> "read(source[dnum], buf+disk * chunk_size, chunk_size) != chunk_size)
> 
> Will send below changes if it is ok.
> 
> diff --git a/restripe.c b/restripe.c
> index 31b07e8..48c6506 100644
> --- a/restripe.c
> +++ b/restripe.c
> @@ -867,7 +867,15 @@ int test_stripes(int *source, unsigned long long
> *offsets,
> 
>                 for (i = 0 ; i < raid_disks ; i++) {
>                         lseek64(source[i], offsets[i]+start, 0);
> -                       read(source[i], stripes[i], chunk_size);
> +                       if (read(source[i], stripes[i], chunk_size) !=
> +                           chunk_size) {
> +                               free(q);
> +                               free(p);
> +                               free(blocks);
> +                               free(stripes);
> +                               free(stripe_buf);
> +                               return -1;
> +                       }

That should work, however you really should check the return value of
lseek as well, while looking at this.

Cheers,
Jes


