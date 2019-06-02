Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB55A322BF
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfFBIvl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Jun 2019 04:51:41 -0400
Received: from open-std.org ([93.90.116.65]:49982 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfFBIvl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Jun 2019 04:51:41 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id 50179357121; Sun,  2 Jun 2019 10:51:39 +0200 (CEST)
Date:   Sun, 2 Jun 2019 10:51:39 +0200
From:   keld@keldix.com
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190602085139.GA10257@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com> <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com> <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org> <20190601233151.GP4569@bitfolk.com> <20190602032609.GQ4569@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602032609.GQ4569@bitfolk.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Jun 02, 2019 at 03:26:09AM +0000, Andy Smith wrote:
> On Sat, Jun 01, 2019 at 11:31:51PM +0000, Andy Smith wrote:
> > Okay. Which layout combinations are you interested in seeing results
> > for? Obviously I've done 'n2' already as it's the default, so is it
> > just 'f2' and 'o2' that you would be interested in? I don't think
> > there is any point in changing the number of copies from 2, do you?
> 
> I see number of copies is limited to the number of devices anyway so
> for me, 2 is the only option.

2 is the most  common number here so that is indeed interesting.
I was interested in seeing whether o2 and f2 made a difference.

> I tried out f2 and o2 (in addition to the n2 default that was
> already done):
> 
>     http://strugglers.net/~andy/blog/2019/06/02/exploring-different-linux-raid-10-layouts-with-unbalanced-devices/
> 
> TL;DR: For this setup non-default layouts were worse (~77% of
> default) for sequential read and no different to default layout for
> everything else.
> 
> I reran the benchmark several times for sequential read and got very
> consistent results, so far/offset are definitely worse than near for
> sequential 4KiB reads on these devices.

thanks for doing this.
what about random reads? (which was the puzzle you origially posted afaicr)

would that mean that ssd optimising code is the way forward for md raid10 wrt. this issue?
I think it would be most important for the default near layout, as Andy also indicates
mamy people only use defaults. but also the other layouts should be investigated.

keld

