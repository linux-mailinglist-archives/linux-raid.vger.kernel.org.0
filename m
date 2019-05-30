Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9982FA48
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfE3K2p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 06:28:45 -0400
Received: from open-std.org ([93.90.116.65]:42370 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfE3K2p (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 06:28:45 -0400
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 06:28:44 EDT
Received: by www.open-std.org (Postfix, from userid 500)
        id B8719356BFB; Thu, 30 May 2019 12:04:20 +0200 (CEST)
Date:   Thu, 30 May 2019 12:04:20 +0200
From:   keld@keldix.com
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530100420.GA7106@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529194136.GW4569@bitfolk.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

you need to clarify which layout you use with md raid10.
the layouts are near, far and offset, with very different performance characteristics.
far and offset are designed to be faster than near, which I understand that you use.
So why are you using the slowest md raid10 layout, and not mentioning this fact?

maybe you could run your tests for all 3 layouts?


keld
 

On Wed, May 29, 2019 at 07:41:36PM +0000, Andy Smith wrote:
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
> 
> I did try out --write-mostly, by the way, in an attempt to force
> ~100% of the reads to go to the NVMe, but this actually made
> performance worse. I think that --write-mostly may only make sense
> when the performance gap is much bigger (e.g. between rotational and
> fast flash), where any read to the slow half will kill performance.
> 
> I wrote up my tests here:
> 
> http://strugglers.net/~andy/blog/2019/05/29/linux-raid-10-may-not-always-be-the-best-performer-but-i-dont-know-why/
> 
> There are still a bunch of open questions ("Summary of open
> questions" section) and some results I could not explain. I included
> some tests against slow HDDs and couldn't explain why I achieved 256
> read IOPS there, for example. I don't believe that was the page
> cache.
> 
> If you have any ideas about that, can see any problems with my
> testing methodology, have suggestions for other tests etc then
> please do let me know.
> 
> Thanks,
> Andy
