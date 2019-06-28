Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989B75A6D4
	for <lists+linux-raid@lfdr.de>; Sat, 29 Jun 2019 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF1WVM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Jun 2019 18:21:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1WVM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 28 Jun 2019 18:21:12 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hgzCH-0004r9-T6
        for linux-raid@vger.kernel.org; Fri, 28 Jun 2019 22:18:22 +0000
Received: by mail-qt1-f198.google.com with SMTP id g30so7504209qtm.17
        for <linux-raid@vger.kernel.org>; Fri, 28 Jun 2019 15:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU5oGuW9La28t+68D36cpP8/gkaEFB1F4a4O+Bgz2zY=;
        b=DW0tCB/DiW8zgqL4qPEazXdnQSuMVKi75shZ3MTMQJ5KmDyfkm6BJu2CpdgJ+LwdwS
         qCFCH7hUuPWCyctoWUpleoeEPGo1qhK6Ip2R/ZuNg1oBnFYrGz6TYvlBkYrJuCAA8HU+
         iuN01/Tou6+qnxDZi+oA3sQ7T5uRgBM68S+L3qf1H7tyvH8KgzObUjFNmtlWsjcDQ++9
         XQqskUBzzrgbDDEWQMSg3SZfRSDdMnixe9FjsU+O41BXm7F9mz9TWBBdp60kzyUFHFo2
         b3OtBFjgvrUJl4aE6raDQqimmnw5AcjGmRUwcahaR35e9cCIbWUzVVuAgMH7TV9ec2EH
         LbSA==
X-Gm-Message-State: APjAAAVn0G8HwA94mBE2XQljpRP5d1XzflPbfuOVtLmPNWofm57vwkct
        12PasoeV1TmpXYgnBVVm74VrizzMfS6udfNooJ9i7nN69c4EVUZP8bJAg93dg9WobbbEX61LU+Y
        YoIhKDmydHhLJ69+9MV3GKCqAbzB7fZK09qThaPM=
X-Received: by 2002:ac8:25d9:: with SMTP id f25mr10149284qtf.256.1561760301016;
        Fri, 28 Jun 2019 15:18:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXflS3fVT7sl7MEqs9zXpsmfGIy8mVABLEYn4jY1JzbGKQVFnhhjFC5EeMXcdL1+8hZ1l0tg==
X-Received: by 2002:ac8:25d9:: with SMTP id f25mr10149268qtf.256.1561760300804;
        Fri, 28 Jun 2019 15:18:20 -0700 (PDT)
Received: from localhost ([179.110.97.158])
        by smtp.gmail.com with ESMTPSA id l6sm1532557qkc.89.2019.06.28.15.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 15:18:20 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <songliubraving@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [4.19.y PATCH 2/2] md/raid0: Do not bypass blocking queue entered for raid0 bios
Date:   Fri, 28 Jun 2019 19:17:59 -0300
Message-Id: <20190628221759.18274-2-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628221759.18274-1-gpiccoli@canonical.com>
References: <20190628221759.18274-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

-----------------------------------------------------------------
This patch is not on mainline and is meant to 4.19 stable *only*.
After the patch description there's a reasoning about that.
-----------------------------------------------------------------

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
a) Build kernel v4.19.56-stable with CONFIG_BLK_DEV_THROTTLING=y.

b) Create a raid0 md array with 2 NVMe devices as members, and mount
it with an ext4 filesystem.

c) Run the following oneliner (supposing the raid0 is mounted in /mnt):
(dd of=/mnt/tmp if=/dev/zero bs=1M count=999 &); sleep 0.3;
echo 1 > /sys/block/nvme1n1/device/device/remove
(whereas nvme1n1 is the 2nd array member)

This will trigger the following warning/oops:

------------[ cut here ]------------
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
 md_handle_request+0x126/0x1a0
 md_make_request+0x7b/0x180
 generic_make_request+0x19e/0x3f0
 submit_bio+0x73/0x140
[...]

This patch changes raid0 driver to fallback to the "old" blocking queue
entering procedure, by clearing the BIO_QUEUE_ENTERED from raid0 bios.
This prevents the crashes and restores the regular behavior of raid0
arrays when a member is removed during a large write.

[0] lore.kernel.org/linux-block/343bbbf6-64eb-879e-d19e-96aebb037d47@I-love.SAKURA.ne.jp

----------------------------
Why this is not on mainline?
----------------------------

The patch was originally submitted upstream in linux-raid and
linux-block mailing-lists - it was initially accepted by Song Liu,
but Christoph Hellwig[1] observed that there was a clean-up series
ready to be accepted from Ming Lei[2] that fixed the same issue.

The accepted patches from Ming's series in upstream are: commit
47cdee29ef9d ("block: move blk_exit_queue into __blk_release_queue") and
commit fe2008640ae3 ("block: don't protect generic_make_request_checks
with blk_queue_enter"). Those patches basically do a clean-up in the
block layer involving:

1) Putting back blk_exit_queue() logic into __blk_release_queue(); that
path was changed in the past and the logic from blk_exit_queue() was
added to blk_cleanup_queue().

2) Removing the guard/protection in generic_make_request_checks() with
blk_queue_enter().

The problem with Ming's series for -stable is that it relies in the
legacy request IO path removal. So it's "backport-able" to v5.0+,
but doing that for early versions (like 4.19) would incur in complex
code changes. Hence, it was suggested by Christoph and Song Liu that
this patch was submitted to stable only; otherwise merging it upstream
would add code to fix a path removed in a subsequent commit.

[1] lore.kernel.org/linux-block/20190521172258.GA32702@infradead.org
[2] lore.kernel.org/linux-block/20190515030310.20393-1-ming.lei@redhat.com

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: cd4a4ae4683d ("block: don't use blocking queue entered for recursive bio submits")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 drivers/md/raid0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index ac1cffd2a09b..f4daa56d204d 100644
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
2.22.0

