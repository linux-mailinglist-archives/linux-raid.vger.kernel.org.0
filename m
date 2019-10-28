Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4838FE7C67
	for <lists+linux-raid@lfdr.de>; Mon, 28 Oct 2019 23:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfJ1Wg6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Oct 2019 18:36:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfJ1Wg6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 28 Oct 2019 18:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1FE8AF6A;
        Mon, 28 Oct 2019 22:36:52 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 29 Oct 2019 09:36:45 +1100
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ivan Topolsky <doktor.yak@gmail.com>
Subject: Re: admin-guide page for raid0 layout issue
In-Reply-To: <20191028192326.GA24367@xps13.dannf>
References: <20191025003117.GA19595@xps13.dannf> <CAPhsuW6eYTF3AaisW+QsjEneABsh+fitw7bRz_NtD3Eo_gN0eg@mail.gmail.com> <20191028192326.GA24367@xps13.dannf>
Message-ID: <87y2x4ebuq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28 2019, dann frazier wrote:

> On Fri, Oct 25, 2019 at 04:07:50PM -0700, Song Liu wrote:
>> On Fri, Oct 25, 2019 at 12:16 PM dann frazier
>> <dann.frazier@canonical.com> wrote:
>> >
>> > hey,
>> >   I recently hit the raid0 default_layout issue and found the warning
>> > message to be lacking (and google hits show that I'm not the
>> > only one). It wasn't clear to me that it was referring to a kernel
>> > parameter, also wasn't clear how I should decide which setting to use,
>> > and definitely not clear that picking the wrong one could *cause
>> > corruption* (which, AIUI, is the case). What are your thoughts on
>> > adding a more admin-friendly explanation/steps on resolving the
>> > problem to the admin-guide, and include a URL to it in the warning
>> > message? As prior art:
>> >
>> >   https://github.com/torvalds/linux/commit/6a012288d6906fee1dbc244050a=
de1dafe4a9c8d
>> >
>> > If the idea has merit, let me know if you'd like me to take a stab at
>> > a strawdog.
>>=20
>> I think it is good to provide some more information for the admin.
>> But I am not sure whether we need to point to a url, or just put
>> everything in the message.
>>=20
>> Please feel free to try add this information and submit patches.
>
> Hi Song,
>   Here's an RFC of what I'm thinking - but drafting this has led me to
> more questions:
>
>  - It seems like we've broken backwards compatibility when creating
>    new multi-zone arrays. I expected that mdadm would still let me
>    create an array w/o a kernel cmdline option in-effect, and w/o
>    specifying a specific layout, and just choose a default.
>    But even w/ latest mdadm git, it doesn't:

Yes.  mdadm should let you do this, but it doesn't.  No one has written
the code yet.

>=20=20=20=20=20=20=20
>     $ sudo ./mdadm --create /dev/md0 --run --metadata=3Ddefault \
>       --homehost=3Dakis --level=3D0 --raid-devices=3D2 /dev/vdb1 /dev/vdc1
>     mdadm: /dev/vdb1 appears to be part of a raid array:
>            level=3Draid0 devices=3D2 ctime=3DMon Oct 28 18:55:38 2019
>     mdadm: /dev/vdc1 appears to be part of a raid array:
>            level=3Draid0 devices=3D2 ctime=3DMon Oct 28 18:55:38 2019
>     mdadm: RUN_ARRAY failed: Unknown error 524
>
>   It also doesn't let me specify a layout:
>     $ sudo ./mdadm --create /dev/md0 --run --metadata=3Ddefault \
>       --homehost=3Dakis --level=3D0 --raid-devices=3D2 /dev/vdb1 /dev/vdc=
1 --layout=3D2
>     mdadm: layout not meaningful for raid0 arrays.
>
>  - Once you've decided on a layout to use, how do you make that a property
>    of the array itself, and therefore avoid having to set default_layout=
=20
>    on any machine that uses it? Seems like we'd want to "bake that in"
>    to the array itself. I expected that if I created a new array on a
>    recent kernel that the array would remember the layout. But after
>    creating a new array on 5.4-rc5 w/ default_layout set, I rebooted
>    w/o a raid0.default_layout, and the kernel still refused to start
>    it.
>
>    Note: I realize my observation above does not match the text below
>    in the 3rd paragraph, but I just left it for now until I learn the
>    "right way".
>
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide=
/md.rst
> index 3c51084ffd379..5364c514d7926 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -759,3 +759,37 @@ These currently include:
>=20=20
>    ppl_write_hint
>        NVMe stream ID to be set for each PPL write request.
> +
> +Multi-Zone RAID0 Layout Migration
> +----------------------
> +An unintentional RAID0 layout change was introduced in the v3.14 kernel.
> +This effectively means there are 2 different layouts Linux will use to
> +write data to RAID0 arrays in the wild - the "pre-3.14" way and the
> +"post-3.14" way. Mixing these layouts by writing to an array while booted
> +on these different kernel versions can lead to corruption.

