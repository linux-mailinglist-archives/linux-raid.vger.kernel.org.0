Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE921C5144
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEEIvQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 04:51:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11261 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgEEIvQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 May 2020 04:51:16 -0400
Received: from [81.153.126.158] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jVtIH-0008Wp-Db; Tue, 05 May 2020 09:51:13 +0100
Subject: Re: RAID 1 | Test Booting from /dev/sdb
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5EB12900.3030505@youngman.org.uk>
Date:   Tue, 5 May 2020 09:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/05/20 09:11, Stefanie Leisestreichler wrote:
> Hi.
> I want to test if grub is installed on both of the HDs which are part of
> my raid1 array. I wonder which would be the best solution to do so.
> 
> I think I will archive that when I shutdown the computer, make /dev/sda
> powerless and see if it is able to boot from /dev/sdb.
> 
> If it is not booting /dev/sdb will have no changes, I would shutdown,
> connect /dev/sda with power again, turn it on and do a "grub-install
> /dev/sdb". Depending on the state of the array (I guess it will need
> recovery) I would do a "mdadm /dev/md0 --add /dev/sdb1". After recovery
> I would try it again.
> 
> If it is booting from /dev/sdb this HD will have "more" data because of
> the one boot process than /dev/sda.

Why? If it boots to the grub menu, just hit an arrow key to stop the
timeout, and then hold the power button for 5 secs to shut it down again.

> I am not sure if it is a good idea
> to shutdown and just connect /dev/sda with power again, boot (assuming
> /dev/sda is the standard boot medium) because I do not know in which
> state the array will be. What to do in case I do not want to loose data
> from the last boot process with /dev/sdb?

Which would matter why? If you're worried about downloading mail etc,
just kill the network temporarily.

> Change boot medium to /dev/sdb
> and do a "mdadm /dev/md0 --add /dev/sda1" to get it recovered again
> without loosing the "added" data (i.e. in /var/log) from booting? Also
> device identifiers could change I guess. Even if I am fine with loosing
> the "added" data from booting with /dev/sdb, will - when booting again
> from /dev/sda - /dev/sda be the master in the array again?
> 
> It is not clear to me if I understood correctly in which case which
> array member will be the master which will be the base for recovery. Is
> it always the HD one booted from?
> 
The "master" if recovery is required will be the "older" one - in this
case sda because it was disconnected. HOWEVER. Just check whether you
have a bitmap or journal enabled. You can't have both at once, but the
result should be that sda rejoins the array cleanly, raid has a record
of which writes occurred while it was offline, and it will be updated.

> Could you please help me with that?
> 
> Thanks,
> Steffi

Cheers,
Wol
