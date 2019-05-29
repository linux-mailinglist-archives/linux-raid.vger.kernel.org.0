Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE642E585
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2Tlh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 15:41:37 -0400
Received: from use.bitfolk.com ([85.119.80.223]:45064 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfE2Tlh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 May 2019 15:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=MwH5wTdJW1agyzU28/2mqxPnZ+2GfBaj47TG2suRCd8=;
        b=F8ZVx0fRBtbnwRWM1DJ6ei/8VbbJUnjWJJwFvK1RcdVA4xN3Zunq+0KzWi21FU0lhm33UMCb6BaZ4n79zTsKEYvtOLIz3ldihlgvC1ykN9rj4nC/42Ig9p64oCwkIcLKRnqEzl0JEQZXasAaaJ/pNppN7G4zRq5kCP5Ngk39Oj75zzsFAI33MjAtvFvt97V0S9XXo6UCn3C5T3a5+CX/FU0VKfI4TH4YVRc/62JfriXpIvP+YxwT+p5Fj9dG6P2tPEYlFacPLciaXX33F1O2snSR2WAxVhbB81LCj+19+A4Y8F+FKFsZGOCCmqiw5tYfkMG7FvCCoPyoWCXGvsPKIw==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hW4S8-00068a-Jf
        for linux-raid@vger.kernel.org; Wed, 29 May 2019 19:41:36 +0000
Date:   Wed, 29 May 2019 19:41:36 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190529194136.GW4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I have a server with a fast device (a SATA SSD) and a very fast
device (NVMe). I was experimenting with different Linux RAID
configurations to see which worked best. While doing so I discovered
that in this situation, RAID-1 and RAID-10 can perform VERY
differently.

A RAID-1 of these devices will parallelise reads resulting in ~84% of
the read IOs hitting the NVMe and an average IOPS close to
that of the NVMe.

By contrast RAID-10 seems to split the IOs much more evenly: 53% hit
the NVMe, and the average IOPS was only 35% that of RAID-1.

Is this expected?

I suppose so since it is documented that RAID-1 can parallelise
reads but RAID-10 will stripe them. That is normally presented as a
*benefit* of RAID-10 though; I'm not sure that it is obvious that if
your devices have dramatically different performance characteristics
that RAID-10 could hobble you.

I did try out --write-mostly, by the way, in an attempt to force
~100% of the reads to go to the NVMe, but this actually made
performance worse. I think that --write-mostly may only make sense
when the performance gap is much bigger (e.g. between rotational and
fast flash), where any read to the slow half will kill performance.

I wrote up my tests here:

http://strugglers.net/~andy/blog/2019/05/29/linux-raid-10-may-not-always-be-the-best-performer-but-i-dont-know-why/

There are still a bunch of open questions ("Summary of open
questions" section) and some results I could not explain. I included
some tests against slow HDDs and couldn't explain why I achieved 256
read IOPS there, for example. I don't believe that was the page
cache.

If you have any ideas about that, can see any problems with my
testing methodology, have suggestions for other tests etc then
please do let me know.

Thanks,
Andy
