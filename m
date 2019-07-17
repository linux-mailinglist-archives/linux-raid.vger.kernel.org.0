Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF126C223
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGQUc7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 16:32:59 -0400
Received: from mail.thelounge.net ([91.118.73.15]:34345 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfGQUc7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 17 Jul 2019 16:32:59 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45ppqX09TgzXMk;
        Wed, 17 Jul 2019 22:32:50 +0200 (CEST)
Subject: Re: slow BLKDISCARD on RAID10 md block devices
To:     Peter Grandi <pg@mdraid.list.sabi.co.UK>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <20190717090200.GD2080@wantstofly.org>
 <20190717113352.GA13079@metamorpher.de>
 <23855.33990.595530.291667@base.ty.sabi.co.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <26ef3b9b-54d0-e660-8614-a45ddd2a4b1e@thelounge.net>
Date:   Wed, 17 Jul 2019 22:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23855.33990.595530.291667@base.ty.sabi.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Am 17.07.19 um 22:27 schrieb Peter Grandi:
> [...]
>> Total time (this is tmpfs-backed, no real I/O)
> 
> That's not even remotely realistic.
> 
>> (Why XFS trims 900G when I said 500G is a bit of a mystery...
> 
>>> # time fstrim -v --minimum 64M --offset 0G --length 500G /mnt/tmp/
> 
> My guess is that those limiting options are advisory: they rely
> on the ability of the filesystem code to easily and cheaply
> check whether a given range of physical addresses is free or
> used. Many filesystems have a "free list" optimized for the
> forward mapping fast "find a free block", not the reverse
> mapping "check whether a block is free".
> 
> A good option would have been to not do 'fstrim'/'blkdiscard'
> and put TRIM in 'fsck' (apparently that happens under MacOS X
> and 'e2fsck' also allows that).

how often do you reboot at all and then check your filesystems versus
blocks freed /data deleted?

and yes, fstrim takes ages after a reboot on a ext4 RAID10 with 2 TB
free space and it got worser with Linux 5.0
