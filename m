Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C479AD5
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfG2VOs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 17:14:48 -0400
Received: from mail.thelounge.net ([91.118.73.15]:62521 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbfG2VOs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 17:14:48 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45yCBB733yzXPv;
        Mon, 29 Jul 2019 23:14:37 +0200 (CEST)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Roman Mamedov <rm@romanrm.net>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <20190730011850.2f19e140@natsu>
 <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <01a849c9-0b9c-2ba7-f866-c92e7ebac1d5@thelounge.net>
Date:   Mon, 29 Jul 2019 23:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 29.07.19 um 22:27 schrieb Guilherme G. Piccoli:
>> If that's correct, then this seems to be a critical weak point in cases when
>> we have a RAID0 as a member device in RAID1/5/6/10 arrays.
> 
> Hi Roman, I don't think this is usual setup. I understand that there are
> RAID10 (also known as RAID 0+1) in which we can have like 4 devices, and
> they pair in 2 sets of two disks using stripping, then these sets are
> paired using mirroring. This is handled by raid10 driver however, so it
> won't suffer for this issue.
> 
> I don't think it's common or even makes sense to back a raid1 with 2
> pure raid0 devices.
if i would have been aware that RAID10 don't support "--write-mostly" to
make a hybrid HDD/SSD RAID (https://www.tansi.org/hybrid/) i would
likely have done exactly that to buy only 2 instead 4 x 2 TB SSD disks
here and frankly i have another 5 machines where this limitation of
RAID110 on linux sucks
