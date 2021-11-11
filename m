Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCC44D8E9
	for <lists+linux-raid@lfdr.de>; Thu, 11 Nov 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhKKPMt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 11 Nov 2021 10:12:49 -0500
Received: from group.wh-serverpark.com ([159.69.170.92]:36594 "EHLO
        group.wh-serverpark.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhKKPMs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 11 Nov 2021 10:12:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by group.wh-serverpark.com (Postfix) with ESMTP id A049AEEBA45;
        Thu, 11 Nov 2021 16:09:57 +0100 (CET)
Received: from group.wh-serverpark.com ([127.0.0.1])
        by localhost (group.wh-serverpark.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Nk5QbPLW9lku; Thu, 11 Nov 2021 16:09:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by group.wh-serverpark.com (Postfix) with ESMTP id 52CC5EEBA49;
        Thu, 11 Nov 2021 16:09:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at valiant.wh-serverpark.com
Received: from group.wh-serverpark.com ([127.0.0.1])
        by localhost (group.wh-serverpark.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z_6cKn92I6Ar; Thu, 11 Nov 2021 16:09:57 +0100 (CET)
Received: from enterprise.localnet (unknown [93.189.159.254])
        by group.wh-serverpark.com (Postfix) with ESMTPSA id 3AE13EEBA45;
        Thu, 11 Nov 2021 16:09:57 +0100 (CET)
From:   Markus Hochholdinger <Markus@hochholdinger.net>
To:     Neil Brown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org, Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 018 of 29] md: Support changing rdev size on running arrays.
Date:   Thu, 11 Nov 2021 16:09:56 +0100
Message-ID: <2991762.XJcJRHA18g@enterprise>
User-Agent: KMail/5.2.3 (Linux/4.19.0-0.bpo.6-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <5424512.plDBMOIIcH@enterprise>
References: <20080627164503.9671.patches@notabene> <1941952.8ZYzkbqb7V@enterprise> <5424512.plDBMOIIcH@enterprise>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It's possible, I've found the error:
  rdev->sb_start = sb_start;
is missing within md.c within /* minor version 0; superblock after data */
From my understanding, this means the new calculated superblock position isn't 
used.

I changed:
--- a/drivers/md/md.c    2021-09-30 08:11:08.000000000 +0000
+++ b/drivers/md/md.c     2021-11-11 14:54:10.535633028 +0000
@@ -2252,6 +2252,7 @@
 
                if (!num_sectors || num_sectors > max_sectors)
                        num_sectors = max_sectors;
+               rdev->sb_start = sb_start;
        }
        sb = page_address(rdev->sb_page);
        sb->data_size = cpu_to_le64(num_sectors);

I tested it with 5.10.46 and resizing with superblock version 1.0 is now 
working for me.

If this is correct, how can I get this into longterm 5.10.x and the current 
kernel upstream?

Many thanks in advance.


-- 
Mfg

Markus Hochholdinger
