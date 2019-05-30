Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB433040C
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE3VQL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 17:16:11 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:36926 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfE3VQL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 May 2019 17:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=49U9cREWyWiSLE/Tfk3ppOcQVTNH0y/MZkO9j+9JAsQ=; b=FTbpvZYxYOLq0l2mh0yIZ7pP+
        MKbA3lUhjwUwxKV4hq9Pglwx3CWJtmMEH/bnofmDIde8irOD9SUE14ZjpGN9S7zA37MJgEzHBF+jZ
        F/EfZyIQHeWCbQm+uJQFYHkv+4zT1bIZCkjzzu9iL4gbwCMuJAfjUntSwBbv4if9wXPUU=;
Received: by exim4; Thu, 30 May 2019 23:16:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=49U9cREWyWiSLE/Tfk3ppOcQVTNH0y/MZkO9j+9JAsQ=; b=FTbpvZYxYOLq0l2mh0yIZ7pP+
        MKbA3lUhjwUwxKV4hq9Pglwx3CWJtmMEH/bnofmDIde8irOD9SUE14ZjpGN9S7zA37MJgEzHBF+jZ
        F/EfZyIQHeWCbQm+uJQFYHkv+4zT1bIZCkjzzu9iL4gbwCMuJAfjUntSwBbv4if9wXPUU=;
Received: by exim4; Thu, 30 May 2019 23:16:07 +0200
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id DAEB16A0586; Thu, 30 May 2019 22:16:04 +0100 (BST)
Date:   Thu, 30 May 2019 22:16:04 +0100
From:   Robin Hill <robin@robinhill.me.uk>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530211604.GC29447@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
 <20190530180853.GB4569@bitfolk.com>
 <20190530200456.GA2264@www5.open-std.org>
 <20190530201941.GB29447@cthulhu.home.robinhill.me.uk>
 <20190530203002.GD4569@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530203002.GD4569@bitfolk.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu May 30, 2019 at 08:30:02PM +0000, Andy Smith wrote:

> Hi Robin,
> 
> On Thu, May 30, 2019 at 09:19:41PM +0100, Robin Hill wrote:
> > "fastest half" means the fastest half of the mirror - the NVMe drive, as
> > opposed to the slower SSD.
> > 
> > I suspect the slowdown is because there's no optimisation for the
> > 2-drive RAID-10 case,
> 
> I did wonder about this. I'd love to be able to try out 4 devices
> but unfortunately I can't afford to buy 2 SSDs and 2 NVMe at once!
> 
> For testing purposes do you think it would be worth faking it with
> partitions, i.e. 2 partitions on each device making a 4 device
> RAID-10?
> 
It depends on what you're trying to test. I don't think it'll work for
performance testing - I think md is smart enough to recognise that the
partitions share the same underlying disk and avoid concurrent
reads/writes. Even if not, you'll just be emphasising the performance
difference of the SSD.

Is your interest in RAID-10 for future expansion? I can't see any other
reason not to just use RAID-1 for a 2-device array of solid state
drives.

Cheers,
    Robin
