Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0533018B
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3SMb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 14:12:31 -0400
Received: from open-std.org ([93.90.116.65]:42701 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3SMb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 14:12:31 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id 171823566AA; Thu, 30 May 2019 20:12:29 +0200 (CEST)
Date:   Thu, 30 May 2019 20:12:28 +0200
From:   keld@keldix.com
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530181228.GA30315@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com> <20190530100420.GA7106@www5.open-std.org> <bd4ac362-6d91-df02-d7df-84de54dd90bf@thelounge.net> <20190530155834.GA21315@www5.open-std.org> <0f5dcfb4-bb86-6f46-cf19-9d5b97608fac@thelounge.net> <20190530171233.GB26772@www5.open-std.org> <4af3fa20-a39f-a9f2-42e2-ceff907ecf32@thelounge.net> <20190530175545.GA29704@www5.open-std.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530175545.GA29704@www5.open-std.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 30, 2019 at 07:55:45PM +0200, keld@keldix.com wrote:
> On Thu, May 30, 2019 at 07:50:45PM +0200, Reindl Harald wrote:
> > 
> > 
> > Am 30.05.19 um 19:12 schrieb keld@keldix.com:
> > > On Thu, May 30, 2019 at 06:01:29PM +0200, Reindl Harald wrote:
> > >>
> > >>
> > >> Am 30.05.19 um 17:58 schrieb keld@keldix.com:
> > >>> so you will not get performance gains if you read one file sequentially in raid10,near
> > >>> nor md raid1, reading 2 different files concurrently theoretcally should give the same
> > >>> speed in md raid1 an mdraid10,near - but I think raid10,near only reads from one device.
> > >>> so it is a driver issue.
> > >>
> > >> but why?
> > >>
> > >> you have two simple mirrors, read from both disks, one half from mirror1
> > >> and the second from mirror2
> > > 
> > > if you have one file and you read every other block from each mirror then you loose
> > > a lot of reading capacity.
> > > 
> > > say you read block 0 and 2 from mirror1 and block 1 and 3 from mirror2, then
> > > after reading block 0 from mirror1 you have to skip block 1 on mirror1 to read block 2,
> > > given that the disk is rotating anyway to advance to block 2.  you could just as well read block 1 from mirror1
> > > so all your reading frem mirror2 is unnessecary, and you could use mirror2 for other things.
> > > 
> > > it is a matter o the disk drivers strategy.
> > 
> > on a SSD RAID? seriously?
> 
> no, only on hard disks, sorry for not pointing that out

the drivers are quite old and mostly written for hard drives.
ssd drives are handled by the same code.

keld
