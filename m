Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E530346
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 22:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3UaE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 16:30:04 -0400
Received: from use.bitfolk.com ([85.119.80.223]:41378 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfE3UaE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 16:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=m8ia45/hr2Fgms37JNHHfEoO3rb0mQ5uxcoM4zCyE6I=;
        b=oDOym3BfxC46XFwmmuBzHNXtl/3u0pfH7ppK1e6mwADPjUD+c72qj3Varkk9qCxTmRfvj1yjgCMDDCnNHNXZYvo5KAWIhRJvhqYZMCRV1tqMcwtHNW7MV+UK0QPchu+/MOUaHzoQrctsaCmbUB7z7P219g/yz2GBsFW8jF/NUeXqxgXI2hDSLU0CmhaJhzhqNsRid3nvVKlZn65xZLKbAqabS5o9UZvE1NdtfbZP0gCfl5HT1v96p1x0OrqQSFxrZQpYly403wkZkhDauOetjkSmGIYPk9XB2HnsRL4LrELlD+q//XhfOSzm7p/LBbqzjDBxCedeIehdIT+GViCJ6A==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hWRgY-00015N-Gw
        for linux-raid@vger.kernel.org; Thu, 30 May 2019 20:30:02 +0000
Date:   Thu, 30 May 2019 20:30:02 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530203002.GD4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
 <20190530180853.GB4569@bitfolk.com>
 <20190530200456.GA2264@www5.open-std.org>
 <20190530201941.GB29447@cthulhu.home.robinhill.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530201941.GB29447@cthulhu.home.robinhill.me.uk>
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

On Thu, May 30, 2019 at 09:19:41PM +0100, Robin Hill wrote:
> "fastest half" means the fastest half of the mirror - the NVMe drive, as
> opposed to the slower SSD.
> 
> I suspect the slowdown is because there's no optimisation for the
> 2-drive RAID-10 case,

I did wonder about this. I'd love to be able to try out 4 devices
but unfortunately I can't afford to buy 2 SSDs and 2 NVMe at once!

For testing purposes do you think it would be worth faking it with
partitions, i.e. 2 partitions on each device making a 4 device
RAID-10?

Thanks,
Andy
