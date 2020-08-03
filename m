Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D162239DDD
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHCDg0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Aug 2020 23:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHCDgZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 2 Aug 2020 23:36:25 -0400
X-Greylist: delayed 2444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Aug 2020 20:36:25 PDT
Received: from hermes.turmel.org (hermes.turmel.org [IPv6:2604:180:f1::1e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D1C06174A
        for <linux-raid@vger.kernel.org>; Sun,  2 Aug 2020 20:36:25 -0700 (PDT)
Received: from 108-243-25-188.lightspeed.tukrga.sbcglobal.net ([108.243.25.188] helo=[192.168.20.61])
        by hermes.turmel.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <philip@turmel.org>)
        id 1k2QdW-00016s-6I; Mon, 03 Aug 2020 02:55:38 +0000
Subject: Re: Restoring a raid0 for data rescue
To:     tyranastrasz@gmx.de, antlists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
References: <S1726630AbgHBR6v/20200802175851Z+2001@vger.kernel.org>
 <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
 <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
 <d8f9d16d-b6a2-77ba-bff2-a56c62dac5df@gmx.de>
 <057b0c58-3876-0f03-af33-86f3b266a18a@gmx.de>
 <4d48303b-b8f4-0749-cc6c-8d73ea77edb6@youngman.org.uk>
 <84492bfd-8a1b-6109-fb3f-a32ce25e740d@gmx.de>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <811f84cf-62e1-f8e0-b120-60f7369e3774@turmel.org>
Date:   Sun, 2 Aug 2020 22:55:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <84492bfd-8a1b-6109-fb3f-a32ce25e740d@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/2/20 8:46 PM, tyranastrasz@gmx.de wrote:
> On 02.08.20 22:50, antlists wrote:

>>>> No, I have the disks in my pc.
>>>> The server can't boot the disks because Intel Storage says the raid has
>>>> a failure, because one of the disks has no raid information. But as I
>>>> read them both yesterday they had, now (see the last attachment) one of
>>>> them has none.
>>>> It makes no sense... I need the files
>>>>
>>>> Intel means "yeah make a new raid, with data loss" that's no option.
>>>>
>>>> Nara
>>>
>>>
>>> I tried something what was told here
>>> https://askubuntu.com/questions/69086/mdadm-superblock-recovery
>>>
>>> root@Nibler:~# mdadm --create /dev/md0 -v -f -l 0 -c 128 -n 2 /dev/sdd
>>> /dev/sdb
>>
>> OH SHIT !!!
>>
>> You didn't try booting with a rescue disk? That mistake could well cost
>> you the array :-( I'm out of my depth ...
>>
>> https://raid.wiki.kernel.org/index.php/Linux_Raid
>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>>
>> I've called in the heavy cavalry, and fortunately with 1.2 the damage
>> might not be too bad.
>>
>> Here's hoping,
>> Wol
> 
> What do you mean with 1.2?
> 
> Should I do?
> https://raid.wiki.kernel.org/index.php/Recovering_a_damaged_RAID
> 
> I wait for an answer so I do it not more complicated :/
> But is it not possible to merge both disks together into a virtual one,
> block by block?
> Our put the old superblock back?
> 
> I dunno what's the best solution.
> 
> Thanks
> Nara

Oy.  I don't mind being called a "big gun", but I've zero experience 
with IMSM / software raid combinations.  Not even a sparkler for you, sorry.

I avoid any form of "fakeraid" as too dangerous to play with.  I 
understand it is necessary if you wish to dual boot windows and linux on 
the same raid, but I don't do the former at all any more (no bare metal 
windows in my life for over a decade, now).

):

Phil
