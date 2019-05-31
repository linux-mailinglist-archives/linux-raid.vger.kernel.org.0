Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33430648
	for <lists+linux-raid@lfdr.de>; Fri, 31 May 2019 03:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEaBno (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 21:43:44 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:55997 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaBno (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Thu, 30 May 2019 21:43:44 -0400
Received: from linux-fcij.suse (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 30 May 2019 19:43:40 -0600
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     andy@strugglers.net
References: <20190529194136.GW4569@bitfolk.com>
From:   Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid@vger.kernel.org
Message-ID: <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
Date:   Fri, 31 May 2019 09:43:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190529194136.GW4569@bitfolk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 5/30/19 3:41 AM, Andy Smith wrote:
> Hi,
>
> I have a server with a fast device (a SATA SSD) and a very fast
> device (NVMe). I was experimenting with different Linux RAID
> configurations to see which worked best. While doing so I discovered
> that in this situation, RAID-1 and RAID-10 can perform VERY
> differently.
>
> A RAID-1 of these devices will parallelise reads resulting in ~84% of
> the read IOs hitting the NVMe and an average IOPS close to
> that of the NVMe.
>
> By contrast RAID-10 seems to split the IOs much more evenly: 53% hit
> the NVMe, and the average IOPS was only 35% that of RAID-1.
>
> Is this expected?
>
> I suppose so since it is documented that RAID-1 can parallelise
> reads but RAID-10 will stripe them. That is normally presented as a
> *benefit* of RAID-10 though; I'm not sure that it is obvious that if
> your devices have dramatically different performance characteristics
> that RAID-10 could hobble you.

There are some optimizations in raid1's read_balance for ssd, unfortunately,
raid10 didn't have similar code. I guess the below commits are related.

commit 9dedf60313fa4dddfd5b9b226a0ef12a512bf9dc ("md/raid1: read balance 
chooses idlest disk for SSD")
commit 12cee5a8a29e7263e39953f1d941f723c617ca5f ("md/raid1: prevent 
merging too large request")

Thanks,
Guoqing
