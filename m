Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80672046D6
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 03:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgFWBpO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 22 Jun 2020 21:45:14 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:59998 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgFWBpO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jun 2020 21:45:14 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 23B682551A;
        Mon, 22 Jun 2020 21:45:13 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 87E64A64A4; Mon, 22 Jun 2020 21:45:12 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <24305.24232.459249.386799@quad.stoffel.home>
Date:   Mon, 22 Jun 2020 21:45:12 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID types & chunks sizes for new NAS drives
In-Reply-To: <rco1i8$1l34$1@ciao.gmane.io>
References: <rco1i8$1l34$1@ciao.gmane.io>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Ian" == Ian Pilcher <arequipeno@gmail.com> writes:

Ian> I'm replacing the drives in my 5-bay NAS, and planning how I'm
Ian> going to divide them up.  My general plan is to create a matching
Ian> set of partitions on the drives, and then create RAID devices
Ian> across the sets of partitions, for example:

Ian>    md1:  /dev/sdb1  /dev/sdc1  /dev/sdd1  /dev/sde1  /dev/sdf1
Ian>    md2:  /dev/sdb2  /dev/sdc2  /dev/sdd2  /dev/sde2  /dev/sdf2
Ian>     ⋮         ⋮          ⋮          ⋮          ⋮          ⋮
Ian>    md16: /dev/sdb16 /dev/sdc16 /dev/sdd16 /dev/sde16 /dev/sdf16

Ian> This will give me the flexibility to create RAID devices of different
Ian> types, as well as maybe(?) reducing the "blast radius" if a particular
Ian> portion of a disk goes bad.

This is a terrible idea.  Just think about how there is just one head
per disk, and it takes a signifigant amount of time to seek from track
to track, and then add in rotational latecy.  This all adds up.

So now create multiple seperate RAIDS across all these disks, with
competing seek patterns, and you're just going to thrash you disks.  

If you really have two types of data, I'd only setup two partitions at
most, one for your RAID10 (with one hot spare partition) and then
RAID5 or even RAID6 (three data, two parity) on the other five
drives for your bulk data that doesnt' change much.  Say photos,
movies, CDs you've ripped, etc.  

Ian> I believe that it makes sense to use at least 2 different RAID
Ian> levels - RAID-10 for "general" use and RAID-6 for media content.
Ian> Does this make sense?

Sorta kinda maybe... In either case, you only get 1 drive more space
with RAID 6 vs RAID10.  You can suffer any two disk failure, while
RAID10 is limited to one half of each pair.  It's a tradeoff.

Look at the recent Arstechnica article on RAID levels and
performance.  It's an eye opener.

Ian> If so, does anyone have any thoughts or pointers on the chunk
Ian> size, particularly for RAID-10?  (I assume that RAID-6 will have
Ian> similar considerations to RAID-5, and so a large chunk size would
Ian> make sense, particularly for large media files.)

I don't think larger chunk sizes really make all that much difference,
especially with your plan to use multiple partitions.

You also don't say how *big* your disks will be, and if your 5 bay NAS
box can even split like that, and if it has the CPU to handle that.
Is it an NFS connection to the rest of your systems?

Honestly, I'd just setup two RAID1 mirrors with a single hot spare,
then use LVM on top to build the volumes you need.  With 8tb disks,
this only gives you 16Tb of space, but you get performance, quicker
rebuild speed if there's a problem with a disk, and simpler
management.

With only five drives, you are limited in what you can do.  Now if you
could add a pair of mirror SSDs for caching, then I'd be more into
building a single large RAID6 backing device for media content, then
use the mirrored SSDs as a cache for a smaller block of day to day
storage.

But it all depends on what you're going to do.

In any case, make sure you get NAS rated disks, either the newest WD
RED+ (or is it Blue?)  In any case, make sure to NOT get the SMR
(Shingled Magnetic Recording) format drives.  See previous threads in
this group, as well as the arstechnica.com discussion about it all
that they disk last month.  Very informative.

Personally, with regular hard disks, I still kinda think 4gb is the
sweet spot, since you can just mirror pairs of the disks and then
stripe across on top as needed.  I like my storage simple, because
when (not if!) it all hits the fan, simple is easier to recover from.

John
