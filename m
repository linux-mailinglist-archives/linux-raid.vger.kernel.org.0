Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5408269FE10
	for <lists+linux-raid@lfdr.de>; Wed, 22 Feb 2023 23:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBVWBs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Feb 2023 17:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBVWBp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Feb 2023 17:01:45 -0500
Received: from resqmta-a1p-077724.sys.comcast.net (resqmta-a1p-077724.sys.comcast.net [IPv6:2001:558:fd01:2bb4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1DC41B5F
        for <linux-raid@vger.kernel.org>; Wed, 22 Feb 2023 14:01:42 -0800 (PST)
Received: from resomta-a1p-077058.sys.comcast.net ([96.103.145.239])
        by resqmta-a1p-077724.sys.comcast.net with ESMTP
        id Uphjpj5j4S9f3Ux8op6aZn; Wed, 22 Feb 2023 21:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1677103150;
        bh=XTRLMoVLaadCgZz6CHw3Me+EomanXlgSJsgcV3FeuiU=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=r+SguYkxGKhPZUJKQrl0q6J8cdNl0aPP9kUvccPsGBvB3xbjevdK9IJ9Br5ugH59d
         TXTmeJlefOMbD0as8Gm6HuMHcqNnMxKosv0AX8gd7fk/SvZheYgbAi8+FGdUl+Tp5F
         LDOI8JKqhlXqi7ldI0dLtHjDRekngQkBXS1vMjEvC91mCgXhbmEeqUi90k6kS9wpEm
         LhdPf36sO2ILScZiol3M/NmG3T7ATNEkMK8xfv3Yn5256gIWukjpAox82//96byi/X
         eIshoOE/Vn0L5LZtIjQj8CUiVAZSAt/FOvpA9CDTpbH9eppOz0oygId/qLaO5+tXWS
         Wi1caYRxsm0PA==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-a1p-077058.sys.comcast.net with ESMTPA
        id Ux8JpSr0ZqdkEUx8Vpx9bc; Wed, 22 Feb 2023 21:58:51 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnrghthhgrnhcuffgvrhhrihgtkhcuoehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvheqnecuggftrfgrthhtvghrnheptdetleejfffgffevhefhteevfeeuvdehveffffehtdejuedvvefgfedttdehfedtnecukfhppeejuddrvddthedrudekuddrhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepjhguvghrrhhitghkqdhmohgslhegrdgrmhhrrdgtohhrphdrihhnthgvlhdrtghomhdpihhnvghtpeejuddrvddthedrudekuddrhedtpdhmrghilhhfrhhomhepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrrghiugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeignhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphhmvghnii
 gvlhesmhholhhgvghnrdhmphhgrdguvgdprhgtphhtthhopehsuhhshhhmrgdrkhgrlhgrkhhothgrsehinhhtvghlrdgtohhm
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>, <linux-raid@vger.kernel.org>
Cc:     Xiao Ni <xni@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Sushma Kalakota <sushma.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v3 3/3] md: Use optimal I/O size for last bitmap page
Date:   Wed, 22 Feb 2023 14:58:28 -0700
Message-Id: <20230222215828.225-4-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230222215828.225-1-jonathan.derrick@linux.dev>
References: <20230222215828.225-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Jon Derrick <jonathan.derrick@linux.dev>

If the bitmap space has enough room, size the I/O for the last bitmap
page write to the optimal I/O size for the storage device. The expanded
write is checked that it won't overrun the data or metadata.

The drive this was tested against has higher latencies when there are
sub-4k writes due to device-side read-mod-writes of its atomic 4k write
unit. This change helps increase performance by sizing the last bitmap
page I/O for the device's preferred write unit, if it is given.

Example Intel/Solidigm P5520
Raid10, Chunk-size 64M, bitmap-size 57228 bits

$ mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/nvme{0,1,2,3}n1
        --assume-clean --bitmap=internal --bitmap-chunk=64M
$ fio --name=test --direct=1 --filename=/dev/md0 --rw=randwrite --bs=4k --runtime=60

Without patch:
  write: IOPS=1676, BW=6708KiB/s (6869kB/s)(393MiB/60001msec); 0 zone resets

With patch:
  write: IOPS=15.7k, BW=61.4MiB/s (64.4MB/s)(3683MiB/60001msec); 0 zone resets

Biosnoop:
Without patch:
Time        Process        PID     Device      LBA        Size      Lat
1.410377    md0_raid10     6900    nvme0n1   W 16         4096      0.02
1.410387    md0_raid10     6900    nvme2n1   W 16         4096      0.02
1.410374    md0_raid10     6900    nvme3n1   W 16         4096      0.01
1.410381    md0_raid10     6900    nvme1n1   W 16         4096      0.02
1.410411    md0_raid10     6900    nvme1n1   W 115346512  4096      0.01
1.410418    md0_raid10     6900    nvme0n1   W 115346512  4096      0.02
1.410915    md0_raid10     6900    nvme2n1   W 24         3584      0.43 <--
1.410935    md0_raid10     6900    nvme3n1   W 24         3584      0.45 <--
1.411124    md0_raid10     6900    nvme1n1   W 24         3584      0.64 <--
1.411147    md0_raid10     6900    nvme0n1   W 24         3584      0.66 <--
1.411176    md0_raid10     6900    nvme3n1   W 2019022184 4096      0.01
1.411189    md0_raid10     6900    nvme2n1   W 2019022184 4096      0.02

With patch:
Time        Process        PID     Device      LBA        Size      Lat
5.747193    md0_raid10     727     nvme0n1   W 16         4096      0.01
5.747192    md0_raid10     727     nvme1n1   W 16         4096      0.02
5.747195    md0_raid10     727     nvme3n1   W 16         4096      0.01
5.747202    md0_raid10     727     nvme2n1   W 16         4096      0.02
5.747229    md0_raid10     727     nvme3n1   W 1196223704 4096      0.02
5.747224    md0_raid10     727     nvme0n1   W 1196223704 4096      0.01
5.747279    md0_raid10     727     nvme0n1   W 24         4096      0.01 <--
5.747279    md0_raid10     727     nvme1n1   W 24         4096      0.02 <--
5.747284    md0_raid10     727     nvme3n1   W 24         4096      0.02 <--
5.747291    md0_raid10     727     nvme2n1   W 24         4096      0.02 <--
5.747314    md0_raid10     727     nvme2n1   W 2234636712 4096      0.01
5.747317    md0_raid10     727     nvme1n1   W 2234636712 4096      0.02

Signed-off-by: Jon Derrick <jonathan.derrick@linux.dev>
---
 drivers/md/md-bitmap.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 11f4453775ee..196984fc3776 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -209,6 +209,28 @@ static struct md_rdev *next_active_rdev(struct md_rdev *rdev, struct mddev *mdde
 	return NULL;
 }
 
+static unsigned int optimal_io_size(struct block_device *bdev,
+				    unsigned int last_page_size,
+				    unsigned int io_size)
+{
+	if (bdev_io_opt(bdev) > bdev_logical_block_size(bdev))
+		return roundup(last_page_size, bdev_io_opt(bdev));
+	return io_size;
+}
+
+static unsigned int bitmap_io_size(unsigned int io_size, unsigned int opt_size,
+				   sector_t start, sector_t boundary)
+{
+	if (io_size != opt_size &&
+	    start + opt_size / SECTOR_SIZE <= boundary)
+		return opt_size;
+	else if (start + io_size / SECTOR_SIZE <= boundary)
+		return io_size;
+
+	/* Overflows boundary */
+	return 0;
+}
+
 static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 			   struct page *page)
 {
@@ -218,14 +240,15 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	sector_t offset = mddev->bitmap_info.offset;
 	sector_t ps, sboff, doff;
 	unsigned int size = PAGE_SIZE;
+	unsigned int opt_size = PAGE_SIZE;
 
 	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
 	if (page->index == store->file_pages - 1) {
 		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
 		if (last_page_size == 0)
 			last_page_size = PAGE_SIZE;
-		size = roundup(last_page_size,
-			       bdev_logical_block_size(bdev));
+		size = roundup(last_page_size, bdev_logical_block_size(bdev));
+		opt_size = optimal_io_size(bdev, last_page_size, size);
 	}
 
 	ps = page->index * (PAGE_SIZE / SECTOR_SIZE);
@@ -240,7 +263,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 			return -EINVAL;
 	} else if (offset < 0) {
 		/* DATA  BITMAP METADATA  */
-		if (offset + ps + size / SECTOR_SIZE > 0)
+		size = bitmap_io_size(size, opt_size, offset + ps, 0);
+		if (size == 0)
 			/* bitmap runs in to metadata */
 			return -EINVAL;
 
@@ -249,7 +273,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 			return -EINVAL;
 	} else if (rdev->sb_start < rdev->data_offset) {
 		/* METADATA BITMAP DATA */
-		if (sboff + ps + size / SECTOR_SIZE > doff)
+		size = bitmap_io_size(size, opt_size, sboff + ps, doff);
+		if (size == 0)
 			/* bitmap runs in to data */
 			return -EINVAL;
 	} else {
-- 
2.27.0

