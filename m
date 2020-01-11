Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03646138241
	for <lists+linux-raid@lfdr.de>; Sat, 11 Jan 2020 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAKQDY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 Jan 2020 11:03:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51697 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbgAKQDX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 Jan 2020 11:03:23 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iqJEP-0006H8-9m
        for linux-raid@vger.kernel.org; Sat, 11 Jan 2020 16:03:21 +0000
Received: by mail-io1-f71.google.com with SMTP id x2so3466585iog.5
        for <linux-raid@vger.kernel.org>; Sat, 11 Jan 2020 08:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eeFfxi8FLhkk0KnUonlD4P9fN9MWwy/mbQaaM3woNPM=;
        b=qvNcgjcbt3pDQBIUjoXoSLXzWkXKPlHwTgGrKhhacDvBDLC3l3/ACVAP5cAHQKSkSl
         8jVnL81d46ftXnKVANpYU41RhOEYvT7Ynm6pabcSpQM70q993IzuxpB9j8+fWqd6Size
         wsYg0kmoYFw8tzJsHy0M1ydMC2gCfpmqR6Tc7XhJKyFYHzkhk10DMMxvlGU4nVvgX/S1
         DTMklKOPz9thCNtwU6iJGn0jWDSEngye+quxnhC9Y25qCwKGNHx+lk3rwfK64NgiDys6
         N75rYjUx7eYJ3B2Ww7hFBqdqCn5o2nXjz64Y2sLvOMirkrNNCHDtgLKYQt5EfJlRZsDT
         KmiA==
X-Gm-Message-State: APjAAAUr45PUxa3xCb2XrnDrkx1lK03aniiD8FBfjaMIiEeWeCQ7JcqD
        jwMKfS/WPppCsjdU3+21s4omxZ/VZmqwwnd8juqHMu5C8zEh9g/vNa1MRhd3TaRQ/fwe1MAIY15
        /kvJxzKtTWmqa4v3CAXiyhzQU96mjnVYkEe91bzY=
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr6737656iop.144.1578758600115;
        Sat, 11 Jan 2020 08:03:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqycDs6UuyRnXoKTNtv3HaiaNjpTaxmGG/qFkLm8VSn39ePIA2Y+GWmvb2tPdHxi9UygLHDJKg==
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr6737639iop.144.1578758599816;
        Sat, 11 Jan 2020 08:03:19 -0800 (PST)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id v7sm1397106iom.58.2020.01.11.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 08:03:19 -0800 (PST)
From:   dann frazier <dann.frazier@canonical.com>
To:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Ivan Topolsky <doktor.yak@gmail.com>, Andreas <a@hegyi.info>,
        Jes Sorensen <jes@trained-monkey.org>,
        linux-raid@vger.kernel.org
Subject: [PATCH v3] md/raid0: Provide admin guidance on multi-zone RAID0 layout migration
Date:   Sat, 11 Jan 2020 09:03:16 -0700
Message-Id: <20200111160316.518611-1-dann.frazier@canonical.com>
X-Mailer: git-send-email 2.25.0.rc2
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

v3:
  - Include "raid0" in each line of the error message, which I've found
    makes it easier to spot w/ grep.

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
 drivers/md/raid0.c               |  4 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

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
index b7c20979bd19a..587b9ab37d0ac 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -154,7 +154,9 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 	} else {
 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
 		       mdname(mddev));
-		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
+		pr_err("md/raid0:%s: please set raid0.default_layout to 1 or 2\n", mdname(mddev));
+		pr_err("md/raid0:%s: Read the following page for more information:\n", mdname(mddev));
+		pr_err("md/raid0:%s: https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration\n", mdname(mddev));
 		err = -ENOTSUPP;
 		goto abort;
 	}
-- 
2.25.0.rc2

