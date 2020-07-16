Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFA221D03
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGPHHM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 03:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPHHL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 03:07:11 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6AB2071B
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 07:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594883231;
        bh=0c82U4eJQd32HhR5ktJhe1VU1ffBaFiHTVeS5LaJMTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0oeOpvFvq83On/+DiTaJyZeGIFR8uv090i8/oQs8GF09SeZy+n1d3HszHJgNkaCAS
         6lkr3psTkLhc5HGMcoAQ+bwRkS/yTr/FxBP+WSkYcUFCNiRMuZVW8mU/63dE8Ipl80
         W/VVBXiCJRKCjyJzSVeWCaIIvoz+hnTpkWBKhdjw=
Received: by mail-lj1-f169.google.com with SMTP id d17so5976645ljl.3
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 00:07:10 -0700 (PDT)
X-Gm-Message-State: AOAM533NwcwyG7OJroYj8utFdtSOw2KmrSKqWFupvPl+y73nDkK2rLsY
        Z8RmrggcLoxTfFB09+41r4dTCrNzOkyvdw/9yjA=
X-Google-Smtp-Source: ABdhPJwCN8oWG8kWo3Xw0dAfaUFqimzl/lxqGxyXftJLuEedhJ8JDM9dHsRztEQfJdE1IxEIi7I8Kq1uTXidBF3A4v8=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr1327795ljk.273.1594883228944;
 Thu, 16 Jul 2020 00:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200715124257.3175816-1-yuyufen@huawei.com> <20200715124257.3175816-12-yuyufen@huawei.com>
In-Reply-To: <20200715124257.3175816-12-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 16 Jul 2020 00:06:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66oecM0RfGQjvsAnBKrwA7Hxv_Ytf1U-S4Jzirs49N7g@mail.gmail.com>
Message-ID: <CAPhsuW66oecM0RfGQjvsAnBKrwA7Hxv_Ytf1U-S4Jzirs49N7g@mail.gmail.com>
Subject: Re: [PATCH v6 11/15] md/raid5: support config stripe_size by sysfs entry
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 15, 2020 at 5:42 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Adding a new 'stripe_size' sysfs entry to set and show stripe_size.
> After that, we can adjust stripe_size by writing value into sysfs
> entry, likely, set stripe_size as 16KB:
>
>           echo 16384 > /sys/block/md1/md/stripe_size
>
> Show current stripe_size value:
>
>           cat /sys/block/md1/md/stripe_size
>
> stripe_size should not be bigger than PAGE_SIZE, and it requires to be
> multiple of 4096.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

For this patch, please consider the following changes:
1) use DEFAULT_STRIPE_SIZE instead of 4096;
2) make the sysfs entry read only for PAGE_SIZE == 4096


diff --git i/drivers/md/raid5.c w/drivers/md/raid5.c
index 735238425c7f3..320fc14bc628c 100644
--- i/drivers/md/raid5.c
+++ w/drivers/md/raid5.c
@@ -6532,6 +6532,8 @@ raid5_show_stripe_size(struct mddev  *mddev, char *page)
        return ret;
 }

+#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
+
 static ssize_t
 raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 {
@@ -6544,13 +6546,12 @@ raid5_store_stripe_size(struct mddev  *mddev,
const char *page, size_t len)
                return -EINVAL;
        if (kstrtoul(page, 10, &new))
                return -EINVAL;
+
        /*
-        * When PAGE_SZIE is 4096, we don't need to modify stripe_size.
-        * And the value should not be bigger than PAGE_SIZE.
-        * It requires to be multiple of 4096.
+        * The value should not be bigger than PAGE_SIZE. It requires to
+        * be multiple of DEFAULT_STRIPE_SIZE.
         */
-       if (PAGE_SIZE == 4096 || new % 4096 != 0 ||
-                       new > PAGE_SIZE || new == 0)
+       if (new % DEFAULT_STRIPE_SIZE != 0 || new > PAGE_SIZE || new == 0)
                return -EINVAL;

        err = mddev_lock(mddev);
@@ -6612,6 +6613,15 @@ raid5_stripe_size = __ATTR(stripe_size, 0644,
                         raid5_show_stripe_size,
                         raid5_store_stripe_size);

+#else
+
+static struct md_sysfs_entry
+raid5_stripe_size = __ATTR(stripe_size, 0444,
+                        raid5_show_stripe_size,
+                        NULL);
+
+#endif /* PAGE_SIZE != DEFAULT_STRIPE_SIZE */
+
 static ssize_t
 raid5_show_preread_threshold(struct mddev *mddev, char *page)
 {
