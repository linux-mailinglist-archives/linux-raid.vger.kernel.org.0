Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFC211044
	for <lists+linux-raid@lfdr.de>; Wed,  1 Jul 2020 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbgGAQIe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Jul 2020 12:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbgGAQI3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 Jul 2020 12:08:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E59C08C5DE
        for <linux-raid@vger.kernel.org>; Wed,  1 Jul 2020 09:08:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so20474535edz.0
        for <linux-raid@vger.kernel.org>; Wed, 01 Jul 2020 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgtGRFNzMUt8UwQnpVLH6Q0lK3Q/pmzbcISwUTSvZp4=;
        b=sgyWg0odMXUUNA+ymUvc43LaYs2s/aJwbFyXWRoPjxwdAxwM/8NDCnpUaFI4p3liR0
         gB3SPFv0A/WozVPJacrsy3TT9HIOMMCESTpphsqE92coNdoMTDE/jB5/k99TrA7k0WXT
         HwfvYQsx393r8hZTsu6RX5RUEhIafmeLpfC5Xxvgan8YQB6lIclWByvvZYmq9DcmZLWN
         JlL5WK7hHhUXeDny6LC8Ts2exiDWCHCRjEx+DVoYVUZMCGpeUSrXG6yeqYlDTXCkU+hk
         g1qHbmn4FwKHi5mTo+XYno4GD6wFdoeaM1etI9G0XSOMB6JxPVUPvp1yv+DnjQn7iHAQ
         vT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgtGRFNzMUt8UwQnpVLH6Q0lK3Q/pmzbcISwUTSvZp4=;
        b=BOlGoqiDB4rJaGmcsGnblEW6c8VpL2Lhuk8x3REcuimXM2zZp9EBqptiZ0b1OJUy+T
         KHlnugot4ardVK02Znt1kgCeqvUgnCsuvsb0zpbJ1MINpDDwg4uFUjOgoy2Gwv0wkhBp
         1bJWeeeZlSIjvpVoGjdynw3dBl6PA0x6ygnUyZdYYMoncDettRvm8syX/jifHJ/9X/Gx
         BC/Ro5uPmGzQ0yBzgrf3t4FqRKwrSARamu/bIxI9ipmKsdlt/OnnupLtU2VmJiAhJXl3
         DHARMf+NexuswIr34kIDRAH+HES71Mp71LEWFhOE0rRdQ+YtiL4VUNHhb0F39yfXUWXg
         +n+w==
X-Gm-Message-State: AOAM530lNe2ngkGXGpN5JNOgHg/8ElxV8VhBt9lRL2a01Krgp6KkRJh5
        BfV84YbNdIXJoqmkTJIOQR9S/oEHhnZoilmWpavZ3Q==
X-Google-Smtp-Source: ABdhPJwTtEaJeqUJmjVrnga0zb3T87bQXg/qHVHNHjeT7uurwTRSLAeKnsyE6dqNxhAJ1jQ5OrZ9KB+p0GzE9WKAsFg=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr29609575edb.296.1593619707927;
 Wed, 01 Jul 2020 09:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200701085947.3354405-1-hch@lst.de> <20200701085947.3354405-17-hch@lst.de>
In-Reply-To: <20200701085947.3354405-17-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Jul 2020 09:08:17 -0700
Message-ID: <CAPcyv4hELsX=dnqppbL72Tg2k8xMm-5ZaEsxM98eQ7XPoG5NGg@mail.gmail.com>
Subject: Re: [PATCH 16/20] block: move ->make_request_fn to struct block_device_operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-nvme@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 1, 2020 at 2:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The make_request_fn is a little weird in that it sits directly in
> struct request_queue instead of an operation vector.  Replace it with
> a block_device_operations method called submit_bio (which describes much
> better what it does).  Also remove the request_queue argument to it, as
> the queue can be derived pretty trivially from the bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[..]
>  drivers/nvdimm/blk.c                          |  5 +-
>  drivers/nvdimm/btt.c                          |  5 +-
>  drivers/nvdimm/pmem.c                         |  5 +-

For drivers/nvdimm

Acked-by: Dan Williams <dan.j.williams@intel.com>
