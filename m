Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2670C5D
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfGVWJs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 18:09:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33056 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGVWJs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 18:09:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so29702677qkc.0
        for <linux-raid@vger.kernel.org>; Mon, 22 Jul 2019 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjOfvZSaKkxP5jCx0s+nVh9/nqI34qL6I60yELY86YQ=;
        b=Horvry8ek6TE/v+FMZdUwcoHzqOGxEfGGInTHwJeXbtC/4t6S3VyOLMRsk9afGPcuX
         Ad1wiGUKU3P9f7mZVJ0++bI0pw4g16Va2c8aANugeZ7DQ2VviBhZVR6JnLOD+2C3uNND
         CDLicBDvPlSkaibh2tDm2nu/DheCCZ/wN2wlV9i13DrKw7lybuNJdRJnu2zLQSYWZ1tA
         wj0UnYwbk9oOU54P7bm0q1r+I3bhxil1kNX+IScGCfSjZ8mecI4/zZGz3USZpX+HbCwL
         2e37iwh62VhOozav6QByOhk+34E9XnZDLM6tQI4h3hwF5sn9A/jkljonBbuh2wkD4Kg5
         pQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjOfvZSaKkxP5jCx0s+nVh9/nqI34qL6I60yELY86YQ=;
        b=pWImb/viNEQunqqxEq+KB/UoGuZsLYfdNnUmM6B+nHwBA9S1sYEmnluN+N2NGx7Oh8
         R4+mjcTt20fINehSHZ9FzhlzwFVE1CceRsDFrtaNsZByBhFYlm1Sb6nh+xxlyaSxreRc
         4VLvqO2Crse7O9sJ6h4QdEjr4l46Rn1AEtx3dfzWTpTJr/htiglTwGd77e6lgN27zoG4
         R3mh5R0eQi6BYPLTmSExat3CNNbbo3yRTO7Ibw7RXEv/hInwWOudADDtdS9GKtiS+aau
         Ge44vS4wZdsZ5/5sgWa92uGU0KLWK9TsoHQ6obiUFznHtW6/n3RgJwo1F8WvbvGgdTdv
         +pVQ==
X-Gm-Message-State: APjAAAUBcq3fAMk+0/tsL7k9vLNEnuJNGRC/FCXIV0RhrNr4LU2Y5Qie
        7StTWK91z1dQkl99nglqL2mXoFpiVxHPtJdmwVQ8pA==
X-Google-Smtp-Source: APXvYqxivJMbK3Yh8g11qTghMuCVkYWL68icorCR9siwIXS9Dtt4fHhDzVPJfO6x3NVEaDJZsN3AI1ujWPMQqeah3oc=
X-Received: by 2002:a37:6984:: with SMTP id e126mr46939479qkc.487.1563833387352;
 Mon, 22 Jul 2019 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190708032804.4503-1-yuyufen@huawei.com>
In-Reply-To: <20190708032804.4503-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 22 Jul 2019 15:09:36 -0700
Message-ID: <CAPhsuW7Wdp_oheO45HXzgAbGLTqn6BY-SVOgQdWkPoUfUH4+Cw@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: remove the unnecessary plug in raid1d()
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     NeilBrown <neilb@suse.com>, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Jul 7, 2019 at 8:11 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> When raid1d() submits a lot of IO, block plug can improve IO merge
> and increase IO throughput. But, after commit 18022a1bd37 ("md/raid1/10:
> add missed blk plug"), flush_pending_writes have added start/finish
> plug by itself.
>
> Except flush_pending_writes(), other processing in raid1d() would
> not submit a lot of IO. They may issue some IO, but these IOs are
> synchronous, i.e. submit bio and wait it finish. Plug can increase
> io latency, which is not expected.
>
> Thus, we may need to remove the unneceessary start/finish plug.

Could you please add some data showing the difference in performance?

Thanks,
Song
