Return-Path: <linux-raid+bounces-3801-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DE4A4956B
	for <lists+linux-raid@lfdr.de>; Fri, 28 Feb 2025 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92688188B98D
	for <lists+linux-raid@lfdr.de>; Fri, 28 Feb 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E2256C9A;
	Fri, 28 Feb 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQUPDNEt"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C5256C8A
	for <linux-raid@vger.kernel.org>; Fri, 28 Feb 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735498; cv=none; b=X2v+iYyvwaU4BVMnBIrIgyMSeZl8mTqlzSAwJXpl7zbmrpsjDW3O1Nq3DqirefGuX5W2gPuy5zj9KlRwTw/ygAote3Ab/I+mabQKtsNUyo/gZNccBsWyhRr7NR7CQr3bPOIXfLXhNeGWsw9apyUXN+KSi6k/eLBzg4INAYtcB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735498; c=relaxed/simple;
	bh=fCAqNyZrUj+14Jc7nkJuAMXd2vgR/aoF1ZFoRdJA7vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uF+b8FVNLN+pO21EWK4NfM3EBiQW/W3qdEExRQNXaWvk7fGLPoDtOtQuCInVnQF28HflgHiHN6A0CQBz1DvsgVEkcYTbgKfKGPndfJhZJDuivM3H/TCIYYBZzCcxxXv4GD9CVHk8g/lerXbx7PlPB1Ko7O5OlOXTnb1RjGxGTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQUPDNEt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740735497; x=1772271497;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fCAqNyZrUj+14Jc7nkJuAMXd2vgR/aoF1ZFoRdJA7vs=;
  b=fQUPDNEtVh3ZYk0ZhZPFl4eIAfOhtFTvgaSjGPNN3tVon4gCSk4Bz4hl
   GqMFnh0pwYDzSRuWHtzp4emw8Kkvm84g22dswVu4zisrAFNnUBCMYD/qR
   ojnW7XmIwVytztWO8dF4f53sI+rtKATOtCPea/+JCthmPj3DyHneVJ4Eo
   NALfVntE3mgPZ9GbPGlzjSktTfZVb376xLN7ak0YOCDMdqY7BHWuUfR+r
   HVOsKxGKz5HRDozP93ZFgO0+pW+JKeTXyaAYxU1KJTpYu9z+JOrThhJj/
   Or0g7B89OvBRrwJETrC7kCKmX/1BMHRSTAxpiThbaKX7nzIRAyOJPT91g
   w==;
