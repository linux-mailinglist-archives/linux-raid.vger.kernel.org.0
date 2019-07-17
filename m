Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3451F6C269
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGQVEk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 17:04:40 -0400
Received: from mail.thelounge.net ([91.118.73.15]:18199 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQVEj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 17 Jul 2019 17:04:39 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45pqX52VRKzXMk;
        Wed, 17 Jul 2019 23:04:37 +0200 (CEST)
Subject: Re: slow BLKDISCARD on RAID10 md block devices
To:     Peter Grandi <pg@mdraid.list.sabi.co.UK>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <20190717090200.GD2080@wantstofly.org>
 <20190717113352.GA13079@metamorpher.de>
 <23855.33990.595530.291667@base.ty.sabi.co.uk>
 <26ef3b9b-54d0-e660-8614-a45ddd2a4b1e@thelounge.net>
 <23855.35565.981137.953275@base.ty.sabi.co.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <aa0f1547-9e86-286a-e9b6-a83237e79cf3@thelounge.net>
Date:   Wed, 17 Jul 2019 23:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23855.35565.981137.953275@base.ty.sabi.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 17.07.19 um 22:54 schrieb Peter Grandi:
>>> [...] Many filesystems have a "free list" optimized for the
>>> forward mapping fast "find a free block", not the reverse
>>> mapping "check whether a block is free". A good option would
>>> have been to not do 'fstrim'/'blkdiscard' and put TRIM in
>>> 'fsck' (apparently that happens under MacOS X and 'e2fsck'
>>> also allows that).
> 
>> how often do you reboot at all and then check your filesystems
>> versus blocks freed /data deleted?
> 
> System design is all about tradeoffs: in this case between
> having complicated and subtle code to list unused block segments
> in the kernel or have it in 'fsck' (which can take weeks to
> complete...), which must be regularly used to audit the
> filesystem structure anyhow.
> 
> I am aware that the opinion that "reboot at all and then check
> your filesystems" (and presumably other maintenance operations)
> should be or can be performed rarely is very popular among many
> sysadmins, being very low cost; to an extreme example I have
> seen systems in semi production use for which hardware and
> software went EOL in 2007 and untouched since then, and still
> "work". But some people get away with it, some don't

that's not the point, i use Fedora in producton and so kernel updates
and reboots are regulary

but at the same time i have de-duplication backups which are UNMAP aware
on the layer below which makes with a daily "fstrim -av" a large
difference how the backups are growing, espeially the ones with some
month retention time

you don't want all the temporary crap deleted hourd ago in your daily,
weekly, monthly backups - nor do you want to reboot a fsck daly because
someone will seek and kill you - period
