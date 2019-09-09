Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0CAD19D
	for <lists+linux-raid@lfdr.de>; Mon,  9 Sep 2019 03:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfIIBj4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 8 Sep 2019 21:39:56 -0400
Received: from hoggar.fisica.ufpr.br ([200.238.171.242]:38056 "EHLO
        hoggar.fisica.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbfIIBj4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 8 Sep 2019 21:39:56 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 21:39:55 EDT
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id AAA72362018A; Sun,  8 Sep 2019 22:33:26 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1567992806;
        bh=o/M9ua+libS+BFurj6V09x1uBrLIhmB6AUakPFoT68s=;
        h=Date:From:To:Subject:From;
        b=WpPjl+/KN80udTsC1wPi4KYaiTt6mqbt6pZkNjlNXcmB1aVlnSJI07Ovr6bqLQnoG
         byOo8ytZYUwwDJkZuVH0U7q4ZY9Ln/gWUgTKUbb0HkVMVUMkDB8KaX/B1LVMgeNHPT
         sjxeZjoECFL3aBRVKczechRpQ7n7O27NhOz8dc4Sotw6ORnmZtwZVKnRS55rkzudG3
         3zjt9Za3fzsnNj1PiOhKjtSph6N5Drvuix8sL6joUTVJ13LtaFWK+w9X/ce/0QfFGQ
         ZjrKbCgOrrBCH4ZOdXRFvsRzT/EtJnQn/0QO3r1UF0n7GRsDwYkkckKsQJpIapbn8H
         /PB96F4R1bGPQ==
Date:   Sun, 8 Sep 2019 22:33:26 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     linux-raid@vger.kernel.org
Subject: --add-journal not working with 5.2.13??!!
Message-ID: <20190909013326.GA31505@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I've been using arrays with journal for about 2 years. I created them with
journal. Now I tried to create a raid6 array without journal and add it after,
and it doesn't work(!)... This is with vanilla 5.2.13 and mdadm 4.1.

Here's the result:

# ~/mdadm-4.1-3/sbin/mdadm  -C /dev/md0 -l 6 -e 1.1 -n 15 --assume-clean /dev/sda[k-y]
# ~/mdadm-4.1-3/sbin/mdadm  --readonly /dev/md0

# cat /proc/mdstat
Personalities : [raid1] [raid6] [raid5] [raid4] 
md0 : active (read-only) raid6 sday[14] sdax[13] sdaw[12] sdav[11] sdau[10] sdat[9] sdas[8] sdar[7] sdaq[6] sdap[5] sdao[4] sdan[3] sdam[2] sdal[1] sdak[0]
      101580623872 blocks super 1.1 level 6, 512k chunk, algorithm 2 [15/15] [UUUUUUUUUUUUUUU]
      bitmap: 0/59 pages [0KB], 65536KB chunk

# ~/mdadm-4.1-3/sbin/mdadm /dev/md0 --add-journal /dev/sdaz
mdadm: Failed to hot add /dev/sdaz as journal, please try restart /dev/md0.

??? To re-assemble I first put its UUID in /etc/mdadm/mdadm.conf, then

# ~/mdadm-4.1-3/sbin/mdadm -S /dev/md0
mdadm: stopped /dev/md0

# ~/mdadm-4.1-3/sbin/mdadm  -A /dev/md0
mdadm: Fail create md0 when using /sys/module/md_mod/parameters/new_array
mdadm: device 30 in /dev/md0 has wrong state in superblock, but /dev/sdaz seems ok
mdadm: failed to RUN_ARRAY /dev/md0: Invalid argument

I don't compile modules in the kernel.

What am I missing?
