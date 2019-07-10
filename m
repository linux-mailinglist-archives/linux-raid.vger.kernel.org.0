Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D663F94
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGJDOq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 23:14:46 -0400
Received: from mail.thelounge.net ([91.118.73.15]:19643 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGJDOp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 23:14:45 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45k46q2yMmzXMk;
        Wed, 10 Jul 2019 05:14:43 +0200 (CEST)
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
 <5e40eefb-8158-8c2c-f28d-e9fb657fe6ce@thelounge.net>
 <4c4338ea-f5a2-21cf-1c54-2a3a5819d89f@websitemanagers.com.au>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <72148027-089c-3f7f-1bf7-a7747e9f8f63@thelounge.net>
Date:   Wed, 10 Jul 2019 05:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4c4338ea-f5a2-21cf-1c54-2a3a5819d89f@websitemanagers.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 10.07.19 um 05:01 schrieb Adam Goryachev:
> On 10/7/19 12:31 pm, Reindl Harald wrote:
>> so if you are paranoid about drive failures get 6x1 TB = 300 € with 3 TB
>> useable which is exatcly between 3x2 RAID1 and 4x2 RAID10 :-)
> 
> Assuming you are now suggesting 6 x 1TB in RAID10 with 2 mirrors (to get
> 3TB usable) then you are still suffering from the 2 drive failures
> causing loss of all data (although potentially you can lose 3 with no
> data loss). 

i yet need to see an array with 6 different disks where 2 are failing at
the same time which in this case needs to be the two right ones making a
stripe-mirror.... at least you have decent write performance while a
RAID1 with 6 mirrors sucks

and about "OP advised their system can only support a maximum of 3
drives" i need to see that hardware - even the HP microservers have 4
slots and while my HP desktop from 2011 only "supports" 3 disks there
are adapters to place a 2.5" or 3.5" disk or in case of SSDs 4x2.5" in a
5.25 slot

the only hardware i ever seen with 3 slots are Apple X-Serve and i would
throw them away anyways but also any other box not support RAID10 at all
