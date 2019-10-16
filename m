Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11020D84A3
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfJPAEu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 20:04:50 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39482 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfJPAEt (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Oct 2019 20:04:49 -0400
Received: from [86.132.37.73] (helo=[192.168.1.78])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iKWo2-0005xG-Bb; Wed, 16 Oct 2019 01:04:47 +0100
Subject: Re: Degraded RAID1
To:     curtis@npc-usa.com, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
 <5DA648B9.7030506@youngman.org.uk>
 <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
Date:   Wed, 16 Oct 2019 01:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/10/2019 23:44, Curtis Vaughan wrote:
> 
>>>
>>> Device info:
>>> ST1000DM003-9YN162, S/N:Z1D17B24, WWN:5-000c50-050e6c90f, FW:CC4C, 1.00 TB
>> Urkk
>>
>> Seagate Barracudas are NOT recommended. Can you do a "smartctl -x" and
>> see if SCT/ERC is supported? I haven't got a datasheet for the 1GB
>> version, but I've got the 3GB version and it doesn't support it. That
>> means you WILL suffer from the timeout problem ...
>>
>> (Not that that's your problem here, but there's no point tempting fate.
>> I know Seagate say "suitable for desktop raid", but the experts on this
>> list wouldn't agree ...)
> 
> SCT supported, but SCT/ERC not. GREAT! Hm and the replacement is also a Seagate.

My new drives are Seagate Ironwolf, which are supposedly fine. I still 
haven't managed to boot the system - it's been sat for ages with an 
assembly problem I haven't solved - I hope it's something as simple as 
needs a bios update, but I can't do that ...
>   
> However another of my servers also has Seagates like the one I'm buying and it
> that ERC is supported. So maybe I should buy one more such drive and also
> replace sdb?

Depends. If you run the script on the timeout problem page it "fixes" 
the problem. The only downside is that if you have a disk error, you've 
just set your timeout to three minutes, so the system could freeze for 
near enough that time. Not nice for the user, but at least the system 
will be okay. A proper ERC drive can be set to return with an error very 
quickly - the default is 7 secs.
> 
> Here are the results of the command on the problem drive:
> 
> smartctl -x /dev/sda | grep SCT
> SCT capabilities:            (0x3085)    SCT Status supported.
> 0xe0       GPL,SL  R/W      1  SCT Command/Status
> 0xe1       GPL,SL  R/W      1  SCT Data Transfer
> SCT Status Version:                  3
> SCT Version (vendor specific):       522 (0x020a)
> SCT Support Level:                   1
> SCT Data Table command not supported
> SCT Error Recovery Control command not supported
> 
Typical Barracuda :-(

Cheers,
Wol
