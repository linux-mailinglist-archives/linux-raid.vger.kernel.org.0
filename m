Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C689A17A851
	for <lists+linux-raid@lfdr.de>; Thu,  5 Mar 2020 15:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCEO5d (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Mar 2020 09:57:33 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43514 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCEO5d (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Mar 2020 09:57:33 -0500
Received: by mail-ed1-f41.google.com with SMTP id dc19so7106618edb.10
        for <linux-raid@vger.kernel.org>; Thu, 05 Mar 2020 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vWKXZPtN54/V8GggcZSsLdOhuGgEGGkZsve2Kr/Evwg=;
        b=EIB98UZDcQfV3o1Jz7IP+d4ltpai/fjg2fRJPeBUBU5MllraEh3VBvicM2vPKmuYwK
         6I7ZX39yLZDHTP7s6iYQrKFYsZbokaQNmV0QsDOC5mRXK1EmXnGPn6TAJaZsR9o6N3gd
         zTTYJ5sNfRay8wtbRf8dj33j1H8gJWbBf1kR1xoxWyTq5NAwPHQWWr3eErHr11jZ5uEg
         q6nQjo1srRYUEVJ+fEyHnChYUU1tis6Gsp9A1Oj3N2NoD5xkk86p4WmqA6Ec7ch+4nZk
         dwbZETUgc+5WcZt5uMUVACaZJiyADiv6rOekNHOZB1Rz6zQWIeKGUiugGg0ymqiZ2OLK
         p6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vWKXZPtN54/V8GggcZSsLdOhuGgEGGkZsve2Kr/Evwg=;
        b=dkmLidj4aV1TvLj4IZlMJFkNN0S38QEefm+F2mZ52sPrsog6TQJAmlIHKvtOG8czCS
         u7s/zAnl09b+HCRjwbRN5WuQmtEl8sXwHFk72mbBtvlcHhzg1tonQy3Sfe50etXSkfiM
         aoddcfs6J3lPYFCcVykqDRtzg2lc01guquSTJSBJKYddbWi5nyO15k1RRUnpONRQVZ20
         UH40FOKPYRXArUkuzp1Hfz5LJhdfcjMMS6gJUmyVLAqZiJAAdZUYAU8qJKpz0gmcbG2f
         Pt3d1vp2A4gyh+R5nGDD2YP5Zh6zLDUWEsQNpmbTN/1YplPitHWke3d/fMcd+wdW6jGs
         OoQg==
X-Gm-Message-State: ANhLgQ2xy3MUMr/n7pnyUm4VXj9QOWl2S/FAk8pN3sDfua1JO5Fw0ZPz
        MeJpO9S5hs324Cfv/XYSNXfbp5XeI5XCGyncTgDLJvni
X-Google-Smtp-Source: ADFU+vtB6fYxpl6oB9tBtGQQhONKNIUSFDpQIErFdxyaXreioYMBl1ZsZMaRqsg0txCaj40quCfuFk0R+WDhVQ4Xrq0=
X-Received: by 2002:aa7:da4a:: with SMTP id w10mr9143089eds.9.1583420251787;
 Thu, 05 Mar 2020 06:57:31 -0800 (PST)
MIME-Version: 1.0
From:   Patrick Dung <patdung100@gmail.com>
Date:   Thu, 5 Mar 2020 22:57:05 +0800
Message-ID: <CAJTWkdvU3of87+-zyUPn7uDBen8ZBswujwMn8wYSiwZb=0V3EQ@mail.gmail.com>
Subject: Please show descriptive message about degraded raid when booting
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

The system have Linux software raid (md) raid 1.
One of the disk is missing or have problem.

The raid is degraded.
When the OS boot, it hangs at the message for outputting to kernel at
about three seconds.
There is no descriptive message that the RAID is degraded.
I know the problem because I had wrote zero to one of the disk of the
raid 1. If I don't know the problem (maybe cable is loose or disk
failure), it is confusing.

Related log:

[    2.917387] sd 32:0:0:0: [sda] 56623104 512-byte logical blocks:
(29.0 GB/27.0 GiB)
[    2.917446] sd 32:0:1:0: [sdb] 56623104 512-byte logical blocks:
(29.0 GB/27.0 GiB)
[    2.917499] sd 32:0:0:0: [sda] Write Protect is off
[    2.917516] sd 32:0:0:0: [sda] Mode Sense: 61 00 00 00
[    2.917557] sd 32:0:1:0: [sdb] Write Protect is off
[    2.917575] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
[    2.917615] sd 32:0:0:0: [sda] Cache data unavailable
[    2.917636] sd 32:0:0:0: [sda] Assuming drive cache: write through
[    2.917661] sd 32:0:1:0: [sdb] Cache data unavailable
[    2.917677] sd 32:0:1:0: [sdb] Assuming drive cache: write through
[    2.927076] sd 32:0:0:0: [sda] Attached SCSI disk
[    2.927458]  sdb: sdb1 sdb2 sdb3 sdb4
[    2.929018] sd 32:0:1:0: [sdb] Attached SCSI disk
[    3.060855] vmxnet3 0000:0b:00.0 ens192: intr type 3, mode 0, 3
vectors allocated
[    3.061826] vmxnet3 0000:0b:00.0 ens192: NIC Link is Up 10000 Mbps
[  139.411464] md/raid1:md125: active with 1 out of 2 mirrors
[  139.412176] md125: detected capacity change from 0 to 1073676288
[  139.433441] md/raid1:md126: active with 1 out of 2 mirrors
[  139.434182] md126: detected capacity change from 0 to 314507264
[  139.436894]  md126:
[  139.455511] md/raid1:md127: active with 1 out of 2 mirrors
[  139.456739] md127: detected capacity change from 0 to 27582726144

So there are about 130 seconds without any descriptive messages. I
thought the system had hanged.

Could the kernel display more descriptive messages about the RAID?

If I use rd.debug boot parameters, I know the kernel is still running.
But it is scrolling very fast without actually knowing what is the the
problem.

Thanks,
Patrick
