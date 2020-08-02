Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B32235A39
	for <lists+linux-raid@lfdr.de>; Sun,  2 Aug 2020 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHBT0K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Aug 2020 15:26:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:33211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgHBT0K (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Aug 2020 15:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596396365;
        bh=dUG/HMuIU+kZhnP537wJxgZ615Ae0cIjPrdJZLKgK+k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lPOxo47sYPYfWKJgB8/dq+tofDIkPkDitxTx/LF8ivtZCF1bYKavsvgc57a4nJZfX
         TnIP66AoqKhfVoUZtGHnxp/7/WGu/CBLH5XsHE3JzsF7pF+IDU3nXQY5W6EeqFbJz/
         oDFjr6CQ3ZCIbiD15p9VcwNhUJsa/5jZdDSddQbk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.10] ([46.127.167.108]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1k4m433PeR-006Lsk; Sun, 02
 Aug 2020 21:26:04 +0200
Subject: Re: Restoring a raid0 for data rescue
To:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <S1726630AbgHBR6v/20200802175851Z+2001@vger.kernel.org>
 <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
 <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
From:   tyranastrasz@gmx.de
Message-ID: <d8f9d16d-b6a2-77ba-bff2-a56c62dac5df@gmx.de>
Date:   Sun, 2 Aug 2020 21:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ce+AL5alWDkgSoEmIEsOqh9z+q0IOzhwscecr+vogb9nog5WpYm
 qXEC2tui4JGCPZ3jh7GnQq/XVv01i8pmhgHA1IEN6DLh0zQZwIY6wOgMbpzxKz7y+MMFHVy
 sr8jXzCZH5TJFlRsI/kmlST4dSiswDB6SPrrL60egDwLDCxL/vJT+mN00px6QqtBJZrXNaK
 SpJuQiWPlTosZNcLgsSUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N7mPzhxiKtE=:3nq1oPLqOEvCZdBU0ssoRk
 RcRNvNZyRjz68IWQUXZl7M34ZaVfnyCCVY7tEWtYjrUqM25SDPr1v6BEkA2BMPaifAX86z4So
 m2/o6Nn73HNmvWNw5QUGnICMSFCk84vrPjt9NWu2JDKdGz8dxQ/0THuVC0yJnBNLcq5rJOOY4
 DwSbtokAHvcLkBTGMn/7sr5exH2jAWQfSy1xhDhbXetLX1pLKeXonVATrQ2ebffHsEAIbInbp
 I0CeczInqNUCOyytDf7tWFQcB2GKq8eIeOxY1n/cAQjespo/8gGQ61HEoYmyxExJ5n/wgapdG
 yB/cvbQInNlJPAznfN+7of23L7ZbmavvH4C40AzXFt4KW2op8VU1XHbhr0dFIw0TKqEOD9gAQ
 SFjmyudMN8vfF/CHvfv0ofMh6QW3BPDYU+NY3yRxRu5AbhEVCHFZxy/haY6sgxyIOAMjNa8S/
 lpyCTuKg9pCdVgS0oYxMK3+07lHCsJLiy2bq4MwaS7XhokK//XwgYknPPJUl3OA1hab/2FMAu
 AFt5fTIPrDD/9N4JNhOS48vhxCcG56L3xxJ1q8/k997TpyZVjZ4ecIT+v86UBw2/LYpJZ8RFb
 j8Bq2KwbkbzirCyta3OZjHN2H57SE65eDPE4rlvVgtciE36WIRSDA9x+gvW+tqFNIjy8IkEG7
 r1fKwQNPHqj/RfPH3Z6txXMhWtAYKp1qb9pPPxX2G9DMFHR2RxZ0oNMu6E1/sDvrlIJ2E0SbO
 e2CpQue04OhBw49VIxBKkMKr051IAoZ17zdKYioAAGzWnODOXGoIoi/rWTPUYaBM6kiA+IJs0
 6jI22inJ6+fG7ZSz6+6dVaxBSyCRPK4q/IRTe+dGBIU5qJ2PxRVVMspOdFcH+eFB1Vyym9mF5
 5466qjwHVcNzyMYjkGzhn/H5xeakaokARfg3LegYWr9DttsiuB2bEFnHHGpoJs+yCBs5nmAuc
 bRnZULQn1X//VkeH4HzVK5a/31YEZAVhiD/JQPkRRvAm/wSwSCjMaIwmIeWtfd2fq3xid94OZ
 Bi9MrUqwhSGqM020929EPDSDdbm9x9fQxT5ObfVUDmhhRUvIH8PMxjMFODgUbYqYIsO8sVYyw
 avNqO6VdHjYbWqFKHp4gdPwqFrkUVBONbSMdUuFJIPTrOpuI8qOZZLL1LiGvytsZxtxo8i96Y
 EB7nEBqHO7lwe5N14meW9RI8S1Km5Ibr7tqolSDqYQi6ex+gRph1AcDtUM0SRGkTNz238qyzf
 Tz8dYSy6TCF0Na47pCKKJ8u+2cFZZY+QqtTDMjQbeO+FYSVDHoyk3ak+7SuuASxgsb9UBXZQN
 pygj9vCNhbloPHN6wzkxbg2xO+57ExTawPmMyydpYpqp04a5qjXkO2kvacaRTTqMvqYpbmI+R
 XQvkDULEGBIYOlRl4LxIw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02.08.20 21:01, antlists wrote:
> On 02/08/2020 19:09, tyranastrasz@gmx.de wrote:
>> Hello
>>
>> I've a problem with my raid0.
>> The probelmatic disks (2x 1TB wdred) were in usage in my server, now
>> they got replaced with 3x 4TB seagate in a raid5.
>>
>> Before I turned them off, I made a backup on an external drive (normal
>> hdd via USB) via rsync -avx /source /mnt/external/
>>
>> Whatever happens in the night, the backup isn't complete and I miss
>> files.
>> So I put the old raid again into the server and wanted to start, but th=
e
>> Intel Raid Controller said that one of the disks are no member of a rai=
d.
>>
>> My server mainboard is from Gigabyte a MX11-PC0.
>>
>> Well I made some mdadm examines, smartctl, mdstat, lsdrv logfiles and
>> attached them to the mail.
>>
> Ow...
>
> This is still the same linux on the server? Because mdstat says no raid
> personalities are installed. Either linux has changed or you've got
> hardware raid. in which case you'll need to read up on the motherboard
> manual.
>
> I'm not sure what they're called, but try "insmod raid1x" I think it is.
> Could be raid0x. If that loads the raid0 driver, cat /proc/mdstat should
> list raid0 as a personality. Once that's there, mdadm may be able to
> start the array.
>
> Until you've got a working raid driver in the kernel, I certainly can't
> help any further. But hopefully reading the mobo manual might help. The
> other thing to try is an up-to-date rescue disk and see if that can read
> the array.
>
> Cheers,
> Wol

No, I have the disks in my pc.
The server can't boot the disks because Intel Storage says the raid has
a failure, because one of the disks has no raid information. But as I
read them both yesterday they had, now (see the last attachment) one of
them has none.
It makes no sense... I need the files

Intel means "yeah make a new raid, with data loss" that's no option.

Nara
