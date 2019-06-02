Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07924323CC
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFBQED (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Jun 2019 12:04:03 -0400
Received: from use.bitfolk.com ([85.119.80.223]:59737 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfFBQED (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Jun 2019 12:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=Z3Ew3UstPght88g3TFlpTSSDoGzouSBgCws0im9HzmA=;
        b=hUNrA2qtAZPC5CJ9kyz4tdIkvnr6JoIKkxrpfA4lN1ih/S4azHLyQKdgCwdkwfOTLKR/L8E8myQno3Wb+m8Xu8AY8MIWbAe89nboH9dRBHQhFSOhHVdQ6YxqzUkuHZMxWESW039nlQK5y91CUhoabLBtBdGAB9yL14AhlxtU/30mkSTwRIRCl8c9DSdvq1KW2NM7UosycBaA7IL+VrhZVaFnUt1bpt69iprE0X1ZwYw3rCeXcmfkAxnEAIMHFaYKLrklA8UHSkIdPoGQ183lIuqg5UtrZrFmaCzUo15pPChgxQDFZu7Kgw+JjCNGIKO98UqQKlDB3twBJtwWiplBig==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hXSxm-0007fT-7i
        for linux-raid@vger.kernel.org; Sun, 02 Jun 2019 16:04:02 +0000
Date:   Sun, 2 Jun 2019 16:04:02 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190602160402.GR4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com>
 <20190601085024.GA7575@www5.open-std.org>
 <20190601233151.GP4569@bitfolk.com>
 <20190602032609.GQ4569@bitfolk.com>
 <20190602085139.GA10257@www5.open-std.org>
 <20190602094300.GA12631@www5.open-std.org>
 <5CF3B3FC.1060402@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CF3B3FC.1060402@youngman.org.uk>
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

Hello,

On Sun, Jun 02, 2019 at 12:33:16PM +0100, Wols Lists wrote:
> Note that raid-10 is not raid-1+0 is not raid-0+1 as far as linux is
> concerned.
> 
> Provided that you have more disks in the array than you have disks in
> your raid-0 striped set, raid-10 will spread the mirror across disks.

If I had 4 devices (2x SSD and 2x NVMe) I'd love to test how
striped-LVM-on-pair-of-RAID-1s compares against RAID-1+0, but
unfortunately I'm unlikely to be able to justify buying that
hardware at once just for testing purposes.

To be honest if I'm happy with the NVMe then I'll probably just
switch to NVMe in future as it's actually cheaper (but has only 3 vs
5 year warranty, and a quarter the write endurance).

Cheers,
Andy
