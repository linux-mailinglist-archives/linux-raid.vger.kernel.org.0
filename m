Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC13636532B
	for <lists+linux-raid@lfdr.de>; Tue, 20 Apr 2021 09:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhDTHWa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Apr 2021 03:22:30 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41315 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229718AbhDTHWa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 20 Apr 2021 03:22:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UWBJ92o_1618903315;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UWBJ92o_1618903315)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Apr 2021 15:21:57 +0800
Subject: Re: [dm-devel] [RFC PATCH 2/2] block: support to freeze bio based
 request queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
 <b1db72f3-f0a1-72f2-be12-6fd50c29e231@linux.alibaba.com>
 <YH2Kr8ZIn2fWKFyl@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <42c79dce-ad99-4e59-6566-727fa08a66bc@linux.alibaba.com>
Date:   Tue, 20 Apr 2021 15:21:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YH2Kr8ZIn2fWKFyl@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 4/19/21 9:50 PM, Ming Lei wrote:
> On Mon, Apr 19, 2021 at 08:05:46PM +0800, JeffleXu wrote:
>>
>>
>> On 4/15/21 6:33 PM, Ming Lei wrote:
>>> For bio based request queue, the queue usage refcnt is only grabbed
>>> during submission, which isn't consistent with request base queue.
>>>
>>> Queue freezing has been used widely, and turns out it is very useful
>>> to quiesce queue activity.
>>>
>>> Support to freeze bio based request queue by the following approach:
>>>
>>> 1) grab two queue usage refcount for blk-mq before submitting blk-mq
>>> bio, one is for bio, anther is for request;
>>
>>
>> Hi, I can't understand the sense of grabbing two refcounts on the
>> @q_usage_count of the underlying blk-mq device, while
>> @q_usage_count of the MD/DM device is kept untouched.
> 
> Follows the point:
> 
> 1) for blk-mq, we hold one refcount for bio and another for request, and
> release one after ending bio or completing request.

Blk-mq has already implemented queue freezing semantics, even without
this 'grabbing two refcount'. So is this just for the code consisdency
with the bio-based queue?


> 
> 2) for bio based queue, just holding one refcount for bio, and release it
> after the bio is ended.

OK.

> 
> As I mentioned to you, the current in-tree code only grabs the refcount
> during submitting bio for bio base queue, and the refcount is released
> after returning from submission, see __submit_bio().

Yes. I ignored that the refcount grabbed in the entry of bio submission
has been returned back when the submission completes for bio-based queue.

> 
>>
>> In the following calling stack
>>
>> ```
>> queue_poll_store
>> 	blk_mq_freeze_queue(q)
>> ```
>>
>> Is the input @q still the request queue of MD/DM device?
> 
> It can be either one after bio based io polling is supported,
> queue/io_poll is exposed for both blk-mq and bio based queue.
> 
> However, I guess bio based polling doesn't need such strict bio queue
> freezing, cause QUEUE_FLAG_POLL is only read in submission path, so
> looks current freezing just during submission is enough.

Not actually.

blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	struct blk_mq_hw_ctx *hctx;
 	long state;

-	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
+	if (!blk_queue_poll(q) || (queue_is_mq(q) && !blk_qc_t_valid(cookie)))

Here QUEUE_FLAG_POLL is still checked in blk_poll() for bio-based queue,
at least in your latest patch for bio-based polling.

-- 
Thanks,
Jeffle
