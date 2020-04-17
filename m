Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649491AE89C
	for <lists+linux-raid@lfdr.de>; Sat, 18 Apr 2020 01:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgDQXZD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Apr 2020 19:25:03 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:60310 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgDQXZD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 17 Apr 2020 19:25:03 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 03HNA5M3003249;
        Sat, 18 Apr 2020 00:10:05 +0100
From:   Nix <nix@esperi.org.uk>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     G <garboge@shaw.ca>, linux-raid@vger.kernel.org
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
        <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
        <c6be03e8-7726-f184-7752-b41732a9e015@peter-speer.de>
Emacs:  ballast for RAM.
Date:   Sat, 18 Apr 2020 00:10:05 +0100
In-Reply-To: <c6be03e8-7726-f184-7752-b41732a9e015@peter-speer.de> (Stefanie
        Leisestreichler's message of "Tue, 14 Apr 2020 18:14:00 +0200")
Message-ID: <87h7xhemk2.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=3 Fuz1=3 Fuz2=3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14 Apr 2020, Stefanie Leisestreichler outgrape:

> On 14.04.20 18:00, G wrote:
>> Since you are running disks less than 2TB I would suggest a more rudimentary setup using legacy bios booting. This setup will not
>> allow disks greater than 2TB because they would not be partitioned GPT. There would still be an ability to increase total storage
>> using more disks. There would be raid redundancy with the ability for grub to boot off either disk.
>>
>> Two identical partitions on each disk using mbr partition tables.
>
> Thank you for your thoughts and input.
> I would prefer using uefi/gpt in favor of legacy setup even you are
> totally right about the 2TB border.

Agreed. I avoided GPT like the plague for ages (shoddy early-2010s
motherboard firmware), but once I switched to it it was so much easier
to manage than old-style BIOS, and so much easier to deal with when
disaster struck, that I'd never consider going back. Does the BIOS have
anything like an EFI shell? No, no it doesn't. Can you hack your own
device drivers up if need be and throw them into place for more recovery
options? No, no you can't.

Can you play DOOM before the OS starts in your BIOS-based system -- oh
wait, sane people don't do that, do they. But you can't get higher
availability for truly important functions than that!
<https://doomwiki.org/wiki/Doom_UEFI>
