Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0DF855F
	for <lists+linux-raid@lfdr.de>; Tue, 12 Nov 2019 01:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLAe1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 Nov 2019 19:34:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726887AbfKLAe1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 Nov 2019 19:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573518865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0DQEAJBWlUHfpRJNFedwfcIHvENs/TBO2HR/D+2gF0=;
        b=MczvU6nHdAY76MgjAzgC/hZvMjfmIIDspJ7N//LunYMD5a8Ivh97WvOHGpYgRmBok6WmeS
        BgebqTUbfkXqke7IwEo51gTx2UvSVrf61QqejpvYNGZYtAVAFmL5No4l0pdhEED3EAtlbl
        Oyo/V9wnQrcczSEftWDAskt7zpQQIJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Rs7m9_ehOQu2VMyoSVDjVA-1; Mon, 11 Nov 2019 19:34:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9125418B5FA2;
        Tue, 12 Nov 2019 00:34:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A476B10027B3;
        Tue, 12 Nov 2019 00:34:14 +0000 (UTC)
Date:   Tue, 12 Nov 2019 08:34:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Pittman <jpittman@redhat.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org, xni@redhat.com,
        ncroxon@redhat.com, loberman@redhat.com, djeffery@redhat.com,
        minlei@redhat.com
Subject: Re: [PATCH] md/raid10: prevent access of uninitialized resync_pages
 offset
Message-ID: <20191112003409.GB15079@ming.t460p>
References: <20191111153243.9588-1-jpittman@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111153243.9588-1-jpittman@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Rs7m9_ehOQu2VMyoSVDjVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 11, 2019 at 10:32:43AM -0500, John Pittman wrote:
> Due to unneeded multiplication in the out_free_pages portion of
> r10buf_pool_alloc(), when using a 3-copy raid10 layout, it is
> possible to access a resync_pages offset that has not been
> initialized.  This access translates into a crash of the system
> within resync_free_pages() while passing a bad pointer to
> put_page().  Remove the multiplication, preventing access to the
> uninitialized area.
>=20
> Fixes: f0250618361db ("md: raid10: don't use bio's vec table to manage re=
sync pages")
> Signed-off-by: John Pittman <jpittman@redhat.com>
> Suggested-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/md/raid10.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 299c7b1c9718..8a62c920bb65 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -191,7 +191,7 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags, void=
 *data)
> =20
>  out_free_pages:
>  =09while (--j >=3D 0)
> -=09=09resync_free_pages(&rps[j * 2]);
> +=09=09resync_free_pages(&rps[j]);
> =20
>  =09j =3D 0;
>  out_free_bio:
> --=20
> 2.17.2
>=20

Reviewed-by: Ming Lei <ming.lei@redhat.com>

--=20
Ming

