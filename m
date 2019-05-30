Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001892FFBD
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfE3P6g (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 11:58:36 -0400
Received: from open-std.org ([93.90.116.65]:42605 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3P6g (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 11:58:36 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id 5A295356BFB; Thu, 30 May 2019 17:58:34 +0200 (CEST)
Date:   Thu, 30 May 2019 17:58:34 +0200
From:   keld@keldix.com
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530155834.GA21315@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com> <20190530100420.GA7106@www5.open-std.org> <bd4ac362-6d91-df02-d7df-84de54dd90bf@thelounge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4ac362-6d91-df02-d7df-84de54dd90bf@thelounge.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 30, 2019 at 04:37:43PM +0200, Reindl Harald wrote:
> 
> 
> Am 30.05.19 um 12:04 schrieb keld@keldix.com:
> > you need to clarify which layout you use with md raid10.
> > the layouts are near, far and offset, with very different performance characteristics.
> > far and offset are designed to be faster than near, which I understand that you use.
> > So why are you using the slowest md raid10 layout, and not mentioning this fact?
> 
> besides that when you install a distribution like Fedora "near" is
> default for pure reads it shouldn't be slower than RAID1 at all, just
> read from both mirrors of the stripe

near is mdadm default, so people often do not realize the faster options.
 
> "far" has the advantage that it shoukd be even faster than RAID1

yes that is because it is striping so that it can read concurrently from two disks.
one reason raid10,near cannot stripe is the layout of the blocks, where you have 
identical partitions, that can be freestanding. 

so you will not get performance gains if you read one file sequentially in raid10,near
nor md raid1, reading 2 different files concurrently theoretcally should give the same
speed in md raid1 an mdraid10,near - but I think raid10,near only reads from one device.
so it is a driver issue.

keld
