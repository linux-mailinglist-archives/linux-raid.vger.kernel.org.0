Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61BE1CF20
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfENSf2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:35:28 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:3638 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfENSf2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 May 2019 14:35:28 -0400
Received: from [192.168.28.40] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id B3DA4B005A1;
        Tue, 14 May 2019 20:35:21 +0200 (CEST)
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Reindl Harald <h.reindl@thelounge.net>, eric.valette@free.fr,
        linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
From:   Julien ROBIN <julien.robin28@free.fr>
Message-ID: <2e69c60c-eda3-c637-92d4-03fe67228c01@free.fr>
Date:   Tue, 14 May 2019 20:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

You're probably right, this is going a little bit out of the original 
subject but lots of tutorials online are only using block devices 
addresses as /dev/sdXN, I guess this has to be improved.

Anyway blocks devices will still be necessary at creation and at a new 
member adding : the UUID used to differentiate members seems to be 
available as "UUID_SUB" but is this field is only available after the 
member insertion into the array, or after array creation.

blkid:
/dev/sdb1: LABEL="HDD-1TB" UUID="15fb0d9f-9fc0-43d9-87bf-68068cdee61e" 
TYPE="ext4" PARTLABEL="HDD-1TB" 
PARTUUID="aec960e5-1018-461b-a65e-975233faf482"
/dev/loop0: UUID="b81ed231-1163-6921-fb6e-5c517003143d" 
UUID_SUB="fc2a081f-6586-0be9-cf8e-d305296e7c54" LABEL="Octocrobe:0" 
TYPE="linux_raid_member"
/dev/loop1: UUID="b81ed231-1163-6921-fb6e-5c517003143d" 
UUID_SUB="2d53982e-9bb5-6492-bec7-dca139197492" LABEL="Octocrobe:0" 
TYPE="linux_raid_member"
/dev/loop2: UUID="b81ed231-1163-6921-fb6e-5c517003143d" 
UUID_SUB="dcc52dc7-ecac-dcb9-1992-ab549f699374" LABEL="Octocrobe:0" 
TYPE="linux_raid_member"
/dev/loop3: UUID="b81ed231-1163-6921-fb6e-5c517003143d" 
UUID_SUB="6d8f237b-1a27-9492-d03e-43245dc4406c" LABEL="Octocrobe:0" 
TYPE="linux_raid_member"
/dev/loop4: UUID="b81ed231-1163-6921-fb6e-5c517003143d" 
UUID_SUB="93084a9c-0190-66fb-f318-91c23ace31b3" LABEL="Octocrobe:0" 
TYPE="linux_raid_member"

I may propose my help in some following days if I have few time 
available into the Linux Raid Wiki, but if anybody else feel comfortable 
with it, please feel free to be faster ;)

Anyway, given the amount of existing Wiki over the Internet it may be 
difficult to change this habit - but improving a wiki can always be useful.


On 5/14/19 8:13 PM, Reindl Harald wrote:
> 
> 
> Am 14.05.19 um 17:48 schrieb Eric Valette:
>> I have a dedicated hardware nas that runs a self maintained debian 10.
>>
>> before the hardware disk problem (before/after)
>>
>> sda : system disk OK/OK no raid
>> sdb : first disk of the raid10 array OK/OK
>> sdc : second disk of the raid10 array OK/OK
>> sdd : third disk of the raid10 array OK/KO
>> sde : fourth disk of the raid10 array OK/OK but is now sdd
>> sdf : spare disk for the array is now sde
>>
>> After the failure the BIOS does not detect the original third disk. Disk
>> are renamed and I think sde has become sdd and sdf -> sde
> 
> how does that matter on any proper setup?
> *never* use /dev/xyz anywhere
> 
> [root@srv-rhsoft:~]$ cat /etc/mdadm.conf
> MAILADDR root
> HOMEHOST localhost.localdomain
> AUTO +imsm +1.x -all
> 
> ARRAY /dev/md0 level=raid1 num-devices=4
> UUID=1d691642:baed26df:1d197496:4fb00ff8
> ARRAY /dev/md1 level=raid10 num-devices=4
> UUID=b7475879:c95d9a47:c5043c02:0c5ae720
> ARRAY /dev/md2 level=raid10 num-devices=4
> UUID=ea253255:cb915401:f32794ad:ce0fe396
> 
