Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4093ED9C21
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfJPVBU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 17:01:20 -0400
Received: from MAIL.NPC-USA.COM ([173.160.187.9]:41318 "EHLO
        nautilus.npc-usa.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726565AbfJPVBT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Oct 2019 17:01:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by nautilus.npc-usa.com (Postfix) with ESMTP id DBEB41DC0196
        for <linux-raid@vger.kernel.org>; Wed, 16 Oct 2019 14:01:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at npc-usa.com
Received: from nautilus.npc-usa.com ([127.0.0.1])
        by localhost (mail.npc-usa.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E-YC4aAYC92e for <linux-raid@vger.kernel.org>;
        Wed, 16 Oct 2019 14:01:17 -0700 (PDT)
Received: from [10.0.1.65] (unknown [10.0.1.65])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: curtis)
        by nautilus.npc-usa.com (Postfix) with ESMTPSA id 927D21DC0182
        for <linux-raid@vger.kernel.org>; Wed, 16 Oct 2019 14:01:17 -0700 (PDT)
Reply-To: curtis@npc-usa.com
Subject: Re: Degraded RAID1
To:     linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
 <5DA648B9.7030506@youngman.org.uk>
 <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
 <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
From:   Curtis Vaughan <curtis@npc-usa.com>
Openpgp: preference=signencrypt
Autocrypt: addr=curtis@npc-usa.com; keydata=
 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
Organization: North Pacific Corporation
Message-ID: <cec07a1f-8497-1589-52ef-e89550630956@npc-usa.com>
Date:   Wed, 16 Oct 2019 14:01:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/10/2019 23:44, Curtis Vaughan wrote:
>>
>>>>
>>>> Device info:
>>>> ST1000DM003-9YN162, S/N:Z1D17B24, WWN:5-000c50-050e6c90f, FW:CC4C,
>>>> 1.00 TB
>>> Urkk
>>>
>>> Seagate Barracudas are NOT recommended. Can you do a "smartctl -x" and
>>> see if SCT/ERC is supported? I haven't got a datasheet for the 1GB
>>> version, but I've got the 3GB version and it doesn't support it. That
>>> means you WILL suffer from the timeout problem ...
>>>
>>> (Not that that's your problem here, but there's no point tempting fate.
>>> I know Seagate say "suitable for desktop raid", but the experts on this
>>> list wouldn't agree ...)
>>
>> SCT supported, but SCT/ERC not. GREAT! Hm and the replacement is also
>> a Seagate.
>
> My new drives are Seagate Ironwolf, which are supposedly fine. I still
> haven't managed to boot the system - it's been sat for ages with an
> assembly problem I haven't solved - I hope it's something as simple as
> needs a bios update, but I can't do that ...
>>   However another of my servers also has Seagates like the one I'm
>> buying and it
>> that ERC is supported. So maybe I should buy one more such drive and
>> also
>> replace sdb?
>
> Depends. If you run the script on the timeout problem page it "fixes"
> the problem. The only downside is that if you have a disk error,
> you've just set your timeout to three minutes, so the system could
> freeze for near enough that time. Not nice for the user, but at least
> the system will be okay. A proper ERC drive can be set to return with
> an error very quickly - the default is 7 secs.
>>
>> Here are the results of the command on the problem drive:
>>
>> smartctl -x /dev/sda | grep SCT
>> SCT capabilities:            (0x3085)    SCT Status supported.
>> 0xe0       GPL,SL  R/W      1  SCT Command/Status
>> 0xe1       GPL,SL  R/W      1  SCT Data Transfer
>> SCT Status Version:                  3
>> SCT Version (vendor specific):       522 (0x020a)
>> SCT Support Level:                   1
>> SCT Data Table command not supported
>> SCT Error Recovery Control command not supported
>>
> Typical Barracuda :-(
>
Switched out bad hard drive and added a brand new one.

Now I thought I should just run:

sudo mdadm --add /dev/md1 /dev/sda2
sudo mdadm --add /dev/md1 /dev/sda1

and the raid would be back up and running (RAID1, btw). But I think it
won't add sda1 or sda2 cause they don't exist. So it seems I need to
first partition the drive? But how do I partition EXACTLY like the
other? Or is there another way?

