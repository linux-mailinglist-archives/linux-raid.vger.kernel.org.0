Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D9618E5A
	for <lists+linux-raid@lfdr.de>; Fri,  4 Nov 2022 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKDCld (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Nov 2022 22:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKDClc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 3 Nov 2022 22:41:32 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C223388
        for <linux-raid@vger.kernel.org>; Thu,  3 Nov 2022 19:41:31 -0700 (PDT)
Subject: Re: A crash caused by the commit
 0dd84b319352bb8ba64752d4e45396d8b13e6018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667529689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiN5eMV1+vn15L1kP99sfueg2N/uogH1tNlGfNEJbi4=;
        b=i7BXz8+aCC3egaS/u6aLeRWHIOQdjnM7u5Xi+JvRxMtVSTMAQbSqcAdi1L18+CLU7P96zg
        zO8tK5yu0RpLtcQl4KfASFP2uKQ5R0crT42Sp9N6b5WBZImVntcjEfC7bfdCqVzZrkti5p
        v89wYJvfSvQ9RQueegG5Hov01xQ5vdQ=
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Neil Brown <neilb@suse.de>
References: <alpine.LRH.2.21.2211021214390.25745@file01.intranet.prod.int.rdu2.redhat.com>
 <78646e88-2457-81e1-e3e7-cf66b67ba923@linux.dev>
 <alpine.LRH.2.21.2211030851090.10884@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.21.2211031018030.18305@file01.intranet.prod.int.rdu2.redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <5dd07779-5c09-4c75-6e34-392e4c05c3c8@linux.dev>
Date:   Fri, 4 Nov 2022 10:41:18 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2211031018030.18305@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/3/22 11:20 PM, Mikulas Patocka wrote:
>
> On Thu, 3 Nov 2022, Mikulas Patocka wrote:
>
>>> BTW, is the mempool_free from endio -> dec_count -> complete_io?
>>> And io which caused the crash is from dm_io -> async_io / sync_io
>>>  �-> dispatch_io, seems dm-raid1 can call it instead of dm-raid, so I
>>> suppose the io is for mirror image.
>>>
>>> Thanks,
>>> Guoqing
>> I presume that the bug is caused by destruction of a bio set while bio
>> from that set was in progress. When the bio finishes and an attempt is
>> made to free the bio, a crash happens when the code tries to free the bio
>> into a destroyed mempool.
>>
>> I can do more testing to validate this theory.
>>
>> Mikulas
> When I disable tail-call optimizations with "-fno-optimize-sibling-calls",
> I get this stacktrace:

Just curious, is the option used for compile kernel or lvm? BTW, this 
trace is
different from previous one, and it is more understandable to me, thanks.

> [  200.105367] Call Trace:
> [  200.105611]  <TASK>
> [  200.105825]  dump_stack_lvl+0x33/0x42
> [  200.106196]  dump_stack+0xc/0xd
> [  200.106516]  mempool_free.cold+0x22/0x32
> [  200.106921]  bio_free+0x49/0x60
> [  200.107239]  bio_put+0x95/0x100
> [  200.107567]  super_written+0x4f/0x120 [md_mod]
> [  200.108020]  bio_endio+0xe8/0x100
> [  200.108359]  __dm_io_complete+0x1e9/0x300 [dm_mod]
> [  200.108847]  clone_endio+0xf4/0x1c0 [dm_mod]
> [  200.109288]  bio_endio+0xe8/0x100
> [  200.109621]  __dm_io_complete+0x1e9/0x300 [dm_mod]
> [  200.110102]  clone_endio+0xf4/0x1c0 [dm_mod]

Assume the above from this chain.

clone_endio -> dm_io_dec_pending -> __dm_io_dec_pending -> dm_io_complete
-> __dm_io_complete -> bio_endio

> [  200.110543]  bio_endio+0xe8/0x100
> [  200.110877]  brd_submit_bio+0xf8/0x123 [brd]
> [  200.111310]  __submit_bio+0x7a/0x120
> [  200.111670]  submit_bio_noacct_nocheck+0xb6/0x2a0
> [  200.112138]  submit_bio_noacct+0x12e/0x3e0
> [  200.112551]  dm_submit_bio_remap+0x46/0xa0 [dm_mod]
> [  200.113036]  flush_expired_bios+0x28/0x2f [dm_delay]

Was flush_expired_bios triggered by the path?

__dm_destroy or __dm_suspend -> suspend_targets -> delay_presuspend
-> del_timer_sync(&dc->delay_timer) -> handle_delayed_timer

> [  200.113536]  process_one_work+0x1b4/0x320
> [  200.113943]  worker_thread+0x45/0x3e0
> [  200.114319]  ? rescuer_thread+0x380/0x380
> [  200.114714]  kthread+0xc2/0x100
> [  200.115035]  ? kthread_complete_and_exit+0x20/0x20
> [  200.115517]  ret_from_fork+0x1f/0x30
> [  200.115874]  </TASK>
>
> The function super_written is obviously buggy, because it first wakes up a
> process and then calls bio_put(bio) - so the woken-up process is racing
> with bio_put(bio) and the result is that we attempt to free a bio into a
> destroyed bio set.

Does it mean the woken-up process destroyed the bio set?

The io for super write is allocated from sync_set, and the bio set is 
mostly destroyed
in md_free_disk or md_stop, I assume md_stop is more relevant here as it 
is called
by dm-raid.

So I guess the problem is, raid_dtr is called while in flight (or 
expired) bio still not
completed, maybe lvm issues cmd to call dm_table_destroy and dm was in the
progress of suspend or destroy. Just my $0.02.

> When I fix super_written, there are no longer any crashes. I'm posting a
> patch in the next email.

IIRC, the code existed for a long time, I'd suggest try with mdadm test 
suite first
with the change. Cc Neil too.

Thanks,
Guoqing
