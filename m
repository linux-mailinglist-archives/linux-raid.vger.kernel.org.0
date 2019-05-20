Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA02435A
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2019 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfETWJ1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 May 2019 18:09:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55156 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfETWJ1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 May 2019 18:09:27 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hSqTF-0005pW-63
        for linux-raid@vger.kernel.org; Mon, 20 May 2019 22:09:25 +0000
Received: by mail-qk1-f199.google.com with SMTP id v144so6395819qka.13
        for <linux-raid@vger.kernel.org>; Mon, 20 May 2019 15:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eleW/E3HCVGRd/hOEzTX6UY7GJoHVcEBDC+LzdhjVI=;
        b=qWzG142yIfpoRNzHYlxOfvjwPb3pWKcFIkm7/0CMyFudSMr5uGpao7kdBuFpzGYqcQ
         Xo5QwoQFauKnjxCwzJ1YGxVHwUYD3Can1G8VChP3G7BLJP8uYcwuRapXTfy0wx7aAaPY
         08Bh46Q4dWjz2lUKfZBUdQRgp4IO4K9dv8heZiHF0RY+N+aZ3a6wUxoQAlNBFdQD64T3
         beDHKO7SyD7Xgzb+4w62MKEz7MmgkSJPQW1kASePJa0N+lU6tof1Z7tIk7Eus/NGw6MF
         /pB/ivRzMDWKhcvoaw0sB4cWW+Z0TPRz6tPvrEtxe8iuJ3Lqf1BB5Mbvk37lcw1VaE06
         0rzw==
X-Gm-Message-State: APjAAAVEVjURv+EUlg7O4MHX9QM7HnIRnzrO5vRsYBsKx0oNFFOcqmpT
        4vJuRN7RgsS03pVFVh5ehkzJZqZ7wsbAB7hEV6yJDasV6O4FR5RaXqvXTQtJZYPKdH2gJZa4hLI
        Pi7S/zDYZHXxMCWvPLhZ1aqIBfN2g8Fgmxxz/Bw8=
X-Received: by 2002:a0c:9e58:: with SMTP id z24mr8192550qve.214.1558390164367;
        Mon, 20 May 2019 15:09:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDPcMv/m+gLKi2bFuQpOJ6k5LytU6lAjId7qA4kvxP4mLQlY8gLTvLnvgb7pw9YL0/VwxNMA==
X-Received: by 2002:a0c:9e58:: with SMTP id z24mr8192528qve.214.1558390164167;
        Mon, 20 May 2019 15:09:24 -0700 (PDT)
Received: from localhost ([152.250.107.7])
        by smtp.gmail.com with ESMTPSA id a51sm11767472qta.85.2019.05.20.15.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 15:09:23 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net, stable@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Subject: [PATCH V2 1/2] block: Fix a NULL pointer dereference in generic_make_request()
Date:   Mon, 20 May 2019 19:09:10 -0300
Message-Id: <20190520220911.25192-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Commit 37f9579f4c31 ("blk-mq: Avoid that submitting a bio concurrently
with device removal triggers a crash") introduced a NULL pointer
dereference in generic_make_request(). The patch sets q to NULL and
enter_succeeded to false; right after, there's an 'if (enter_succeeded)'
which is not taken, and then the 'else' will dereference q in
blk_queue_dying(q).

This patch just moves the 'q = NULL' to a point in which it won't trigger
the oops, although the semantics of this NULLification remains untouched.

A simple test case/reproducer is as follows:
a) Build kernel v5.2-rc1 with CONFIG_BLK_CGROUP=n.

b) Create a raid0 md array with 2 NVMe devices as members, and mount it
with an ext4 filesystem.

c) Run the following oneliner (supposing the raid0 is mounted in /mnt):
(dd of=/mnt/tmp if=/dev/zero bs=1M count=999 &); sleep 0.3;
echo 1 > /sys/block/nvme0n1/device/device/remove
(whereas nvme0n1 is the 2nd array member)

This will trigger the following oops:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
RIP: 0010:generic_make_request+0x32b/0x400
Call Trace:
 submit_bio+0x73/0x140
 ext4_io_submit+0x4d/0x60
 ext4_writepages+0x626/0xe90
 do_writepages+0x4b/0xe0
[...]

This patch has no functional changes and preserves the md/raid0 behavior
when a member is removed before kernel v4.17.

Cc: stable@vger.kernel.org # v4.17
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Eric Ren <renzhengeek@gmail.com>
Fixes: 37f9579f4c31 ("blk-mq: Avoid that submitting a bio concurrently with device removal triggers a crash")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

Changes V1->V2:
* Implemented Ming's suggestion (drop {} from if) - thanks Ming!
* Rebased to v5.2-rc1
* Added Reviewed-by/Tested-by tags

Also, Ming mentioned a new patch series[0] that will refactor legacy IO
path so probably the bug won't happen anymore. Even in this case,
I consider this patch important specially aiming the stable releases,
in which backporting small bugfixes is much simpler than more complex
patch sets.

[0] https://lore.kernel.org/linux-block/20190515030310.20393-1-ming.lei@redhat.com/T/#t

 block/blk-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..e887915c7804 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1054,10 +1054,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
-			if (blk_queue_enter(q, flags) < 0) {
+			if (blk_queue_enter(q, flags) < 0)
 				enter_succeeded = false;
-				q = NULL;
-			}
 		}
 
 		if (enter_succeeded) {
@@ -1088,6 +1086,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 				bio_wouldblock_error(bio);
 			else
 				bio_io_error(bio);
+			q = NULL;
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
-- 
2.21.0

