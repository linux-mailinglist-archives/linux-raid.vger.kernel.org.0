Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5E3EE7C6
	for <lists+linux-raid@lfdr.de>; Tue, 17 Aug 2021 09:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhHQHsa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Aug 2021 03:48:30 -0400
Received: from out2.migadu.com ([188.165.223.204]:28593 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239326AbhHQHr6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Aug 2021 03:47:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629186444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bkUQwsvWkb9wD53bg43GRj4wh4isgcHFsEI7ZMI6KY=;
        b=g8OjWctrm9NdV+vlPNqCtqzdSOhADEGWnOqXlM5gdbFn8yzUsyp+M4YghOnjNarhWMNdNn
        nzpSgPVO/e8NMI5gtKprpkHa2mVFVBXxXw4DRMVc/AKOD8OOAkNdgve+/apRHEafKlAwwj
        4ms5QLhU2NpiltRdoKxuPVn9VNIcIRU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH] drivers:md:fix a potential use-after-free bug
To:     Song Liu <song@kernel.org>, lwt105 <3061522931@qq.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <tencent_888910D6F881B3D8BD9C3DFED667A5009806@qq.com>
 <CAPhsuW7cC+d5mhNjJb0AiHDKCUb5WzYPNzZ5UPOSScdtFuNzww@mail.gmail.com>
Message-ID: <6b4c8938-a8a9-1a14-87bd-f30e4eda2b3d@linux.dev>
Date:   Tue, 17 Aug 2021 15:47:16 +0800
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7cC+d5mhNjJb0AiHDKCUb5WzYPNzZ5UPOSScdtFuNzww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 8/14/21 12:16 AM, Song Liu wrote:
> On Thu, Aug 12, 2021 at 8:46 PM lwt105<3061522931@qq.com>  wrote:
>> In line 2867, "raid5_release_stripe(sh);" drops the reference to sh and
>> may cause sh to be released. However, sh is subsequently used in lines
>> 2869 "if (sh->batch_head && sh != sh->batch_head)". This may result in an
>> use-after-free bug.
>>
>> It can be fixed by moving "raid5_release_stripe(sh);" to the bottom of
>> the function.
>>
>> Signed-off-by: lwt105<3061522931@qq.com>
> The fix looks reasonable.

I am not sure this is needed unless there is real calltrace to prove it. 
Because raid5_release_stripe
doesn't mean it will release the sh's memory,  pls see the comment 
before clear_batch_ready in
handle_stripe, and the path handle_stripe -> handle_stripe_clean_event 
-> break_stripe_batch_list.

Thanks,
Guoqing
