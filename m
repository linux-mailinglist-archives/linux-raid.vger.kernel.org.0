Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027EB6E98D0
	for <lists+linux-raid@lfdr.de>; Thu, 20 Apr 2023 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjDTPyx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Apr 2023 11:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDTPyw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 20 Apr 2023 11:54:52 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FD3272D
        for <linux-raid@vger.kernel.org>; Thu, 20 Apr 2023 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=8jRt1J0BK9Zz+scp1LwnXobVwhKhfQ4aqavahGNFBYw=; b=BI64h04D8Qh0hHRKPZsi81LVxw
        3hkPgOVX/jtV3L0fFEau3tkmNMOXuMC8aduwlz7g2lR55E+3d7by9nXztBUXYI9a6Zm1Xu6AS/KXV
        /GI+JtQ9XDfru2wrGexXkXgRuKakq9KY5YmZ4lXy+DC//g7h89cNoMcTKiMtVOnJ0ug3eE/rbDy0F
        UI4QZrKyIUb7ZIVyjh71/zzK5HMqsFQ0KM18YyZv94MrhhPVdxeoId6wnjuk8LlilyY2GH/qqSF2z
        0i5jvmt45IWrZM1+suGFwkmINSFQ6iM6amlf8hNVjews+jLmKjYErFf8VkWp+gG0fLG1eY997Vn1H
        DYu7B+mg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ppWc8-00DUz1-OU; Thu, 20 Apr 2023 09:54:29 -0600
Message-ID: <c5830dd8-57c5-0d94-a48d-d85f154607e0@deltatee.com>
Date:   Thu, 20 Apr 2023 09:54:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, David Sloan <David.Sloan@eideticom.com>
References: <20230417171537.17899-1-jack@suse.cz>
 <9a1e2e05-72cd-aba2-b380-d0836d2e98dd@deltatee.com>
 <CAPhsuW76n5w7AJ5Ee6foGgm4U2FpRDfpMYhELS7=gJE5SeGwAA@mail.gmail.com>
 <20230420112613.l5wyzi7ran556pum@quack3>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230420112613.l5wyzi7ran556pum@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jack@suse.cz, song@kernel.org, linux-raid@vger.kernel.org, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] md/raid5: Improve performance for sequential IO
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2023-04-20 05:26, Jan Kara wrote:
> On Wed 19-04-23 22:26:07, Song Liu wrote:
>> On Wed, Apr 19, 2023 at 12:04 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>> On 2023-04-17 11:15, Jan Kara wrote:
>>>> Commit 7e55c60acfbb ("md/raid5: Pivot raid5_make_request()") changed the
>>>> order in which requests for underlying disks are created. Since for
>>>> large sequential IO adding of requests frequently races with md_raid5
>>>> thread submitting bios to underlying disks, this results in a change in
>>>> IO pattern because intermediate states of new order of request creation
>>>> result in more smaller discontiguous requests. For RAID5 on top of three
>>>> rotational disks our performance testing revealed this results in
>>>> regression in write throughput:
>>>>
>>>> iozone -a -s 131072000 -y 4 -q 8 -i 0 -i 1 -R
>>>>
>>>> before 7e55c60acfbb:
>>>>               KB  reclen   write rewrite    read    reread
>>>>        131072000       4  493670  525964   524575   513384
>>>>        131072000       8  540467  532880   512028   513703
>>>>
>>>> after 7e55c60acfbb:
>>>>               KB  reclen   write rewrite    read    reread
>>>>        131072000       4  421785  456184   531278   509248
>>>>        131072000       8  459283  456354   528449   543834
>>>>
>>>> To reduce the amount of discontiguous requests we can start generating
>>>> requests with the stripe with the lowest chunk offset as that has the
>>>> best chance of being adjacent to IO queued previously. This improves the
>>>> performance to:
>>>>               KB  reclen   write rewrite    read    reread
>>>>        131072000       4  497682  506317   518043   514559
>>>>        131072000       8  514048  501886   506453   504319
>>>>
>>>> restoring big part of the regression.
>>>>
>>>> Fixes: 7e55c60acfbb ("md/raid5: Pivot raid5_make_request()")
>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>
>>> Looks good to me. I ran it through some of the functional tests I used
>>> to develop the patch in question and found no issues.
>>>
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>
>> Thanks Jan and Logan! I will apply this to md-next. But it may not make
>> 6.4 release, as we are already at rc7.
> 
> OK, sure, this is not a critical issue.
> 
>>>> ---
>>>>  drivers/md/raid5.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 44 insertions(+), 1 deletion(-)
>>>>
>>>> I'm by no means raid5 expert but this is what I was able to come up with. Any
>>>> opinion or ideas how to fix the problem in a better way?
>>>
>>> The other option would be to revert to the old method for spinning disks
>>> and use the pivot option only on SSDs. The pivot optimization really
>>> only applies at IO speeds that can be achieved by fast solid state disks
>>> anyway, and there isn't likely enough IOPS possible on spinning disks to
>>> get enough lock contention that the optimization would provide any benefit.
>>>
>>> So it could make sense to just fall back to the old method of preparing
>>> the stripes in logical block order if we are running on spinning disks.
>>> Though, that might be a bit more involved than what this patch does. So
>>> I think this is probably a good approach, unless we want to recover more
>>> of the lost throughput.
>>
>> How about we only do the optimization in this patch for spinning disks?
>> Something like:
>>
>>         if (likely(conf->reshape_progress == MaxSector) &&
>>             !blk_queue_nonrot(mddev->queue))
>>                 logical_sector = raid5_bio_lowest_chunk_sector(conf, bi);
> 
> Yeah, makes sense. On SSD disks I was not able to observe any adverse
> effects of the different stripe order. Will you update the patch or should
> I respin it?

Does it make sense? If SSDs work fine with the new stripe order, why do
things different for them? So I don't see a  benefit of making the fix
only work with non-rotational devices. It's my original change which
could be made for non-rotationatial only, but that's much more involved.

Logan
