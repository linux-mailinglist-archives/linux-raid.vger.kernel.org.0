Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B8228215
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jul 2020 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGUO0m (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jul 2020 10:26:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726412AbgGUO0l (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 Jul 2020 10:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595341600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TTbJDXw9juqx7GHf25fmdcVFUqbBz8s28P0Ijl2LM8=;
        b=Dn2NHLiz7Zn4NScnzcXW7S4XOCJ9hEehsGrZ7TilHkwtbQNEX+Err035+z73GW1tCrM7DF
        DRFlwO+FBO4cQDrjkl7gAT5VXMwoIHgjfCv9UuYYrUDevKG/l64he5gomB5YaevqMnKoS5
        sii+yp5QviC+nXXI8CRi5gcGjKsMNOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-pP2qZbnxOtiUKw1dr6EIcQ-1; Tue, 21 Jul 2020 10:26:38 -0400
X-MC-Unique: pP2qZbnxOtiUKw1dr6EIcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8608E800471;
        Tue, 21 Jul 2020 14:26:37 +0000 (UTC)
Received: from ovpn-114-9.rdu2.redhat.com (ovpn-114-9.rdu2.redhat.com [10.10.114.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D2E0100EBA7;
        Tue, 21 Jul 2020 14:26:37 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 1/1] md/raid10: avoid deadlock on recovery.
From:   Nigel Croxon <ncroxon@redhat.com>
In-Reply-To: <1583259280-124995-2-git-send-email-vmayatskikh@digitalocean.com>
Date:   Tue, 21 Jul 2020 10:26:35 -0400
Cc:     linux-raid@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5A36675-8344-4D67-9836-64F9BA78D78E@redhat.com>
References: <1583259280-124995-1-git-send-email-vmayatskikh@digitalocean.com>
 <1583259280-124995-2-git-send-email-vmayatskikh@digitalocean.com>
To:     Vitaly Mayatskikh <vmayatskikh@digitalocean.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


> On Mar 3, 2020, at 1:14 PM, Vitaly Mayatskikh =
<vmayatskikh@digitalocean.com> wrote:
>=20
> When disk failure happens and the array has a spare drive, resync =
thread
> kicks in and starts to refill the spare. However it may get blocked by
> a retry thread that resubmits failed IO to a mirror and itself can get
> blocked on a barrier raised by the resync thread.
>=20
> Signed-off-by: Vitaly Mayatskikh <vmayatskikh@digitalocean.com>
> ---
> drivers/md/raid10.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index ec136e4..f1a8e26 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -980,6 +980,7 @@ static void wait_barrier(struct r10conf *conf)
> {
> 	spin_lock_irq(&conf->resync_lock);
> 	if (conf->barrier) {
> +		struct bio_list *bio_list =3D current->bio_list;
> 		conf->nr_waiting++;
> 		/* Wait for the barrier to drop.
> 		 * However if there are already pending
> @@ -994,9 +995,16 @@ static void wait_barrier(struct r10conf *conf)
> 		wait_event_lock_irq(conf->wait_barrier,
> 				    !conf->barrier ||
> 				    (atomic_read(&conf->nr_pending) &&
> -				     current->bio_list &&
> -				     =
(!bio_list_empty(&current->bio_list[0]) ||
> -				      =
!bio_list_empty(&current->bio_list[1]))),
> +				     bio_list &&
> +				     (!bio_list_empty(&bio_list[0]) ||
> +				      !bio_list_empty(&bio_list[1]))) ||
> +				     /* move on if recovery thread is
> +				      * blocked by us
> +				      */
> +				     (conf->mddev->thread->tsk =3D=3D =
current &&
> +				      test_bit(MD_RECOVERY_RUNNING,
> +					       &conf->mddev->recovery) =
&&
> +				      conf->nr_queued > 0),
> 				    conf->resync_lock);
> 		conf->nr_waiting--;
> 		if (!conf->nr_waiting)
> =E2=80=94=20
> 1.8.3.1
>=20

Song, Have you had a chance to look at this patch?
We would like to have it pulled in to the kernel.

-Nigel


