Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE80B4C5A3
	for <lists+linux-raid@lfdr.de>; Thu, 20 Jun 2019 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFTCzA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Jun 2019 22:55:00 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:57231 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTCzA (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Wed, 19 Jun 2019 22:55:00 -0400
Received: from linux-fcij.suse (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 19 Jun 2019 20:54:55 -0600
Subject: Re: [PATCH 1/5 V2] md/raid1: fix potential data inconsistency issue
 with write behind device
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-2-gqjiang@suse.com>
 <20190619093046.14066-1-gqjiang@suse.com>
 <CAPhsuW5wuqL=q6THJKwS1ZDkqZLyXaz2gGM7yr==UDOpKOhTVg@mail.gmail.com>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <e355dae1-06bf-262a-4365-b172db664068@suse.com>
Date:   Thu, 20 Jun 2019 10:54:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5wuqL=q6THJKwS1ZDkqZLyXaz2gGM7yr==UDOpKOhTVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/20/19 1:28 AM, Song Liu wrote:
> On Wed, Jun 19, 2019 at 2:10 AM Guoqing Jiang <gqjiang@suse.com> wrote:
>>
>> For write-behind mode, we think write IO is complete once it has
>> reached all the non-writemostly devices. It works fine for single
>> queue devices.
>>
>> But for multiqueue device, if there are lots of IOs come from upper
>> layer, then the write-behind device could issue those IOs to different
>> queues, depends on the each queue's delay, so there is no guarantee
>> that those IOs can arrive in order.
>>
>> To address the issue, we need to check the collision among write
>> behind IOs, we can only continue without collision, otherwise wait
>> for the completion of previous collisioned IO.
>>
>> And WBCollision is introduced for multiqueue device which is worked
>> under write-behind mode.
>>
>> But this patch doesn't handle below cases which could have the data
>> inconsistency issue as well, these cases will be handled in later
>> patches.
>>
>> 1. modify max_write_behind by write backlog node.
>> 2. add or remove array's bitmap dynamically.
>> 3. the change of member disk.
>>
>> Reviewed-by: NeilBrown <neilb@suse.com>
>> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
> 
> Applied to https://github.com/liu-song-6/linux/tree/md-next
> 
> Thanks Guoqing!
> 

Thanks Song! BTW, maybe you need to update the git tree information in 
MAINTAINER file, then people can track md tree well.

And could you take a look at other 4 patches as well? Thanks.

BRs,
Guoqing
