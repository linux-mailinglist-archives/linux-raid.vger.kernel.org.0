Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C5123BBD
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 01:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRAqD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 19:46:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40385 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLRAqC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 19:46:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so90972qkg.7
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGv6NWwC5T+2qGsF15yb4UDCK8X8f/JnXrJ8F/7ELJA=;
        b=pqld6fE5zuS3E94SMyQOyg86sEr7Ir6DvfHaOzLf+mvJQLdkFwwe7XENmdotDlz0KT
         TbPzAGeWvk1QJVlc8bIR+sFjO5fVGS26adaA1jmGTGpIZ5uiO/MKq4czP020pTzoEJkn
         sZLYlCH+GD9t9YJ8hLHTj0YJJu9uFKnQhjFpPlpn6uagkmTq+GWU54wLGVMP+DxBeNgr
         1ws6srVVhO31xFz8mcASZ/4h3YDoJ7IeINE8R+dAIiLRWz1NR6iF8oknAPTXiL4XV1nP
         yDl+Wa2cWQ+dWPfsUGSqQJ9pQpEsFsO4JnMrTMRKx7yT5ILJMFyIXE/piERJZ3gP3AV9
         ZKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGv6NWwC5T+2qGsF15yb4UDCK8X8f/JnXrJ8F/7ELJA=;
        b=KT4MUdcmKz6YkWkLHIZsKWOb6e/65CaEKcJdZRmc8UERWcIMyOho7A26i4IKjggrtV
         p08P68DgkaZYDrx6/U6j7Bm+RQjNBNSuZuyO3zigQ8NhGBPeTHf5fq58SEyy3FxOlUjc
         2SrkLbVyOzeG4MdA3QapPsA15XQKZbNF6JRn7cMU5/BLRsI8fZWy77WafUeseTV3Hmft
         BZTSeyJxCeMd8QqAHg1gKzgl6TdDslmgy+6LkRUeh+OkqhTGPiGYx2ax4KdXLBNKMbWa
         4qU+ywky01zcrLCLtzpHdk9YyyutTduK2iiGWfxslshctRWos0Jn7aZEFuwm600PWKxy
         3ohw==
X-Gm-Message-State: APjAAAUuLDzU9RBq/AyMR6ITwM2g4PqwlsdfWZILTXmalNxxQuVMnn7C
        TdDPBuD/HFWCREsGIhiSoCMbQx7LlKiFLGdefvTHig==
X-Google-Smtp-Source: APXvYqzylY0MzaFJod5uOZ6rFk99jWiv5sdPS7aV/+e7p6WNCrFcWwgAJyDK7PQaXQVYRwTz2AMS+luqyNpEFFW5Sr4=
X-Received: by 2002:a37:8b85:: with SMTP id n127mr891705qkd.353.1576629961898;
 Tue, 17 Dec 2019 16:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
 <20191121103728.18919-4-guoqing.jiang@cloud.ionos.com> <CAPhsuW7OYyCbdidYVKjhYqs09WKvgOMny-QXDwnkhbebs+ZT1A@mail.gmail.com>
In-Reply-To: <CAPhsuW7OYyCbdidYVKjhYqs09WKvgOMny-QXDwnkhbebs+ZT1A@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 17 Dec 2019 16:45:51 -0800
Message-ID: <CAPhsuW5aE7Pzj2_EVHgFFZ61=CmJDAQGXH=_7Ah8M3Us=p0Y3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] md: add serialize_policy sysfs node for raid1
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Dec 17, 2019 at 4:06 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
> >
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> > With the new sysfs node, we can use it to control if raid1 array
> > wants io serialization or not. So mddev_create_serial_pool and
> > mddev_destroy_serial_pool are called in serialize_policy_store
> > to enable or disable the serialization.
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> I added:
>
> diff --git i/drivers/md/md.c w/drivers/md/md.c
> index efeaeba3583d..5a2bb6bcc43d 100644
> --- i/drivers/md/md.c
> +++ w/drivers/md/md.c
> @@ -5330,6 +5330,9 @@ serialize_policy_store(struct mddev *mddev,
> const char *buf, size_t len)
>         if (value == mddev->serialize_policy)
>                 return len;
>
> +       if (value < 0 || value > 1)
> +               return -EINVAL;
> +
>         err = mddev_lock(mddev);
>         if (err)
>                 return err;

Actually, this is not necessary. Never mind.

Song