X-CSE-ConnectionGUID: 3VsNfCwWT4CYI1aaKpRHjQ==
X-CSE-MsgGUID: iE4WIai2SOeOVdXkPS+Cvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52293045"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="52293045"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:38:15 -0800
X-CSE-ConnectionGUID: ffdcFehVSoWZGExKr7sCiA==
X-CSE-MsgGUID: o0aVQQlPRwGpFNLKzCfhzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154466355"
Received: from unknown (HELO localhost) ([10.217.182.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:38:12 -0800
Date: Fri, 28 Feb 2025 10:38:07 +0100
From: Blazej Kucman <blazej.kucman@linux.intel.com>
To: Xiao Ni <xni@redhat.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>, mtkaczyk@kernel.org,
 linux-raid@vger.kernel.org, ncroxon@redhat.com, song@kernel.org,
 yukuai@kernel.org
Subject: Re: [PATCH V2] mdmon: imsm: fix metadata corruption when managing
 new array
Message-ID: <20250228103807.000028e7@linux.intel.com>
In-Reply-To: <CALTww2-DSfGAO-f2Porbu3+vrhNGcAd=SsP7h+wciw60v12JAA@mail.gmail.com>
References: <20250218184831.19694-1-junxiao.bi@oracle.com>
	<20250224141541.000042f1@linux.intel.com>
	<CALTww2-DSfGAO-f2Porbu3+vrhNGcAd=SsP7h+wciw60v12JAA@mail.gmail.com>
Organization: intel
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2025 14:48:17 +0800
Xiao Ni <xni@redhat.com> wrote:

> On Mon, Feb 24, 2025 at 9:16=E2=80=AFPM Blazej Kucman
> <blazej.kucman@linux.intel.com> wrote:
> >
> > On Tue, 18 Feb 2025 10:48:31 -0800
> > Junxiao Bi <junxiao.bi@oracle.com> wrote:
> > =20
> > > When manager thread detects new array, it will invoke
> > > manage_new(). For imsm array, it will further invoke
> > > imsm_open_new(). Since commit bbab0940fa75("imsm: write bad block
> > > log on metadata sync"), it preallocates bad block log when
> > > opening the array, that requires increasing the mpb buffer size.
> > > For that, imsm_open_new() invokes function
> > > imsm_update_metadata_locally(), which first uses
> > > imsm_prepare_update() to allocate a larger mpb buffer and store
> > > it at "mpb->next_buf", and then invoke imsm_process_update() to
> > > copy the content from current mpb buffer "mpb->buf" to
> > > "mpb->next_buf", and then free the current mpb buffer and set the
> > > new buffer as current.
> > >
> > > There is a small race window, when monitor thread is syncing
> > > metadata, it gets current buffer pointer in
> > > imsm_sync_metadata()->write_super_imsm(), but before flushing the
> > > buffer to disk, manager thread does above switching buffer which
> > > frees current buffer, then monitor thread will run into
> > > use-after-free issue and could cause on-disk metadata corruption.
> > > If system keeps running, further metadata update could fix the
> > > corruption, because after switching buffer, the new buffer will
> > > contain good metadata, but if panic/power cycle happens while disk
> > > metadata is corrupted, the system will run into bootup failure if
> > > array is used as root, otherwise the array can not be assembled
> > > after boot if not used as root.
> > >
> > > This issue will not happen for imsm array with only one member
> > > array, because the memory array has not be opened yet, monitor
> > > thread will not do any metadata updates.
> > > This can happen for imsm array with at lease two member array, in
> > > the following two scenarios:
> > > 1. Restarting mdmon process with at least two member array
> > > This will happen during system boot up or user restart mdmon after
> > > mdadm upgrade
> > > 2. Adding new member array to exist imsm array with at least one
> > > member array.
> > >
> > > To fix this, delay the switching buffer operation to monitor
> > > thread.
> > >
> > > Fixes: bbab0940fa75("imsm: write bad block log on metadata sync")
> > > Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> > > ---
> > > v2 <- v1:
> > >  - address code style in manage_new()
> > >  - make lines of git log not over 75 characters
> > >
> > >  managemon.c   | 10 ++++++++--
> > >  super-intel.c | 14 +++++++++++---
> > >  2 files changed, 19 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/managemon.c b/managemon.c
> > > index d79813282457..74b64bfc9613 100644
> > > --- a/managemon.c
> > > +++ b/managemon.c
> > > @@ -721,11 +721,12 @@ static void manage_new(struct mdstat_ent
> > > *mdstat,
> > >        * the monitor.
> > >        */
> > >
> > > +     struct metadata_update *update =3D NULL;
> > >       struct active_array *new =3D NULL;
> > >       struct mdinfo *mdi =3D NULL, *di;
> > > -     int i, inst;
> > > -     int failed =3D 0;
> > >       char buf[SYSFS_MAX_BUF_SIZE];
> > > +     int failed =3D 0;
> > > +     int i, inst;
> > >
> > >       /* check if array is ready to be monitored */
> > >       if (!mdstat->active || !mdstat->level)
> > > @@ -824,9 +825,14 @@ static void manage_new(struct mdstat_ent
> > > *mdstat, /* if everything checks out tell the metadata handler we
> > > want to
> > >        * manage this instance
> > >        */
> > > +     container->update_tail =3D &update;
> > >       if (!aa_ready(new) || container->ss->open_new(container,
> > > new, inst) < 0) {
> > > +             container->update_tail =3D NULL;
> > >               goto error;
> > >       } else {
> > > +             if (update)
> > > +                     queue_metadata_update(update);
> > > +             container->update_tail =3D NULL;
> > >               replace_array(container, victim, new);
> > >               if (failed) {
> > >                       new->check_degraded =3D 1;
> > > diff --git a/super-intel.c b/super-intel.c
> > > index cab841980830..4988eef191da 100644
> > > --- a/super-intel.c
> > > +++ b/super-intel.c
> > > @@ -8467,12 +8467,15 @@ static int imsm_count_failed(struct
> > > intel_super *super, struct imsm_dev *dev, return failed;
> > >  }
> > >
> > > +static int imsm_prepare_update(struct supertype *st,
> > > +                            struct metadata_update *update);
> > >  static int imsm_open_new(struct supertype *c, struct
> > > active_array *a, int inst)
> > >  {
> > >       struct intel_super *super =3D c->sb;
> > >       struct imsm_super *mpb =3D super->anchor;
> > > -     struct imsm_update_prealloc_bb_mem u;
> > > +     struct imsm_update_prealloc_bb_mem *u;
> > > +     struct metadata_update mu;
> > >
> > >       if (inst >=3D mpb->num_raid_devs) {
> > >               pr_err("subarry index %d, out of range\n", inst);
> > > @@ -8482,8 +8485,13 @@ static int imsm_open_new(struct supertype
> > > *c, struct active_array *a, dprintf("imsm: open_new %d\n", inst);
> > >       a->info.container_member =3D inst;
> > >
> > > -     u.type =3D update_prealloc_badblocks_mem;
> > > -     imsm_update_metadata_locally(c, &u, sizeof(u));
> > > +     u =3D xmalloc(sizeof(*u));
> > > +     u->type =3D update_prealloc_badblocks_mem;
> > > +     mu.len =3D sizeof(*u);
> > > +     mu.buf =3D (char *)u;
> > > +     imsm_prepare_update(c, &mu);
> > > +     if (c->update_tail)
> > > +             append_metadata_update(c, u, sizeof(*u));
> > >
> > >       return 0;
> > >  } =20
> >
> > Hi Junxiao,
> >
> > LGTM, Approved
> >
> > Thanks,
> > Blazej
> > =20
>=20
> Hi Blazej
>=20
> Have you updated the PR
> https://github.com/md-raid-utilities/mdadm/pull/152 with this V2
> version?
>=20
> Regards
> Xiao
>=20
Hi,

Yes, the test result is the same as V1 but there is one note from
checkpatch

WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12
chars of sha1> ("<title line>")' - ie: 'Fixes: ca847037fafb ("[V2]mdmon: im=
sm: fix metadata corruption when managing new array")'
#42:
Fixes: bbab0940fa75("imsm: write bad block log on metadata sync")

Regards,
Blazej

>=20


