Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93DD2C82A4
	for <lists+linux-raid@lfdr.de>; Mon, 30 Nov 2020 11:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgK3Kvp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Nov 2020 05:51:45 -0500
Received: from mail.thelounge.net ([91.118.73.15]:36203 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgK3Kvp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Nov 2020 05:51:45 -0500
X-Greylist: delayed 1161 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 05:51:44 EST
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4Cl1k52mQWzXVl;
        Mon, 30 Nov 2020 11:31:41 +0100 (CET)
To:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <e6b7a61d16a25c433438c670fa4c0b4f@posteo.de>
 <bc15926a-8bf4-14ae-bd67-ae14d915d4c0@youngman.org.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Subject: =?UTF-8?Q?Re=3a_=e2=80=9croot_account_locked=e2=80=9d_after_removin?=
 =?UTF-8?Q?g_one_RAID1_hard_disc?=
Message-ID: <0fd4f7e5-b71d-0c53-baca-d483d7872981@thelounge.net>
Date:   Mon, 30 Nov 2020 11:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <bc15926a-8bf4-14ae-bd67-ae14d915d4c0@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.11.20 um 10:27 schrieb antlists:
>> I read that a single RAID1 device (the second is missing) can be 
>> accessed without any problems. How can I do that?
> 
> When a component of a raid disappears without warning, the raid will 
> refuse to assemble properly on next boot. You need to get at a command 
> line and force-assemble it

since when is it broken that way?

from where should that commandlien come from when the operating system 
itself is on the for no vali dreason not assembling RAID?

luckily the past few years no disks died but on the office server 300 
kilometers from here with /boot, os and /data on RAID1 this was not true 
at least 10 years

* disk died
* boss replaced it and made sure
   the remaining is on the first SATA
   port
* power on
* machine booted
* me partitioned and added the new drive

hell it's and ordinary situation for a RAID that a disk disappears 
without warning because they tend to die from one moment to the next

hell it's expected behavior to boot from the remaining disks, no matter 
RAID1, RAID10, RAID5 as long as there are enough present for the whole 
dataset

the only thing i expect in that case is that it takes a little longer to 
boot when soemthing tries to wait until a timeout for the missing device 
/ componenzt


