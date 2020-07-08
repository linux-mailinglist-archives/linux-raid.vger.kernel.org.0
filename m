Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC721861B
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jul 2020 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgGHL3V (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jul 2020 07:29:21 -0400
Received: from forward103p.mail.yandex.net ([77.88.28.106]:37323 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbgGHL3V (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jul 2020 07:29:21 -0400
Received: from mxback25j.mail.yandex.net (mxback25j.mail.yandex.net [IPv6:2a02:6b8:0:1619::225])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 5E2C218C02EE;
        Wed,  8 Jul 2020 14:29:14 +0300 (MSK)
Received: from iva1-bc1861525829.qloud-c.yandex.net (iva1-bc1861525829.qloud-c.yandex.net [2a02:6b8:c0c:a0e:0:640:bc18:6152])
        by mxback25j.mail.yandex.net (mxback/Yandex) with ESMTP id S3gzMbfceg-TEfOegUL;
        Wed, 08 Jul 2020 14:29:14 +0300
Received: by iva1-bc1861525829.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id UXS6K2yUJb-TDl4kEmA;
        Wed, 08 Jul 2020 14:29:13 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl>
 <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl>
 <CAPhsuW59Q7mU9WH36RHs9kb-TMk7FmrQL+JCApupf_TZtpWynA@mail.gmail.com>
 <4a03e900-61a8-f150-9be8-739e88ba8ce6@yandex.pl>
 <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
 <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl>
 <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
 <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl>
 <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
 <57247f5e-ec38-fb8c-9684-abbe699945fb@yandex.pl>
 <CAPhsuW4hnpsbhQWWNKqgnw4nhp4Ho+gFbPU2fGjoMOcM8y7L+Q@mail.gmail.com>
 <15a3dd66-39a9-894d-3e72-d231cf36758e@yandex.pl>
 <4577498e-4124-ac6f-9d76-1f039fa1ba80@yandex.pl>
 <CAPhsuW4Y-23m7JexbnUCO3pq6+yTNrMrN6v-od+FFzZU8PgCdA@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <40054126-5009-3633-b7f9-198c2cc53ce7@yandex.pl>
Date:   Wed, 8 Jul 2020 13:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4Y-23m7JexbnUCO3pq6+yTNrMrN6v-od+FFzZU8PgCdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/7/20 12:08 AM, Song Liu wrote:
>>
>> So, what kind of next step after this ?
> 
> Sorry for the delay. I read the log again, and found the following
> line caused this issue:
> 
> [ +16.088243] r5l_write_super_and_discard_space set MD_SB_CHANGE_PENDING
> 
> The attached patch should workaround this issue. Could you please give it a try?

Yea, this solved the issue - the raid assembled correctly (so the patch 
is probably a good candidate for lts kernels).

Thanks for helping with this bug.

Underlying filesystems are mountable/usable as well - albeit read-only 
fsck (ext4) or btrfs check do find some minor issues; tough to say at 
this point what was the exact culprit.

In this particular case - imho - one issue remains: the assembly is 
slower than full resync (without bitmap), which outside of some 
performance gains (writeback journal) and write-hole fixing - kind of 
completely defeats the point of having such resync policy in the first 
place.

dmesg -H | grep r5c_recovery_flush_log

[ +13.550877] r5c_recovery_flush_log processing ctx->seq 860700000
[Jul 7 15:16] r5c_recovery_flush_log processing ctx->seq 860800000
[Jul 7 15:40] r5c_recovery_flush_log processing ctx->seq 860900000
...
[Jul 8 06:40] r5c_recovery_flush_log processing ctx->seq 866300000
[Jul 8 06:58] r5c_recovery_flush_log processing ctx->seq 866400000
[Jul 8 07:20] r5c_recovery_flush_log processing ctx->seq 866500000

During those periods when I was testing your patches, the machine has 
always been basically idle - no cpu/io/waits, or anything that could 
hamper it. The read process going from the journal device (ssds) was 
averaging 1-4 mb/s.
