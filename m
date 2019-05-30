Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07C304A2
	for <lists+linux-raid@lfdr.de>; Fri, 31 May 2019 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3WKh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 18:10:37 -0400
Received: from use.bitfolk.com ([85.119.80.223]:59711 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfE3WKh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 18:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=kjDQ9DsIaxn6nGrs5X/6QjnviDtGMyzhvxxOYbOK+f0=;
        b=K6Up1bMuRWXsKLOLwAGJV0F4FCnoQENqJ15fHW8D1C0UisE8tfrJq/du2oD+FdaDSixVDWr6HDEA6FrEBJrE19UwR0yXEaSk2Kqph4dBcJYTsU2qbIGMoFUOuNmNupTPQs93Zyr8Q2SG38qhQZzjHca3vWe6MSgVN9HMgNV5JPgLPFEhbTHNadwcgbCnYXYGcCfnMKPO6JI8lkUN3rQZkFLnDhjHHhK44tNSQ975pfKKZfnw1lbgDJdU2/TXhujPM8JiDGAhf2Tq391OkFi5R7wiPm95Z1fnPAkFJUdypzqgmj1HaF5B2Vv57ufnnr8Oi8siXm40rCRM5p3CJC9ULg==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hWTFr-0005oI-Ro
        for linux-raid@vger.kernel.org; Thu, 30 May 2019 22:10:35 +0000
Date:   Thu, 30 May 2019 22:10:35 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530221035.GG4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
 <20190530180853.GB4569@bitfolk.com>
 <20190530200456.GA2264@www5.open-std.org>
 <20190530201941.GB29447@cthulhu.home.robinhill.me.uk>
 <20190530203002.GD4569@bitfolk.com>
 <20190530211604.GC29447@cthulhu.home.robinhill.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530211604.GC29447@cthulhu.home.robinhill.me.uk>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Robin,

On Thu, May 30, 2019 at 10:16:04PM +0100, Robin Hill wrote:
> On Thu May 30, 2019 at 08:30:02PM +0000, Andy Smith wrote:
> > For testing purposes do you think it would be worth faking it with
> > partitions, i.e. 2 partitions on each device making a 4 device
> > RAID-10?
> > 
> It depends on what you're trying to test. I don't think it'll work for
> performance testing - I think md is smart enough to recognise that the
> partitions share the same underlying disk and avoid concurrent
> reads/writes. Even if not, you'll just be emphasising the performance
> difference of the SSD.

Okay, I won't test that then.

> Is your interest in RAID-10 for future expansion? I can't see any other
> reason not to just use RAID-1 for a 2-device array of solid state
> drives.

RAID-10's just always been my go-to for a really long time as I'd
tested it to be better for my use case back then (more than 10 years
ago). So when I tested it again and found it wasn't, I was just
interested in why and if that can be resolved.

I will go with RAID-1. An expansion is reasonably likely at some
point but I don't think I will lose much by just adding it as
another RAID-1 pair and then adding that to the LVM VG that the
initial array will be used for.

Cheers,
Andy
