Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE169E381
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfH0JAb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 05:00:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57098 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH0JAb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 27 Aug 2019 05:00:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R8wTCu169020;
        Tue, 27 Aug 2019 09:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4NijKk9tpEMuY8W3hn5hFSsEVycvTF0ivvA7mhxLp24=;
 b=BfPNdfIhqNFVBT4S+5/wVl+xC3D2Zvm+i23oAqRZnfdK1crgEy/i3Ww1jh1EqNWA+qDQ
 SqmQGd+MDxTo68+cfdK/ARywo0XBOeOu+N+WWWbla28Rfd1dN5hzqna8u+uW/SZw6mlu
 yRDKdB8SrrKenro5+ii6Fm5QE21L7V5DvEypJ2L1f1jB2eFyqZc8aH9HzMohc5DGN4+D
 lU+UlWG6f8I1q8g1v0ouf0M+fgLUbMiU2PJBN1b1XrORJ3qsojNUh2gDEY4ZWK+R8NP6
 wjBxxjsYdto0Xm4GXbDEDc2so+5aZ2KeMPNc3gvJsLS9nDB28wdMEWn0VWGGSptYTNdT 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2un1dsg1eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 09:00:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R8vhXu169256;
        Tue, 27 Aug 2019 09:00:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2umhu8ft3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 09:00:28 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R90R8o032498;
        Tue, 27 Aug 2019 09:00:27 GMT
Received: from [10.182.70.155] (/10.182.70.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 02:00:27 -0700
Subject: Re: [PATCH] raid5: fix spelling mistake \"bion\" -> \"bios\"
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
References: <1566875864-5386-1-git-send-email-sunny.s.zhang@oracle.com>
 <3658318d-0c75-7afb-9629-9a5135e3149e@cloud.ionos.com>
From:   sunnyZhang <sunny.s.zhang@oracle.com>
Message-ID: <ceddf491-1c04-c52a-875c-a74e90d16295@oracle.com>
Date:   Tue, 27 Aug 2019 17:00:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3658318d-0c75-7afb-9629-9a5135e3149e@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270101
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks, I get it. :)

在 2019/8/27 下午4:12, Guoqing Jiang 写道:
>
>
> On 8/27/19 5:17 AM, Shuning Zhang wrote:
>> There is a spelling mistake in raid5, fix it.
>>
>> Signed-off-by: Shuning Zhang <sunny.s.zhang@oracle.com>
>> ---
>>   drivers/md/raid5.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 3de4e13..2a33b13 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -3189,7 +3189,7 @@ schedule_reconstruction(struct stripe_head *sh, 
>> struct stripe_head_state *s,
>>   }
>>     /*
>> - * Each stripe/dev can have one or more bion attached.
>> + * Each stripe/dev can have one or more bios attached.
>>    * toread/towrite point to the first in a chain.
>>    * The bi_next chain must be in order.
>>    */
>
> Please see the link.
>
> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dkernel-26m-3D143037808730977-26w-3D2&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=mcYQsljqnoxPHJVaWVFtwsEEDhXdP3ULRlrPW_9etWQ&m=q2szZHRGKy-LepA3MoS0xmwfP5j26QLkoTVHpomyO-U&s=gief9-L-2ck0dsicV8edCu7JEAcxJLp1Z4__oCgF4Ro&e= 
>
> Thanks,
> Guoqing
