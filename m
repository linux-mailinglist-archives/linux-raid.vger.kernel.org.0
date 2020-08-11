Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43988242087
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKTpv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 15:45:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:23599 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgHKTpv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Aug 2020 15:45:51 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1k5aDU-000CKH-62; Tue, 11 Aug 2020 20:45:49 +0100
Subject: Re: Recommended filesystem for RAID 6
To:     Michael Fritscher <michael@fritscher.net>,
        linux-raid@vger.kernel.org
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <1381759926.21710099.1597158389614.JavaMail.zimbra@karlsbakk.net>
 <4a7bfca8-af6e-cbd1-0dc4-feaf1a0288be@fritscher.net>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F32F56C.7040603@youngman.org.uk>
Date:   Tue, 11 Aug 2020 20:45:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <4a7bfca8-af6e-cbd1-0dc4-feaf1a0288be@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/08/20 20:19, Michael Fritscher wrote:
> Hi,
> 
> if you really want to use these tiny 2 TB HDDs - yes, RAID 6 (2x - the
> second for the backup system on a physically different location) is a
> good choice.
> 
> But: If you can, buy some 8-12 TB HDDs and forget the old rusty tiny
> HDDs. You'll save a lot at the system - and power.
> 
I'm looking at one of these ...
https://www.amazon.co.uk/Seagate-ST8000DM004-Barracuda-internal-Silver/dp/B075WYBQXJ/ref=pd_ybh_a_8?_encoding=UTF8&psc=1&refRID=WF1CTS2K9RWY96D1RENJ

Note that it IS a shingled drive, so fine for backup, much less so for
anything else. I'm not sure whether btrfs would be a good choice or not ...

> ext4 is fine. In my experience, it is rock-solid, and also fsck.ext4 is
> fairly qick (don't know what Roy is doing that it is so slow - do you
> really made a full-fledged ext4 with journal or a old ext2 file system?^^)
> 
> Another way would be deploying zfs with raid-z2 (Yes, I can hear the
> screams :-D )
> 
Cheers,
Wol

