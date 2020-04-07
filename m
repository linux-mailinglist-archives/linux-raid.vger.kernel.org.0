Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACD41A0F73
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgDGOm5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 10:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbgDGOm5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Apr 2020 10:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E3201AE2A;
        Tue,  7 Apr 2020 14:42:54 +0000 (UTC)
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200402081312.32709-1-colyli@suse.de>
 <8A145C50-D9E8-4874-A365-576FC4578486@fb.com>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <ca40cbaa-ebf5-dcf2-1c4f-c3403ce9c63e@suse.de>
Date:   Tue, 7 Apr 2020 22:42:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8A145C50-D9E8-4874-A365-576FC4578486@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/4/6 1:43 上午, Song Liu wrote:
> Hi Coly,
> 
> Thanks for the patch!
> 
>> On Apr 2, 2020, at 1:13 AM, Coly Li <colyli@suse.de> wrote:
>>
>> Commit b330e6a49dc3 ("md: convert to kvmalloc") uses kvmalloc_array()
>> to allocate memory with GFP_NOIO flag in resize_chunks() via function
>> scribble_alloc(),
>> 2269	err = scribble_alloc(percpu, new_disks,
>> 2270			     new_sectors / STRIPE_SECTORS,
>> 2271			     GFP_NOIO);
>>
>> The purpose of GFP_NOIO flag to kvmalloc_array() is to allocate
>> non-physically continuous pages and avoid extra I/Os of page reclaim
>> which triggered by memory allocation. When system memory is under
>> heavy pressure, non-physically continuous pages allocation is more
>> probably to success than allocating physically continuous pages.
>>
>> But as a non GFP_KERNEL compatible flag, GFP_NOIO is not acceptible
>> by kvmalloc_node() and the memory allocation indeed is handled with
>> kmalloc_node() to allocate physically continuous pages. This is not
>> the expected behavior of the original purpose when mistakenly using
>> GFP_NOIO flag.
>>
>> In this patch, the memalloc scope APIs memalloc_noio_save() and
>> memalloc_noio_restore() are used when calling scribble_alloc(). Then
>> when calling kvmalloc_array() with GFP_KERNEL mask, the scope APIs
>> may indicatet the allocating context to avoid memory reclaim related
>> I/Os, to avoid recursive I/O deadlock on the md raid array itself
>> which is calling scribble_alloc() to allocate non-physically continuous
>> pages.
>>
>> This patch also removes gfp_t flags from scribble_alloc() parameters
>> list, because the invalid GFP_NOIO is replaced by memalloc scope APIs.
>>
>> Fixes: b330e6a49dc3 ("md: convert to kvmalloc")
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Kent Overstreet <kent.overstreet@gmail.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> ---
>> drivers/md/raid5.c | 22 ++++++++++++++++------
>> 1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index ba00e9877f02..6b23f8aba169 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -2228,14 +2228,15 @@ static int grow_stripes(struct r5conf *conf, int num)
>>  * of the P and Q blocks.
>>  */
> 
> I noticed the comment before scribble_alloc() is outdated. Maybe
> fix also that as we are on it? 
> 

OK, I will do that.

>> static int scribble_alloc(struct raid5_percpu *percpu,
>> -			  int num, int cnt, gfp_t flags)
>> +			  int num, int cnt)
>> {
>> 	size_t obj_size =
>> 		sizeof(struct page *) * (num+2) +
>> 		sizeof(addr_conv_t) * (num+2);
>> 	void *scribble;
>> +	unsigned int noio_flag;
> I think we don't use noio_flag in scribble_alloc()? 

You are right of cause. It should not be here :-)

Thanks.
-- 

Coly Li
