Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18E239D1B
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 02:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgHCAqh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Aug 2020 20:46:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:53003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgHCAqg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Aug 2020 20:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596415588;
        bh=ydaHUQrcRsKmu/b4mwF/U9l6C6rFnyKXJeqn9KDD1LU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UNdM7ukOoHkOBMfQHJolGI+vHYGcLDSO4BsWFuAljXemUn23NKlKAfRCoCJmezHMq
         5xgss60Rgww1taYngJ8C0h7rQvxkVxbaENGELGbxsmn4305I2yuYEW/Sp8gkVuDm2s
         flPclJYWicBb3bwCV7PHNLGDVyqpqlo2XsHoocUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.10] ([46.127.167.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1jwMCo0t1S-00Ey1Z; Mon, 03
 Aug 2020 02:46:28 +0200
Subject: Re: Restoring a raid0 for data rescue
To:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org,
        Phil Turmel <philip@turmel.org>, NeilBrown <neilb@suse.com>
References: <S1726630AbgHBR6v/20200802175851Z+2001@vger.kernel.org>
 <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
 <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
 <d8f9d16d-b6a2-77ba-bff2-a56c62dac5df@gmx.de>
 <057b0c58-3876-0f03-af33-86f3b266a18a@gmx.de>
 <4d48303b-b8f4-0749-cc6c-8d73ea77edb6@youngman.org.uk>
From:   tyranastrasz@gmx.de
Message-ID: <84492bfd-8a1b-6109-fb3f-a32ce25e740d@gmx.de>
Date:   Mon, 3 Aug 2020 02:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d48303b-b8f4-0749-cc6c-8d73ea77edb6@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7tpX92/XxndXMzVHI6UiHQPd+WNJAO99JoODIJ2kRJ6KwNA6Efj
 3QVKcnTdmNJvyejU947EKsiXzLrTHdgRQJm+D49XtXDy0yCV1kULo8NPYd3F/3kYpw6EfXj
 dTaAv3/vbaYy0rBp7WTzKec1/0lgLHApQYcmWALrCm1zBXrbz3ZdT+ZZddEYNjS+k0NUJqD
 PTEZHWxPqfJitegz6CKBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RXyV6qW+0YA=:AfzrhBDIN0ow3Y5HAcVGI4
 838wnWFsuXlMCe7Z3QEqEJuRm+6ODjaetraNBBVOa4J13EwhU87BE1q+8JqkQS057B+XO+FPC
 /wPC06gGmnErUFI6m21hHmowXvr4j2wQC2uX3bQCmRIX+86uomH9xcdUKxBeQ1aRSkZ/XdpEy
 ZIYRKaZThIdqBhB6La6Eang/yLzC+dK2pE+MPKe9qmZ+JyXIQcwmfCl9EwwB1rD3oHLjqeUAB
 O3tQqe/MIFUpOvj9gu9mby+p/fmaEDzxqAnXTc6sIRyYb2M4McCqNUp9lZFxEDo7+r+Ml65BH
 qGJXkihH/U8BuEcBhiTlVUxNweLvj17svKKP++txqd3T+RUSzLfrTy3/yjt1OkQ+GnmzlT9px
 puTWcw8VVemiBLUT3kdpLbdq9h4DX9SBuLhXmYIlljC5irFXd4Tcag7j66AIJQEAVlxcyXTqW
 W/05wh+rcbJJxxaSFkCZ1d+2ZtW22LGxOgYXbLFBihpFcJmUMl9fRKNGAA8nz1HgLeZSG4N07
 JmMJUCpRkWacWpQY4xgTOXC5jp9qKp96XYQS5kCH/65BSavWH+0pU/+Jds7nrjOzccYfq7Y0b
 R8Fb8jTIdE9hB/yC5KE02P+H4L9v9DMckX6LIeTkXdQ4hb83NCcJCvpMWyC13P1wG1Iqio10D
 pLrPucGOTMIw+W6e6HgrDnPd4a/j929fwQ1VeJLDjP7xYmowdWRj4jpVBfzW02+3RJU4eMLR7
 lELjNrNVBBkJEdJwiFKmKduhwjm7VPoUBr3884K9rPOy0LbNsHTApygEMwtYpx48smW+BNecv
 /hLfd6NkConfs1VyX+RpUn0DVRFamTGgqrCgkitBfxa1egVPQd7SVGuF9Tdjlm8nHgJ74nkVs
 SiQhLFWwONF7Jo+pcS3YYp1r6wa4+v3fr0Z6iwDptC1zez5qWhKNtjGvE7pwFy7vZtiFQJJJD
 DkUE4SJ+3WN9MaPojbNob9gykyOh4UH7Ai3KvRpIgOtNV2IwKXpnOz9EEezOHME1ktjM14sFC
 1aFZR0sv2Q983/BDrATFA0HClsGzsCTpsD2JPuelqPe9IVErDGkCPC/1h5n5essKv6Lnk/79V
 WEOZHY6X7OUeKbi/J9iHGteuBth/4yQgkPHHONZLiiQjVKLmQ46nxSDtewl6dUfR5AZOYUOzt
 pHLwEgZ1K7aFT6ySpvyIrfAWD/3WPb4HwjH1da0lRYKsRtEi4fqNR2Kp7rMyLnr8tD2+PlMfr
 wxBBqW/gIDIr+lCUjKEu80TJQQVAkOYXHCl6e6A==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02.08.20 22:50, antlists wrote:
> On 02/08/2020 21:38, tyranastrasz@gmx.de wrote:
>> On 02.08.20 21:24, tyranastrasz@gmx.de wrote:
>>> On 02.08.20 21:01, antlists wrote:
>>>> On 02/08/2020 19:09, tyranastrasz@gmx.de wrote:
>>>>> Hello
>>>>>
>>>>> I've a problem with my raid0.
>>>>> The probelmatic disks (2x 1TB wdred) were in usage in my server, now
>>>>> they got replaced with 3x 4TB seagate in a raid5.
>>>>>
>>>>> Before I turned them off, I made a backup on an external drive (norm=
al
>>>>> hdd via USB) via rsync -avx /source /mnt/external/
>>>>>
>>>>> Whatever happens in the night, the backup isn't complete and I miss
>>>>> files.
>>>>> So I put the old raid again into the server and wanted to start,
>>>>> but the
>>>>> Intel Raid Controller said that one of the disks are no member of a
>>>>> raid.
>>>>>
>>>>> My server mainboard is from Gigabyte a MX11-PC0.
>>>>>
>>>>> Well I made some mdadm examines, smartctl, mdstat, lsdrv logfiles an=
d
>>>>> attached them to the mail.
>>>>>
>>>> Ow...
>>>>
>>>> This is still the same linux on the server? Because mdstat says no ra=
id
>>>> personalities are installed. Either linux has changed or you've got
>>>> hardware raid. in which case you'll need to read up on the motherboar=
d
>>>> manual.
>>>>
>>>> I'm not sure what they're called, but try "insmod raid1x" I think it
>>>> is.
>>>> Could be raid0x. If that loads the raid0 driver, cat /proc/mdstat
>>>> should
>>>> list raid0 as a personality. Once that's there, mdadm may be able to
>>>> start the array.
>>>>
>>>> Until you've got a working raid driver in the kernel, I certainly can=
't
>>>> help any further. But hopefully reading the mobo manual might help. T=
he
>>>> other thing to try is an up-to-date rescue disk and see if that can
>>>> read
>>>> the array.
>>>>
>>>> Cheers,
>>>> Wol
>>>
>>> No, I have the disks in my pc.
>>> The server can't boot the disks because Intel Storage says the raid ha=
s
>>> a failure, because one of the disks has no raid information. But as I
>>> read them both yesterday they had, now (see the last attachment) one o=
f
>>> them has none.
>>> It makes no sense... I need the files
>>>
>>> Intel means "yeah make a new raid, with data loss" that's no option.
>>>
>>> Nara
>>
>>
>> I tried something what was told here
>> https://askubuntu.com/questions/69086/mdadm-superblock-recovery
>>
>> root@Nibler:~# mdadm --create /dev/md0 -v -f -l 0 -c 128 -n 2 /dev/sdd
>> /dev/sdb
>
> OH SHIT !!!
>
> You didn't try booting with a rescue disk? That mistake could well cost
> you the array :-( I'm out of my depth ...
>
> https://raid.wiki.kernel.org/index.php/Linux_Raid
> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>
> I've called in the heavy cavalry, and fortunately with 1.2 the damage
> might not be too bad.
>
> Here's hoping,
> Wol

What do you mean with 1.2?

Should I do?
https://raid.wiki.kernel.org/index.php/Recovering_a_damaged_RAID

I wait for an answer so I do it not more complicated :/
But is it not possible to merge both disks together into a virtual one,
block by block?
Our put the old superblock back?

I dunno what's the best solution.

Thanks
Nara
