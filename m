Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955E763F57
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 04:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGJCbz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 22:31:55 -0400
Received: from mail.thelounge.net ([91.118.73.15]:63261 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCbz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 22:31:55 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45k39N38xfzXMk;
        Wed, 10 Jul 2019 04:31:47 +0200 (CEST)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
 <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
 <006fbf98-ec73-818d-f9d1-fbe315dc0f60@thelounge.net>
 <30c63d5e-34fb-47ce-71f7-272fb4ef3d17@websitemanagers.com.au>
 <0640dd81-a4fe-5847-ec26-3a7dedd5872f@thelounge.net>
 <cb440d7c-e7eb-1826-3f9d-e7b44ab359f6@websitemanagers.com.au>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <5e40eefb-8158-8c2c-f28d-e9fb657fe6ce@thelounge.net>
Date:   Wed, 10 Jul 2019 04:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb440d7c-e7eb-1826-3f9d-e7b44ab359f6@websitemanagers.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 10.07.19 um 04:18 schrieb Adam Goryachev:
> On 10/7/19 11:57 am, Reindl Harald wrote:
>> Am 10.07.19 um 03:28 schrieb Adam Goryachev:
>>> PS, unless you were referring to 3 disk RAID10 as a joke?
>> exactly
>>
>>> TBH, I really don't understand RAID10, other than improving performance.
>>> For example, in a 10 drive RAID10, you have a higher probability to lose
>>> 2 drives that are a "pair" than losing 3 drives in total from a 7 drive
>>> RAID6 (both events lead to total data loss, although potentially you
>>> could recover more "usable" data from the RAID10 array since you would
>>> more likely have a large amount of contiguous data).
>> RAID10 is about performance *and* redundancy *as well* as storage size
>>
>> as said: 3 disk RAID10 is a joke and a 3 disk RAID1 is waste of size
>>
>> 3x2 TB RAID1 = 2 TB useable
>> 4x2 TB RAID10 = 4 TB useable
> 
> So for the cost of an extra 2TB drive, you got:
> 
> 1) An extra 2TB capacity - which the OP doesn't need
> 2) Less data protection, you can only lose a MAXIMUM of 2 disks without
> losing data, but if you lose the "wrong" 2 disks, then you lost all your
> data.
> 
> Using 4 x 2TB RAID1 (ie, same cost/number of disks) would mean you can
> lose any 3 disks with no data loss, and when you replace them, quick and
> simple recovery process. Even 3 x 2TB allows for ANY 2 disk failure
> without data loss.
> 
> The OP stated that performance and capacity was not something that
> interests him. The primary concern was avoiding the loss of data,
> presumably due to drive failure, perhaps availability is also important.
> 2TB is sufficient for 5 years.

don't change the fact that a 2 TB HDD (when we say performance is not
important) costs nothing these days and with RAID1 you are limited to
the write speed of a single disk

so if you are paranoid about drive failures get 6x1 TB = 300 € with 3 TB
useable which is exatcly between 3x2 RAID1 and 4x2 RAID10 :-)

that's 60 € per year over 5 years or one beer less per week....
