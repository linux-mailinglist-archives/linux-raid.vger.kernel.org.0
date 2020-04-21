Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8061B2C0F
	for <lists+linux-raid@lfdr.de>; Tue, 21 Apr 2020 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDUQNt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 12:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUQNt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 12:13:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87142C061A10
        for <linux-raid@vger.kernel.org>; Tue, 21 Apr 2020 09:13:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g74so15040797qke.13
        for <linux-raid@vger.kernel.org>; Tue, 21 Apr 2020 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pjubg0S+eBGw3HUfCK0wQszF+b9C0OnmFFgkaANd2j8=;
        b=e4eLA6AbQxkU9zcOldrOXhlNfBko39N5w/LnK3i+MDrud8pZnlFyRjyvgsM6EsBowc
         YZyAD8bfFOcIw2WHjBYNP6lBELMAlehW3qisxhdY7ucizQMlVlrJWwXuLh8nUIW53MAd
         M/9f6uw8wWJ5UFNTGELIhljTUNyTb8VwgI1rMuNEAxzVmFvFpf0aD2nxYpE3MGlfaPRx
         tJpNVSXecNy79LLniIqufIm0SevzcldYWPeONRo5aTr1qh+rF30rFuI6t+NBslOYt396
         q1B2kyB8nAu+tw0Qrp1OhJWb6qNxxrvFJGFXP7LD8hPaPScvs8hrm4i9bgLMruLZexl2
         4yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pjubg0S+eBGw3HUfCK0wQszF+b9C0OnmFFgkaANd2j8=;
        b=m4rouGlj/qwDDZSP23rIM1vPv28DNKR1C76DIPdgp1vjzhrEkNq8cVLyIB9jDKljsS
         nfUG6/Cqe/I3GRKITpBjNcjRRZtWJ2gem6mWaZoejnG0v/qOTyWBZ57Tm7Wv2E4Tb/Ef
         T3OxLc7SWKP3NnRIjzdPscCE15c9QSwG7SwSTs717QOqyW94A9y+UxgVXP8v9GERO5nR
         y7Iscdmr3lt8jU0WKsMHxtCPBWEJ5mS5Yj7tfYEjgj3pZsXVHGMa4UYXq1QCXa+TU7/U
         BqpUE7kXdSy9YANftmZ7M+5RS3DoTBFBfqhyVABNhCsucQan1q28ZTsm5a3Ktuq60fNX
         F2hg==
X-Gm-Message-State: AGi0PuYqpx6cCd+/b+Z21fmHm5oZDU5n/R15kt4/p6I371rcxiIOS+L+
        1vOAtgLHvsrFf5HhFz9CRUD4I1jrxT/ZrDRh9LD6d6+BNJc=
X-Google-Smtp-Source: APiQypJzs4C9abtTmZOpP99exFgHzs7ky/FcFplwEtYxpKweCfmfVzXIhKmRRJ66qZp2Xk+AmXr8dJgS9pCh8PQxqAk=
X-Received: by 2002:a05:620a:1306:: with SMTP id o6mr7220196qkj.443.1587485626495;
 Tue, 21 Apr 2020 09:13:46 -0700 (PDT)
MIME-Version: 1.0
From:   Leland Ball <lelandmball@gmail.com>
Date:   Tue, 21 Apr 2020 12:13:32 -0400
Message-ID: <CAM++EjGaFBh8ZChnyY0p=du0CKFT1WVikSNYyUUcJhuKwQf4sQ@mail.gmail.com>
Subject: Recovering From RAID5 Failure
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I have an old NAS device (Iomega StorCenter ix4-200d  2.1.48.30125)
which has failed to warn me that things were going awry. The NAS is
now in a state that appears unrecoverable from its limited GUI, and is
asking for overwrite confirmation on all 4 drives (1.8TB WD drives).
This smells of data loss, so I hopped on the box and did some
investigating:

I can "more" to find data on each of two partitions for each of the 4
drives /dev/sd[abcd][12] so the drives are functioning in some
capacity. I believe this is running in a RAID 5 configuration, at
least that's what the settings state.

Here's what I'm working with...
# mdadm --version
mdadm - v2.6.7.2 - 14th November 2008

I believe the array was first created in 2011. Not sure if the disks
have been replaced since then, as this array was given to me by a
friend.

I am unsure of how I should go about fixing this, and which (if any)
drives truly needs replacing. My next step would be to try:
# mdadm /dev/md1 --assemble /dev/sda2 /dev/sdb2 /dev/sdc2 /dev/sdd2
(and if that didn't work, maybe try the --force command?). Would this
jeopardize data like the --create command can?

I've compiled output from the following commands here:
https://pastebin.com/EmqX3Tyq
# fdisk -l
# cat /etc/fstab
# cat /proc/mdstat
# mdadm -D /dev/md0
# mdadm -D /dev/md1
# mdadm --examine /dev/sd[abcd]1
# mdadm --examine /dev/sd[abcd]2
# cat /etc/lvm/backup/md1_vg
# dmesg
# cat /var/log/messages

I don't know if md0 needs to be fixed first (if it's even
malfunctioning). I have never administered RAID volumes at this level
before. Would appreciate any help you can provide. Thanks!
