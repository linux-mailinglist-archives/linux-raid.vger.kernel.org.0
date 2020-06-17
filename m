Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD241FC49D
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jun 2020 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFQDUZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Jun 2020 23:20:25 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:37478 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgFQDUZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 16 Jun 2020 23:20:25 -0400
Date:   Wed, 17 Jun 2020 03:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1592363656;
        bh=9U/fWvxQhrAM60JYx4lEbl6Ou31cMPnIDOAC0rB97SQ=;
        h=Date:To:From:Reply-To:Subject:From;
        b=rPAMPh4462lK5v+9q+DnIWV0owl81RqYCV9aMJfL3/6HWUguJBw4oR5RG+OF98/5S
         ruIymWh0+FvnVtz3+iX6LbbqOmi2lbp1GUUzHZy2LoLTLNHXRA8DlBNnlnjZLmJxt9
         12o/SRR+dbl+hRfrM8k27/TMub5GCl6VnyJnKG1U=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Jonas Fisher <fisherthepooh@protonmail.com>
Reply-To: Jonas Fisher <fisherthepooh@protonmail.com>
Subject: Choosing the value to update the size of each member device in mdadm Grow_reshape
Message-ID: <D6m2t3zOKX2WVfwblOhsMTF2cxL2bcl55Amvta4TPl8c9f5wv79ydTCPMsuX0WCtexsFSK-Bjlpryhccn3cpC_F48XdEgYOnSujcnrMydrs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I got a raid1 composed with 2 disks, 4T each

At first, I was only using 1T of the each disk, then I grew the array recen=
tly

with the command

mdadm --grow /dev/md1 --size=3D1951944704K

After grow finished, I found that Avail Dev Size become 3903889408

not like 4T as before

/dev/sdb3:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x0
     Array UUID : 8d7b8858:e0e93d83:7c87e6e0:bd1628b8
           Name : 1
  Creation Time : Sun Apr 8 09:54:47 2018
     Raid Level : raid1
   Raid Devices : 2

Avail Dev Size : 3903889408 (1861.52 GiB 1998.79 GB)
     Array Size : 1951944704 (1861.52 GiB 1998.79 GB)
........

/dev/sda3:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x0
     Array UUID : 8d7b8858:e0e93d83:7c87e6e0:bd1628b8
           Name : 1
  Creation Time : Sun Apr 8 09:54:47 2018
     Raid Level : raid1
   Raid Devices : 2

Avail Dev Size : 3903889408 (1861.52 GiB 1998.79 GB)
     Array Size : 1951944704 (1861.52 GiB 1998.79 GB)

after tracing the code, this value was modified in mdadm Grow.c

Grow_reshape() function

/* Update the size of each member device in case
  * they have been resized.  This will never reduce
  * below the current used-size.  The "size" attribute
  * understands '0' to mean 'max'.
  */
min_csize =3D 0;
rv =3D 0;
for (mdi =3D sra->devs; mdi; mdi =3D mdi->next) {
         if (sysfs_set_num(sra, mdi, "size",
                           s->size =3D=3D MAX_SIZE ? 0 : s->size) < 0) {
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 /* Probably kernel refusing to let us
                  * reduce the size - not an error.
                  */
                 break;
         }

I thought the "size" here in kernel means "Device size", but under this sit=
uation,

my component device size become smaller than its actual size

I was curious that why don't we always set the size to MAX_SIZE?

Thanks,
