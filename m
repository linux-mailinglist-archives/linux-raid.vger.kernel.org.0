Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E54158C69
	for <lists+linux-raid@lfdr.de>; Tue, 11 Feb 2020 11:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBKKKn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Feb 2020 05:10:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:53347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgBKKKn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Feb 2020 05:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581415837;
        bh=2uzVsZOyZTsQxrK1gUbaP3ucuWSIhmqerPmCa16vGkg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SteethzYtS21royTssCM+D7Q5M4efBvhjcnPex9g35EYLknwA9XtMx+4XbYkpnqAv
         8/Qrs0qVXIo3NgKDN8b+jpsCwm7ffDch/aYmu8zMoRIUwkKXtymg9RMiPQhHsJRKFi
         2qRU7J0+VTcO0ZJ6Z6zqIjQOu2ntj4H8dvb0Rz6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from nb01257.pb.local ([89.187.162.124]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlT2-1jk6er24Zi-00jpiz; Tue, 11
 Feb 2020 11:10:37 +0100
From:   Guoqing Jiang <guoqing.jiang@gmx.us>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] md: check arrays is suspended in mddev_detach before call quiesce operations
Date:   Tue, 11 Feb 2020 11:10:04 +0100
Message-Id: <20200211101004.2993-1-guoqing.jiang@gmx.us>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:RFYyKLEC5VgvcyMuvYh7F5Vi1yhyyqUaQ2yUg1RdFVuVYq+wRDi
 ETneKw9dCWEYKLdEdSgGLWHhzQv+rWqQwTRdNQ15JHC0jrrlUim1VthqAnPihkHKskvZVeP
 KIa7BbMyf7nXhzlCT4Ma3NwXEODAk71peQJF/WsjNM2GTTiDia99THNEXdmRMzHowFrpr70
 T1Dsk8UrTPScJi9HNvIoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1bqN/Uov7xQ=:i0um84h2MNcGiBTxPTjWGh
 vD0UvxmPsiTlsXQhGkt7f/EXv5HlN/a+KdDIvosz4mhxGieT7BsC5M/55fOOa4XOXZ3O7q2gZ
 lWaQMcJOHP+COGhsjCdMh2bA+UKsIzuUNBX2JGnP1DBBgrXJ3DDNByDxFcHrn1Z7xcxDe/jxB
 d8YD4sxaWcHTwkXtqlpruTZEQRp6wcdBMk4YXxx4fmt34rR5U+N51iFLPZ3A4MtAaafIpPD2H
 saC/7MhUsHalp4scfqD4wXVNu4lDDKdYPhV5rfYNpGXZIk5BG2dnQq4caqpoXQOig3HI6fYsI
 uifzLPlqyYYFGOlk7WUsh9j78Zr4Ss5q4rx/6saE766duoMrQocnhKtAMINi42xswnJrB5K0e
 ETd+oPFJ5oZR1fBZbDZMFmBhWmwQXjee6hrj4VukEt1Axke2uoyq9lzklTmaQ1ZsmzNxfYLpK
 E4muWo1O84Z7qC3t3vGencLQGnDysqq/rlrbFX/9b+9yKDBjVXHws1ayWPgQgBlQ4Guaz9mBy
 N+ivCOvxw/p9SUCtydyrXWPQRITuLJkCfvDGbTfXgmalbHZ3DUYDI4GTSTveJ/I5+Ck1UZ3ch
 X0ldeaIz5gzfoKMpnAH8ll3r69KnX0X4JKaAX81VV9kZF0bOQ1juy85BaveAck8fQhdD6yPD+
 bw8X0OzbcvpF/NUJ+w9EK/8YHTrmAEj5ob8m9VOT+hKSW4k41cLfNsqfxQqBoMn+f5pIzItW2
 K8qf2mimIHPvrk7HHeoIOCapHIu98zhRdj58s5kGU9/D97nG4D3YuYRenMXDLZhCzYeJqxpvC
 bGp0xFZlyCX2VsgBsxJbj1f7O1pyRMI+dU3p5barRqYg9qucy/0U5QVF2wCRRmf/hKxLtAPfD
 bymX/HSZctdrV7a80Xb+cygxzRXZrWX24v7azmp0sHVbpu8z8i/nWu2gEwfZeYX6vd6ddA0o8
 3iZNaEeKaQ3G4RNGerkTu6NkI+SgoxtTedCEyrivVgf1pigXgCUio6FJymidBiwI2qPT/zklk
 9CnuJDqjsUp5+4t8arUwmJVXo0ig5KUfj8amLNPey/4rKLs1+jGpvPVI8i2iXd1XtflDDN422
 Lvj5FUFn75FrINB29cLG9c+65TXKJDOT2NWSH6rZdoI7Of12xtCRcMugTfwomwFViRgNXCNBX
 BGlWufusKV4SupzvkTyGH/gOsutiWYBwrcGqRHLsrzO7SOff4EFzlYISBNDyPhfngIBU8d6iN
 MaYQRzbo01V7v7vq4
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Don't call quiesce(1) and quiesce(0) if array is already suspended,
otherwise in level_store, the array is writable after mddev_detach
in below part though the intention is to make array writable after
resume.

	mddev_suspend(mddev);
	mddev_detach(mddev);
	...
	mddev_resume(mddev);

And it also causes calltrace as follows in [1].

[48005.653834] WARNING: CPU: 1 PID: 45380 at kernel/kthread.c:510 kthread_=
park+0x77/0x90
[...]
[48005.653976] CPU: 1 PID: 45380 Comm: mdadm Tainted: G           OE     5=
.4.10-arch1-1 #1
[48005.653979] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M=
./J4105-ITX, BIOS P1.40 08/06/2018
[48005.653984] RIP: 0010:kthread_park+0x77/0x90
[48005.654015] Call Trace:
[48005.654039]  r5l_quiesce+0x3c/0x70 [raid456]
[48005.654052]  raid5_quiesce+0x228/0x2e0 [raid456]
[48005.654073]  mddev_detach+0x30/0x70 [md_mod]
[48005.654090]  level_store+0x202/0x670 [md_mod]
[48005.654099]  ? security_capable+0x40/0x60
[48005.654114]  md_attr_store+0x7b/0xc0 [md_mod]
[48005.654123]  kernfs_fop_write+0xce/0x1b0
[48005.654132]  vfs_write+0xb6/0x1a0
[48005.654138]  ksys_write+0x67/0xe0
[48005.654146]  do_syscall_64+0x4e/0x140
[48005.654155]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[48005.654161] RIP: 0033:0x7fa0c8737497

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D206161

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
=2D--
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d3212d61e660..92c626b506d6 100644
=2D-- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6076,7 +6076,7 @@ EXPORT_SYMBOL_GPL(md_stop_writes);
 static void mddev_detach(struct mddev *mddev)
 {
 	md_bitmap_wait_behind_writes(mddev);
-	if (mddev->pers && mddev->pers->quiesce) {
+	if (mddev->pers && mddev->pers->quiesce && !mddev->suspended) {
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
 	}
=2D-
2.17.1

