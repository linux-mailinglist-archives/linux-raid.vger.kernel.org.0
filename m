Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F211B05E4
	for <lists+linux-raid@lfdr.de>; Mon, 20 Apr 2020 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTJpr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Apr 2020 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTJpr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Apr 2020 05:45:47 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11EC061A0C
        for <linux-raid@vger.kernel.org>; Mon, 20 Apr 2020 02:45:46 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jQSzp-0007of-9e; Mon, 20 Apr 2020 11:45:45 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Nix <nix@esperi.org.uk>, Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
 <13a3bc12-67f7-46d5-7e6a-c6880ace4b1c@peter-speer.de>
 <5E95F461.50209@youngman.org.uk> <87lfmtemqf.fsf@esperi.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <f3139daa-37d5-a965-d204-0ef5d9fe4f3f@peter-speer.de>
Date:   Mon, 20 Apr 2020 11:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87lfmtemqf.fsf@esperi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587375947;6eb54aa0;
X-HE-SMSGID: 1jQSzp-0007of-9e
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 18.04.20 01:06, Nix wrote:
> Rather than trying to make some sort of clever mirroring setup work with
> the ESP, I just made one partition per disk, added all of them to the
> efibootmgr:
> 
> Boot000B* Current kernel	HD(1,GPT,b6697409-a6ec-470d-994c-0d4828d08861,0x800,0x200000)/File(\efi\nix\current.efi)
> Boot000E* Current kernel (secondary disk)	HD(1,GPT,9f5912c7-46e7-45bf-a49d-969250f0a388,0x800,0x200000)/File(\efi\nix\current.efi)
> Boot0011* Current kernel (tertiary disk)	HD(1,GPT,8a5cf352-2e92-43ac-bb23-b0d9f27109e9,0x800,0x200000)/File(\efi\nix\current.efi)
> Boot0012* Current kernel (quaternary disk)	HD(1,GPT,83ec2441-79e9-4f3c-86ec-378545f776c6,0x800,0x200000)/File(\efi\nix\current.efi)
> 
> ... and used simple rsync at kernel install time to keep them in sync
> (the variables in here are specific to my autobuilder, but the general
> idea should be clear enough):
> 
>      # For EFI, we install the kernel by hand.  /boot may be a mountpoint,
>      # kept unmounted in normal operation.
>      mountpoint -q /boot && mount /boot
>      KERNELVER="$(file $BUILDMAKEPATH/.o/arch/x86/boot/bzImage | sed 's,^.*version \([0-9\.]*\).*$,\1,g')"
>      install -o root -g root $BUILDMAKEPATH/.o/System.map /boot/System.map-$KERNELVER
>      install -o root -g root $BUILDMAKEPATH/.o/arch/x86/boot/bzImage /boot/efi/nix/vmlinux-$KERNELVER.efi
>      [[ -f /boot/efi/nix/current.efi ]] && mv /boot/efi/nix/current.efi /boot/efi/nix/old.efi
>      install -o root -g root $BUILDMAKEPATH/.o/arch/x86/boot/bzImage /boot/efi/nix/current.efi
>      for backup in 1 2 3; do
>          test -d/boot/backups/$backup || continue
>          mount/boot/backups/$backup
>          rsync -rtq --modify-window=2 --one-file-system/boot/  /boot/backups/$backup
>          umount/boot/backups/$backup
>      done
>      mountpoint -q /boot && umount /boot

Is there any reason why one could not have another entry for each disk 
(8 entries in this example in total instead of the 4 being listed) like:

Boot000B* Current kernel 
HD(1,GPT,b6697409-a6ec-470d-994c-0d4828d08861,0x800,0x200000)/File(\efi\nix\old.efi)

and so on to support booting the old kernel in case something went wrong?
