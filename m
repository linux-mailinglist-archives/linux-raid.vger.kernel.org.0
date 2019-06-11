Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13C63C160
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbfFKCxS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 10 Jun 2019 22:53:18 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39771 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390717AbfFKCxR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 10 Jun 2019 22:53:17 -0400
Received: by mail-oi1-f176.google.com with SMTP id m202so7823860oig.6
        for <linux-raid@vger.kernel.org>; Mon, 10 Jun 2019 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ksSmBFe307E5i5k5dWMRUNM0t4jm7BomMPjfEPTix3o=;
        b=f/snEZFZFczuipTV0VsRe7hyggkgMuYPRHN1T00SYhHGaaTqyOodR5LpETCwGqbkM1
         xvMT8K2L3r9/QyT2YWZQI5zb5ReeTLr5g645jQuSxTG6F7G/K/2cQ/+SmMJ3iVsTfj+s
         NCS3Gn0Im9lYWu8fFL4OOAD2QCjuzoZ6SF7ePk8LY2/0XBz3+1gI4JrmpBnLDzvrMh6o
         xD92+3GLu0BehaWvFpg2JCEQVv/OmvOhEIOOkQI304qnU5Qiok2pereIyeNkgLeiY+S3
         H7dL6Y9gmf3uMnHQCT581EwN8AIg0AKQzq9FRXOQrpK0ioQ12aBTcni83cnigDztLax/
         dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:references:in-reply-to:subject
         :date:message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ksSmBFe307E5i5k5dWMRUNM0t4jm7BomMPjfEPTix3o=;
        b=t0gNT1M2EzJ7AhMcsaguc74X5rGnZFGBnEZmH1iDkt562qXYcRApZBBcw65EU5C9dk
         BUcj3NSrhztaOMVs6u2202skqqVA2ESMvvcm5xVuhi0BwALBEuICYyXHGs00HoT2Xj31
         Cja1UPQE30rK86xj0tMxecUpPQpgF4mOZJ4t5l3VFGRA5FkVBp+8UwtKQaYENAGSsMxy
         iCvu+kqJHMX6LHqGuiADbKKRPrn/QSEiushOJQiei7t+lxbxerNjC99qruBlzd1LVdz2
         9a3c3VAg54f3Mwk5ujLzDBydqJbYx6AEFUozJtwbL8ZfBrzHdx4EQPzqRjZaEykWcbWI
         ewDw==
X-Gm-Message-State: APjAAAVBZDIC2xN8D2pyLM6o81xoCK4RGwQnD4SIinDVJqhuvjURO35K
        rb3qmJgCEJc5G/emuJCH3EF4SrKp
X-Google-Smtp-Source: APXvYqw5aFOUzPUuJVHJDENXZi2wrpawFTa4SERO52rZQrH0Bcr3HpxIQMtzbgjiFRQSJbQ0sYdhDg==
X-Received: by 2002:aca:5b86:: with SMTP id p128mr5959252oib.126.1560221596857;
        Mon, 10 Jun 2019 19:53:16 -0700 (PDT)
Received: from VELDA1 ([216.163.20.84])
        by smtp.gmail.com with ESMTPSA id p64sm4454279oif.8.2019.06.10.19.53.16
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 19:53:16 -0700 (PDT)
From:   Colt Boyd <coltboyd@gmail.com>
X-Google-Original-From: "Colt Boyd" <ColtBoyd@Gmail.com>
Reply-To: <ColtBoyd@Gmail.com>
To:     <linux-raid@vger.kernel.org>
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
In-Reply-To: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
Subject: RE: RAID-6 aborted reshape
Date:   Mon, 10 Jun 2019 21:53:15 -0500
Message-ID: <008b01d52000$d1628040$742780c0$@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF3CbZEIWOLM33oAN+5SVf2cGNvXqdR7akQ
Content-Language: en-us
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Is there anything that can be done?

-----Original Message-----
From: Colt Boyd <coltboyd@gmail.com>=20
Sent: Saturday, June 8, 2019 10:48 AM
To: linux-raid@vger.kernel.org
Subject: RAID-6 aborted reshape

I was resizing a raid6 array with a internal write intent bitmap from
5 3TB drives (in RAID6) to 6 drives. It was aborted very early in =
reshape via reboot and then reassembled with:
'mdadm -A /dev/md0 --force --verbose --update=3Drevert-reshape =
--invalid-backup /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1 =
/dev/sdg1'

When I reassembled it this way I incorrectly thought the backup file was =
zero bytes. It wasn't. I still have the intact backup file.

I=E2=80=99ve also since tried to reassemble it with the following create =
but the XFS fs is not accessible:
'mdadm --create /dev/md0 --data-offset=3D1024 --level=3D6 =
--raid-devices=3D5 --chunk=3D1024K --name=3DOMV:0 /dev/sdb1 /dev/sde1 =
/dev/sdc1 /dev/sdd1
/dev/sdf1 --assume-clean --readonly'

I can see the XFS FS on the drives, example:
root@OMV1:~# dd if=3D/dev/sde1 bs=3D512k count=3D5 | hexdump -C <snip>
00200000  58 46 53 42 00 00 10 00  00 00 00 00 82 f2 c3 00  =
|XFSB............|
00200010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
|................|
00200020  4e 2b 04 64 e8 1b 49 d9  a5 20 b5 74 79 94 52 f8  |N+.d..I.. =
.ty.R.| <snip>

This is what it looked like immediately following the aborted reshape =
and before attempting to recreate it. This is from the drive that was =
being added at the time.

/dev/sdg1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : f8fdf8d4:d173da32:eaa97186:eaf88ded
           Name : OMV:0
  Creation Time : Mon Feb 24 18:19:36 2014
     Raid Level : raid6
   Raid Devices : 6

 Avail Dev Size : 5858529280 (2793.56 GiB 2999.57 GB)
     Array Size : 11717054464 (11174.25 GiB 11998.26 GB)
  Used Dev Size : 5858527232 (2793.56 GiB 2999.57 GB)
    Data Offset : 2048 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D1960 sectors, after=3D2048 sectors
          State : clean
    Device UUID : 92e022c9:ee6fbc26:74da4bcc:5d0e0409

Internal Bitmap : 8 sectors from superblock
    Update Time : Thu Jun  6 10:24:34 2019
  Bad Block Log : 512 entries available at offset 72 sectors
       Checksum : 8f0d9eb9 - correct
         Events : 1010399

         Layout : left-symmetric
     Chunk Size : 1024K

   Device Role : Active device 5
   Array State : AAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =
=3D=3D replacing)

Where can I go from here to get this back?

