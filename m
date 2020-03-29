Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E519711B
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC2Xkf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Mar 2020 19:40:35 -0400
Received: from mail1.ugh.no ([178.79.162.34]:59332 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgC2Xkf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 29 Mar 2020 19:40:35 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 19:40:35 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id C3562250D53
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 01:34:48 +0200 (CEST)
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tdVrFcNDW_ea for <linux-raid@vger.kernel.org>;
        Mon, 30 Mar 2020 01:34:47 +0200 (CEST)
Received: from [10.255.64.11] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id 98612250C73
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 01:34:47 +0200 (CEST)
To:     linux-raid <linux-raid@vger.kernel.org>
From:   Andre Tomt <andre@tomt.net>
Subject: Unable to fail/remove journal device
Message-ID: <59985bfe-2786-b4a9-64a4-283f5de98f82@tomt.net>
Date:   Mon, 30 Mar 2020 01:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I'm having a issue here where I am unable to get a journal device 
removed from a raid6 array. From what I could gather from mailing list 
posts and documentation, one should set the journal mode to 
write-through, fail the journal and remove it, then restart the array 
(perhaps with force).

But this isnt working. The journal just gets re-added on array startup. 
I've done this successfully before, in the same way, I think.

I also tried a bigger hammer, wipefs the journal device too, to "make 
sure", the array will come up but refuse any writes.

For now, the journal device has been restored and the array is back to 
read-write, but I really need to get it removed at some point 
(preferably without re-building metadata with --assume-clean)

Any ideas? Is this way just out of date?

mdadm: 4.1-5ubuntu1
kernel: 5.5.13

# cat /proc/mdstat
md2 : active (auto-read-only) raid6 sdm1[0] sde1[11] sdk1[10] sdt1[9] 
sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] sdd1[1] 
nvme0n1p1[12](J)

       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
[12/12] [UUUUUUUUUUUU]


# echo write-through > /sys/block/md2/md/journal_mode
# mdadm --fail /dev/md2 /dev/nvme0n1p1
mdadm: set /dev/nvme0n1p1 faulty in /dev/md2

# mdadm --remove /dev/md2 /dev/nvme0n1p1

mdadm: hot removed /dev/nvme0n1p1 from /dev/md2

# cat /proc/mdstat
md2 : active (auto-read-only) raid6 sdm1[0] sde1[11] sdk1[10] sdt1[9] 
sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] sdd1[1]

       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
[12/12] [UUUUUUUUUUUU]


# mdadm --stop /dev/md2

mdadm: stopped /dev/md2


# mdadm --assemble /dev/md2 --force

mdadm: /dev/md2 has been started with 12 drives and 1 journal.
  <-- !?
# cat /proc/mdstat
md2 : active (auto-read-only) raid6 sdm1[0] nvme0n1p1[12](J) sde1[11] 
sdk1[10] sdt1[9] sdl1[8] sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] 
sdd1[1]

                                             ^^^
       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
[12/12] [UUUUUUUUUUUU]


Okay then. Hammer time. Do all that again, wipefs the journal device, 
force start the array:

# mdadm --assemble /dev/md2 --force

mdadm: Journal is missing or stale, starting array read only.

mdadm: /dev/md2 has been started with 12 drives.

# cat /proc/mdstat
md2 : active (read-only) raid6 sdm1[0] sde1[11] sdk1[10] sdt1[9] sdl1[8] 
sdc1[7] sdj1[6] sdb1[5] sdu1[4] sds1[3] sdr1[2] sdd1[1]

       58603894400 blocks super 1.2 level 6, 64k chunk, algorithm 2 
[12/12] [UUUUUUUUUUUU]


Then it is just stuck in read-only.
