Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943141CF0E
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENS2W (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:28:22 -0400
Received: from mail.thelounge.net ([91.118.73.15]:56899 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENS2W (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 14:28:22 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 453R5J18HkzXLx;
        Tue, 14 May 2019 20:28:20 +0200 (CEST)
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
 <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <5a28b0de-c50a-fdd1-f6ea-7746da3c9a6e@thelounge.net>
Date:   Tue, 14 May 2019 20:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 14.05.19 um 20:19 schrieb Eric Valette:
> On 14/05/2019 20:13, Reindl Harald wrote:
>>
>>
>> Am 14.05.19 um 17:48 schrieb Eric Valette:
>>> I have a dedicated hardware nas that runs a self maintained debian 10.
>>>
>>> before the hardware disk problem (before/after)
> 
>> how does that matter on any proper setup?
>> *never* use /dev/xyz anywhere
> 
> Fine. Does available online documentation makes it explicit? No .I
> carefully read it before raid creation several years ago

that /dev/sdX changes *randomly* depending on which drives are available
and in which order they appear is common knowledge  and exactly what you
don't want in a setup which shouldn't care if a random drive is missing

>> [root@srv-rhsoft:~]$ cat /etc/mdadm.conf
>> MAILADDR root
>> HOMEHOST localhost.localdomain
>> AUTO +imsm +1.x -all
>>
>> ARRAY /dev/md0 level=raid1 num-devices=4
>> UUID=1d691642:baed26df:1d197496:4fb00ff8
>> ARRAY /dev/md1 level=raid10 num-devices=4
>> UUID=b7475879:c95d9a47:c5043c02:0c5ae720
>> ARRAY /dev/md2 level=raid10 num-devices=4
>> UUID=ea253255:cb915401:f32794ad:ce0fe396
> 
> So what? the question was how do I add array member using symbolic
> names. Of course I can use /dev/by--xxx/ but when dumping I do not know
> if it will be lost or net.

the above *is not* about /dev/by...
it's about the UUID of the 3 RAID devices itself

> Thanks for non helping and only blaming. Glad others have helped instead

bla, as you can see my mdadm.conf don't contain *any* devices
it don't contain any scan stuff

but the kernel line contains mentioning the 3 raid-arrays explicit
rd.md.uuid=1d691642:baed26df:1d197496:4fb00ff8
rd.md.uuid=b7475879:c95d9a47:c5043c02:0c5ae720
rd.md.uuid=ea253255:cb915401:f32794ad:ce0fe396

