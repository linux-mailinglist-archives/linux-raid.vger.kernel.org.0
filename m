Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124DF23B1E7
	for <lists+linux-raid@lfdr.de>; Tue,  4 Aug 2020 02:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHDAvj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Aug 2020 20:51:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:53367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgHDAvj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 3 Aug 2020 20:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596502291;
        bh=wXNxlpRQEzYBd3gMN+L0SSu803X9BRLZK0hUKEwT0w8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XNOrio/O0xovVwG/1ieVz3iRomKkX7c6rTVU8L+PE5SbKYpwoqs+OCmHH/9oSICwa
         /+mxVDvVr4eMk8BALUzwO5sE9cAgIcJkzjJi+HjTJIb3g2+YBYrKAdMA0g6nWeXvxW
         wCEBXFyPw5k28MoaXPtMo4EbObn5xUR+mdvI0S5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.10] ([46.127.167.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1knfjd424R-017C1k; Tue, 04
 Aug 2020 02:51:31 +0200
Subject: Re: Restoring a raid0 for data rescue
To:     NeilBrown <neil@brown.name>, antlists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <S1726630AbgHBR6v/20200802175851Z+2001@vger.kernel.org>
 <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
 <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
 <d8f9d16d-b6a2-77ba-bff2-a56c62dac5df@gmx.de>
 <057b0c58-3876-0f03-af33-86f3b266a18a@gmx.de>
 <873654tkdy.fsf@notabene.neil.brown.name>
From:   tyranastrasz@gmx.de
Message-ID: <1f362a36-3aa3-4183-597d-ea2b3a624789@gmx.de>
Date:   Tue, 4 Aug 2020 02:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <873654tkdy.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ub90/BKApN1J+dUpuFF4pWpbmKotx+KtxoMmH1/ydZJRD39AwnO
 zX2aaUNrGwxgiSw/sW6mkOtxKimGhdZfAOHicHHRFxKzN5wiUddInHksuFuIPNTC+2JxMVz
 iuJNUCzK/U+KjzuMyVNGK7LvtJDH33EtlFS7srcob2Zha13xTa+s+Ip2dcdbKrVZQnytQtG
 3bCWHYgf+YdMvUKhRhlGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j+KzURu0O6A=:+11phRY7qZ+xoOtd1m/DYg
 t3VYYQkZs2/Hjl33RqSLQa/3ROzB+1ZLrj/Ji7g33QjXLzZmv2YXbk+h6Ow3H9niqvJAprpOp
 UFUVoJvkTraIkC0cUourYJeMftm6h9oRSMt80/c/vzEWLKvxsojxSpbnq5ZxKJ6ApF6ojV8nK
 8Clalc3gH/Jr4nI9GrjFxSpDV38Uly7X+3DAkr9TtVlU5p+qjRF7ygcQmDQtceNvjns1f6Gga
 oaz6Rzk3tEAWYyGkBdIYH3o24siANMe9bECaNqcaD+w/aO564e3RocuUOImJIquBOqMQ4ediv
 JX9x8HGMtxYXnWLYiOxYD8V3SSZcPyvHxuEeS1Aa7CACYH5L4T1mwnt+Kl5X6TpEAs/PfkaOD
 ZOlKZ3AEQruUA3SH560dHUUqK1CU6JRphbePKB0APWuAjbScUBJBckJ5tepIlCRTtCJ1fAYPZ
 9w+uDHjhgECEXooLXHjPol9FEH9zUKzP7YlryieUMSal/ntf+erJtopL24ejSL5wcSMdyEdY8
 tjgZ2fCE/8d8aXk4bwU9VuSxnR8ky0lUYhQ0VGZa2WrgUflFIdcmhJAjpByPZK8V5MlDEN4XP
 7OUDW53yRlhdDyxRUYggMn+/eTLWjB1aqhXcXXrzOHTlGveJMD0A+bFtGAJCHDSWIJmA3TN+y
 dh4bnKGr4KsaZqDtdDjzHyPmZmRLYBhEzTEdgbNqLNmcAET7YhSmTGP8GtOYcQ3A/BrczIChL
 CViCyIJAqb78WdTqPRl1HQFtAVy0DhKV2lTaDjdxNAcT7EdVk5guHheqAx+LSFVX5PlY4kfhv
 ZNNv8XwO+nkqLFWxkA1HlodyyG9mLmoGN0Hp0q/qq53lGxLFc2vWC7t9dsWtE9vcdXzAml/Ul
 BdIvntZR38oA93phDZpv482McN2YAKmepR5fQAK6iCuw9XpthkR+g9AROm0c0Tw2/ysohPlGH
 qFhvIY23se3Rh64KH0gQfaotFwnySMJEcmOwJylEcEyYiFJdZkeOk0dX69SAeqGbabrCh3lek
 FXuztDO8ZuS46UAy8oMyQelw0OyUYRgwO/MwTne6k7Q3OBaW2Jyjnd/LhiOQZ+iRHS/+O01N8
 y76NO61Cutw8O5lS/wO+1vDeybksTSqBaBRcK3zhnNCJG1BXmQjkjxGf6Rh18Atr6ngX7NF6B
 1F/7vNj/oczWJOQWoDvA9RL/TEjaU2t90OCKS/4AncnMre79KeMqnpsYMsliULj5k9B/B1MyJ
 ymAC+2i7cbdlD/S/q0B7LtRvee+kBy6HejJy3Ww==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Your numbers were correct, everything is perfect from you.
Yes it is everything on the 1800GB partition, ext4. It's consistency is
by 100%.
It worked perfectly!

You saved over 6 month of hard work!
Thank you so much!

The heatwave killed my braincells :/

All who helped get included of my godnight prayer, thank you :)

Nara
- Can now sleep well

On 03.08.20 06:37, NeilBrown wrote:
> On Sun, Aug 02 2020, tyranastrasz@gmx.de wrote:
>>
>> I tried something what was told here
>> https://askubuntu.com/questions/69086/mdadm-superblock-recovery
>>
>> root@Nibler:~# mdadm --create /dev/md0 -v -f -l 0 -c 128 -n 2 /dev/sdd
>> /dev/sdb
>
> That was a mistake.  I probably could have saved you before you did
> that.  Maybe I still can...
>
> You have an Intel IMSM RAID0 array over sdb and sdd.
> This was 3711741952 sectors in size using the first 1855871240 sectors
> of each device - data arranged in 7249496 256KiB stripes (128KiB on each
> device).
>
> This 1900GB array was partitioned into 3 partitions: 3MB, 1800MB,
> and 18MB.
>
> Presumably the data you want is on the 2nd partition: the 1800MB one?
>
> When you ran the "mdadm --create" command it wrote some meta data at the
> start of the device - probably only a 4K block at 8K from the start.
> This is before the first partition, so it might not have affected any
> data at all.  It may have corrupted the partition table.
>
> You need to put the array together again without writing anything to
> it.  Fortunately that is fairly easy with RAID0.
>
> 1/ If /dev/md0 still exists, stop it "mdadm --stop /dev/md0"
> 2/ put the two devices into a RAID0 with no metadata.
>      mdadm --build /dev/md0 -n 2 -z 927935620 -c 128 -l 0 /dev/sdb /dev/=
sdd
>
> 3/ create a read-only loop device over the second partition
>      losetup -r -o 4096K --sizelimit 7176980M /dev/loop0 /dev/md0
>
> 4/ Examine the filesystem at /dev/loop0 READ-ONLY.
>    You didn't say what sort of filesystem you used.  If ext4, then
>       fsck -n /dev/loop0
>
> 5/ If it looks good, try mounting /dev/loop0 READ-ONLY.
>
> I recommend that you FIRST read the relevant parts of the mdadm and
> losetup man pages, and check my arithmetic to make sure the numbers that
> I have given are correct.  If unsure, ask.
>
> If it doesn't work, I recommend reporting results, asking, and waiting
> before doing anything that might change anything on the drives.
>
> NeilBrown
>

