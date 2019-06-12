Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291E842E5A
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2019 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFLSHu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Jun 2019 14:07:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54580 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfFLSHu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 12 Jun 2019 14:07:50 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hb7f2-0005T1-6V
        for linux-raid@vger.kernel.org; Wed, 12 Jun 2019 18:07:48 +0000
Received: by mail-wm1-f72.google.com with SMTP id 20so1308672wma.2
        for <linux-raid@vger.kernel.org>; Wed, 12 Jun 2019 11:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OGRUmhqlKrRJMqfWIDmM/X2ZfNPUoSa1OGXxMXehSE=;
        b=sPqP5n6/simthzjEthe03WjymTnXalp7vMyyMTsz7NXGbOgO5iYRpY3gRfpcX/18VN
         Tucl6OQ1ZWdyRXLg5Xg8vfx61WSeaIKA3549a7U6SPPYdrNIPHPFHglOig6OcI4kEZJb
         iZe1nC4PVMalNLlchkiq/v9Ekua+5Ye4TMULfXXohj7RzST9KsWrcnD7YK+0EYX0Ibbl
         /B+ZUMa8ml9JpxfNs5geH+wZh9hDUU7TsJH9tfoM9ceMUn2t5bgip35lrAVwZ/BvEFrb
         MwyO1Tk2xRJDRalbeda4JY5zZ27rhJ8FPYwr3C27UIQOHRte94iLxalvgPJa5tgVJOO6
         EhlA==
X-Gm-Message-State: APjAAAUnm9MuAQV8PpHnsxPNxkMNrMCenXswnyeADfeMU8koY6aGSNYV
        jD+MxfaTNWufMvYZoIpZcNqDbMENSRFKlkiOjfiwhkpSVwQW0K/D1uv+6pyC+ahEyH2OzyfUK//
        vZ3DjDdytlEk/Av3fBSiIujCleBx4z9p5EDWJgM9bWv0ZnHmaiz2EP78=
X-Received: by 2002:adf:ee48:: with SMTP id w8mr33383247wro.308.1560362867969;
        Wed, 12 Jun 2019 11:07:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOqEGqIlqv+f9AXu73DLfKUKScc/uWI7hpSWZQ2cTHVf6FRayN7hzBGmeRUIbYbzbQeUXLl0TkfWRTbRPD8HU=
X-Received: by 2002:adf:ee48:: with SMTP id w8mr33383235wro.308.1560362867807;
 Wed, 12 Jun 2019 11:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190523172345.1861077-1-songliubraving@fb.com>
 <20190523172345.1861077-2-songliubraving@fb.com> <3d77dc37-e4be-2395-7067-5a9b6a71bf3a@canonical.com>
 <20190612164958.GB31124@kroah.com>
In-Reply-To: <20190612164958.GB31124@kroah.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 12 Jun 2019 15:07:11 -0300
Message-ID: <CAHD1Q_yoda7MUWDU5H4FKGK6tgmFXEEK9cvg20QJNrsgNgHnZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jun 12, 2019 at 1:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 12, 2019 at 01:37:24PM -0300, Guilherme G. Piccoli wrote:
> > +Greg, Sasha
>
> Please resend them in a format that they can be applied in.
>
> Also, I need a TON of descriptions about why this differs from what is
> in Linus's tree, as it is, what you have below does not show that at
> all, they seem to be valud for 5.2-rc1.

Thanks Greg, I'll work on it. Can this "ton" of description be a cover-letter?
Cheers,


Guilherme

>
> And I need acks from the maintainers of the subsystems.
>
> thanks,
>
> greg k-h