Says "pre-3.14" and "post-3.14" leaves it unclear what happens with
3.14.
Maybe "pre.3.14" and "3.14 and later" ??

> +
> +Note that this only impacts RAID0 arrays that include devices of differe=
nt
> +sizes. If your devices are all the same size, both layouts are equivalen=
t,
> +and your array is not at risk of corruption due to this issue.
> +
> +The kernel has since been updated to record a layout version when creati=
ng
> +new arrays. Unfortunately, the kernel can not detect which layout was us=
ed

As you note in the intro, the kernel doesn't record the layout version.
The kernel doesn't change the v1.x metadata at all where possible. That
is left for mdadm to do.

> +for writes to pre-existing arrays, and therefore requires input from the
> +administrator. This input can be provided via the
> +``raid0.default_layout=3D<N>`` kernel command line parameter, or via the
> +``layout`` attribute in the sysfs filesystem (but only when the array is
> +stopped).
> +
> +Which layout version should I use?
> +++++++++++++++++++++++++++++++++++
> +If your RAID array has only been written to by a >=3D 3.14 kernel, then =
you
> +should specify version 2. If your kernel has only been written to by a <=
 3.14
> +kernel, then you should specify version 1. If the array may have already=
 been
> +written to by both kernels < 3.14 and >=3D 3.14, then it is possible tha=
t your
> +data has already suffered corruption. Note that ``mdadm --detail`` will =
show
> +you when an array was created, which may be useful in helping determine =
the
> +kernel version that was in-use at the time.
> +
> +When determining the scope of corruption, it maybe also be useful to know
> +that the area susceptible to this corruption is limited to the area of t=
he
> +array after "MIN_DEVICE_SIZE * NUM DEVICES".
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index 1e772287b1c8e..e01cd52d71aa4 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -155,6 +155,8 @@ static int create_strip_zones(struct mddev *mddev, st=
ruct r0conf **private_conf)
>  		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_lay=
out setting\n",
>  		       mdname(mddev));
>  		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
> +		pr_err("Read the following page for more information:\n");
> +		pr_err("https://www.kernel.org/doc/html/latest/admin-guide/md.html#mul=
ti-zone-raid0-layout-migration\n");
>  		err =3D -ENOTSUPP;
>  		goto abort;
>  	}

I think it is an excellent idea to write this document and put the link
in the code - thanks.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl23bX4ACgkQOeye3VZi
gblzkQ//Wvf4ROhfcnkgc0mQkcRilXMCsoAEp9cXch4YGpBrJAKz89yi1uBi2VQi
VDRjGDnSaFaRcNHstWyxHre49qnlGGNLaRzE0s6JTAeKc9mwM9qGyD/VCiIFSIAO
cpsxdLiDRdAUtAhj0cWVGN/ujJtq8EITdhfahgWPFedPFPsLQlumCY0S37Sjw40Y
seun5f3/y1pIpD2HtAMovI/jcP1OX6dCYeQFF4+3FPd8jMfWl1AFQ4j3586Bd3oZ
knLWSAHm+bcuqBnwyBZyDVfAJ5oClXsK9clD+FU5kCT97yihIp1lxZZFnZ292RCD
n3V21M0saEKJNySGJ52Mm/Pf1J9uIz5+/L8amL+Rl/AsYCKpGEHsDm7zin8yzl0K
E3wOIyB3MYIPRqDNrqZlb7MECjTExOFP3qMfsVptquNUXdPJvPatFfmms0cIQqF5
P16j5+NrDYl/dPMzrO2X9+jFwW0GYZeSTWYnuIccMbrpeSSTif3hWFoiEXuPxR32
UkrhwOWWz0InrDFT892XzNsizcFCrRh7hfNe+R8gA+Yi7cKRqDiaHT+asi83ACDB
QAaAtgNODRn6wVqgdQ0PKfEYiIny+QkKjpu604U8UPWE+6P21EYZoFqhGmtdUgCj
G9efPFj3Mwl+XFzpKbQ4zxYyQmBmEjbPSq77a+E/u5pVmj5S9Vc=
=G9EN
-----END PGP SIGNATURE-----
--=-=-=--
