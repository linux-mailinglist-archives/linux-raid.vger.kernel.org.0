Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3367A692
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jul 2019 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfG3LHV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 07:07:21 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:41421 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfG3LHV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jul 2019 07:07:21 -0400
Received: by mail-io1-f49.google.com with SMTP id j5so122954247ioj.8
        for <linux-raid@vger.kernel.org>; Tue, 30 Jul 2019 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fISqQZ33mQa3df9nU7rcU3Qpn9FTuWBNe5/ktsPrQNU=;
        b=eKQ+47Wy9s6LbtCgYzMxppoj0qxzjoREVZYv8BgwE6MwC3yWhCW4Aj0gJbbUSFM9JJ
         yPMn3rLycTF8I6/QG2PCMl4915vQo3eY0xdcI+KWZSmzCBR6paSXNUcE7zT/AudOuJnN
         I0Zt0ASJJY7IEfYqYeeJSlk6Cn9YwKRsuHnyiV22uKmCgbTk2ydxm/iF+v/iDxCaQQl4
         po/VdFUihXzCglMKbd78UocIhLk29QiAYGs1j1JZsPODcDRtvD/3fFV86hMTllacKrRk
         kVfDsakotQ4ggKI0FAQddPafR9NYvKO89bRPOfidJhJxaloAS6GEe1xR0ui9pF8b5pPI
         wX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fISqQZ33mQa3df9nU7rcU3Qpn9FTuWBNe5/ktsPrQNU=;
        b=kpGs9dVBkTV0XhtM2S9Rt99qTvnmqgU4gOJdxJky19EwCkbZpOGCmqog9NoHelGc3u
         4TFqCbU/Mqo/LQMezr/Fe0jISwlcH3ZhR3TL5XfySCzIqsN6pfdca52H6zmMfT4nHRK8
         hvpgKQQ7K6YzIOpFXyn1SEo/B63EOk2LhY1x/aY2ZSwSqAA28/V9rNZ4183pWbq8R6Te
         S88TAIylzsuGvx0F4adg5J5cNPbdfm+Nr/nemZCOkZA+rqkgcdwBHmW37nP1nVS169rs
         jc+/g2+eJM5nvxOKqbwkhQaZnEqZ7zhhqOLczgIyg7dTve6yoXIn7q5ZyuRoq/PJ91ct
         iZLA==
X-Gm-Message-State: APjAAAWUWLWp7R9h07NJC0e7CUrXwI7rdxG9+c6E8jcuL+wC1ux8z1o2
        q4PZ+vGho0Hh02U0nrEfl9o4qBfonny7YFp4Pw5Ogyt0
X-Google-Smtp-Source: APXvYqwXaEQKoRP9CmBwJaT98/f3cg5W3M3WL9JyQ++S75zD1KKFGYrolZSyMtEUzvs9PZvnuzbQCnZqF4UNwqdtmWk=
X-Received: by 2002:a02:5a89:: with SMTP id v131mr121847329jaa.130.1564484839976;
 Tue, 30 Jul 2019 04:07:19 -0700 (PDT)
MIME-Version: 1.0
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Tue, 30 Jul 2019 13:07:09 +0200
Message-ID: <CAJH6TXjer-gs4bwOCLkdi4xXm-g17ZLMZT1zCHig2Cip5Xokmw@mail.gmail.com>
Subject: RAID-1 from SAS to SSD
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi to all.
I have the following raid1:

/dev/md0:
        Version : 1.2
  Creation Time : Tue Dec 27 21:35:37 2016
     Raid Level : raid1
     Array Size : 292836608 (279.27 GiB 299.86 GB)
  Used Dev Size : 292836608 (279.27 GiB 299.86 GB)
   Raid Devices : 2
  Total Devices : 2
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Tue Jul 30 12:58:34 2019
          State : active
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

           Name : x:0  (local to host x)
           UUID : d8599926:69a5c35a:66a167d4:5a464a7b
         Events : 68628

    Number   Major   Minor   RaidDevice State
       0       8        1        0      active sync   /dev/sda1
       2       8       17        1      active sync   /dev/sdb1


# pvs
  PV         VG   Fmt  Attr PSize   PFree
  /dev/md0   vg1  lvm2 a--  279.27g 120.27g

# vgs
  VG   #PV #LV #SN Attr   VSize   VFree
  vg1    1   7   0 wz--n- 279.27g 120.27g

# lvs
  LV       VG   Attr       LSize  Pool Origin Data%  Meta%  Move Log
Cpy%Sync Convert
  lv_boot  vg1  -wi-ao----  1.00g
  lv_log   vg1  -wi-ao---- 50.00g
  lv_mysql vg1  -wi-ao---- 20.00g
  lv_root  vg1  -wi-ao---- 20.00g
  lv_swap  vg1  -wi-ao----  8.00g
  lv_tmp   vg1  -wi-ao---- 10.00g
  lv_www   vg1  -wi-ao---- 50.00g


as I need more space and I have some free slots on the server, can I
replace 1 by 1 (by adding a new disk and removing the old one from the
array when done), with some SSDs ?

Something like this:

# Sync disk partitions
sfdisk --dump /dev/sda | sfdisk /dev/sdc
sfdisk --dump /dev/sdb | sfdisk /dev/sdd

# Rebuild array
mdadm /dev/md0 --add /dev/sdc1
mdadm /dev/md0 --replace /dev/sda1 --with /dev/sdc1
mdadm /dev/md0 --add /dev/sdd1
mdadm /dev/md0 --replace /dev/sdb1 --with /dev/sdd1

This should replace, with no loss of redundancy, sda with sdc and sdb with sdd.
Then I have to re-install the bootloaded on new disks and reboot to
run from the SSDs

Any thoughts ? What about LVM ?  By syncing the disk partitions and
the undelying array, LVM should be up & running on next reboot
automatically, even if moved from SAS to SSD, right ?
