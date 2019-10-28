Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0AE7AB4
	for <lists+linux-raid@lfdr.de>; Mon, 28 Oct 2019 22:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfJ1VDh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Oct 2019 17:03:37 -0400
Received: from magic.merlins.org ([209.81.13.136]:53750 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbfJ1VDg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 28 Oct 2019 17:03:36 -0400
X-Greylist: delayed 2162 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 17:03:36 EDT
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1iPBbw-0003Yn-QA by authid <merlin>; Mon, 28 Oct 2019 13:27:32 -0700
Date:   Mon, 28 Oct 2019 13:27:32 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     linux-raid@vger.kernel.org
Subject: Cannot fix Current_Pending_Sector even after check and repair
Message-ID: <20191028202732.GV15771@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have 6 drives behind a Perc H700 card. I'd love to do without, but it
was the only reasonable way to plug 6 drives in that dell server's drive
midplane. I configured the drives as single drive raid0, which isn't
quite passthrough, but as close as I can get it.

Then, I just created software raid5 on top of them, as I would with
regular drives.

magic:~# smartctl -d megaraid,3 -a /dev/sda | grep Current_Pending_Sector
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE UPDATED  WHEN_FAILED RAW_VALUE
197 Current_Pending_Sector  0x0032   200   200   000    Old_age Always -       9

The drive is:
Model Family:     Western Digital Caviar Green (AF)
Device Model:     WDC WD20EARS-00MVWB0
Serial Number:    WD-WMAZA0374092
LU WWN Device Id: 5 0014ee 6558fe0fe
Firmware Version: 50.0AB50

Normally
echo check > /sys/block/mdx/md/sync_action
would re-read everything, get errors on the pending sectors, and write
new ones from parity.
But check just ran fine, no output, nothing

Then I tried
echo repair > /sys/block/mdx/md/sync_action 
same thing, no output, it ran fine.

Out of desperation, I ran
hdrecover /dev/sdx on all my drives. It reads the whole drive block by
block, allowing to re-read a block many times to try and rescue data
from it, or just re-write it with 0's.
That one again, ran fine, no error.

So now I'm getting daily warnings about the pending sector count, when
apparently nothing is wrong.

Any idea how to reset that counter?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
