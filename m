Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4135131194
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 12:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAFLtk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 06:49:40 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:34653 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLtk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 06:49:40 -0500
Received: by mail-il1-f179.google.com with SMTP id s15so42390424iln.1
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 03:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9aoaQSmaOFrOCsoVpXLUIHds+3SkRO4o45vJvhgBbdI=;
        b=trn6gOYoUuk7Y4qHH9KdtyRVrurvJNDo2gsczGJxvt9Oj3SRchQS8uvXIopZg8Puy4
         OJCxJcepB15ReHQXHitCC1ff7x/G3dmz+FZJbatZN7WY3EkLqw65wfBdg9vlE//9CcgF
         Kl3DFujlxJzuFLRIpdMG9WUCP/Hb1CkC5otort06wpL3DehNlPiQE/ny9+hgoO32wadw
         Bd6X2cxQlTorqYWhE1dgb24pmuxB0mkVVi0IKxBo/XBQIEqAkBdck1VVjpSI2Vz3f1aj
         4g2uPishVysvFCn7VNp3NKP8QgJD7Npg4H98ZiVF4Tw61EqxNyHi7zFUVgXUvQIeYDZL
         C0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9aoaQSmaOFrOCsoVpXLUIHds+3SkRO4o45vJvhgBbdI=;
        b=QXsavLQ1WuTMvJFuihoyJD9Pd4UEvklxLT9iUXBPnU7n526rgAhtp01KUbGx50GdSz
         9AaYJV09C75MSX800C8PmKmKEXHo0bmsoqEclfF2ALCAGEfxC0qvHxzDLb4yZVkTxGCu
         pvqch4qyrAX4vqigkO8A+r+YdZOpe+MlMEF5SvbIVkgMl3So7hXTAS0hdEG6T+OHJV6G
         Mw9k88o/C9zsC5T4dwUULqfLPUOQfm6XIZJIIHT/GZai4K7VqlVY3PtK9uNF4V3kYzqd
         k2uEKx0odOVy1gnB++lKmXa6SH68gRt9wcC5x7ygrOCD/N8v08t+CR0ySr7kE+gNX7xg
         QHyw==
X-Gm-Message-State: APjAAAW8daqUF655R6F2h4YsiANjERtFRSHpJMHh1z1vh4uSka4Hw4g6
        IE+UbDx2Lk09QZExxK45cNS3Vngg/+NdO6DHIF1RzbHx/RA=
X-Google-Smtp-Source: APXvYqxY5YDG1K5UD+mIBuETqoVO0ZmRYFAZtR1/niJzhbYzfaRFo5SKX8MNXMZMGLFPiPDcwUeaIZozH3mdTc8w8V0=
X-Received: by 2002:a92:60f:: with SMTP id x15mr82629112ilg.181.1578311379625;
 Mon, 06 Jan 2020 03:49:39 -0800 (PST)
MIME-Version: 1.0
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Mon, 6 Jan 2020 12:49:28 +0100
Message-ID: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
Subject: Last scrub date and result
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Would be possible to add, in mdadm --detail output, the date of last
scrub and it's result ?
Looking through logs is not always possible (and much more harder to
script something), having something like:

Update Time : Mon Jan  6 12:47:29 2020
          State : clean
Last scrub Time: Mon Jan  4 12:47:29 2020
Last scrub result: success

would be great!
