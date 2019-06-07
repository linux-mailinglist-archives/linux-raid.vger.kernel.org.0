Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2547B388E4
	for <lists+linux-raid@lfdr.de>; Fri,  7 Jun 2019 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFGLWV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Jun 2019 07:22:21 -0400
Received: from use.bitfolk.com ([85.119.80.223]:44541 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfFGLWU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 7 Jun 2019 07:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=sesVp8mbKCuT5JjDQezLR6ocih2Ib8g9D61RxSbbNco=;
        b=jj9woDaZc3ZDqmDh+Vhqmb2fisMsG+R6lSGIaXqwk2u8+mJ0s8VGofNni0X61tWeXf8tdG+kN78WoEaOD8cx94FhNLvkmxMu6WUuX3Llma9gvxvexa1LYhKtB0uLHYnpVbfUJokq2qLDNINe4jcEEnslOY86ctXmlnUVsf6r/gz4fiN9AtsWVuWTMwzG/FIi2KCpP0SKXaKBEK0auIINRiEG1EZyzLgub/Eaj7qJ+fRm6rfUevPUDmx8omHVd5hsP6dxJVCiVyvdeCcPTyZ6fWfgWghv659NlHE1mt/lJUyVFmuDjgUVgcl9vDjNUp9NWJnaSmLlUYy6ncnTWdRWpw==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hZCwt-00080z-QB
        for linux-raid@vger.kernel.org; Fri, 07 Jun 2019 11:22:19 +0000
Date:   Fri, 7 Jun 2019 11:22:19 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190607112219.GA4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190601053925.GO4569@bitfolk.com>
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

On Sat, Jun 01, 2019 at 05:39:25AM +0000, Andy Smith wrote:
> On Fri, May 31, 2019 at 09:43:35AM +0800, Guoqing Jiang wrote:
> > There are some optimizations in raid1's read_balance for ssd, unfortunately,
> > raid10 didn't have similar code.

[…]

> Is it just that no one has tried to apply the same optimizations to
> RAID-10, or is it technically difficult/impossible to do this in
> RAID-10?

Guoqing sent me a patch off-list that implements these same device
selection optimizations to RAID-10, and it seems to work. RAID-10
random read performance in this setup is now the same as RAID-1
(both very near to fastest device) and sequential read is even
better than RAID-1.

    http://strugglers.net/~andy/blog/2019/06/06/linux-raid-10-fixed-on-imbalanced-devices/

Cheers,
Andy
