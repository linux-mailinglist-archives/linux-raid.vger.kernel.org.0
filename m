Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A2D179CDC
	for <lists+linux-raid@lfdr.de>; Thu,  5 Mar 2020 01:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbgCEAbf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Mar 2020 19:31:35 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:33767 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCEAbf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Mar 2020 19:31:35 -0500
Received: by mail-vs1-f48.google.com with SMTP id n27so2485713vsa.0
        for <linux-raid@vger.kernel.org>; Wed, 04 Mar 2020 16:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XPBbwGKI+D/rOGGSlTimrXUPHE3Wn9yxorSf218jcGk=;
        b=XS1HzUaJLkJxP75FO07tW1oalHpPbFfHYGnZma5nREJMS7fALDcTjmJu+WGVL5rsKQ
         tTaZ8huLHWjL56viT5/DfMG635OcAxMhF4cx/W+2IxFyTHrRC3eVYWQ0awwwUijjT7cA
         vKZy4p0ZImBsZsiHoPws/lRUiiI/3yyKoUG0tIOQcuXL+0BVoFpXzF/CJ/B0wbpVfEXd
         rXV4gtsyDqlLxmQsA7dJNHZWkmsWU3BP3UZr2lmHnFu5tFy1l5Pov5YA9fNxAOS595sK
         jaqiZ+uMNvqs2EREYUN0BnC196IOeWhcxsbaEIxaTDUIm0TVD+p8Gb5s5Y50T28vClWL
         wlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XPBbwGKI+D/rOGGSlTimrXUPHE3Wn9yxorSf218jcGk=;
        b=E/xMxpgFK8Dd0GBVBVCX2Vg8AKaFvyBVrlDnMQw3dePYtoWe7KQ5k5WPrSBz4VMcl8
         UxB1M/8di/bxDjIFsx8+6aCspoMwACZcbA5khHDl2L0REHuhIevO51ddjXxSo+EUzDs/
         d3YvNk4Eh1wh2uOcIfyDUOhe81vVcQF1/16QTOuNys2UAvTInDDlYjiBDNnv7uryunF1
         VAZISBzM/Y25FKS90mmJ99Zcpgwm3Drwfp5rzUqIcunwQK6mAFfKPYOpHV8x2ah+LsY4
         tv9ML0Qfyb17HxLkKWwYMBUD50hnbCVCUGEmzE1hoc1XgvRPhy9Rb0CxR8YxCz1yTviL
         qNVA==
X-Gm-Message-State: ANhLgQ1LsSm2oP6nCaJ+tZ/w4Mqvi8b/axuc5OCv0+WGGrC3EtkBXq3a
        upEJ4j7U3njRV7s3WT3OGZ+5uz/vjhRMG/2EWefq3LsR
X-Google-Smtp-Source: ADFU+vvFZzvkhzybgAjZPDy26aVD484YjBolHXz/Qac7kByx90D1vqr/p7cegYcJj6M5m3DLMLvZFNFMsVvBqm8Wt5w=
X-Received: by 2002:a67:fa43:: with SMTP id j3mr2824270vsq.70.1583368291831;
 Wed, 04 Mar 2020 16:31:31 -0800 (PST)
MIME-Version: 1.0
From:   William Morgan <therealbrewer@gmail.com>
Date:   Wed, 4 Mar 2020 18:31:21 -0600
Message-ID: <CALc6PW74+m1tk4BGgyQRCcx1cU5W=DKWL1mq7EpriW6s=JajVg@mail.gmail.com>
Subject: Need help with degraded raid 5
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I'm working with a 4 disk raid 5. In the past I have experienced a
problem that resulted in the array being set to "inactive", but with
some guidance from the list, I was able to rebuild with no loss of
data. Recently I have a slightly different situation where one disk
was "removed" and marked as "spare", so the array is still active, but
degraded.

I've been monitoring the array, and I got a "Fail event" notification
right after a power blip which showed this mdstat:

Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
md0 : active raid5 sdm1[4](F) sdj1[0] sdk1[1] sdl1[2]
      23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
      bitmap: 0/59 pages [0KB], 65536KB chunk

unused devices: <none>

A little while later I got a "DegradedArray event" notification with
the following mdstat:

Personalities : [raid6] [raid5] [raid4] [linear] [multipath] [raid0]
[raid1] [raid10]
md0 : active raid5 sdl1[4] sdj1[1] sdk1[2] sdi1[0]
      23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
      [>....................]  recovery =  0.0% (12600/7813893120)
finish=113621.8min speed=1145K/sec
      bitmap: 2/59 pages [8KB], 65536KB chunk

unused devices: <none>

which seemed to imply that sdl was being rebuilt, but then I got
another "DegradedArray event" notification with this:

Personalities : [raid6] [raid5] [raid4] [linear] [multipath] [raid0]
[raid1] [raid10]
md0 : active raid5 sdl1[4](S) sdj1[1] sdk1[2] sdi1[0]
      23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
      bitmap: 2/59 pages [8KB], 65536KB chunk

unused devices: <none>


I don't think anything is really wrong with the removed disk however.
So assuming I've got backups, what do I need to do to reinsert the
disk and get the array back to a normal state? Or does that disk's
data need to be completely rebuilt? And how do I initiate that?

I'm using the latest mdadm and a very recent kernel. Currently I get this:

bill@bill-desk:~$ sudo mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Sat Sep 22 19:10:10 2018
        Raid Level : raid5
        Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
     Used Dev Size : 7813893120 (7451.91 GiB 8001.43 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Mon Mar  2 17:41:32 2020
             State : clean, degraded
    Active Devices : 3
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 1

            Layout : left-symmetric
        Chunk Size : 64K

Consistency Policy : bitmap

              Name : bill-desk:0  (local to host bill-desk)
              UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
            Events : 10407

    Number   Major   Minor   RaidDevice State
       0       8      129        0      active sync   /dev/sdi1
       1       8      145        1      active sync   /dev/sdj1
       2       8      161        2      active sync   /dev/sdk1
       -       0        0        3      removed

       4       8      177        -      spare   /dev/sdl1
