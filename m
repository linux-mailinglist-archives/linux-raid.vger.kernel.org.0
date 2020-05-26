Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF441E1A0D
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 05:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgEZDsE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 23:48:04 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:11271 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388579AbgEZDsE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 23:48:04 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 23:48:03 EDT
Date:   Tue, 26 May 2020 03:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1590464463;
        bh=HqQrMwsI/bxSV0v/ezZEwzt72rHTtGVNjlFsPHyXV7U=;
        h=Date:To:From:Reply-To:Subject:From;
        b=md0oyYZ2IuX5LCQrU5FA8lGjqWFk7RUi/qY14WtA7QOlapuOFsSVUvWLJs9DjU7av
         /MXPyOcBQMXBTElxoqGtVFyG7fqfPoAJe1OdXQ1BUl4vkj5LY0AucjSOmL3EvtQcYc
         18KlkFSROYILd3pmmz3B87G9/7mf5NK2TY6Q9DGE=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Jonas Fisher <fisherthepooh@protonmail.com>
Reply-To: Jonas Fisher <fisherthepooh@protonmail.com>
Subject: mdadm failed to create internal bitmap
Message-ID: <46XMI93tZHsxcOEfRj7cEIl272c4YrZUfsGBCr904ogr3xj8zPNdBaJdDWZBnahFIVVpLhDKWE0zc4_6JsBXWMu2mkiK63MUzuM6_ND7CpE=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_FILL_THIS_FORM_SHORT shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

I got a raid1 composed with 2 disks
/dev/sda -- 2T
/dev/sdb -- 4T

mdadm version is 3.3 and md metadata version is 1.0

At first, I was only using 1T of the each disk,

then I grew the array recently with the command

mdadm --grow /dev/md1 --size=3D1951944704K

I also tried to add the internal bitmap after expansion finished

mdadm --grow /dev/md1 --bitmap=3Dinternal

But I got the following message

mdadm: failed to create internal bitmap - chunksize problem.

I found that Avail Dev Size in superblock examine of two disks

are the same, same as the value I set when I expanded the array (1951944704=
K).

Then I found that in mdadm bitmap chunksize calculation,

in function add_internal_bitmap1 (super1.c)

variable "room" and and "max_bits" seems to be overflowed under this situat=
ion

/dev/sdb3:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x0
     Array UUID : 8d7b8858:e0e93d83:7c87e6e0:bd1628b8
           Name : 1
  Creation Time : Sun Apr  8 09:54:47 2018
     Raid Level : raid1
   Raid Devices : 2

Avail Dev Size : 3903889408 (1861.52 GiB 1998.79 GB)
     Array Size : 1951944704 (1861.52 GiB 1998.79 GB)
   Super Offset : 7810899368 sectors
   Unused Space : before=3D0 sectors, after=3D3907009952 sectors
          State : clean
    Device UUID : 3546fab2:3bfd9a17:39d78059:3d1eb830

    Update Time : Sun May 17 10:24:33 2020
  Bad Block Log : 512 entries available at offset -8 sectors
       Checksum : cf552c50 - correct
         Events : 93088


   Device Role : Active device 0
   Array State : AA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D repl=
acing)

/dev/sda3:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x0
     Array UUID : 8d7b8858:e0e93d83:7c87e6e0:bd1628b8
           Name : 1
  Creation Time : Sun Apr  8 09:54:47 2018
     Raid Level : raid1
   Raid Devices : 2

Avail Dev Size : 3903889408 (1861.52 GiB 1998.79 GB)
     Array Size : 1951944704 (1861.52 GiB 1998.79 GB)
   Super Offset : 3903891368 sectors
   Unused Space : before=3D0 sectors, after=3D1952 sectors
          State : clean
    Device UUID : 980038ac:99f4e8c6:39d91851:bdf6ed6d

    Update Time : Sun May 17 10:24:33 2020
  Bad Block Log : 512 entries available at offset -8 sectors
       Checksum : c3ce8290 - correct
         Events : 93088


   Device Role : Active device 1
   Array State : AA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D repl=
acing)

I was wondering is this because mdadm set the size of the rdevs in the arra=
y

before doing expansion (in function Grow_reshape)

that caused the sb->data_size not equals to actual raw device size

and consequently led to bitmap chunksize calculation error

or it is simply a data type issue.

Thanks,





