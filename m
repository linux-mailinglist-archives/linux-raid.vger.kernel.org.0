Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7D1B7EAE
	for <lists+linux-raid@lfdr.de>; Fri, 24 Apr 2020 21:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDXTPY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Apr 2020 15:15:24 -0400
Received: from vps.thesusis.net ([34.202.238.73]:55378 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXTPX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 24 Apr 2020 15:15:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id D980723E16;
        Fri, 24 Apr 2020 15:15:22 -0400 (EDT)
Received: from vps.thesusis.net ([IPv6:::1])
        by localhost (ip-172-26-1-203.ec2.internal [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id mHBJbKHrZyqX; Fri, 24 Apr 2020 15:15:22 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 5A08C23E0D; Fri, 24 Apr 2020 15:15:22 -0400 (EDT)
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de> <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca> <c6be03e8-7726-f184-7752-b41732a9e015@peter-speer.de> <87h7xhemk2.fsf@esperi.org.uk>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Phillip Susi <phill@thesusis.net>
To:     Nix <nix@esperi.org.uk>
Cc:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>, G <garboge@shaw.ca>,
        linux-raid@vger.kernel.org
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
In-reply-to: <87h7xhemk2.fsf@esperi.org.uk>
Date:   Fri, 24 Apr 2020 15:15:22 -0400
Message-ID: <87d07wr8z9.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Nix writes:

> Agreed. I avoided GPT like the plague for ages (shoddy early-2010s
> motherboard firmware), but once I switched to it it was so much easier
> to manage than old-style BIOS, and so much easier to deal with when
> disaster struck, that I'd never consider going back. Does the BIOS have
> anything like an EFI shell? No, no it doesn't. Can you hack your own

My current and previous motherboard with UEFI boot support did not come
with the shell.  I once tried downloading one and running it but never
could find anything useful to do with it.  I also haven't ever been able
to find any useful UEFI drivers or programs.

> Can you play DOOM before the OS starts in your BIOS-based system -- oh
> wait, sane people don't do that, do they. But you can't get higher
> availability for truly important functions than that!
> <https://doomwiki.org/wiki/Doom_UEFI>

OMG!
