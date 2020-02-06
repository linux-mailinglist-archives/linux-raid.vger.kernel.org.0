Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14635154AD3
	for <lists+linux-raid@lfdr.de>; Thu,  6 Feb 2020 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBFSLw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Feb 2020 13:11:52 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:36247 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFSLv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 Feb 2020 13:11:51 -0500
Received: from [81.153.122.72] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1izlcw-00054P-CA; Thu, 06 Feb 2020 18:11:47 +0000
Subject: Re: Recover RAID6 with 4 disks removed
To:     Nicolas Karolak <nicolas.karolak@ubicast.eu>,
        Reindl Harald <h.reindl@thelounge.net>,
        linux-raid@vger.kernel.org
References: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
 <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
 <20200206162250.GA32172@cthulhu.home.robinhill.me.uk>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E3C56E1.1070100@youngman.org.uk>
Date:   Thu, 6 Feb 2020 18:11:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200206162250.GA32172@cthulhu.home.robinhill.me.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 06/02/20 16:22, Robin Hill wrote:
> On Thu Feb 06, 2020 at 03:07:00PM +0100, Reindl Harald wrote:
> 
>> Am 06.02.20 um 14:46 schrieb Nicolas Karolak:
>>> I have (had...) a RAID6 array with 8 disks and tried to remove 4 disks
>>> from it, and obviously i messed up. Here is the commands i issued (i
>>> do not have the output of them):
>>
>> didn't you realize that RAID6 has redundancy to survive *exactly two*
>> failing disks no matter how many disks the array has anmd the data and
>> redundancy informations are spread ove the disks?
>>
>>> mdadm --manage /dev/md1 --fail /dev/sdh
>>> mdadm --manage /dev/md1 --fail /dev/sdg
>>> mdadm --detail /dev/md1
>>> cat /proc/mdstat
>>> mdadm --manage /dev/md1 --fail /dev/sdf
>>> mdadm --manage /dev/md1 --fail /dev/sde
>>> mdadm --detail /dev/md1
>>> cat /proc/mdstat
>>> mdadm --manage /dev/md1 --remove /dev/sdh
>>> mdadm --manage /dev/md1 --remove /dev/sdg
>>> mdadm --manage /dev/md1 --remove /dev/sde
>>> mdadm --manage /dev/md1 --remove /dev/sdf
>>> mdadm --detail /dev/md1
>>> cat /proc/mdstat
>>> mdadm --grow /dev/md1 --raid-devices=4
>>> mdadm --grow /dev/md1 --array-size 7780316160  # from here it start
>>> going wrong on the system
>>
>> becaue mdadm din't't prevent you from shoot yourself in the foot, likely
>> for cases when one needs a hammer for restore from a uncommon state as
>> last ressort
>>
>> set more than one disk at the same time to "fail" is aksing for troubles
>> no matter what
>>
>> what happens when one drive starts to puke when you removed every
>> redundancy and happily start a reshape that implies heavy IO?
>>
>>> I began to have "inpout/output" error, `ls` or `cat` or almost every
>>> command was not working (something like "/usr/sbin/ls not found").
>>> `mdadm` command was still working, so i did that:
>>>
>>> ```
>>> mdadm --manage /dev/md1 --re-add /dev/sde
>>> mdadm --manage /dev/md1 --re-add /dev/sdf
>>> mdadm --manage /dev/md1 --re-add /dev/sdg
>>> mdadm --manage /dev/md1 --re-add /dev/sdh
>>> mdadm --grow /dev/md1 --raid-devices=8
>>> ```
>>>
>>> The disks were re-added, but as "spares". After that i powered down
>>> the server and made backup of the disks with `dd`.
>>>
>>> Is there any hope to retrieve the data? If yes, then how?
>>
>> unlikely - the started reshape did writes
> 
> I don't think it'll have written anything as the array was in a failed
> state.

That was my reaction, too ...

> You'll have lost the metadata on the original disks though as
> they were removed & re-added (unless you have anything recording these
> before the above operations?)

Will you?

> so that means doing a create --assume-clean
> and "fsck -n" loop with all combinations until you find the correct
> order (and assumes they were added at the same time and so share the
> same offset). At least you know the positions of 4 of the array members,
> so that reduces the number of combinations you'll need.

I'm not sure about that ... BUT DO NOT try anything that may be
destructive without making sure you've got backups !!!

What I would try (there've been plenty of reports of disks being added
back as spares) is to take out sdh and sdg (the first two disks to be
removed) which will give you a degraded 6-drive array that SHOULD have
all the data on it. Do a forced assembly and run - it will hopefully work!

If it does, then you need to re-add the other two drives back, and hope
nothing else goes wrong while the array sorts itself out ...
> 
> Check the wiki - there should be instructions on there regarding use of
> overlays to prevent further accidental damage. There may even be scripts
> to help with automating the create/fsck process.
> 
https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

> Cheers,
>     Robin
> 
Cheers,
Wol
