Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32671D81C1
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgERRub convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 18 May 2020 13:50:31 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17167 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgERRub (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 13:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589824226; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Ui3zyWt53t15DGt3jugn7ogfqJnyDjFjmALJ2pjccN9+H5wCSZpGR8a0QOk6sWXS5oX1N7xGdn1CLbK+GpLLN+fwh5MG5hKFeMPtgjZ8RFsQO/FqYnPoE4gTxZ8JnU9n+qyYewAMhFkCm3pEzuWBY9o2Vaamf1+blPGdoBSgWBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589824226; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Cb4EBrn1CGPC62DDZtZn0FiG0v1hwk6shsL54onDP2g=; 
        b=Qg3hcRFJR9YyVoaDnW9I9HjNigRkHxJE5TIERqbJAy10ITUSAlxb1ryBa7plniYTNDawIJuu3vFNFHoTmZGy727/ZFuvFMxVMTotevwqXLyta8FSJyyGQYuh1e6C5Fof/l0TMeiAex4+3une2jVGkFKzq8kdaZ1d2uhz0QnxWL0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1589824224289236.23598885047272; Mon, 18 May 2020 19:50:24 +0200 (CEST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
 <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
 <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <01676778-bfc2-46d4-112b-ee16ef4cbcc1@trained-monkey.org>
Date:   Mon, 18 May 2020 13:50:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 1:32 PM, Guoqing Jiang wrote:
> On 5/18/20 7:22 PM, Jes Sorensen wrote:
>> On 5/15/20 9:40 AM, Guoqing Jiang wrote:
>>> Got below error when run "make everything".
>>>
>>> restripe.c: In function ‘test_stripes’:
>>> restripe.c:870:4: error: ignoring return value of ‘read’, declared
>>> with attribute warn_unused_result [-Werror=unused-result]
>>>      read(source[i], stripes[i], chunk_size);
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Fix it by set the return value of ‘read’ to diskP, which should be
>>> harmless since diskP will be set again before it is used.
>>>
>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>> ---
>>>   restripe.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/restripe.c b/restripe.c
>>> index 31b07e8..21c90f5 100644
>>> --- a/restripe.c
>>> +++ b/restripe.c
>>> @@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long
>>> *offsets,
>>>             for (i = 0 ; i < raid_disks ; i++) {
>>>               lseek64(source[i], offsets[i]+start, 0);
>>> -            read(source[i], stripes[i], chunk_size);
>>> +            /*
>>> +             * To resolve "ignoring return value of ‘read’", it
>>> +             * should be harmless since diskP will be again later.
>>> +             */
>>> +            diskP = read(source[i], stripes[i], chunk_size);
>> It doesn't complain on Fedora 32, however checking the return value of
>> lseek64 and read is a good thing.
>>
>> However what you have done is to just masking the return value and
>> throwing it away, is not OK. Please do it properly.
> 
> Yes, it is used to suppress the warning. And set the return value to a
> new variable
> could cause unused-but-set-variable, not sure if there is better way now.

The correct way is to check the return values and take appropriate
action if an error is returned.

Jes



