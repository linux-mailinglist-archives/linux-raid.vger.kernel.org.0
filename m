Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB18E93C5
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfJ2XiW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 19:38:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJ2XiW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 19:38:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iPb47-0005sd-ID
        for linux-raid@vger.kernel.org; Tue, 29 Oct 2019 23:38:19 +0000
Received: by mail-il1-f198.google.com with SMTP id c2so468831ilj.16
        for <linux-raid@vger.kernel.org>; Tue, 29 Oct 2019 16:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wCUp2Bmsru0QNAJPj6UTwQYShWWD1JJ7BMd7tsMxio=;
        b=Pyq47CXTqtpF+R+wK5ppzy/Xi12XcPrX44jolxA0mMvalWl/cJ2peB4tggy1IxHVpX
         9w+9/5tXCjLBP9XLTDr0xKeJcF3ZSa9iYecA/2EnCP3aIUMTdj11DGOMj+KbTaLzd1qo
         WAIB0zpMPddV4MTXQFs26ac7cTCgetOcd47g6oV1kaiCjOKFIh8o1fyoE9DKWbDMsfKq
         +H3XwsUQ+fnYfodoBc0sGaIk8Xdjm2DY3MOfKKX1EbiLwcgFoJFkXWd7sgzGxqzeB7gl
         01gc1d+7mFht2tq3+io0NDepukbWc4wfzNpAHk4skcyr9vcK00WSMkQulNIET6j2PD/m
         kheQ==
X-Gm-Message-State: APjAAAWlSWeBRz1Xj8irlTr/u3GkD/fXkA/y6cpy3U8iQ6TPXzqdqX8F
        A9sRDWAFpRpgzRvWOignUKm8Vp49xmBDHaj7eKtctXF7UlCnRUEAm1FOd2QBbhV2N8/1hO0J/jQ
        9j9WAh2IbT11mHhGzEa+Jwv7YHhfxyUHhzpvgG+k=
X-Received: by 2002:a02:3e96:: with SMTP id s144mr25856323jas.138.1572392298360;
        Tue, 29 Oct 2019 16:38:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGsc61/viUIrrUPKH/uFPcBEmzf03xf5PKx/NL8qp34ibBml4I9cN/CitJScInRKbHz825kQ==
X-Received: by 2002:a02:3e96:: with SMTP id s144mr25856297jas.138.1572392297740;
        Tue, 29 Oct 2019 16:38:17 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id d27sm62693ill.64.2019.10.29.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:38:17 -0700 (PDT)
From:   dann frazier <dann.frazier@canonical.com>
To:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Ivan Topolsky <doktor.yak@gmail.com>, Andreas <a@hegyi.info>,
        linux-raid@vger.kernel.org
Subject: [PATCH] md/raid0: Provide admin guidance on multi-zone RAID0 layout migration
Date:   Tue, 29 Oct 2019 17:38:11 -0600
Message-Id: <20191029233811.2394-1-dann.frazier@canonical.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Helping an administrator understand this issue and how to deal with it
requires more text than achievable in a kernel error message. Let's
clarify the issue in the admin guide, and have the kernel emit a link
to it.

Note that this mentions a few current limitations of the mdadm tool. As
those get addressed, we should update the text to point to a recommended
minimum version of mdadm that addresses these issues.

Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Cc: stable@vger.kernel.org (3.14+)
Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 Documentation/admin-guide/md.rst | 44 ++++++++++++++++++++++++++++++++
 drivers/md/raid0.c               |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 3c51084ffd379..4a37a50d51f97 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -759,3 +759,47 @@ These currently include:
 
   ppl_write_hint
       NVMe stream ID to be set for each PPL write request.
+
+Multi-Zone RAID0 Layout Migration
+----------------------
+An unintentional RAID0 layout change was introduced in the v3.14 kernel.
+This effectively means there are 2 different layouts Linux will use to
+write data to RAID0 arrays in the wild - the "pre-3.14" way and the
+"3.14 and later" way. Mixing these layouts by writing to an array while
+booted on these different kernel versions can lead to corruption.
+
+Note that this only impacts RAID0 arrays that include devices of different
+sizes. If your devices are all the same size, both layouts are equivalent,
+and your array is not at risk of corruption due to this issue.
+
+Unfortunately, the kernel cannot detect which layout was used for writes
+to pre-existing arrays, and therefore requires input from the
+administrator. This input can be provided via the kernel command line
+with the ``raid0.default_layout=<N>`` parameter, or by setting the
+``default_layout`` module parameter when loading the ``raid0`` module.
+You can also set the layout on a per-array basis using the ``layout``
+attribute of the array in the sysfs filesystem (but only when the array is
+stopped).
+
+Note that, as of this writing, ``mdadm`` requires ``raid0.default_layout``
+to be set when creating new multi-zone arrays as well. ``mdadm`` also does
+not yet have a way to store the layout type in the array itself. Until it
+does, either the ``default_layout`` parameter or per-array ``layout`` sysfs
+attributes need to be set on every boot.
+
+Which layout version should I use?
+++++++++++++++++++++++++++++++++++
+If your RAID array has only been written to by a 3.14 or later kernel, then
+you should specify version 2. If your kernel has only been written to by a
+< 3.14 kernel, then you should specify version 1. If the array may have
+already been written to by both kernels < 3.14 and >= 3.14, then it is
+possible that your data has already suffered corruption. Note that
+``mdadm --detail`` will show you when an array was created, which may be
+useful in helping determine the kernel version that was in-use at the time.
+
+When determining the scope of corruption, it may also be useful to know
+that the area susceptible to this corruption is limited to the area of the
+array after "MIN_DEVICE_SIZE * NUM DEVICES".
+
+For new arrays you may choose either 1 or 2 - neither layout version is
+inherently better than the other.
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 1e772287b1c8e..e01cd52d71aa4 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -155,6 +155,8 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
 		       mdname(mddev));
 		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
+		pr_err("Read the following page for more information:\n");
+		pr_err("https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration\n");
 		err = -ENOTSUPP;
 		goto abort;
 	}
-- 
2.24.0.rc1

