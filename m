Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3157749C14
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfFRIfW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 04:35:22 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:52645 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIfW (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Tue, 18 Jun 2019 04:35:22 -0400
Received: from linux-fcij.suse (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 02:35:15 -0600
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
From:   Guoqing Jiang <gqjiang@suse.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-1-gqjiang@suse.com>
 <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
Message-ID: <6d5373a4-7aeb-336a-a234-3b386f9e2ef4@suse.com>
Date:   Tue, 18 Jun 2019 16:35:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/18/19 11:41 AM, Guoqing Jiang wrote:
>>>
>>> +static int check_and_add_wb(struct md_rdev *rdev, sector_t lo, 
>>> sector_t hi)
>>> +{
>>> +       struct wb_info *wi;
>>> +       unsigned long flags;
>>> +       int ret = 0;
>>> +       struct mddev *mddev = rdev->mddev;
>>> +
>>> +       wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
>>> +
>>> +       spin_lock_irqsave(&rdev->wb_list_lock, flags);
>>> +       list_for_each_entry(wi, &rdev->wb_list, list) {
>> This doesn't look right. We should allocate wi from mempool after
>> the list_for_each_entry(), right?
>
> Good catch, I will use an temp variable in the iteration since 
> mempool_alloc
> could sleep.

After a second thought, I think it should be fine since wi is either
reused to record the sector range or freed after the iteration.

Could you elaborate your concern? Thanks.

Guoqing

