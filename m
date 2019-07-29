Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5529179A05
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 22:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfG2UcI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 16:32:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2UcI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 16:32:08 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCJR-0001qM-KW
        for linux-raid@vger.kernel.org; Mon, 29 Jul 2019 20:32:05 +0000
Received: by mail-pf1-f199.google.com with SMTP id f25so39157705pfk.14
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 13:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMfAWDCqrjBeE42rbQCRmwqZEuUIVCeOcgzSaEx81J8=;
        b=AornWxt7/rVrLXNUcW+hy4W/fABr2J3D0MA2TC9vgGuw6XJ3+bSHXJk9wH0zpB64RR
         1sY3wUsZ0c6EcqaPhCCNG1HPfg8dOoDs4ZnvOAwBNXZQ5Aspc5QufYNkmNPjenfgEYD5
         4cSDzLOS02ByHy1UxfVlLy/ncMAwWWbF5bELFdQ82FFA1/YeKndsCubNaf1/mu8ggLTl
         N7WLF0r998sytxeu5tqOBVKrejR7N5i+73JxHbc4zgRMpZYPVHxQM9sHCMD7NjE3YOZ3
         budb/Cb4FutApeLIYjxDxdtmNyXITMaGZS5QVGl7xRVzv99d7vM7ICiRGJbCsVy7i8YJ
         Gdqw==
X-Gm-Message-State: APjAAAVb4haBAI1b7nDd0ckj8r+41e+uLQI4PstQDwKq/jYE/r99lTEV
        g2lC/9kuy82arnsy+DQP0AgR8pPLqA7tuiTNsbm5+VBEADXQbL+JXR9Gd52EI30cfX1WjyWSX7V
        7w/wuzbD5WmIVewIP0YIesos07hX+14qpQ+HrZG4=
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr113783958pll.236.1564432324028;
        Mon, 29 Jul 2019 13:32:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5CwXyWbTEeZiJ87HQ6jaOLVqakwH/nw+0O+WCPiV0SFTLFFtXdaAewFJs6dO9mSgODGZ6tA==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr113783942pll.236.1564432323845;
        Mon, 29 Jul 2019 13:32:03 -0700 (PDT)
Received: from localhost ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id i74sm122266922pje.16.2019.07.29.13.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:32:02 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com, neilb@suse.com,
        songliubraving@fb.com
Subject: [PATCH 0/2] Introduce new raid0 state 'broken'
Date:   Mon, 29 Jul 2019 17:31:33 -0300
Message-Id: <20190729203135.12934-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently the md/raid0 device behaves quite differently of other block
devices when it comes to failure. While other md levels contain vast
logic to deal with failures, and other non-md devices like scsi disks
or nvme rely on a dying queue when they fail, md/raid0 for instance
does not signal failures if an array member is removed while the array
is mounted; in that case, udev signals the device removal but mdadm
cannot succeed in the STOP_ARRAY ioctl, since it's mounted.

This behavior was tentatively changed in the past to match the scsi/nvme
devices (see [0]), but this attempt was quite complex, it had some corner
cases and (the few) community reviews weren't generally positive.
So, we are trying again with a simpler approach this time.

This series introduces a new array state 'broken' (for raid0 only), which
mimics the state 'clean'. The main goal for this new state is a way to
signal the user that something is wrong with the array. We also included a
warn_once-style message in kernel log to alert the user when the array has
one failed member.

The series encompass changes in the kernel and in mdadm tool. To get the
'broken' state completely functional one requires both changes, but mdadm
and kernel can live without their counterpart changes (in case some users
gets an updated mdadm for example, but keeps using an old kernel).

This series does not affect at all the way md/raid0 will react to I/O
failures. It was discussed in [0] that it should be better if raid0 could
fail faster in case it gets a member removed; we just proposed a change in
that realm too (see [1]), but it seems better to have them reviewed/treated
separately.

This series was tested with raid0 arrays holding both an ext4 and xfs
filesystems. Thanks in advance for the reviews/feedbacks.
Cheers,


Guilherme


[0] lore.kernel.org/linux-block/20190418220448.7219-1-gpiccoli@canonical.com
[1] lore.kernel.org/linux-block/20190729193359.11040-1-gpiccoli@canonical.com


Guilherme G. Piccoli (1):
  md/raid0: Introduce new array state 'broken' for raid0

[kernel part]
 drivers/md/md.c    | 23 +++++++++++++++++++----
 drivers/md/md.h    |  2 ++
 drivers/md/raid0.c | 26 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

[mdadm]
 Detail.c  | 16 ++++++++++++++--
 Monitor.c |  9 +++++++--
 maps.c    |  1 +
 mdadm.h   |  1 +
 mdmon.h   |  2 +-
 monitor.c |  4 ++--
 6 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.22.0

