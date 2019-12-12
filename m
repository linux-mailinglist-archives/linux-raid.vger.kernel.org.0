Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616A011D246
	for <lists+linux-raid@lfdr.de>; Thu, 12 Dec 2019 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfLLQ3p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Dec 2019 11:29:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44581 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfLLQ3p (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 12 Dec 2019 11:29:45 -0500
Received: from [IPv6:2601:646:8600:3281:2420:25f9:3c97:b919] ([IPv6:2601:646:8600:3281:2420:25f9:3c97:b919])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xBCGTb1G927684
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 12 Dec 2019 08:29:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xBCGTb1G927684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019111901; t=1576168179;
        bh=nuP/4boowKzJPhRi4j0fQm7kFXqb9kxlqDSnY97fFMo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=szqb3mNKQG7qQu+wWrwJb+Zfi6Rl7VzIyNFTxTZSpodGrdwveN963qawqO3A1lO/H
         G9Lqt7sWO5ERS6vViZkui9VXsSohzTleG10//6kDdXgYOLfHb88wk98tMcYa6p9kFc
         pazbs4bdx80kpiTmFKGZS7QBP73SYeLs+ABy3ZaNRGnoV3CCJy43IDPBEer5lGF1pc
         4T6tKyq5qLz597qjb/13wvGNIUfNaWx8Mre/RhDq259KwSCiqseyUkyILBl46bP5YO
         7UmdVdXnzBcYI09dp2kN3f+dyIEOQeKFzkVLd9DAbPesbaF/uBqu4cNW6EMsYb6gtT
         h/mx65TKYJZUw==
Date:   Thu, 12 Dec 2019 08:29:29 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <2b57d709-aa3e-5e3a-25b7-b530ffb6902e@kylinos.cn>+92742B149C89862B
References: <20191205031318.7098-1-liuzhengyuan@kylinos.cn> <20191205031318.7098-2-liuzhengyuan@kylinos.cn> <CAPhsuW7ZYYB6CQY48TjQ86cRJianE5dL07gNKJA-WLYM_AMmsQ@mail.gmail.com> <2b57d709-aa3e-5e3a-25b7-b530ffb6902e@kylinos.cn>+92742B149C89862B
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        Song Liu <liu.song.a23@gmail.com>
CC:     linux-raid <linux-raid@vger.kernel.org>, liuzhengyuang521@gmail.com
From:   hpa@zytor.com
Message-ID: <D472AFC5-4C38-457E-A841-C9C2D712FFCE@zytor.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On December 12, 2019 8:08:36 AM PST, Zhengyuan Liu <liuzhengyuan@kylinos=2E=
cn> wrote:
>
>
>On 2019/12/12 =E4=B8=8A=E5=8D=883:26, Song Liu wrote:
>> On Wed, Dec 4, 2019 at 7:13 PM Zhengyuan Liu
><liuzhengyuan@kylinos=2Ecn> wrote:
>>>
>>> There are several algorithms available for raid6 to generate xor and
>syndrome
>>> parity, including basic int1, int2 =2E=2E=2E int32 and SIMD optimized
>implementation
>>> like sse and neon=2E  To test and choose the best algorithms at the
>initial
>>> stage, we need provide enough disk data to feed the algorithms=2E
>However, the
>>> disk number we provided depends on page size and gfmul table, seeing
>bellow:
>>>
>>>          int __init raid6_select_algo(void)
>>>          {
>>>                  const int disks =3D (65536/PAGE_SIZE) + 2;
>>>                  =2E=2E=2E
>>>          }
>>>
>>> So when come to 64K PAGE_SIZE, there is only one data disk plus 2
>parity disk,
>>> as a result the chosed algorithm is not reliable=2E For example, on my
>arm64
>>> machine with 64K page enabled, it will choose intx32 as the best
>one, although
>>> the NEON implementation is better=2E
>>=20
>> I think we can fix this by simply change raid6_select_algo()? We
>still have
>
>Actually I fixed this by only changing raid6_select_algo() in patch V1,
>
>but I found lib/raid6/test has also defined a block size named
>PAGE_SIZE=20
>for himself in pq=2Eh:
>
>	#ifndef PAGE_SIZE
>	# define PAGE_SIZE 4096
>	#endif
>
>There is no need to separately define two block size for testing, just=20
>unify them to use one=2E
>
>>=20
>> #define STRIPE_SIZE             PAGE_SIZE
>>=20
>> So testing with PAGE_SIZE represents real performance=2E
>>=20
>I originally preferred to choose PAGE_SIZE as the block size, but there
>
>is no suitable data source since gmful table has only 64K=2E It's too=20
>expensive to use a random number generator to fill all the data=2E
>
>My test result shows there is no obvious differences between 4k block=20
>size and 64 block size under 64k PAGE_SIZE=2E
>
>Thanks,
>Zhengyuan
>> Thanks,
>> Song
>>=20

The test directory tests mainly for correctness, not comparative performan=
ce=2E

The main reason for use a full page as the actual RAID code will would be =
for architectures which may have high setup overhead, such as off-core acce=
lerators=2E In that case using a smaller buffer may give massively wrong re=
sults and we lose out on the use of the accelerator unless we have hardcode=
d priorities; the other thing is that you might find that your data set fit=
s in a lower level cache that would be realistic during actual operation, w=
hich again would give very wrong results for cache bypassing vs non-bypassi=
ng algorithms=2E

The use of the RAID-6 coefficient table is just a matter of convenience; i=
t was already there, and at that time the highest page size in use was 32K;=
 this is also why zisofs uses that block size by default=2E I wanted to abo=
ut multiple dynamic allocations as much as possible in order to avoid cache=
- or TLB-related nondeterminism=2E

The more I think about it, the more I think that he best thing to do is to=
 do a single order-3 dynamic allocation, and just fill the first six pages =
with some arbitrary content (either copying the table as many times as need=
ed, but it would be better to use a deterministic PRNG which is *not* Galoi=
s field based; something as simple as x1 =3D A*x0 + B where A is a prime sh=
ould be plenty fine) and use the second two as the target buffer, then to t=
he benchmarking with 6 data disks/8 total disks for all architectures; this=
 then also models the differences in RAID stripe size=2E  We are running in=
 a very benign environment at this point, so if we end up sleeping a bit to=
 be able to do a high order allocation, it is not a problem (and these days=
, the mm can do compaction if needed=2E)
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
