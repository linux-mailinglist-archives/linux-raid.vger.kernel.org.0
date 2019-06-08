Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599EB3A085
	for <lists+linux-raid@lfdr.de>; Sat,  8 Jun 2019 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFHPrn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 8 Jun 2019 11:47:43 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36887 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfFHPrn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 8 Jun 2019 11:47:43 -0400
Received: by mail-io1-f49.google.com with SMTP id e5so3761676iok.4
        for <linux-raid@vger.kernel.org>; Sat, 08 Jun 2019 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UQ1Hkx3i2UgR285I4CTSOUoQrUivfhTCXCzuHwzGPVI=;
        b=QwKt5NdKtlYGuJibsAKuc0QNToSGfEyNWdT0K5TtJPSLGItoOmSNrdPVlP8UpTWWZs
         i4uKVbsTyiF92bz3UcYHn3s+qT+ZwZ9xCQ+OqWRyWORnG3VF5QcdzD9aXJxWT6Vy9QMa
         cVZmXcWkLqJoVDdQJqrvJCXSDdY9RGIRd9/PzWhgciw3bDTGq3cs/aMOHtfK41dzLPvA
         GkpyaogFPiiI50hiWX6JruuCEUiZIwzstPZY5i0RzjdUOThhoy8LXyWuUsiFNnpsbuy1
         3TeekUHKFeLIxgO15hx5OiF3Ra+IJzpfBrkAL59EFZhPfzgtyKgLWgM1rARpVgpCcYLx
         H+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UQ1Hkx3i2UgR285I4CTSOUoQrUivfhTCXCzuHwzGPVI=;
        b=sMuZFT3+C/6eh/PRei05Sa9BHKaLR50QETtDJcn/euKWbBbCwJLHg4zWl7WpRDwmTi
         gncbnfCyu0xYThrLPP6iOVPKcKZK/3egpi2Ra3AzGqV5m/6c0B9G12xf9p8Ky5Vc6ku5
         GKp8AbG6jLR/MK2JjrgZf5sGev8O047O/0bH+QFx9O5PiVSFmuuBaAsACFcI2HwAeJKu
         2lyxd3UWODGm/gnDxLVNFx5k8Yltrz6ot1yNCwuwa5FtP16Be/OA6WqLdXpOgFj+i+i4
         ZxUrLwk8MW77LF3jZdz2buYRl4iR16lrztoVS7KM6RHqu/MKlRLtChL8lduk4D+nO9pc
         ePoQ==
X-Gm-Message-State: APjAAAVMkV/K92iE7uOM3RyvM/9EVex56vN93gdJ8RdujhEaD8QeRP4u
        vBTZc32/Ey5Rk3zfi87VTMeccilo3g3owDjGzCbcqBqI
X-Google-Smtp-Source: APXvYqw2kmK0axwRjVOS+NjBJKyHnONwYnh8IRpL/rucyikBIxWyt5YgarJv54Ftw9WTiZJau+30SYrBm7N9EBGFGVQ=
X-Received: by 2002:a5d:8747:: with SMTP id k7mr14142186iol.20.1560008861988;
 Sat, 08 Jun 2019 08:47:41 -0700 (PDT)
MIME-Version: 1.0
From:   Colt Boyd <coltboyd@gmail.com>
Date:   Sat, 8 Jun 2019 10:47:30 -0500
Message-ID: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
Subject: RAID-6 aborted reshape
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I was resizing a raid6 array with a internal write intent bitmap from
5 3TB drives (in RAID6) to 6 drives. It was aborted very early in
reshape via reboot and then reassembled with:
'mdadm -A /dev/md0 --force --verbose --update=3Drevert-reshape
--invalid-backup /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1
/dev/sdg1'

When I reassembled it this way I incorrectly thought the backup file
was zero bytes. It wasn't. I still have the intact backup file.

I=E2=80=99ve also since tried to reassemble it with the following create bu=
t
the XFS fs is not accessible:
'mdadm --create /dev/md0 --data-offset=3D1024 --level=3D6 --raid-devices=3D=
5
--chunk=3D1024K --name=3DOMV:0 /dev/sdb1 /dev/sde1 /dev/sdc1 /dev/sdd1
/dev/sdf1 --assume-clean --readonly'

I can see the XFS FS on the drives, example:
root@OMV1:~# dd if=3D/dev/sde1 bs=3D512k count=3D5 | hexdump -C
<snip>
00200000  58 46 53 42 00 00 10 00  00 00 00 00 82 f2 c3 00  |XFSB..........=
..|
00200010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
00200020  4e 2b 04 64 e8 1b 49 d9  a5 20 b5 74 79 94 52 f8  |N+.d..I.. .ty.=
R.|
<snip>

This is what it looked like immediately following the aborted reshape
and before attempting to recreate it. This is from the drive that was
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
   Array State : AAAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D =
replacing)

Where can I go from here to get this back?
