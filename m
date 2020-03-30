Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04CA197D1A
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgC3Nil convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 30 Mar 2020 09:38:41 -0400
Received: from len.romanrm.net ([91.121.86.59]:55980 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbgC3Nil (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Mar 2020 09:38:41 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 359AC4051D;
        Mon, 30 Mar 2020 13:38:39 +0000 (UTC)
Date:   Mon, 30 Mar 2020 18:38:38 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org
Subject: Re: mdcheck: slow system issues
Message-ID: <20200330183838.7a9389b8@natsu>
In-Reply-To: <5693a405-2722-03e9-2f63-c5916022dc60@thelounge.net>
References: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
        <5693a405-2722-03e9-2f63-c5916022dc60@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 30 Mar 2020 15:27:13 +0200
Reindl Harald <h.reindl@thelounge.net> wrote:

> 
> 
> Am 30.03.20 um 14:18 schrieb Paul Menzel:
> > How do you run `mdcheck` in production without noticeably affecting the
> > system?
> 
> you can' for years
> 
> either lower "dev.raid.speed_limit_max" and wait ages for the raid check
> or cripple system performance
> 
> i remember "dev.raid.speed_limit_max" did 10 years ago what it is
> supposed to do: use that when the system is idle but slow down the
> raid-check in case of heavy user-io
> 
> but the current drama exists for many years

This still cleanly reverts on current kernels and I believe is the cause of
what you are talking about. Would be nice if you can check if that's indeed
the case. ("patch -R" with the below)

---


From ac8fa4196d205ac8fff3f8932bddbad4f16e4110 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Thu, 19 Feb 2015 16:55:00 +1100
Subject: md: allow resync to go faster when there is competing IO.

When md notices non-sync IO happening while it is trying
to resync (or reshape or recover) it slows down to the
set minimum.

The default minimum might have made sense many years ago
but the drives have become faster.  Changing the default
to match the times isn't really a long term solution.

This patch changes the code so that instead of waiting until the speed
has dropped to the target, it just waits until pending requests
have completed.
This means that the delay inserted is a function of the speed
of the devices.

Testing shows that:
 - for some loads, the resync speed is unchanged.  For those loads
   increasing the minimum doesn't change the speed either.
   So this is a good result.  To increase resync speed under such
   loads we would probably need to increase the resync window
   size.

 - for other loads, resync speed does increase to a reasonable
   fraction (e.g. 20%) of maximum possible, and throughput of
   the load only drops a little bit (e.g. 10%)

 - for other loads, throughput of the non-sync load drops quite a bit
   more.  These seem to be latency-sensitive loads.

So it isn't a perfect solution, but it is mostly an improvement.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/md/md.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3b9b032..d4f31e1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7880,11 +7880,18 @@ void md_do_sync(struct md_thread *thread)
 			/((jiffies-mddev->resync_mark)/HZ +1) +1;
 
 		if (currspeed > speed_min(mddev)) {
-			if ((currspeed > speed_max(mddev)) ||
-					!is_mddev_idle(mddev, 0)) {
+			if (currspeed > speed_max(mddev)) {
 				msleep(500);
 				goto repeat;
 			}
+			if (!is_mddev_idle(mddev, 0)) {
+				/*
+				 * Give other IO more of a chance.
+				 * The faster the devices, the less we wait.
+				 */
+				wait_event(mddev->recovery_wait,
+					   !atomic_read(&mddev->recovery_active));
+			}
 		}
 	}
 	printk(KERN_INFO "md: %s: %s %s.\n",mdname(mddev), desc,
-- 
cgit v1.1


