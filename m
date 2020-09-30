Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9327F516
	for <lists+linux-raid@lfdr.de>; Thu,  1 Oct 2020 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgI3W0j (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Sep 2020 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgI3W0i (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Sep 2020 18:26:38 -0400
Received: from achernar.gro-tsen.net (achernar6.gro-tsen.net [IPv6:2001:bc8:30e8::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B695C061755
        for <linux-raid@vger.kernel.org>; Wed, 30 Sep 2020 15:26:38 -0700 (PDT)
Received: by achernar.gro-tsen.net (Postfix, from userid 500)
        id EB8AB214050C; Thu,  1 Oct 2020 00:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=madore.org;
        s=achernar; t=1601504797;
        bh=iZ+vG+3tpaW8fuMdYhixkEoHwckCc7KVW4ha4xCTtGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alSoso2C3vF5EXUcWdgYeKmeCcvEJIOlUH6ryWpDuDcXkPBCI0/qkCciJ8+hcC6JD
         FtdZlU7YoakqnZKUtJVeGqp13LCZhje7d7WZEgoCfe2Ibh13/c65EFk/ajfP/Z0/hN
         dMB5aYshiJr32Ekj+Q/TbaLFcs2lUO0M4yBQIMvQ=
Date:   Thu, 1 Oct 2020 00:26:37 +0200
From:   David Madore <david+ml@madore.org>
To:     antlists <antlists@youngman.org.uk>
Cc:     Linux RAID mailing-list <linux-raid@vger.kernel.org>
Subject: Re: RAID5->RAID6 reshape remains stuck at 0% (does nothing, not even
 start)
Message-ID: <20200930222637.mmlphc4patipalng@achernar.gro-tsen.net>
References: <20200930014032.pd4csjwu3m7uihin@achernar.gro-tsen.net>
 <5F740390.7050005@youngman.org.uk>
 <20200930090031.6lzrs336fr4inpz4@achernar.gro-tsen.net>
 <90338e5b-9ed4-c86e-fa35-8acdd6768ca7@youngman.org.uk>
 <20200930185824.q6dphu2axpfcjjly@achernar.gro-tsen.net>
 <5F74D684.8020005@youngman.org.uk>
 <20200930194510.vki7zixjca6sxvin@achernar.gro-tsen.net>
 <bfe9949c-1b46-baa3-1a89-0d994175dc95@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe9949c-1b46-baa3-1a89-0d994175dc95@youngman.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Sep 30, 2020 at 09:16:10PM +0100, antlists wrote:
> The problem is that if you use mdadm 3.4 with kernel 4.9.237, the 237 means
> that your kernel has been heavily updated and is far too new. But if you use
> mdadm 4.1 with kernel 4.9.237, the 4.9 means that the kernel is basically a
> very old one - too old for mdadm 4.1

But the point of the longterm kernel lines like 4.9.237 is to keep
strict compatibility with the original branch point (that's the point
of a "stable" line) and perform only bugfixes, isn't it?  Do you mean
to say that there is NO stable kernel line with full mdadm support?
Or just the ones provided by distributions?  (But don't distributions
like Debian do exactly the same thing as GKH and others with these
longterm lines?  I.e., fix bugs while keeping strict compatibility.
If there are no longterm stable kernels with full RAID support, I find
this rather worrying.)

But in my specific case, the issue didn't come from a mdadm/kernel
mismatch after all: I performed further investigation after I wrote my
previous message, and my problem did indeed come from the
/lib/systemd/system/mdadm-grow-continue@.service which, as far as I
can tell, is broken insofar as --backup-file=... goes (the option is
needed for --continue to work and it isn't passed).  Furthermore, this
file appears to be distributed by mdadm itself (it's not
Debian-specific), and the systemd service is called by mdadm (from
continue_via_systemd() in Grow.c).

So it seems to me that RAID reshaping with backup files is currently
broken on all systems which use systemd.  But then I'm confused as to
why this didn't get more attention.  Anyway, if you have any
suggestion as to where I should bugreport this, it's the least I can
do.

In my particular setup, after giving this more thought, I thought the
wisest thing would be to get tons of external storage, copy everything
away, recreate a fresh RAID6 array, and copy everything back into it.

Whatever the case, thanks for your help.

Cheers,

-- 
     David A. Madore
   ( http://www.madore.org/~david/ )
