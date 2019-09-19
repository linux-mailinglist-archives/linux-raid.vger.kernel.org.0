Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92FB87E3
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404292AbfISW7N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Sep 2019 18:59:13 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:32892 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392063AbfISW7N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Sep 2019 18:59:13 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 18:59:12 EDT
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 934A31E4AE;
        Thu, 19 Sep 2019 18:53:15 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 31197A5B49; Thu, 19 Sep 2019 18:53:15 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23940.1755.134402.954287@quad.stoffel.home>
Date:   Thu, 19 Sep 2019 18:53:15 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     <Liviu.Petcu@ugal.ro>
Cc:     <linux-raid@vger.kernel.org>
Subject: Re: RAID 10 with 2 failed drives
In-Reply-To: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Liviu> Please let me know if in this situation detailed below, there
Liviu> are chances of restoring the RAID 10 array and how I can do it
Liviu> safely.  Thank you!

It depends.  Do you have either of the two missing disks (/dev/sdc and
/dev/sdd) available at all?  Have you tried doing a badblocks recovery
of either of those disks onto a replacement disk and then trying to
re-assemble your array?

What happens if you do:

  mdadm --assemble --scan

or instead

  mdadm --assemble md99 /dev/sd[abcdef]1

Can you post the output message(s) you get when you try this?

I'm not an export on how the 0.90 version of the metadata mirrors data
across pairs, and then stripes across the pairs.  But if you've lost
both halves of a pair, then you're probably out of luck.

Have you looked at the raid wiki as well?  There's a bunch of good
advice there.

 https://raid.wiki.kernel.org/index.php/Linux_Raid

Good luck!  And post more details of your system as well.

Liviu> Liviu Petcu

Liviu> # mdadm --examine /dev/sd[abcdef]2

Liviu> /dev/sda2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:15 2019
Liviu>           State : active
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e528c455 - correct
Liviu>          Events : 271498

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     5       8        2        5      active sync   /dev/sda2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2
Liviu> /dev/sdb2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:15 2019
Liviu>           State : active
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e528c45b - correct
Liviu>          Events : 271498

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     0       8       18        0      active sync   /dev/sdb2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2
Liviu> /dev/sde2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:16 2019
Liviu>           State : clean
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e52ce91f - correct
Liviu>          Events : 271499

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     3       8       66        3      active sync   /dev/sde2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2
Liviu> /dev/sdf2:
Liviu>           Magic : a92b4efc
Liviu>         Version : 0.90.00
Liviu>            UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
Liviu>   Creation Time : Fri Aug 14 12:11:48 2015
Liviu>      Raid Level : raid10
Liviu>   Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
Liviu>      Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
Liviu>    Raid Devices : 6
Liviu>   Total Devices : 6
Liviu> Preferred Minor : 1

Liviu>     Update Time : Thu Sep 19 21:05:16 2019
Liviu>           State : clean
Liviu>  Active Devices : 4
Liviu> Working Devices : 4
Liviu>  Failed Devices : 2
Liviu>   Spare Devices : 0
Liviu>        Checksum : e52ce931 - correct
Liviu>          Events : 271499

Liviu>          Layout : offset=2
Liviu>      Chunk Size : 256K

Liviu>       Number   Major   Minor   RaidDevice State
Liviu> this     4       8       82        4      active sync   /dev/sdf2

Liviu>    0     0       8       18        0      active sync   /dev/sdb2
Liviu>    1     1       0        0        1      faulty removed
Liviu>    2     2       0        0        2      faulty removed
Liviu>    3     3       8       66        3      active sync   /dev/sde2
Liviu>    4     4       8       82        4      active sync   /dev/sdf2
Liviu>    5     5       8        2        5      active sync   /dev/sda2

