Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19C21A8AC0
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgDNT37 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504777AbgDNT3u (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 15:29:50 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B524C03C1AD
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 12:13:47 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jOR0D-0003bf-OI; Tue, 14 Apr 2020 21:13:45 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
 <13a3bc12-67f7-46d5-7e6a-c6880ace4b1c@peter-speer.de>
 <5E95F461.50209@youngman.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <fe996f6f-3b0a-4638-d74d-ae6dc99599df@peter-speer.de>
Date:   Tue, 14 Apr 2020 21:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5E95F461.50209@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1586891627;8dc4a041;
X-HE-SMSGID: 1jOR0D-0003bf-OI
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 14.04.20 19:35, Wols Lists wrote:
> I prefer swap to be at least twice ram. A lot of people think I'm daft
> for that, but it always used to be the rule things were better that way.
Twice RAM means 32G here, no prob, will do so. Not afraid of DoS-Attacks 
also - this machine operates in stealth mode and has got the most clean 
logs one could have seen so far :-)

>> OK. Does this mean that I have to partition my both drives first and
>> after that create the raid arrays, which will end in /dev/md0 for ESP
>> (mount point /boot), /dev/md1 (swap), /dev/md2 for the rest?
> Yup. Apart from the fact that they will probably be 126, 125 and 124 not
> 0, 1, 2. And if I were you I'd name them, for example EFI, SWAP, MAIN or
> LVM.
I will do so, thanks for the hint.

>> What Partition Type do I have to use for /dev/sd[a|b]3? Will it be LVM
>> or RAID?
>>
> I'd just use type linux ...
Could you please be a little more concrete on this one?

