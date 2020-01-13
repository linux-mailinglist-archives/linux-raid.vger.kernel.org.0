Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76613943D
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgAMPEY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 10:04:24 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:24996 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMPEX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 10:04:23 -0500
Received: from [81.135.72.163] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ir1GP-0004GC-Cl; Mon, 13 Jan 2020 15:04:22 +0000
Subject: Re: Reassembling Raid5 in degraded state
To:     Christian Deufel <christian.deufel@inview.de>,
        linux-raid@vger.kernel.org
References: <54384251-9978-eb99-e7ec-2da35f41566c@inview.de>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Cc:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>
Message-ID: <5E1C86F4.4070506@youngman.org.uk>
Date:   Mon, 13 Jan 2020 15:04:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <54384251-9978-eb99-e7ec-2da35f41566c@inview.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13/01/20 09:41, Christian Deufel wrote:
> My plan now would be to run mdadm --assemble --force /dev/md3 with 3
> disk, to get the Raid going in a degraded state.

Yup, this would almost certainly work. I would recommend overlays and
running a fsck just to check it's all okay before actually doing it on
the actual disks. The event counts say to me that you'll probably lose
little to nothing.

> Does anyone have any experience in doing so and can recommend which 3
> disks I should use. I would use sdc1 sdd1 and sdf1, since sdd1 and sdf1
> are displayed as active sync in every examine and sdc1 as it is also
> displayed as active sync.

Those three disks would be perfect.

> Do you think that by doing it this way I have a chance to get my Data
> back or do you have any other suggestion as to get the Data back and the
> Raid running again?

You shouldn't have any trouble, I hope. Take a look at

https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

and take note of the comment about using the latest mdadm - what version
is yours (mdadm --version)? That might assemble the array no problem at all.

Song, Neil,

Just a guess as to what went wrong, but the array event count does not
match the disk counts. Iirc this is one of the events that cause an
assemble to stop. Is it possible that a crash at the wrong moment could
interrupt an update and trigger this problem?

Cheers,
Wol
