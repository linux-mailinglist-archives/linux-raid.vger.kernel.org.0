Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCFAE31FDA
	for <lists+linux-raid@lfdr.de>; Sat,  1 Jun 2019 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfFAQDa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Jun 2019 12:03:30 -0400
Received: from mail.thelounge.net ([91.118.73.15]:24585 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFAQDa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 1 Jun 2019 12:03:30 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45GR1q4jXMzXQV;
        Sat,  1 Jun 2019 18:03:22 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     keld@keldix.com
Cc:     linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org>
 <2d01a882-0902-b7b6-a359-80e04a919aaa@thelounge.net>
 <20190601154302.GA27756@www5.open-std.org>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <67a47528-541d-09ec-c9f9-560c382b6760@thelounge.net>
Date:   Sat, 1 Jun 2019 18:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190601154302.GA27756@www5.open-std.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 01.06.19 um 17:43 schrieb keld@keldix.com:
> On Sat, Jun 01, 2019 at 04:03:05PM +0200, Reindl Harald wrote:
>> well, it would be nice just skip optimizations for rotating disks
>> entirely when the whole 4 disk RAID10 is built of SSD's
> 
> yes, possibly, if there is a gain in this.
> 
> as I wrote layout offset may already do the right thing.
> and raid1 probably also does it.
> I think raid10 offers extra functionlity over raid1 that could be useful
>  for raids of drives with different speeds.
> Even layout far may be advantageaous to use with ssds, this was reported to the list some time ago.

problem is that you can't switch layouts and given that "near" is
default when you setup a distribution with RAID10 in the installer you
get that

if i would have known that in 2011 at least md2 where VMs are running
would have been created after the inital setup, now that ship has sailed
because the whole point of RAID10 was "never install from scratch, just
repplace dead disks and in case of switch the hardware create a
non-hostonly initrd and move the drives"

now it's more about reduce overhead in general because for a SSD all the
optimizations trying to take head movement into account are useless,
just read from as much drives as possible

for dives with different speeds "writemostly" would be perfect and two
years ago that was my lan not realizing that Linux RAID10 is not the
same as a ordinary RAID10 and on a testing VM the param was recognized
for RAID10 too but turned out not to work in reality after replace two
drives with SSD

for my primary machine it don't no longer matter, already 4x2 TB SSD
RAID10 but for example i have a HP Microserver Gen8 with 4x6 TB RAID10
"far layout" for the storage running a NFS storgae for a VMware
Backup-Appliance

May '19      2.47 TiB |   68.09 TiB

as you can see there is a 1/28 ratio reads/writes and so replace two of
that disks with a SSD would dramatically improve real workload
performance with half of the costs when reads don't go to the HDD at all
as long all 4 drives are up


