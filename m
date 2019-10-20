Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB673DE08D
	for <lists+linux-raid@lfdr.de>; Sun, 20 Oct 2019 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfJTUw1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 20 Oct 2019 16:52:27 -0400
Received: from secmail.pro ([146.185.132.44]:51448 "EHLO secmail.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfJTUw1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 20 Oct 2019 16:52:27 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Oct 2019 16:52:26 EDT
Received: by secmail.pro (Postfix, from userid 33)
        id 9643ADF398; Sun, 20 Oct 2019 20:42:08 +0000 (UTC)
Received: from secmailw453j7piv.onion (localhost [IPv6:::1])
        by secmail.pro (Postfix) with ESMTP id B8EFB1F32F7
        for <linux-raid@vger.kernel.org>; Sun, 20 Oct 2019 13:44:02 -0700 (PDT)
Received: from 127.0.0.1
        (SquirrelMail authenticated user hhardly@secmail.pro)
        by giyzk7o6dcunb2ry.onion with HTTP;
        Sun, 20 Oct 2019 13:44:02 -0700
Message-ID: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
Date:   Sun, 20 Oct 2019 13:44:02 -0700
Subject: How to assemble Intel RST Matrix volumes?
From:   hhardly@secmail.pro
To:     linux-raid@vger.kernel.org
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello everyone,

I have a Intel RST RAID 1 array composed of 2 physical drives and then
split into a 2-volume Intel Matrix. One physical drive appears to have
gone bad. I am trying to recover the data on another computer without the
RST controller. I am working on copies of the original drives but the bad
drive copy doesn't look usable (its --examine output is very different).

Using only the copy of the good drive, mdadm seems to assemble and run it
without having to force it with --run which looks promising.

# IMSM_NO_PLATFORM=1 mdadm --assemble -e imsm -v /dev/md0 /dev/sdc
mdadm: looking for devices for /dev/md0
mdadm: /dev/sdc is identified as a member of /dev/md0, slot -1.
mdadm: added /dev/sdc to /dev/md0 as -1
mdadm: Container /dev/md0 has been assembled with 1 drive

After this I get stuck trying to assemble the Matrix volumes. When I
--examine the physical drive I see a UUID at the top, and this matches the
UUID of the currently assembled device (according to --detail). There are
two volumes listed below that, each with their own different UUID. I think
I'm supposed to use the --incremental mode to continue adding the volumes,
but this fails:

# IMSM_NO_PLATFORM=1 mdadm --incremental -e imsm -v /dev/md0
mdadm: /dev/md0 is not part of an md array.

I have also tried using --assemble using just those UUID separately in a
number of ways, all unsuccessful.

With only the parent container assembled I have this:

# cat /proc/mdstat
Personalities :
md0 : inactive sdc[0](S)
      5201 blocks super external:imsm

Is "inactive" a problem? Adding --run to the --assemble makes no
difference. Is the small block count only for the superblocks?

How can I assemble and access those Intel Matrix volumes?

