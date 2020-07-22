Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78917229FC6
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGVTDb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 15:03:31 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:49388
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTDb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jul 2020 15:03:31 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <linux-raid@m.gmane-mx.org>)
        id 1jyK1Z-000A1i-W3
        for linux-raid@vger.kernel.org; Wed, 22 Jul 2020 21:03:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-raid@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Re: Software RAID6 broke after power outage
Date:   Wed, 22 Jul 2020 14:03:23 -0500
Message-ID: <rfa2ht$1558$1@ciao.gmane.io>
References: <CA+CBf3QZP4Yss0U=6Aa_5a+3D2Yy-WT545VazHiFWCZsreNOEg@mail.gmail.com>
 <CA+CBf3Q8sKv9k83dp38ekkBY1qgvOe2seQOYvxukg-X4__7JkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CA+CBf3Q8sKv9k83dp38ekkBY1qgvOe2seQOYvxukg-X4__7JkA@mail.gmail.com>
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/22/20 2:41 AM, Cory Derenburger wrote:
> [    2.863538] ata3.00: exception Emask 0x0 SAct 0x10 SErr 0x0 action 0x0
> [    2.863594] ata3.00: irq_stat 0x40000008
> [    2.863643] ata3.00: failed command: READ FPDMA QUEUED
> [    2.863695] ata3.00: cmd 60/08:20:08:08:00/00:00:00:00:00/40 tag 4
> ncq 4096 in
> [    2.863695]          res 41/40:00:09:08:00/00:00:00:00:00/40 Emask
> 0x409 (media error) <F>
> [    2.863775] ata3.00: status: { DRDY ERR }
> [    2.863822] ata3.00: error: { UNC }
> [    2.873407] ata3.00: configured for UDMA/133
> [    2.873476] sd 2:0:0:0: [sdc] Unhandled sense code
> [    2.873525] sd 2:0:0:0: [sdc]
> [    2.873571] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [    2.873619] sd 2:0:0:0: [sdc]
> [    2.873665] Sense Key : Medium Error [current] [descriptor]
> [    2.873819] Descriptor sense data with sense descriptors (in hex):
> [    2.873901]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
> [    2.874544]         00 00 08 09
> [    2.874764] sd 2:0:0:0: [sdc]
> [    2.874811] Add. Sense: Unrecovered read error - auto reallocate failed
> [    2.874895] sd 2:0:0:0: [sdc] CDB:
> [    2.874941] Read(10): 28 00 00 00 08 08 00 00 08 00
> [    2.875428] end_request: I/O error, dev sdc, sector 2057

That's an error on sdc all right.

> [    2.875478] Buffer I/O error on device sdc1, logical block 1

Note that this refers to sdc1, the first partition on sdc.

> cat /proc/mdstat
> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
> [raid4] [raid10]
> md0 : inactive sdb1[0](S) sde1[3](S) sdd1[2](S)
>        5860147464 blocks super 1.2

Note that this is again referring to *partitions* (sdb1, sde1, sdd1),
not the whole disks.  So your faulty RAID member is *sdc1* (not sdc).

> Below running mdstat for sdc.  Checking sdb, sdd, sde appear fine.
> 
> mdadm --examine /dev/sdc
> /dev/sdc:   MBR Magic : aa55
> Partition[0] :   3907027120 sectors at         2048 (type fd)

That's expected.  sdc isn't a RAID device.

> mdadm --examine /dev/sdc1
> mdadm: No md superblock detected on /dev/sdc1.

That's not good (but we already knew that the drive is unhappy).

> Is there other information needed to determine the issue?  Where do I
> go from here?

What does mdadm --detail /dev/md0 say?

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================

