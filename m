Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF911EBC2
	for <lists+linux-raid@lfdr.de>; Fri, 13 Dec 2019 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfLMURP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Dec 2019 15:17:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41107 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfLMURO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 13 Dec 2019 15:17:14 -0500
Received: from [IPv6:2601:646:8600:3281:90ef:ce89:f69e:2b3c] ([IPv6:2601:646:8600:3281:90ef:ce89:f69e:2b3c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xBDKH6eV1515506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 13 Dec 2019 12:17:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xBDKH6eV1515506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019111901; t=1576268227;
        bh=hP5r9+ebR4i6c1zOjrBw3oU3B1zCY82K7wxozuPI2vw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=OmUJq5tIb0mr0GswtH3YB71lC1+KQyLnTFN+o6bG+My/83K3J6LXK5afUPl2VRIEz
         EEo47m3OYzVz00rNBDmapX+KO34znh8R/18ecRU8rgJ2tR52v8HvZU3YuTFUZGCrx9
         Lyqj3WJyf8phcgBLC8IELv9XGq9NCTQsP/1n0a78fvCemro1YI6E2t++loxHrt1+6P
         +Bvgk1XOb9k80I77rjNXtu0hZLC6V0YgwDy2jK7lzrcSMdbGzzGySFLrimbqZKUe53
         O46rOT7HElK0J1MxhFHYCl4ecr72P4zodpEdlXj7J4NUREUJUYzaQueLce0tE57qiP
         M52XQrQd0bCPg==
Date:   Fri, 13 Dec 2019 12:16:58 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <215873cc-999c-b627-ed7e-348c1acc4e1a@kylinos.cn>+94A324C49A619E37
References: <20191205031318.7098-1-liuzhengyuan@kylinos.cn> <20191205031318.7098-2-liuzhengyuan@kylinos.cn> <CAPhsuW7ZYYB6CQY48TjQ86cRJianE5dL07gNKJA-WLYM_AMmsQ@mail.gmail.com> <2b57d709-aa3e-5e3a-25b7-b530ffb6902e@kylinos.cn> <D472AFC5-4C38-457E-A841-C9C2D712FFCE@zytor.com> <215873cc-999c-b627-ed7e-348c1acc4e1a@kylinos.cn>+94A324C49A619E37
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        Song Liu <liu.song.a23@gmail.com>
CC:     linux-raid <linux-raid@vger.kernel.org>, liuzhengyuang521@gmail.com
From:   hpa@zytor.com
Message-ID: <A6BE4D77-6622-4810-A062-7B0C9AB7222A@zytor.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On December 13, 2019 9:12:47 AM PST, Zhengyuan Liu <liuzhengyuan@kylinos=2E=
cn> wrote:
>
>
>On 2019/12/13 =E4=B8=8A=E5=8D=8812:29, hpa@zytor=2Ecom wrote:
>> On December 12, 2019 8:08:36 AM PST, Zhengyuan Liu
><liuzhengyuan@kylinos=2Ecn> wrote:
>>>
>>>
>>> On 2019/12/12 =E4=B8=8A=E5=8D=883:26, Song Liu wrote:
>>>> On Wed, Dec 4, 2019 at 7:13 PM Zhengyuan Liu
>>> <liuzhengyuan@kylinos=2Ecn> wrote:
>>>>>
>>>>> There are several algorithms available for raid6 to generate xor
>and
>>> syndrome
>>>>> parity, including basic int1, int2 =2E=2E=2E int32 and SIMD optimize=
d
>>> implementation
>>>>> like sse and neon=2E  To test and choose the best algorithms at the
>>> initial
>>>>> stage, we need provide enough disk data to feed the algorithms=2E
>>> However, the
>>>>> disk number we provided depends on page size and gfmul table,
>seeing
>>> bellow:
>>>>>
>>>>>           int __init raid6_select_algo(void)
>>>>>           {
>>>>>                   const int disks =3D (65536/PAGE_SIZE) + 2;
>>>>>                   =2E=2E=2E
>>>>>           }
>>>>>
>>>>> So when come to 64K PAGE_SIZE, there is only one data disk plus 2
>>> parity disk,
>>>>> as a result the chosed algorithm is not reliable=2E For example, on
>my
>>> arm64
>>>>> machine with 64K page enabled, it will choose intx32 as the best
>>> one, although
>>>>> the NEON implementation is better=2E
>>>>
>>>> I think we can fix this by simply change raid6_select_algo()? We
>>> still have
>>>
>>> Actually I fixed this by only changing raid6_select_algo() in patch
>V1,
>>>
>>> but I found lib/raid6/test has also defined a block size named
>>> PAGE_SIZE
>>> for himself in pq=2Eh:
>>>
>>> 	#ifndef PAGE_SIZE
>>> 	# define PAGE_SIZE 4096
>>> 	#endif
>>>
>>> There is no need to separately define two block size for testing,
>just
>>> unify them to use one=2E
>>>
>>>>
>>>> #define STRIPE_SIZE             PAGE_SIZE
>>>>
>>>> So testing with PAGE_SIZE represents real performance=2E
>>>>
>>> I originally preferred to choose PAGE_SIZE as the block size, but
>there
>>>
>>> is no suitable data source since gmful table has only 64K=2E It's too
>>> expensive to use a random number generator to fill all the data=2E
>>>
>>> My test result shows there is no obvious differences between 4k
>block
>>> size and 64 block size under 64k PAGE_SIZE=2E
>>>
>>> Thanks,
>>> Zhengyuan
>>>> Thanks,
>>>> Song
>>>>
>>=20
>> The test directory tests mainly for correctness, not comparative
>performance=2E
>>=20
>> The main reason for use a full page as the actual RAID code will
>would be for architectures which may have high setup overhead, such as
>off-core accelerators=2E In that case using a smaller buffer may give
>massively wrong results and we lose out on the use of the accelerator
>unless we have hardcoded priorities; the other thing is that you might
>find that your data set fits in a lower level cache that would be
>realistic during actual operation, which again would give very wrong
>results for cache bypassing vs non-bypassing algorithms=2E
>>=20
>> The use of the RAID-6 coefficient table is just a matter of
>convenience; it was already there, and at that time the highest page
>size in use was 32K; this is also why zisofs uses that block size by
>default=2E I wanted to about multiple dynamic allocations as much as
>possible in order to avoid cache- or TLB-related nondeterminism=2E
>
>Thanks for the detailed explanations=2E
>
>>=20
>> The more I think about it, the more I think that he best thing to do
>is to do a single order-3 dynamic allocation, and just fill the first
>six pages with some arbitrary content (either copying the table as many
>times as needed, but it would be better to use a deterministic PRNG
>which is *not* Galois field based; something as simple as x1 =3D A*x0 + B
>where A is a prime should be plenty fine) and use the second two as the
>target buffer, then to the benchmarking with 6 data disks/8 total disks
>for all architectures; this then also models the differences in RAID
>stripe size=2E  We are running in a very benign environment at this
>point, so if we end up sleeping a bit to be able to do a high order
>allocation, it is not a problem (and these days, the mm can do
>compaction if needed=2E)
>>=20
>
>Actually I had tried to fix this problem, as you suggested about three=20
>years ago, by simply doing a order-3 allocation and fill them with a=20
>PRNG(patch V1 uses a simple linear congruential PRNG which was not=20
>suitable as you pointed out and patch V2 uses a non-linear PRNG which=20
>seems to be a bit overkill), seeing the discussion in bellow link:
>
>https://groups=2Egoogle=2Ecom/forum/#!msg/fa=2Elinux=2Ekernel/5uoxjvg0_gg=
/mk_ekZrOBgAJ
>
>To make things as simple as possible,I think we can just copy table=2E

You're right, we have more or less come fill circle=2E=2E=2E I still think=
 it is the best choice=2E

Maybe use plain kmalloc() instead, though, and I strongly suggest using __=
GFP_NOFAIL instead of failing to initialize=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
