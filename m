Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49E1A0FE9
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgDGPJ2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 11:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbgDGPJ1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Apr 2020 11:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4B2DAC6C;
        Tue,  7 Apr 2020 15:09:25 +0000 (UTC)
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200402081312.32709-1-colyli@suse.de>
 <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
Date:   Tue, 7 Apr 2020 23:09:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/4/5 11:53 下午, Guoqing Jiang wrote:
> On 02.04.20 10:13, Coly Li wrote:
>> -    scribble = kvmalloc_array(cnt, obj_size, flags);
>> +    scribble = kvmalloc_array(cnt, obj_size, GFP_KERNEL);
> 
> Maybe it is simpler to call kvmalloc_array between memalloc_noio_save
> and memalloc_noio_restore.
> And seems sched/mm.h need to be included per the report from LKP.

The falgs can be,
- GFP_KERNEL: when called from alloc_scratch_buffer()
- GFP_NOIO: when called from resize_chunks().

If the scope APIs are used inside scribble_alloc(), the first call path
is restricted as noio, which is not expected. So I only use the scope
APIs around the location where GFP_NOIO is used.

Anyway, Michal Hocko suggests to add the scope APIs in
mddev_suspend()/mddev_resume(). Then in the whole code path where md
raid array is suspend, we don't need to worry the recursive memory
reclaim I/Os onto the array. After checking the complicated raid5 code,
I come to realize this suggestion makes sense.

I will try to compose a v2 patch following Michal's suggestion.
-- 

Coly Li
