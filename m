Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C939C72
	for <lists+linux-raid@lfdr.de>; Sat,  8 Jun 2019 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFHKjH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 8 Jun 2019 06:39:07 -0400
Received: from mail.thelounge.net ([91.118.73.15]:34605 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKjH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 8 Jun 2019 06:39:07 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45LbVH6CM7zXQV;
        Sat,  8 Jun 2019 12:38:58 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     Sarah Newman <srn@prgmr.com>, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190607112219.GA4569@bitfolk.com>
 <e0aa2876-cd07-8c38-97f7-a72b279f28e3@prgmr.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <0b7a417e-aea0-878e-aace-364d6c71cf80@thelounge.net>
Date:   Sat, 8 Jun 2019 12:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e0aa2876-cd07-8c38-97f7-a72b279f28e3@prgmr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 08.06.19 um 07:15 schrieb Sarah Newman:
> On 6/7/19 4:22 AM, Andy Smith wrote:
>> On Sat, Jun 01, 2019 at 05:39:25AM +0000, Andy Smith wrote:
>>> On Fri, May 31, 2019 at 09:43:35AM +0800, Guoqing Jiang wrote:
>>>> There are some optimizations in raid1's read_balance for ssd, unfortunately,
>>>> raid10 didn't have similar code.
>>
>> […]
>>
>>> Is it just that no one has tried to apply the same optimizations to
>>> RAID-10, or is it technically difficult/impossible to do this in
>>> RAID-10?
>>
>> Guoqing sent me a patch off-list that implements these same device
>> selection optimizations to RAID-10, and it seems to work. RAID-10
>> random read performance in this setup is now the same as RAID-1
>> (both very near to fastest device) and sequential read is even
>> better than RAID-1.
>>
>>     http://strugglers.net/~andy/blog/2019/06/06/linux-raid-10-fixed-on-imbalanced-devices/
> 
> We've been seriously considering switching from raid10 to lvm stripes across raid1 for a different reason.
> 
> Crucial/Micron SSDs, even the enterprise ones, do not always finish smart tests under some read loads. With RAID1 we could set them temporarily to
> write-mostly so that they can finish their smart tests and vendor tests. It would be really nice if with RAID10 we could also set drives to write-mostly.

funny, 2 years ago as i came up with that after finding out the hard way
that my hybrid RAID10 don't work as expected nobody cared at all except
one guy which after some negative respone statet that he isn't a kernel
developer at all....

obiously that linux RAID10 is not a RAID10 as anywhere else now comes
with it's drawbaks and the optimizatiojs from the past for rotating
media becone a problem these days
