Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6B32125
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFAXbw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Jun 2019 19:31:52 -0400
Received: from use.bitfolk.com ([85.119.80.223]:57801 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfFAXbw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 1 Jun 2019 19:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=GlB4LbwpIWyXukrBuF2+wB9AuFCP9skiq/VWLXWOBUM=;
        b=Hs9UP8bJ07DXFa0bHvGFVQY7YiX/gp+qXSB0N4p+FG4wN44mshc54myDt9ogkggv651DhtmsGeBLct6Ugw5CWBK4jVPAAZkP7I17ikH+sCfy6nl5Jz7TfTjCX7TiAkH6OxVLD0UfB24MGViRPkKAWHaL0Pmfl/jHr9gvk1YsREAMeLtdJIgg8ciKoDtDgMNlAhGadJGHLGzEvqQEfDioy1zks7+dX6jkzDkzzsDBubRUVjX8qr1L/zAHQ4L2oO7CIdcPKogb3/05wIIVFt9BGoRIlqW222UyolXWYz075aa47yQdM5LdebbcIg0/71M2WFsfa3o7ugCt9Q4et8G8vQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hXDTb-0002id-Ce
        for linux-raid@vger.kernel.org; Sat, 01 Jun 2019 23:31:51 +0000
Date:   Sat, 1 Jun 2019 23:31:51 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190601233151.GP4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com>
 <20190601085024.GA7575@www5.open-std.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601085024.GA7575@www5.open-std.org>
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

Hi,

On Sat, Jun 01, 2019 at 10:50:24AM +0200, keld@keldix.com wrote:
> Still, Andy, you need to cover all layouts of md raid10.
> 
> L know that for the far layout we actually had something that meant choosing the faster drives
> an thus it violated the striping on HDs, degrading read performance severely. A patch fixed that.
> 
> this patch did not apply  to the offset layout, so maybe that layout could satisfy your needs.

Okay. Which layout combinations are you interested in seeing results
for? Obviously I've done 'n2' already as it's the default, so is it
just 'f2' and 'o2' that you would be interested in? I don't think
there is any point in changing the number of copies from 2, do you?

Is it enough to stick with a random read test (best at exposing the
differences we are talking about in this thread) or would you like
to see the other tests like sequential read/write and random write
too in case there are other differences?

Finally, do you consider 4KiB IO sufficient? RAID-10 should allow
striping and there is not much opportunity for that with 4KiB IO and
a default 512KiB chunk size.

What I can't do is test more than 2 devices nor equal performance
devices (unless you are interested in what happens with two 5.4kRPM
HDDs, that is), because all I have in a test host right now is the
SSD and the NVMe.

Cheers,
Andy
