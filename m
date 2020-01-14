Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13E513A93C
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 13:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgANM2a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 07:28:30 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:45890 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgANM23 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jan 2020 07:28:29 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 00ECSRB0026264;
        Tue, 14 Jan 2020 12:28:27 GMT
From:   Nix <nix@esperi.org.uk>
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc:     Wols Lists <antlists@youngman.org.uk>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: RAID10, 3 copies, 3 disks
References: <CAJH6TXhWd-AGi0_KnbnepxZXsOvpMQGwkisFuuX14dMe157jWw@mail.gmail.com>
        <82a7d9ec-f991-ad25-bf1f-eee74be90b1b@youngman.org.uk>
        <CAJH6TXji3e1Tp8xDDiqfqy36fpMC4kZTLaYj0Le9A6Cyg8EnGg@mail.gmail.com>
        <5E1A3D4F.30205@youngman.org.uk>
        <CAJH6TXjQ+vLSOJGH_7-mAeRREBSSTS5DTxXFtz2SU06wfhc4gA@mail.gmail.com>
Emacs:  a Lisp interpreter masquerading as ... a Lisp interpreter!
Date:   Tue, 14 Jan 2020 12:28:27 +0000
In-Reply-To: <CAJH6TXjQ+vLSOJGH_7-mAeRREBSSTS5DTxXFtz2SU06wfhc4gA@mail.gmail.com>
        (Gandalf Corvotempesta's message of "Sat, 11 Jan 2020 22:36:21 +0100")
Message-ID: <87sgki2pec.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=3 Fuz1=3 Fuz2=3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11 Jan 2020, Gandalf Corvotempesta said:

> Il giorno sab 11 gen 2020 alle ore 22:25 Wols Lists
> <antlists@youngman.org.uk> ha scritto:
>> Multiple 3-way mirrors (1+0) requires disks in multiples of 3. Raid10
>> simply requires "4 or more" disks. If you expect/want to expand your
>> storage in small increments, then 10 is clearly better. BUT.
>
> I'll start with 8TB usable (more than enough for me atm) and would be ok
> for at least 1 year, thus saving space is not a problem. Next year, if needed,
> i'll add 3 disks more (or i'll grow the existing ones)
>
>> Depending on your filesystem - for example XFS - changing the disk
>> layout underneath it can severely impact performance - when the
>> filesystem is created it queries the layout and optimises for it. When I
>> discussed it with one of the XFS guys he said "use 1+0 and add a fresh
>> *set* of disks (or completely recreate the filesystem), because XFS
>> optimises layout based on what disks it thinks its got."
>
> No XFS, i'll use ext4.

ext4 does the same thing. In both cases you can specify the layout by
hand, and sometimes you have to because not all block device layers pass
the layout up: e.g. my layering of md->lvm->bcache->cryptsetup->fs loses
the layout at (at least) the bcache level.

What I did when I knew I had a reshape coming up (because I was buying
another disk a few months after buying a machine, and reshaping onto it)
was to create the original array with the filesystem told about the
*intended final* shape, and verify after reshaping that everything was
fine (as with alignment, you can check this with blktrace's btrace tool,
doing stuff and seeing if most changes come a whole stripe at a time or
if all are misaligned and cross stripes). That way the fs starts off
less than optimal and improves after the reshape -- if you got
everything right, which sometimes feels like tightrope-walking.

For ext4, the mkfs options to look for are -E stride=and -E
stripe-width=, usually used together. For XFS, the options to look for
are sunit and swidth (and often agcount is useful too).

-- 
NULL && (void)
