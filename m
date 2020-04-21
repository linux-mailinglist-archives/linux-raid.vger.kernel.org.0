Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B71B32E4
	for <lists+linux-raid@lfdr.de>; Wed, 22 Apr 2020 01:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUXGa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 19:06:30 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28226 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgDUXGa (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 19:06:30 -0400
Received: from [81.157.200.200] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jR1yG-00078N-3M; Wed, 22 Apr 2020 00:06:28 +0100
Subject: Re: Recovering From RAID5 Failure
To:     Leland Ball <lelandmball@gmail.com>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
References: <CAM++EjGaFBh8ZChnyY0p=du0CKFT1WVikSNYyUUcJhuKwQf4sQ@mail.gmail.com>
 <CAAMCDeegCE4x26L4OYttiABxvxiu4qYykAo-b-53G-qW8Ua1Hw@mail.gmail.com>
 <CAM++EjHie1FFZ7y-VveWBSQs2TW=PkD+-QXKxK_pAON-GrcRcQ@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <3e3eb845-bd41-1b7a-6d31-2c13dca612b0@youngman.org.uk>
Date:   Wed, 22 Apr 2020 00:06:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAM++EjHie1FFZ7y-VveWBSQs2TW=PkD+-QXKxK_pAON-GrcRcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/04/2020 17:55, Leland Ball wrote:
> Thanks Roger, I appreciate your help and quick reply!
> 
> Two of the disks (sda, sdb) were able to return
>      # smartctl --all /dev/sdX
> just fine, but sdc and sdd returned very little, so I dug a bit deeper with
>      # smartctl -d ata -T permissive --all /dev/sdX
> 
> The results are in the pastebin: https://pastebin.com/yWJTPvBa
> It looks like only sdd has an error count. I would love to get this up
> long enough to recover at least a portion of the data, which isn't
> backed up elsewhere.
> 
PLEASE don't use pastebin and places like that. Just attach them to the 
email - they're plain text and aren't that big.

I looked up the model number on google - it's a Caviar Green. While I 
don't know that model, the fact it's a Green rings alarm bells. And I 
can find no mention of ERC - also a red light.

Can you get the disks out of the NAS and try to assemble the array on an 
up-to-date computer? Can you ddrescue sdd? The lack of ERC is very 
dangerous with parity raid.

Cheers,
Wol
