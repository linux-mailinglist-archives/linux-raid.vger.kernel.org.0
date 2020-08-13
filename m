Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADADB243D65
	for <lists+linux-raid@lfdr.de>; Thu, 13 Aug 2020 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMQaM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Aug 2020 12:30:12 -0400
Received: from u164.east.ru ([195.170.63.164]:33052 "EHLO u164.east.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgHMQaJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 13 Aug 2020 12:30:09 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 12:30:08 EDT
Received: by u164.east.ru (Postfix, from userid 1001)
        id D04BE519F3E; Thu, 13 Aug 2020 19:20:24 +0300 (MSK)
Date:   Thu, 13 Aug 2020 19:20:24 +0300
From:   Anatoly Pugachev <matorola@gmail.com>
To:     linux-raid@vger.kernel.org
Subject: [PATCH] mdadm/Create: Be more verbose on the RAID array create
 failure.
Message-ID: <20200813162024.GA16408@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Be more verbose on the RAID array create failure.
Give a hint to check with the kernel messages on an error.

For example (with missing CONFIG_MD_RAID1 in the kernel config) :

$ ./mdadm --create /dev/md1 --raid-devices=2 --level=1 --spare-devices=0 missing /dev/sdb3
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: Check last messages in the kernel log. RUN_ARRAY failed: Invalid argument

$ journalctl -k -e
Aug 13 15:46:05 lifshitz kernel: md: personality for level 1 is not loaded!
Aug 13 15:46:05 lifshitz kernel: md: md1 stopped.

vs (current version):

$ mdadm --create /dev/md1 --raid-devices=2 --level=1 --spare-devices=0 missing /dev/sdb3
...
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: RUN_ARRAY failed: Invalid argument

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---
 Create.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Create.c b/Create.c
index 6f84e5b..99b3701 100644
--- a/Create.c
+++ b/Create.c
@@ -1052,7 +1052,7 @@ int Create(struct supertype *st, char *mddev,
 			/* param is not actually used */
 			mdu_param_t param;
 			if (ioctl(mdfd, RUN_ARRAY, &param)) {
-				pr_err("RUN_ARRAY failed: %s\n",
+				pr_err("Check last messages in the kernel logs. RUN_ARRAY failed: %s\n",
 				       strerror(errno));
 				if (errno == 524 /* ENOTSUP */ &&
 				    info.array.level == 0)
-- 
2.23.0

