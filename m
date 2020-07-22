Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D088F229267
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGVHmT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGVHmS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jul 2020 03:42:18 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297AC0619DC
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 00:42:18 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id p26so233094oos.7
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3Km/q51MbfY+afbzUVP+V1vOmri1ndZsGCg5aSbOoX8=;
        b=Xg8EaLsdupEjSEnf9iYOc2ixok3xLT+40sbHfmDJGiclZTjlrtHgXzFzfHpBzhbas7
         ByEG33LqZYTs3bEnX3hzryVE5MG5CC7oa7hCuwy83aeWmex79EnZ5fitnUAPpHydQ8Sz
         yebN7TZHFolJR5VkCKjgezictPdkLBrG6cnMcYuTQE7+fOSVKq1qOWx2ETmo++ESjG6B
         M56ZDIo46dkv4LDxbIaDPysIo+Wki8/nGE6PMSHSyIy9DoAi7ffpaTTidrPm3xtr4DQo
         LadulkDOVZ+KXiBio1gYzTBzTzuaGgIkD1ETfMnbU9y+2aTTso+nPjic65AoCM+3RUMh
         h0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3Km/q51MbfY+afbzUVP+V1vOmri1ndZsGCg5aSbOoX8=;
        b=DXnD3BbmTwz9LbzhqzF+ILF9EP+P+zkf99up7ayTFUripUHrmkVk3A+cMOTFbUSOIT
         TFMSxNMM5w246gLYi8BwHQxoWqf+dGmOn/B/j44AnDvB+JJkwHWYPknbL2hWV6cMuy3i
         E1/fvlvsp/wjtlPOS4xcenLcnQMgcDpDDXa8SoJ14zo3cik1URqo9DuWxaRXwgNQ+2+O
         OOdcU4gPIZSHoTbnoSB0LhKicAqrO8wLzRfSyxBJJTuBP9hj18ADFQHvSVVfH2sEUAx9
         h6w3QFzwenTx2of56POPxYT3YJB96Wz/v6V6RnPWi4trlUDPDlhtgef3eaFoPGSkWciA
         aS8g==
X-Gm-Message-State: AOAM532M9tutooKdOoUJgN3b7U2zjut2eY3AFK8ea8IG/lFWIzaIocEt
        5rMf2dnuCGB2wvCQ+LGFJhmK+5tVPRNpj/+4UujAjRM3
X-Google-Smtp-Source: ABdhPJzg14r6l5Qpwcrzx4At3CEQQRzV0ku3KSF2mljPxHS/d3q2KEgJ3GAq0wmfqEJU1OovBMe85tbXdy5XUHvfEV4=
X-Received: by 2002:a4a:e64a:: with SMTP id q10mr27314342oot.37.1595403737378;
 Wed, 22 Jul 2020 00:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CBf3QZP4Yss0U=6Aa_5a+3D2Yy-WT545VazHiFWCZsreNOEg@mail.gmail.com>
In-Reply-To: <CA+CBf3QZP4Yss0U=6Aa_5a+3D2Yy-WT545VazHiFWCZsreNOEg@mail.gmail.com>
From:   Cory Derenburger <cory.derenburger@gmail.com>
Date:   Wed, 22 Jul 2020 00:41:39 -0700
Message-ID: <CA+CBf3Q8sKv9k83dp38ekkBY1qgvOe2seQOYvxukg-X4__7JkA@mail.gmail.com>
Subject: Software RAID6 broke after power outage
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

My server lost power this morning. The server is running Linux Mint
(14?) on a battery backup and I believe it shutdown before losing
power. Upon restarting the server the computer hung for a while, and
after resetting and booting up in recovery mode my RAID is now
nonfunctional.

The server was set up years ago with a RAID 6 array built with mdadm.
To be honest I don't really know what is wrong with the array, it
seems to be an issue with disk sdc. I wanted to reach out for help to
confirm the issue and get some guidance before proceeding (or making
things worse).

Any assistance that can help me determine what steps to take to get
this server back up and running would be greatly appreciated. It's
been 4+ since I have touched RAID, and only attempted a recovery once.
If anyone can help I would be super appreciative.

Below I'm including outputs from various commands for the 3rd disk
which seems to be the culprit

dmesg - boot section section where first errors begin occurring
[    2.637856] md: bind<sdd1>
[    2.646987] random: nonblocking pool is initialized
[    2.647432] md: bind<sde1>
[    2.651429] md: bind<sdb1>
[    2.863538] ata3.00: exception Emask 0x0 SAct 0x10 SErr 0x0 action 0x0
[    2.863594] ata3.00: irq_stat 0x40000008
[    2.863643] ata3.00: failed command: READ FPDMA QUEUED
[    2.863695] ata3.00: cmd 60/08:20:08:08:00/00:00:00:00:00/40 tag 4
ncq 4096 in
[    2.863695]          res 41/40:00:09:08:00/00:00:00:00:00/40 Emask
0x409 (media error) <F>
[    2.863775] ata3.00: status: { DRDY ERR }
[    2.863822] ata3.00: error: { UNC }
[    2.873407] ata3.00: configured for UDMA/133
[    2.873476] sd 2:0:0:0: [sdc] Unhandled sense code
[    2.873525] sd 2:0:0:0: [sdc]
[    2.873571] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[    2.873619] sd 2:0:0:0: [sdc]
[    2.873665] Sense Key : Medium Error [current] [descriptor]
[    2.873819] Descriptor sense data with sense descriptors (in hex):
[    2.873901]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
[    2.874544]         00 00 08 09
[    2.874764] sd 2:0:0:0: [sdc]
[    2.874811] Add. Sense: Unrecovered read error - auto reallocate failed
[    2.874895] sd 2:0:0:0: [sdc] CDB:
[    2.874941] Read(10): 28 00 00 00 08 08 00 00 08 00
[    2.875428] end_request: I/O error, dev sdc, sector 2057
[    2.875478] Buffer I/O error on device sdc1, logical block 1

cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
md0 : inactive sdb1[0](S) sde1[3](S) sdd1[2](S)
      5860147464 blocks super 1.2

{not sure why these drives are now showing as spares}

Below running mdstat for sdc.  Checking sdb, sdd, sde appear fine.

mdadm --examine /dev/sdc
/dev/sdc:   MBR Magic : aa55
Partition[0] :   3907027120 sectors at         2048 (type fd)

mdadm --examine /dev/sdc1
mdadm: No md superblock detected on /dev/sdc1.

fdisk -l
Disk /dev/sdb: 2000.4 GB, 2000398934016 bytes
81 heads, 63 sectors/track, 765633 cylinders, total 3907029168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x38389fdc

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048  3907029167  1953513560   fd  Linux raid autodetect

Disk /dev/sdc: 2000.4 GB, 2000398934016 bytes
81 heads, 63 sectors/track, 765633 cylinders, total 3907029168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd108824d

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1            2048  3907029167  1953513560   fd  Linux raid autodetect

Disk /dev/sdd: 2000.4 GB, 2000398934016 bytes
81 heads, 63 sectors/track, 765633 cylinders, total 3907029168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x6207659a

   Device Boot      Start         End      Blocks   Id  System
/dev/sdd1            2048  3907029167  1953513560   fd  Linux raid autodetect

Disk /dev/sde: 2000.4 GB, 2000398934016 bytes
81 heads, 63 sectors/track, 765633 cylinders, total 3907029168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd9a4afcf

   Device Boot      Start         End      Blocks   Id  System
/dev/sde1            2048  3907029167  1953513560   fd  Linux raid autodetect


Is there other information needed to determine the issue?  Where do I
go from here?



Thank you for your help,
Cory
