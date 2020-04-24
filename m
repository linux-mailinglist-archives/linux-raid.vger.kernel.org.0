Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD41B8076
	for <lists+linux-raid@lfdr.de>; Fri, 24 Apr 2020 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgDXUZA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Apr 2020 16:25:00 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:34174 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUZA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Apr 2020 16:25:00 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 03OKOjr3031872;
        Fri, 24 Apr 2020 21:24:45 +0100
From:   Nix <nix@esperi.org.uk>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>, G <garboge@shaw.ca>,
        linux-raid@vger.kernel.org
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
        <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
        <c6be03e8-7726-f184-7752-b41732a9e015@peter-speer.de>
        <87h7xhemk2.fsf@esperi.org.uk> <87d07wr8z9.fsf@vps.thesusis.net>
Emacs:  because Hell was full.
Date:   Fri, 24 Apr 2020 21:24:45 +0100
In-Reply-To: <87d07wr8z9.fsf@vps.thesusis.net> (Phillip Susi's message of
        "Fri, 24 Apr 2020 15:15:22 -0400")
Message-ID: <87ftcsk4xe.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=4 Fuz1=4 Fuz2=4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 24 Apr 2020, Phillip Susi stated:

>
> Nix writes:
>
>> Agreed. I avoided GPT like the plague for ages (shoddy early-2010s
>> motherboard firmware), but once I switched to it it was so much easier
>> to manage than old-style BIOS, and so much easier to deal with when
>> disaster struck, that I'd never consider going back. Does the BIOS have
>> anything like an EFI shell? No, no it doesn't. Can you hack your own
>
> My current and previous motherboard with UEFI boot support did not come
> with the shell.  I once tried downloading one and running it but never
> could find anything useful to do with it.

It's mostly useful for emergency recovery, I'll admit :)

>                                            I also haven't ever been able
> to find any useful UEFI drivers or programs.

They are very thin on the ground :( a shame, really: it seems like
something you *should* be able to use to build whole rescue
environments, but nooo. I guess it *is* easier to stick those in an
initramfs linked into a kernel built as an EFI stub, since at least it's
a Linux rather than the rather weird PE-based environment which is EFI.
