Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFA30337
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfE3UTs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 16:19:48 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:43916 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3UTs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 May 2019 16:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dfqDYE3QVpnLuERcByP1MBml10DiIN4qbACmTpfN08A=; b=XqAROnTQwekvpNw6TND7WSMv/
        WYfA6dbRih5okndCpZjk1H7zlDdPXMiTm19YxeVOGGawYpC7p5B1IkpuahEDKDo/W1Oa6JDYAc6ZB
        Ayj5cZlp+wBMHPMNW4TwVK8yj2BPBD7N3zc+r8EVkjs5xAaQ+PfkBGyNrkEDRkFkq8tLw=;
Received: by exim4; Thu, 30 May 2019 22:19:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dfqDYE3QVpnLuERcByP1MBml10DiIN4qbACmTpfN08A=; b=XqAROnTQwekvpNw6TND7WSMv/
        WYfA6dbRih5okndCpZjk1H7zlDdPXMiTm19YxeVOGGawYpC7p5B1IkpuahEDKDo/W1Oa6JDYAc6ZB
        Ayj5cZlp+wBMHPMNW4TwVK8yj2BPBD7N3zc+r8EVkjs5xAaQ+PfkBGyNrkEDRkFkq8tLw=;
Received: by exim4; Thu, 30 May 2019 22:19:45 +0200
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id B3EDB6A04D5; Thu, 30 May 2019 21:19:41 +0100 (BST)
Date:   Thu, 30 May 2019 21:19:41 +0100
From:   Robin Hill <robin@robinhill.me.uk>
To:     keld@keldix.com
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530201941.GB29447@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: keld@keldix.com, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
 <20190530180853.GB4569@bitfolk.com>
 <20190530200456.GA2264@www5.open-std.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530200456.GA2264@www5.open-std.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu May 30, 2019 at 10:04:56PM +0200, keld@keldix.com wrote:

> On Thu, May 30, 2019 at 06:08:53PM +0000, Andy Smith wrote:
> > Hi keld,
> > 
> > Thanks for the reply.
> > 
> > On Thu, May 30, 2019 at 12:04:20PM +0200, keld@keldix.com wrote:
> > > you need to clarify which layout you use with md raid10.
> > 
> > I did not bother as I included the commands for the array setup
> > which should indicate that default layout was used.
> 
> 
> yes it did. but it was hidden way down in the extended article.
> 
>  
> > > the layouts are near, far and offset, with very different performance characteristics.
> > 
> > I did not think these would be of any interest on SSD/NVMe which is
> > my main concern and is the area where RAID-1 outperforms RAID-1 by a
> > factor of 3 for 100% 4KiB random reads.
> 
> i think the latter raid-1 should read "md raid10,near".
> yes that is indeed strange, and probably due to the code being written with HDs in mind.
> 
> > 
> > > far and offset are designed to be faster than near, which I understand that you use.
> > > So why are you using the slowest md raid10 layout, and not mentioning this fact?
> > 
> > Because I did not see the point of a non-default layout for fast
> > flash devices.
>  
> 
> i can understand your pow, but due to  differences in the drivers it may actually matter.
> 
> and maybe we can optimize the code a little for ssds.
> I have in mind some patches for the far layout, where the higher blocks are actually
> faster than the lower blocks. is this also true for ssds?
> 
No - there's not even any direct connection between offset you're
writing to and the block on the drive that's written. The drive firmware
remaps everything dynamically for wear levelling and to avoid erasing
blocks during a write cycle (as the erase is slow).

> 
> > > maybe you could run your tests for all 3 layouts?
> > 
> > Yes I will be happy to do this and see what happens but I'm not
> > optimistic that it will change matters so that RAID-10 is able to
> > direct most reads to the fastest half.
> 
> which is the fastest half? does that apply to all ssds/nvme?
> 
"fastest half" means the fastest half of the mirror - the NVMe drive, as
opposed to the slower SSD.

I suspect the slowdown is because there's no optimisation for the
2-drive RAID-10 case, so it can't assume that all data is available on
any drive - it therefore just cycles through the array members and
issues the next read to the next drive each time. With RAID-1 it can
always issue the next read to the first available drive (as each copy
contains all the data) and therefore take advantage of the NVMe
performance.

Cheers,
    Robin
