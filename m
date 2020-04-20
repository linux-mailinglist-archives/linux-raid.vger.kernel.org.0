Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724B61B0706
	for <lists+linux-raid@lfdr.de>; Mon, 20 Apr 2020 13:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTLFg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Apr 2020 07:05:36 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:52470 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTLFg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Apr 2020 07:05:36 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 03KB5WLv030616;
        Mon, 20 Apr 2020 12:05:32 +0100
From:   Nix <nix@esperi.org.uk>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
        <5E95C698.1030307@youngman.org.uk>
        <13a3bc12-67f7-46d5-7e6a-c6880ace4b1c@peter-speer.de>
        <5E95F461.50209@youngman.org.uk> <87lfmtemqf.fsf@esperi.org.uk>
        <f3139daa-37d5-a965-d204-0ef5d9fe4f3f@peter-speer.de>
Emacs:  you'll understand when you're older, dear.
Date:   Mon, 20 Apr 2020 12:05:32 +0100
In-Reply-To: <f3139daa-37d5-a965-d204-0ef5d9fe4f3f@peter-speer.de> (Stefanie
        Leisestreichler's message of "Mon, 20 Apr 2020 11:45:44 +0200")
Message-ID: <87eesito1v.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1481; Body=3 Fuz1=3 Fuz2=3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20 Apr 2020, Stefanie Leisestreichler said:

> On 18.04.20 01:06, Nix wrote:
>> Boot000B* Current kernel	HD(1,GPT,b6697409-a6ec-470d-994c-0d4828d08861,0x800,0x200000)/File(\efi\nix\current.efi)
>> Boot000E* Current kernel (secondary disk)	HD(1,GPT,9f5912c7-46e7-45bf-a49d-969250f0a388,0x800,0x200000)/File(\efi\nix\current.efi)
>> Boot0011* Current kernel (tertiary disk)	HD(1,GPT,8a5cf352-2e92-43ac-bb23-b0d9f27109e9,0x800,0x200000)/File(\efi\nix\current.efi)
>> Boot0012* Current kernel (quaternary disk)	HD(1,GPT,83ec2441-79e9-4f3c-86ec-378545f776c6,0x800,0x200000)/File(\efi\nix\current.efi)
[...]
>
> Is there any reason why one could not have another entry for each disk (8 entries in this example in total instead of the 4 being
> listed) like:
>
> Boot000B* Current kernel HD(1,GPT,b6697409-a6ec-470d-994c-0d4828d08861,0x800,0x200000)/File(\efi\nix\old.efi)
>
> and so on to support booting the old kernel in case something went wrong?

None! I have one entry each for old/stable kernel on the current disk,
but it just gets quite verbose and repetitive with six disks, and the
two (other disks, old kernels) serve different purposes: I'm going to
want to boot off another disk if the kernel works but something went
wrong with the disk, and I'm going to want to boot an old kernel if the
kernel has gone wrong, in which case probably the disk is fine and I can
just boot off the current disk. If I find when booting a new kernel that
it breaks the disk and I have to boot an old kernel off another disk,
I'll just use the EFI shell to do it. :)

-- 
NULL && (void)
