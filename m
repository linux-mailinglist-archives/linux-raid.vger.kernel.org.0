Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A41027C
	for <lists+linux-raid@lfdr.de>; Wed,  1 May 2019 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfD3Whp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 18:37:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3Who (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Apr 2019 18:37:44 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hLbNe-00005K-Q7
        for linux-raid@vger.kernel.org; Tue, 30 Apr 2019 22:37:42 +0000
Received: by mail-qt1-f200.google.com with SMTP id o34so15116188qte.5
        for <linux-raid@vger.kernel.org>; Tue, 30 Apr 2019 15:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1dA/K88cRsfc3q1FRXYfBBWD47UAImz8hgoBP+aK40=;
        b=Taug6U3dNcJJrdc07jHKV97Dui2I5umoBS4L0BEwUbNuI9i1UaMzKHumjQR5xmhD2M
         9Tc5Z7aoF1H/OqtlzCRM5yfJzihBcJP4DVzUF1/RlOLoDrsWQpZPRQ/u67bu+Pf8zxn0
         I/BLzfO1UjXD3MI+7rPqJlJXMbn+Q/jcIaUFWlizy8GUaa3TjWTIRcCAo/xs0b/GxiSz
         PvaIx9U9zLXs3P54XE6y5qNG//U4JLq1757CNdUa0mYfBdSyFft4oNEnEdCWcBw2cz0V
         5weFDohhqR6mbp2h71L2A1w6MPZs2KsnpwN5C9caChujbvVC8Emj/UQWxv6RNRX290zT
         tkBg==
X-Gm-Message-State: APjAAAUmt6WlWG+dLQFEtogK6M+tdjY0S28akQobYHZWw51c8KBOQ2QC
        bwtExZqTtjvcgdgdIYoAUcMfPQaQ+D0zhgMLTqhT2SsYL7OPICoFU+oQNc2Q5ApWLgPMg4QKxWo
        cpCjwessNcI9vab6LTUkT2q2mnbJK1KhxvnY8rgI=
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr26776129qkj.167.1556663861772;
        Tue, 30 Apr 2019 15:37:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIoZITo3gUQWU1LW4I5B24hDxGKDv1EkPpYq3UBpsD1YF4anXHLc6+3ffgyZeEz6P0EUJp3w==
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr26776110qkj.167.1556663861589;
        Tue, 30 Apr 2019 15:37:41 -0700 (PDT)
Received: from localhost (201-13-157-136.dial-up.telesp.net.br. [201.13.157.136])
        by smtp.gmail.com with ESMTPSA id p27sm22875764qte.25.2019.04.30.15.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:37:41 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net, Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for raid0  bios
Date:   Tue, 30 Apr 2019 19:37:22 -0300
Message-Id: <20190430223722.20845-2-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430223722.20845-1-gpiccoli@canonical.com>
References: <20190430223722.20845-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Commit cd4a4ae4683d ("block: don't use blocking queue entered for
recursive bio submits") introduced the flag BIO_QUEUE_ENTERED in order
split bios bypass the blocking queue entering routine and use the live
non-blocking version. It was a result of an extensive discussion in
a linux-block thread[0], and the purpose of this change was to prevent
a hung task waiting on a reference to drop.

Happens that md raid0 split bios all the time, and more important,
it changes their underlying device to the raid member. After the change
introduced by this flag's usage, we experience various crashes if a raid0
member is removed during a large write. This happens because the bio
reaches the live queue entering function when the queue of the raid0
member is dying.

A simple reproducer of this behavior is presented below:
a) Build kernel v5.1-rc7 with CONFIG_BLK_DEV_THROTTLING=y.

b) Create a raid0 md array with 2 NVMe devices as members, and mount it
with an ext4 filesystem.

c) Run the following oneliner (supposing the raid0 is mounted in /mnt):
(dd of=/mnt/tmp if=/dev/zero bs=1M count=999 &); sleep 0.3;
echo 1 > /sys/block/nvme0n1/device/device/remove
(whereas nvme0n1 is the 2nd array member)

This will trigger the following warning/oops:

------------[ cut here ]------------
no blkg associated for bio on block-device: nvme0n1
WARNING: CPU: 9 PID: 184 at ./include/linux/blk-cgroup.h:785
generic_make_request_checks+0x4dd/0x690
[...]
BUG: unable to handle kernel NULL pointer dereference at 0000000000000155
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
RIP: 0010:blk_throtl_bio+0x45/0x970
[...]
Call Trace:
 generic_make_request_checks+0x1bf/0x690
 generic_make_request+0x64/0x3f0
 raid0_make_request+0x184/0x620 [raid0]
 ? raid0_make_request+0x184/0x620 [raid0]
 ? blk_queue_split+0x384/0x6d0
 md_handle_request+0x126/0x1a0
 md_make_request+0x7b/0x180
 generic_make_request+0x19e/0x3f0
 submit_bio+0x73/0x140
[...]

This patch changes raid0 driver to fallback to the "old" blocking queue
entering procedure, by clearing the BIO_QUEUE_ENTERED from raid0 bios.
This prevents the crashes and restores the regular behavior of raid0
arrays when a member is removed during a large write.

[0] https://marc.info/?l=linux-block&m=152638475806811

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: stable@vger.kernel.org # v4.18
Fixes: cd4a4ae4683d ("block: don't use blocking queue entered for recursive bio submits")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 drivers/md/raid0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f3fb5bb8c82a..d5bdc79e0835 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -547,6 +547,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
 				discard_bio, disk_devt(mddev->gendisk),
 				bio->bi_iter.bi_sector);
+		bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 		generic_make_request(discard_bio);
 	}
 	bio_endio(bio);
@@ -602,6 +603,7 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 				disk_devt(mddev->gendisk), bio_sector);
 	mddev_check_writesame(mddev, bio);
 	mddev_check_write_zeroes(mddev, bio);
+	bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 	generic_make_request(bio);
 	return true;
 }
-- 
2.21.0

