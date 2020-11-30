Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74E2C9127
	for <lists+linux-raid@lfdr.de>; Mon, 30 Nov 2020 23:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgK3WcI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Nov 2020 17:32:08 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:58565 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgK3WcH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Nov 2020 17:32:07 -0500
Received: from host86-149-69-253.range86-149.btcentralplus.com ([86.149.69.253] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kjrhe-000752-6m; Mon, 30 Nov 2020 22:31:26 +0000
Subject: Re: partitions & filesystems (was "Re: ???root account locked???
 after removing one RAID1 hard disc")
To:     Reindl Harald <h.reindl@thelounge.net>,
        David T-G <davidtg-robot@justpickone.org>,
        linux-raid@vger.kernel.org
References: <e6b7a61d16a25c433438c670fa4c0b4f@posteo.de>
 <20201130200503.GV1415@justpickone.org>
 <01a571de-8ae8-3d9e-6f3d-16555ad93ea3@youngman.org.uk>
 <2d0fcd02-9e3a-d11a-a1cf-a47c1b6ce2c3@thelounge.net>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <e2a9d347-0703-07a6-0128-adf86b35b6f3@youngman.org.uk>
Date:   Mon, 30 Nov 2020 22:31:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2d0fcd02-9e3a-d11a-a1cf-a47c1b6ce2c3@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/11/2020 21:49, Reindl Harald wrote:
> 
> 
> Am 30.11.20 um 21:51 schrieb antlists:
>> On 30/11/2020 20:05, David T-G wrote:
>>> You don't see any "filesystem" or, more correctly, partition in your
>>>
>>>    fdisk -l
>>>
>>> output because you have apparently created your filesystem on the entire
>>> device (hey, I didn't know one could do that!). 
>>
>> That, actually, is the norm. It is NOT normal to partition a raid array
> 
> it IS normal for several reasons
> 
> * you may end with a replacement disk which is subtle
>    smaller and hence you normally make the partition
>    a little smaller then the device

And what does that have to do with the price of tea in China? 
Partitioning your array doesn't have any effect on whether or not said 
array uses the whole disk or not.
> 
> * in case of SSD you reserve some space for
>    better wear-levelling

And putting a partition table in your array does exactly what to help that?
> 
> * in case you ever need to reinstall your OS you
>    want your data not in the same filesystem

Which is why I partition my disk. I use one raid for the OS, and another 
for my data.

Cheers,
Wol
