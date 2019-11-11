Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6045FF7910
	for <lists+linux-raid@lfdr.de>; Mon, 11 Nov 2019 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKQqi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 Nov 2019 11:46:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726857AbfKKQqi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 Nov 2019 11:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573490796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsM1EMpctSVMVSpaVQhVgnlVuzhFXtixqtw9uah11R4=;
        b=QblbiiVd62Q+WlhJ6Lx8QzY00A5ZEPTwS6e8njDklKxUFp6GoU0PmxhmI9WsbsJs3NN7De
        7lBjRHPYb2oy6v2q/OeA0UZjhgFjHHc4/Yah+43UZ63nCHVdeHrEm06uxJj6FTAc9XcwtE
        9Syrhr3bxIw8pi5IiZjVjrYh0bCdprg=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-pVpx5hN-O0alFYQo2YI-jQ-1; Mon, 11 Nov 2019 11:46:35 -0500
Received: by mail-yw1-f71.google.com with SMTP id r185so12002463ywh.3
        for <linux-raid@vger.kernel.org>; Mon, 11 Nov 2019 08:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9hMvk/HrBmSVwMoNVxIL7PoCpfHSYCMsfxGepdDRbk=;
        b=Hw3gk8tjHmr3PKTmtDIhVx4NALhmw8NVfM7j5qX96BTxtu5BGIJA4ABwU/tlfvy/an
         i9sjq+5DI8J05+/n22ORS+vTWhxK2WmRiVmF0emFKYR2JgMtIQeGsIMq24VlPwQzhf3o
         6y9jCl26dcJZaLc7w4E/figVXo0CA2kUs0V31Ehn48homNGAaralddz8dYRjqJkfqUW9
         461k7IJ3frsBgrLVoUiVR6KGHU5wNYZh0wuN1w9JlEPOWYgODj4NkOxMtuYfF2MSKm9T
         hwSBesT+9nTTwmqIX6xE1QK7u1eIIsXnZVxapUX83oD35IlFhNy7tgk6YBbZq+E82iRD
         6AeQ==
X-Gm-Message-State: APjAAAV9gs4S9SbBEeofQaEWeMEFuwAjlQCik3o3krsQdVF4+6r3cCNG
        nNtQZMIksjfX2KeubGV39ApTs8J/FFogz5KAUfyDPxMuukvJS4h2zxPK+0hQU2RZ+LyIZ6mYXB2
        ZtaDv4WL9vMYkx0yEro6MPg==
X-Received: by 2002:a81:9115:: with SMTP id i21mr17208667ywg.500.1573490794140;
        Mon, 11 Nov 2019 08:46:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvG28DLLZWA6NBouR39YtVwgYjeXnhT4XhBNS2GulHnZncC5qvH358IUKmwHnh+7gquV2R2w==
X-Received: by 2002:a81:9115:: with SMTP id i21mr17208644ywg.500.1573490793658;
        Mon, 11 Nov 2019 08:46:33 -0800 (PST)
Received: from rhel7lobe ([2600:6c64:4e80:f1:336a:6920:3806:8b87])
        by smtp.gmail.com with ESMTPSA id 203sm6110185ywk.29.2019.11.11.08.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:46:33 -0800 (PST)
Message-ID: <e914ff58c0dca1f9d63b203157eae64660e0cd5e.camel@redhat.com>
Subject: Re: [PATCH] md/raid10: prevent access of uninitialized resync_pages
 offset
From:   Laurence Oberman <loberman@redhat.com>
To:     John Pittman <jpittman@redhat.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, xni@redhat.com, ncroxon@redhat.com,
        djeffery@redhat.com, minlei@redhat.com
Date:   Mon, 11 Nov 2019 11:46:31 -0500
In-Reply-To: <20191111153243.9588-1-jpittman@redhat.com>
References: <20191111153243.9588-1-jpittman@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7)
Mime-Version: 1.0
X-MC-Unique: pVpx5hN-O0alFYQo2YI-jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 2019-11-11 at 10:32 -0500, John Pittman wrote:
> Due to unneeded multiplication in the out_free_pages portion of
> r10buf_pool_alloc(), when using a 3-copy raid10 layout, it is
> possible to access a resync_pages offset that has not been
> initialized.  This access translates into a crash of the system
> within resync_free_pages() while passing a bad pointer to
> put_page().  Remove the multiplication, preventing access to the
> uninitialized area.
>=20
> Fixes: f0250618361db ("md: raid10: don't use bio's vec table to
> manage resync pages")
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
> @@ -191,7 +191,7 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags,
> void *data)
> =20
>  out_free_pages:
>  =09while (--j >=3D 0)
> -=09=09resync_free_pages(&rps[j * 2]);
> +=09=09resync_free_pages(&rps[j]);
> =20
>  =09j =3D 0;
>  out_free_bio:

This was reproduduced and tested multiple times by John in the Red Hat
Lab and tested by the customer. Thanks David and John.
Reviewed-by: Laurence Oberman <loberman@redhat.com>


