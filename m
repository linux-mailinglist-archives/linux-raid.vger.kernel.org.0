Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2020B1427C2
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jan 2020 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgATKCe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jan 2020 05:02:34 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38779 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKCd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jan 2020 05:02:33 -0500
Received: by mail-qk1-f178.google.com with SMTP id k6so29521307qki.5
        for <linux-raid@vger.kernel.org>; Mon, 20 Jan 2020 02:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Bt4aqDTTlDyxxE+HXlZYZLILhbeO1ZtxBCR4QMn15Sg=;
        b=CoGK5c9bEuY/jplq4Fe5vveTxL/+2mJdT0Da2RHGqAg2JuC7utS1+Le0GWMj4g4Uus
         J8Jm2r3gfaOMxtODUFvXWqIV6YAV+ckrZiMPbMc5u1228GpPSxNX7b22LAcZlA7hp4ZN
         EzPU8KzKE42WY+x7QtKRFOqBXigrw5ye71flsO/CNxfuIIQ+OzOJFDC8n2/1n7EOS7jb
         nHLcCanIzRx76bSFd/lMtiWylsfC1+dRpKcN425BeG//bxzONJ66ogYcmZfHhRb7tHld
         8bnr5JpTzqMNvi+i2YRtzU2xjrVDUd759K5O9YamAz7AtQMv/pL/5aTsJQOxP6/4o4ya
         RgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Bt4aqDTTlDyxxE+HXlZYZLILhbeO1ZtxBCR4QMn15Sg=;
        b=dqtZcV7DT3j0os9Q5/VSw30nQ6ZsHaf1C0Zlm+Wlb9JHANWnKh7zpZy+FW2lx5gC64
         H8e+z/LGdDix870lNyMhR93pGpWiG2tN/Ntlvpobcf+m19rpZu9p4N5pnCnNslj8lhz9
         cgfyJidrUyA7pHUxnyzSuIDzjedcGfgl0EAfzDNx9b82yU2axBXbbJpzQpZu7s939eWe
         27dB49YXnokKfnfTVyGboEh1uLHlYpPkYPEnvMOVjQ6IkYsdsrTw73hs7DSILZLW0G2z
         Ef0oRN/sfCb5xjv3VISOtw1U3QX1FAMteXBTc6XwlAkO99jGt5YHQJGDT1utodV3W6yl
         V4bw==
X-Gm-Message-State: APjAAAX8smajcwNmctWWc2gPo+2IycPKSuNg7T8tn0J4RVD/B9+gW0eq
        hjsT9d2XwNNMterVEJw7vxBx1K4ni3kfLBlxR4QwMKoH
X-Google-Smtp-Source: APXvYqwh+MwzcDuewmnvgtVvjsp5amJVr3g42Hvghq7qAuC+vMK2rj2pZkki9wUNnpgY10RrYFfVwN37Wk1aZ5Fm/lU=
X-Received: by 2002:a05:620a:100d:: with SMTP id z13mr51866745qkj.475.1579514552466;
 Mon, 20 Jan 2020 02:02:32 -0800 (PST)
MIME-Version: 1.0
Reply-To: andrewbass@gmail.com
From:   "Andrey ``Bass'' Shcheglov" <andrewbass@gmail.com>
Date:   Mon, 20 Jan 2020 13:02:21 +0300
Message-ID: <CADSg1Jh1i+OPq0_hWOvHxK0xroUbn_w0_ZjxjwcnrbSsBXGY5A@mail.gmail.com>
Subject: Repairing a RAID1 with non-zero mismatch_cnt
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings,

I have a question on how to repair a RAID1 array (consisting of 2
physical hard drives, metadata version 1.2) which went split-brain.

One of my md-devices repeatedly shows a non-zero mismatch_cnt:

# cat /sys/block/md4/md/mismatch_cnt
1024

Zeroing out free space (with `zerofree`, as recommended here:
<http://decafbad.net/2017/01/03/mismatch_cnt,-raid1,-and-a-clever-fix/>)
and disabling the swap both retain the mismatch count at the very same
level.
Also, none of the drives is failing (18x and 19x SMART attributes are ok).
Checking file systems (ext4) doesn't show any problem, either, so the
file system metadata is most probably correct, too.

The usual suspects ruled out, I'm starting to think it my data got
corrupted, and at least one out of two replicas is affected.
Of course I can

# echo repair > /sys/block/md0/md/sync_action

but I have a 50% chance of losing information stored on the "right" replica.


So, assuming my /dev/md0 is now assembled from /dev/sda1 and /dev/sdb1,
I feel like assemble and run two separate degraded mirrors from
/dev/sda1 and /dev/sdb1, respectively (`mdadm -A`),
mount the corresponding file systems R/O,
create two backups (one backup per replica)
and then compare them with each other (`diff -urN`).


The question is: is it possible to assemble an array in a read-only mode,
so that the underlying block device is never written to,
the metadata in the superblock remains intact and the event count is
not incremented?

My intention is to avoid the resync when my original /dev/md0 is
reassembled from /dev/sda1 and /dev/sdb1.


If you have any other recommendations on how to interactively repair
the array (I want to be able to peek at the data being synced),
I'd appreciate you sharing them.

Regards,
Andrey.
