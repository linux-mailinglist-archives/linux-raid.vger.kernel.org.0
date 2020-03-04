Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43378179A87
	for <lists+linux-raid@lfdr.de>; Wed,  4 Mar 2020 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbgCDU5K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Mar 2020 15:57:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33161 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgCDU5H (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Mar 2020 15:57:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so3620575oig.0
        for <linux-raid@vger.kernel.org>; Wed, 04 Mar 2020 12:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeXW7YNWKtPM2qhkPxW/kiKtKjk7UpmXN4m91WTJNCM=;
        b=Jrd8sZi8FK4jANBFdzU+UpRWAbAAy7EQjaFH7cCT7k1bLXlDXEqYwWTvoy3XqwXx9N
         oje8H4L7MQFhh/bZTgymvv2Pm37WnJid2buYJA06o01S3aAmAE8SEIX9iecggKE4D5CE
         61KhXhqzn6oIfP2TyxecT/+zPVW/hkGof5elxwtp5/Z+NXZpjf7XRFXWQl6Mu6GIZoOt
         3f4+ZqUK0FE9Egdunl86lWrAB4VPqJuYmuCSW0UKbBKN4yNFCOOzR4iO+QBmSS1MIDz0
         6PS4VpG3X07nTssv+skbDbHfMb1PQmdi4QqJ5NUXJoDp2a2BbU134cApL9tz3ODL8TiU
         FUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeXW7YNWKtPM2qhkPxW/kiKtKjk7UpmXN4m91WTJNCM=;
        b=YPEqvF5W4PbF41Zi7rs1p7RN2n10KYgR8qASn6/uSPcZS+y84vTm3XCovWEDDxQTQR
         605LzNNl9RjrQlKFB/T7pXOfj2wMxbmsx3cQ4jXFTgMvYeyksRDMKhatETOuVejoRGB1
         eeBO5d5AkktA9h0IZsLkfxdXVRZmjyX6LycbNlzzZTWST+nhDts/+2qdhYgOGTGlw6eD
         72O756Dq38tRcXSaVpGeIHGq3+82RbjseciKL4+HruiGBrJUm/yGMP5YPGCS7EGqBPU7
         PbvguyRp1nIChGvddmwB87NRZB8TkH/v+tZ0l9TP1/MD0cD1dTYPYH4HD2b0zZ31KRH1
         itfA==
X-Gm-Message-State: ANhLgQ0E8iWbyl5GM3Kc+/3Hl/eeJYjl798q/pUAYQXbNK9Ar9HQI0Kd
        NA4iB72Ft6y3ktTH+RgvkufsYg6xNm3c4qfbIWS5Dg==
X-Google-Smtp-Source: ADFU+vtFbEv31ANDFs0/4N9Z/l6H9sqYzjPTVswiZTAKAsgysts9zHxyIRsH1as4Wq2QvfA+x1ko0P0794u+WWSSnqw=
X-Received: by 2002:aca:ed58:: with SMTP id l85mr1490175oih.70.1583355426008;
 Wed, 04 Mar 2020 12:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20200223165724.23816-1-mcroce@redhat.com>
In-Reply-To: <20200223165724.23816-1-mcroce@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Mar 2020 12:56:54 -0800
Message-ID: <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
Subject: Re: [PATCH] block: refactor duplicated macros
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Feb 23, 2020 at 9:04 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are defined
> several times in different flavours across the whole tree.
> Define them just once in a common header.
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  block/blk-lib.c                  |  2 +-
>  drivers/block/brd.c              |  3 ---
>  drivers/block/null_blk_main.c    |  4 ----
>  drivers/block/zram/zram_drv.c    |  8 ++++----
>  drivers/block/zram/zram_drv.h    |  2 --
>  drivers/dax/super.c              |  2 +-

For the dax change:

Acked-by: Dan Williams <dan.j.williams@intel.com>

However...

[..]
>  include/linux/blkdev.h           |  4 ++++
[..]
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 053ea4b51988..b3c9be6906a0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -910,6 +910,10 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>  #define SECTOR_SIZE (1 << SECTOR_SHIFT)
>  #endif
>
> +#define PAGE_SECTORS_SHIFT     (PAGE_SHIFT - SECTOR_SHIFT)
> +#define PAGE_SECTORS           (1 << PAGE_SECTORS_SHIFT)
> +#define SECTOR_MASK            (PAGE_SECTORS - 1)
> +

...I think SECTOR_MASK is misnamed given it considers pages, and
should probably match the polarity of PAGE_MASK, i.e.

#define PAGE_SECTORS_MASK            (~(PAGE_SECTORS - 1))
