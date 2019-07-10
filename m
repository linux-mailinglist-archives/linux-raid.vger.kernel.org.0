Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240446439C
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGJIf0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 04:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfGJIfZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 10 Jul 2019 04:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87D783082126;
        Wed, 10 Jul 2019 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8BF992F8F;
        Wed, 10 Jul 2019 08:35:23 +0000 (UTC)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Wols Lists <antlists@youngman.org.uk>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
Date:   Wed, 10 Jul 2019 16:35:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5D25196A.9020606@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 10 Jul 2019 08:35:25 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/10/2019 06:47 AM, Wols Lists wrote:
> On 09/07/19 23:17, Luca Lazzarin wrote:
>> Hi all,
>>
>> actually a server of mine has a 2x1TB Raid 1 array.
>> The disks are becoming old and to avoid possible problems I would like
>> to replace them.
>>
>> Moving from 1TB of space to 2TB could be enough, but since I have to buy
>> the new disks I am considering different possibilities, which are:
>> 1) 2x2TB Raid 1 array;
>> 2) 3x2TB Raid 1 array;
>> 3) 3x1TB Raid 5 array;
>> 4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
>> probably are enough for the next 10 year);
>> 5) 4x1TB Raid 6 array.
>>
>> Which one, in your opinion, would the the best solution?
> What's the price difference between 1TB and 2TB drives? Significant, or
> not much? If the price difference isn't that much I'd go for the larger
> drives every time.
>> Thank you for your suggestions.
>>
> Do you have spare disks to back up on to? The problem with both raids 1
> and 5 is that if you have an error, you don't know which data is
> correct, unless you run a check-summing file system on top or something
> like that. At least with raid 6 you can run a repair utility that will
> try to correct your data.

It can create raid device on dm integrity device. So raid can fix the 
silent data corruption
automatically itself. For example a raid1 with two members A and B. When 
there are some
data corruption on A disk, the read from A will fail, because dm 
integrity return error to
raid1. At this time, raid1 can fix this automatically.

Regards
Xiao
>
> Is speed important? raid 1 is probably best. I wouldn't run raid 1 over
> three disks - if you're thinking of that you're probably better off with
> raid 10.
>
> If you want more definite answers than this, though, you're going to
> have to provide more information about how the server is used - is it
> home or business, is speed or resilience more important, what do you
> actually want from the array? Each version has pros and cons.
>
> Cheers,
> Wol
>

