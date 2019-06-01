Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D40319C7
	for <lists+linux-raid@lfdr.de>; Sat,  1 Jun 2019 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfFAFj1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Jun 2019 01:39:27 -0400
Received: from use.bitfolk.com ([85.119.80.223]:46764 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfFAFj1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 1 Jun 2019 01:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=Pk75OQopuwyuPIJNr3GD/Gd2BL1NhwKgfoIeg50KClM=;
        b=vyOnKLZ71Zd9ixfa8P7XF0McEL/PPOF6YrJbgLe9SW3+2VLTppQygz0iRcP8K47D7XuyERi3waIRPHq7PexdSLgbwiIinwmUBf4woZ0yhMTzRAH/3icCyN8YeL2CH0gb2HykKxhrX8gYGWgj3m/6L0p1EtaJ6gAG/YO5A3gVNcUKCYag0Qise0Zsy9FN1rAA2qosuMsAYiqN5NlT60zZ0DK0xfXe8X8P1OI45S/EYAO0ST50ZFSloCtBDR+hCTNTundpJfmm2DmYxm4mGSww5mXyMsjUtbWirwoUkC8DMNUkbU/QafnWJ5hJ98EoPtJ/Fsi9WREnM66/O8p06W7T4g==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hWwjl-0005IQ-Ec
        for linux-raid@vger.kernel.org; Sat, 01 Jun 2019 05:39:25 +0000
Date:   Sat, 1 Jun 2019 05:39:25 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190601053925.GO4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
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

On Fri, May 31, 2019 at 09:43:35AM +0800, Guoqing Jiang wrote:
> On 5/30/19 3:41 AM, Andy Smith wrote:
> >By contrast RAID-10 seems to split the IOs much more evenly: 53% hit
> >the NVMe, and the average IOPS was only 35% that of RAID-1.
> >
> >Is this expected?

[…]

> There are some optimizations in raid1's read_balance for ssd, unfortunately,
> raid10 didn't have similar code.

Thanks Guoqing, that certainly seems to explain it.

Would it be worth mentioning in the man page and/or wiki that when
there are devices that are very mismatched, performance wise, RAID-1
is likely to be able to direct more reads to the faster device(s),
whereas RAID-10 can't do that?

Is it just that no one has tried to apply the same optimizations to
RAID-10, or is it technically difficult/impossible to do this in
RAID-10?

Thanks,
Andy
