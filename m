Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C431FA2
	for <lists+linux-raid@lfdr.de>; Sat,  1 Jun 2019 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFAODO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Jun 2019 10:03:14 -0400
Received: from mail.thelounge.net ([91.118.73.15]:27909 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfFAODO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 1 Jun 2019 10:03:14 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45GNM25mfSzXQV;
        Sat,  1 Jun 2019 16:03:05 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     keld@keldix.com, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <2d01a882-0902-b7b6-a359-80e04a919aaa@thelounge.net>
Date:   Sat, 1 Jun 2019 16:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190601085024.GA7575@www5.open-std.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 01.06.19 um 10:50 schrieb keld@keldix.com:
> On Sat, Jun 01, 2019 at 05:39:25AM +0000, Andy Smith wrote:
>> Hi,
>>
>> On Fri, May 31, 2019 at 09:43:35AM +0800, Guoqing Jiang wrote:
>>> On 5/30/19 3:41 AM, Andy Smith wrote:
>>>> By contrast RAID-10 seems to split the IOs much more evenly: 53% hit
>>>> the NVMe, and the average IOPS was only 35% that of RAID-1.
>>>>
>>>> Is this expected?
>>
>> [???]
>>
>>> There are some optimizations in raid1's read_balance for ssd, unfortunately,
>>> raid10 didn't have similar code.
>>
>> Thanks Guoqing, that certainly seems to explain it.
>>
>> Would it be worth mentioning in the man page and/or wiki that when
>> there are devices that are very mismatched, performance wise, RAID-1
>> is likely to be able to direct more reads to the faster device(s),
>> whereas RAID-10 can't do that?
>>
>> Is it just that no one has tried to apply the same optimizations to
>> RAID-10, or is it technically difficult/impossible to do this in
>> RAID-10?
> 
> Still, Andy, you need to cover all layouts of md raid10.
> 
> L know that for the far layout we actually had something that meant choosing the faster drives
> an thus it violated the striping on HDs, degrading read performance severely. A patch fixed that.
> 
> this patch did not apply  to the offset layout, so maybe that layout could satisfy your needs.
> 
> 
> it seems that there may be special code for SSDs in the md drivers.
> 
> I would like if we could use more precise terminology, RAID-10 could easily be understood
> as normal raid where you need 4 drives. The name "md raid10" is actually a bit misleading, 
> as for the 4-drive version it is actually a RAID-01 layout, which has poorer redudancy properties.

well, it would be nice just skip optimizations for rotating disks
entirely when the whole 4 disk RAID10 is built of SSD's
