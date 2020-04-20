Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C071B08A5
	for <lists+linux-raid@lfdr.de>; Mon, 20 Apr 2020 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDTMBR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Apr 2020 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDTMBR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Apr 2020 08:01:17 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E0C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 20 Apr 2020 05:01:16 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jQV6w-0002J0-5Q; Mon, 20 Apr 2020 14:01:14 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Nix <nix@esperi.org.uk>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
 <13a3bc12-67f7-46d5-7e6a-c6880ace4b1c@peter-speer.de>
 <5E95F461.50209@youngman.org.uk> <87lfmtemqf.fsf@esperi.org.uk>
 <f3139daa-37d5-a965-d204-0ef5d9fe4f3f@peter-speer.de>
 <87eesito1v.fsf@esperi.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <d9d23909-5b5d-6778-fcab-bb9e6dab33aa@peter-speer.de>
Date:   Mon, 20 Apr 2020 14:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87eesito1v.fsf@esperi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587384076;cbcd6a8f;
X-HE-SMSGID: 1jQV6w-0002J0-5Q
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 20.04.20 13:05, Nix wrote:
>> Is there any reason why one could not have another entry for each disk (8 entries in this example in total instead of the 4 being
>> listed) like:
>>
>> Boot000B* Current kernel HD(1,GPT,b6697409-a6ec-470d-994c-0d4828d08861,0x800,0x200000)/File(\efi\nix\old.efi)
>>
>> and so on to support booting the old kernel in case something went wrong?

> None! I have one entry each for old/stable kernel on the current disk,
> but it just gets quite verbose and repetitive with six disks, and the
> two (other disks, old kernels) serve different purposes: I'm going to
> want to boot off another disk if the kernel works but something went
> wrong with the disk, and I'm going to want to boot an old kernel if the
> kernel has gone wrong, in which case probably the disk is fine and I can
> just boot off the current disk. If I find when booting a new kernel that
> it breaks the disk and I have to boot an old kernel off another disk,
> I'll just use the EFI shell to do it. :)

I guess I got the idea. Need to dive deeper using EFI shell, but this 
sounds like a smart solution even there is no grub, managing the 
kernels, thanks.
