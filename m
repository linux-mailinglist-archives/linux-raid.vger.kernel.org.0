Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3227930010
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE3QSy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 12:18:54 -0400
Received: from mail.thelounge.net ([91.118.73.15]:61651 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3QSy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 May 2019 12:18:54 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45FCSW0XFTzXSN;
        Thu, 30 May 2019 18:18:51 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     keld@keldix.com, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
 <bd4ac362-6d91-df02-d7df-84de54dd90bf@thelounge.net>
 <20190530155834.GA21315@www5.open-std.org>
 <20190530161614.GA16683@cthulhu.home.robinhill.me.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <d0c68176-0743-520c-2d1f-b6c3dd284252@thelounge.net>
Date:   Thu, 30 May 2019 18:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530161614.GA16683@cthulhu.home.robinhill.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.05.19 um 18:16 schrieb Robin Hill:
> On Thu May 30, 2019 at 05:58:34PM +0200, keld@keldix.com wrote:
> 
>> On Thu, May 30, 2019 at 04:37:43PM +0200, Reindl Harald wrote:
>>>
>>>
>>> Am 30.05.19 um 12:04 schrieb keld@keldix.com:
>>>> you need to clarify which layout you use with md raid10.
>>>> the layouts are near, far and offset, with very different performance characteristics.
>>>> far and offset are designed to be faster than near, which I understand that you use.
>>>> So why are you using the slowest md raid10 layout, and not mentioning this fact?
>>>
>>> besides that when you install a distribution like Fedora "near" is
>>> default for pure reads it shouldn't be slower than RAID1 at all, just
>>> read from both mirrors of the stripe
>>
>> near is mdadm default, so people often do not realize the faster options.
>>  
> Are they not only faster on physical disks? The OP indicated they have
> an SSD and an NVMe, so I don't see why any of the RAID-10 variations
> would perform any better.

because what matters is the question over how many drives the read is
spread - read from 4 lightning fast drives at the ame time is still
faster then read only from one - as long there is not other bottenleck
