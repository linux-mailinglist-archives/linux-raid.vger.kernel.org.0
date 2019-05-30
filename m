Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954923031E
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfE3UE6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 16:04:58 -0400
Received: from open-std.org ([93.90.116.65]:42901 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfE3UE6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 16:04:58 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id BB18C3566AA; Thu, 30 May 2019 22:04:56 +0200 (CEST)
Date:   Thu, 30 May 2019 22:04:56 +0200
From:   keld@keldix.com
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530200456.GA2264@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com> <20190530100420.GA7106@www5.open-std.org> <20190530180853.GB4569@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530180853.GB4569@bitfolk.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 30, 2019 at 06:08:53PM +0000, Andy Smith wrote:
> Hi keld,
> 
> Thanks for the reply.
> 
> On Thu, May 30, 2019 at 12:04:20PM +0200, keld@keldix.com wrote:
> > you need to clarify which layout you use with md raid10.
> 
> I did not bother as I included the commands for the array setup
> which should indicate that default layout was used.


yes it did. but it was hidden way down in the extended article.

 
> > the layouts are near, far and offset, with very different performance characteristics.
> 
> I did not think these would be of any interest on SSD/NVMe which is
> my main concern and is the area where RAID-1 outperforms RAID-1 by a
> factor of 3 for 100% 4KiB random reads.

i think the latter raid-1 should read "md raid10,near".
yes that is indeed strange, and probably due to the code being written with HDs in mind.

> 
> > far and offset are designed to be faster than near, which I understand that you use.
> > So why are you using the slowest md raid10 layout, and not mentioning this fact?
> 
> Because I did not see the point of a non-default layout for fast
> flash devices.
 

i can understand your pow, but due to  differences in the drivers it may actually matter.

and maybe we can optimize the code a little for ssds.
I have in mind some patches for the far layout, where the higher blocks are actually
faster than the lower blocks. is this also true for ssds?


> > maybe you could run your tests for all 3 layouts?
> 
> Yes I will be happy to do this and see what happens but I'm not
> optimistic that it will change matters so that RAID-10 is able to
> direct most reads to the fastest half.

which is the fastest half? does that apply to all ssds/nvme?

keld
