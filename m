Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA4321AD
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 05:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFBD0L (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Jun 2019 23:26:11 -0400
Received: from use.bitfolk.com ([85.119.80.223]:45950 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFBD0L (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 1 Jun 2019 23:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=Hy1ef1NsfTFp5hyHDldgpdUQIXk7K4n0VChcgVs0V08=;
        b=U4oey91j1BrLaNzwI9hJsiG546P8zTkabQtTce3ggJnPzn7eZCJORSBVIoZowpOqirJP/R+8yRdScPJ9okvs29zvK0CyGkP5SmExtiLi/fEanBVvB+uay9A12DURvLIr/GcMo00GIhL752FKyq93T+9KVSmnjPAn4u8rHtY0vmoR9ojybMTAiwSKzEVdwLo6AxPMnLFNdnY9i/Pq2MyIDoqTmB1FGuk20Szr7oRU/9jTuXty6zY2lqzufucvUYo53+PqpHHAdhm0wTF5yWNQICp5VusDZeq3uVurOQBirVcamsvG2XRzcxyC6S0V31ysJ8mfGMFY2oYCaBJVzeLU2A==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hXH8L-0003RB-TG
        for linux-raid@vger.kernel.org; Sun, 02 Jun 2019 03:26:09 +0000
Date:   Sun, 2 Jun 2019 03:26:09 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190602032609.GQ4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com>
 <20190601085024.GA7575@www5.open-std.org>
 <20190601233151.GP4569@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601233151.GP4569@bitfolk.com>
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

On Sat, Jun 01, 2019 at 11:31:51PM +0000, Andy Smith wrote:
> Okay. Which layout combinations are you interested in seeing results
> for? Obviously I've done 'n2' already as it's the default, so is it
> just 'f2' and 'o2' that you would be interested in? I don't think
> there is any point in changing the number of copies from 2, do you?

I see number of copies is limited to the number of devices anyway so
for me, 2 is the only option.

I tried out f2 and o2 (in addition to the n2 default that was
already done):

    http://strugglers.net/~andy/blog/2019/06/02/exploring-different-linux-raid-10-layouts-with-unbalanced-devices/

TL;DR: For this setup non-default layouts were worse (~77% of
default) for sequential read and no different to default layout for
everything else.

I reran the benchmark several times for sequential read and got very
consistent results, so far/offset are definitely worse than near for
sequential 4KiB reads on these devices.

Cheers,
Andy
