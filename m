Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17CB1C6695
	for <lists+linux-raid@lfdr.de>; Wed,  6 May 2020 06:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgEFEGT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 May 2020 00:06:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEGT (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 6 May 2020 00:06:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE477F5CF4B481EBEA35;
        Wed,  6 May 2020 12:06:16 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 12:06:13 +0800
Subject: Re: [PATCH 1/4] block: Move SECTORS_PER_PAGE and
 SECTORS_PER_PAGE_SHIFT definitions into <linux/blkdev.h>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
 <20200505115543.1660-2-thunder.leizhen@huawei.com>
 <20200505121043.GG16070@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8ec2a734-d23a-83ef-fe06-6b2895a2d392@huawei.com>
Date:   Wed, 6 May 2020 12:06:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200505121043.GG16070@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/5/5 20:10, Matthew Wilcox wrote:
> On Tue, May 05, 2020 at 07:55:40PM +0800, Zhen Lei wrote:
>> +#ifndef SECTORS_PER_PAGE_SHIFT
>> +#define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
>> +#endif
>> +#ifndef SECTORS_PER_PAGE
>> +#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
>>  #endif
> 
> I find SECTORS_PER_PAGE_SHIFT quite hard to read.  I had a quick skim
> of your other patches, and it seems to me that we could replace
> '<< SECTORS_PER_PAGE_SHIFT' with '* SECTORS_PER_PAGE' and it would be
> more readable in every case.

OK, I will delete SECTORS_PER_PAGE_SHIFT, and replace the shift with {*|/} SECTORS_PER_PAGE if it's
not suitable to be replaced by sectors_to_page()/page_to_sectors().

> 
> .
> 

