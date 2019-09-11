Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53601AF918
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfIKJio (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 05:38:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46191 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKJio (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Sep 2019 05:38:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id v11so24367308qto.13
        for <linux-raid@vger.kernel.org>; Wed, 11 Sep 2019 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCz/VG8bi2Svk6FGKq+odiEPcN3hxS6ayXuH/1xyUr8=;
        b=ik9K30/upSNqqdjIQmOaQC8Lw/Cu25Xr03YEGbzuyxvsSq+poY+rK+4jZo+3p1W4pi
         OjOw5YMU9xi9dMBxs8UGUoNqdzCBshpCj5uCsEivHuo78vgPYJcO1e6+hDmEeYtkbqkO
         Ocd6AlBub4FaaDU2ks2XR05QfZFbmHGzJ7WuXw5EfpZsekBVvEXeGPeZQJfpW/Fq6VsX
         fTSGIHnXwHF2LY0TrTlc6fN7RkjtyWgBIN3nyG+675201bGdFwt0xe65mey7UORPLLnd
         WJNq4LYAY1LSTLK/yKd2rxevnRyOC4RNfAsHLzdDdgidLMGE3XPkAHdsAltcl7h8/l5a
         Aqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCz/VG8bi2Svk6FGKq+odiEPcN3hxS6ayXuH/1xyUr8=;
        b=d2DH53plV7Lv2EPMq65L9+NXLg/yRXrzAwy6gmgKo1k5kv1KmG0cTromQXWfrKILd7
         AO2mm6v7ZHUkqhU2GalrIbHHuAxYHsssXisCDGLrTbmX9q54h9j8Jf9UBtNF/QRll7l1
         Tsx1+hHKUyacm0cgZDR6UQGrmCrD46u/pYeCauWm2xRtWqvqOXXVht1sEEHTi/6upOWx
         ej46x6FCwmSMAgGHIidpqT5OdEstJOptr5d1jM6U9JCCn9RZiVVRlkY0aSrrBPhjpO+Q
         KV8Ug3ynOwA1ZfBI0TOhoUuTVRvkWAN56v6WD9kiIZgSQnz/vpAcKTyiff0akFWKIlSX
         tNkA==
X-Gm-Message-State: APjAAAUSgxk6JcL9RH5uYMGEDAH2EbD9xDqgNogCjbfJbOVcFPxqxT3V
        Ilc4XN262Sk5VuLZm7c1p1i6GFHQeVUoybGF/2W+9ZJM
X-Google-Smtp-Source: APXvYqxMFmmD4Ih+Wiq2YOJRdC7KnWvKoqGYZfiOzsPBMAxdTGmG4A2Wq76DsvFnaQqFmdlVIuR3GlDjPOv/W/2qaf0=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr33622455qtr.77.1568194723171;
 Wed, 11 Sep 2019 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190911030142.49105-1-yuyufen@huawei.com>
In-Reply-To: <20190911030142.49105-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Sep 2019 10:38:31 +0100
Message-ID: <CAPhsuW7Q=YsMkMQGMS54vskTRjM24oRMWP7534n_pkOhyGvJUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] skip spare disk as freshest disk
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Sep 11, 2019 at 3:44 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Hi,
>         For this patchset , we add a new entry .disk_is_spare in super_type
>         to check if the disk is in 'spare' state. If a disk is in spare,
>         analyze_sbs() should skip the disk to be freshest disk. Otherwise,
>         it may cause md run fail. There is a fail example in the second patch.
>

I think we need go a different path. I am sorry that some of early comments
are misleading.

We can extend the output of load_super() to have "2" for spares. And this
_should_ make the code simpler.

Does this make sense?

Thanks,
Song
