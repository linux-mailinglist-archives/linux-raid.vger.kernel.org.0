Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09D3F9E1D
	for <lists+linux-raid@lfdr.de>; Wed, 13 Nov 2019 00:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKLXVT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 Nov 2019 18:21:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40895 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLXVT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 Nov 2019 18:21:19 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iUfTI-0005a8-GV
        for linux-raid@vger.kernel.org; Tue, 12 Nov 2019 23:21:16 +0000
Received: by mail-pl1-f197.google.com with SMTP id x9so112186plv.2
        for <linux-raid@vger.kernel.org>; Tue, 12 Nov 2019 15:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEghIttEEyExffclxjc0fErJRjeqye4FHAMwTkjLON0=;
        b=gQPueVjt3x6YGlzW4Df2r5fFqBDf0qSq+Xj1+r2NIQnS6K0Di0kAbo1K0IxEnC50gF
         FHioGf/hHsfyZ69HxGeFLT7ZQ3FpW+n+vf3vARC1kCzflcbruD3yEoLxIKiNJqtH/UO/
         j6JAeogV2+OUI6uq51UBevIQTHPMUY3qxGs9uqUNoTy/YVpDfuGrHb4r3jbDjcW3jSna
         CldAAQs7i4TuuWDdGZkleTUE8RoTWiSX0VZFQyyeEKwfUalpCCKYsWwqfb7jbZVt0DqY
         tnOedhcNNCcrp6HPXVHkzlOr72QgkTacKpgsaPoYBYF3U9Rdetgzto3wdKUohKZNafIP
         F8Cw==
X-Gm-Message-State: APjAAAWGcxh7rhTC5vIB7FJgNUS4xtsB5u4XX2Um4Ac82n11MhfNvuU+
        8woi5Vzky/GpAPc9qlNMsWrMx9ki3Ow1anvn001W3SmRiaNzhK2Qe8y4mP9ntWlHBiR6W1CpK6Q
        rs423tewDEKJYYMSxSycIJaAyeomlmwZT3XdwY7w=
X-Received: by 2002:a63:6786:: with SMTP id b128mr106667pgc.126.1573600874855;
        Tue, 12 Nov 2019 15:21:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjNtcKVEwZyF60OeAhCYMW0kYjuXH+ExirzFeP/s42v4ztuI09Z2kvTrRBaI12LB5vNPZT3g==
X-Received: by 2002:a63:6786:: with SMTP id b128mr106627pgc.126.1573600874228;
        Tue, 12 Nov 2019 15:21:14 -0800 (PST)
Received: from xps13.canonical.com ([209.121.128.189])
        by smtp.gmail.com with ESMTPSA id v64sm71547pgv.67.2019.11.12.15.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:21:13 -0800 (PST)
From:   dann frazier <dann.frazier@canonical.com>
To:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Ivan Topolsky <doktor.yak@gmail.com>, Andreas <a@hegyi.info>,
        linux-raid@vger.kernel.org
Subject: [PATCH v2] md/raid0: Provide admin guidance on multi-zone RAID0 layout migration
Date:   Tue, 12 Nov 2019 15:21:05 -0800
Message-Id: <20191112232105.749-1-dann.frazier@canonical.com>
X-Mailer: git-send-email 2.20.1
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

v2:
  - Add info about setting layout w/ mdadm, using presumed-next-mdadm
    version.
  - Add comment to doc to help prevent future changes from breaking
    the link emitted by raid0.

Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Cc: stable@vger.kernel.org (3.14+)
Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 Documentation/admin-guide/md.rst | 48 ++++++++++++++++++++++++++++++++
 drivers/md/raid0.c               |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 3c51084ffd379..a736e3b4117fc 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -759,3 +759,51 @@ These currently include:
 
   ppl_write_hint
       NVMe stream ID to be set for each PPL write request.
+
+Multi-Zone RAID0 Layout Migration
+---------------------------------
+.. Note: a public URL to this section is emitted in an error message from
+   the raid0 driver, so please take care to not make changes that would
+   cause that link to break.
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
+With a new enough version of mdadm (>= 4.2, or equivalent distro backports),
+you can set the layout version when assembling a stopped array. For example::
+
+       mdadm --stop /dev/md0
+       mdadm --assemble -U layout-alternate /dev/md0 /dev/sda1 /dev/sda2
+
+See the mdadm manpage for more details. Once set in this manner, the layout
+will be recorded in the array and will not need to be explicitly specified
+in the future.
+
+Which layout version should I use?
+++++++++++++++++++++++++++++++++++
+If your RAID array has only been written to by a 3.14 or later kernel, then
+you should specify default_layout=2, or set ``layout-alternate`` in mdadm.
+If your kernel has only been written to by a < 3.14 kernel, then you should
+specify default_layout=1 or set ``layout-original`` in mdadm. If the array
+may have already been written to by both kernels < 3.14 and >= 3.14, then it
+is possible that your data has already suffered corruption. Note that
+``mdadm --detail`` will show you when an array was created, which may be
+useful in helping determine the kernel version that was in-use at the time.
+
+When determining the scope of corruption, it may also be useful to know
+that the area susceptible to this corruption is limited to the area of the
+array after "MIN_DEVICE_SIZE * NUM DEVICES".
+
+For new arrays you may choose either layout version. Neither version is
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
2.20.1

