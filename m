Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA51E595E
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE1HpH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 03:45:07 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:60817 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1HpG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 28 May 2020 03:45:06 -0400
Date:   Thu, 28 May 2020 07:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1590651903;
        bh=JTJ+VNkiLzkje8o3KsLiegWh4167oGiUTCuZRSqBlA4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=gXiJaU+8iEOYPOBgvtW3JXSCei5hC5r0Pjh+EDP4bqAsGL+PWJlhgo3SAMBTgCNFp
         kP8vF07b1Y2cCOShHvZDnaImlox1qWPT8nOAyQ+eisI5kdbl6qlODjY+TrHTD1EPMb
         iEYE2osRvajMgJW1I+tFia4bor7D9nklws3D3dXY=
To:     antlists <antlists@youngman.org.uk>
From:   Jonas Fisher <fisherthepooh@protonmail.com>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Reply-To: Jonas Fisher <fisherthepooh@protonmail.com>
Subject: Re: mdadm failed to create internal bitmap
Message-ID: <-Kq_IeWCfjojFi_Ual3awQ5xrcMpifG0zq6Mz3sMjN2cIiN4agmKxtW11SJo4TVyYtvhpj0NOv_QV4hDvohKTTpgtvVCDwAhLJzXsbPWNuc=@protonmail.com>
In-Reply-To: <4313d92c-8657-d2d7-0ddc-f91e211cf1bf@youngman.org.uk>
References: <46XMI93tZHsxcOEfRj7cEIl272c4YrZUfsGBCr904ogr3xj8zPNdBaJdDWZBnahFIVVpLhDKWE0zc4_6JsBXWMu2mkiK63MUzuM6_ND7CpE=@protonmail.com>
 <4313d92c-8657-d2d7-0ddc-f91e211cf1bf@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I've tried the latest version of mdadm

and the problem still exists.

I believed it was because in add_internal_super1, variable "room"

overflowed that made it become a negative value,

and if room less than 3 * 2 and also __le32_to_cpu(sb->max_dev) <=3D 384

room would become 6, and max_bits became extremely small,

unfortunately, this is a 2T array, so the bitmap creation failed.

I still wondered, why would mdadm stored the value (if specified)

to rdev->sectors other than just make it to the largest.

In Grow_reshape (Grow.c)

=09=09/* Update the size of each member device in case
=09=09 * they have been resized.  This will never reduce
=09=09 * below the current used-size.  The "size" attribute
=09=09 * understands '0' to mean 'max'.
=09=09 */
=09=09min_csize =3D 0;
=09=09for (mdi =3D sra->devs; mdi; mdi =3D mdi->next) {
=09=09=09sysfs_set_num(sra, mdi, "size",
=09=09=09=09      s->size =3D=3D MAX_SIZE ? 0 : s->size);
                                                                ^^^^^^^^

Thanks,


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On 2020=E5=B9=B45=E6=9C=8826=E6=97=A5Tuesday 18:14, antlists <antlists@youn=
gman.org.uk> wrote:

> On 26/05/2020 04:40, Jonas Fisher wrote:
>
> > Hi all,
> > I got a raid1 composed with 2 disks
> > /dev/sda -- 2T
> > /dev/sdb -- 4T
> > mdadm version is 3.3 and md metadata version is 1.0
>
> That's a well ancient mdadm, you need to upgrade ...
>
> > At first, I was only using 1T of the each disk,
> > then I grew the array recently with the command
> > mdadm --grow /dev/md1 --size=3D1951944704K
> > I also tried to add the internal bitmap after expansion finished
> > mdadm --grow /dev/md1 --bitmap=3Dinternal
> > But I got the following message
> > mdadm: failed to create internal bitmap - chunksize problem.
> > I found that Avail Dev Size in superblock examine of two disks
> > are the same, same as the value I set when I expanded the array (195194=
4704K).
>
> Makes sense, it's a mirror ...
>
> > Then I found that in mdadm bitmap chunksize calculation,
> > in function add_internal_bitmap1 (super1.c)
> > variable "room" and and "max_bits" seems to be overflowed under this si=
tuation
>
> Could well be fault of the old mdadm ...
>
> > I was wondering is this because mdadm set the size of the rdevs in the =
array
> > before doing expansion (in function Grow_reshape)
> > that caused the sb->data_size not equals to actual raw device size
> > and consequently led to bitmap chunksize calculation error
> > or it is simply a data type issue.
> > Thanks,
>
> Download and run a new mdadm. If the problem still persists, then I
> guess the mdadm guys will take a look.
>
> https://raid.wiki.kernel.org/index.php/Linux_Raid
>
> https://raid.wiki.kernel.org/index.php/A_guide_to_mdadm#Getting_mdadm
>
> It seems odd to be mirroring a 2TB and 4TB, but never mind. It's not
> (that much) a problem if you're using desktop drives for a mirror, but
> if you do get a new 4TB drive, read the advice on the website and make
> sure you get a proper raid drive.
>
> Cheers,
> Wol


