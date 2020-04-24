Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D911B6FFC
	for <lists+linux-raid@lfdr.de>; Fri, 24 Apr 2020 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgDXIrn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Apr 2020 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXIrn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Apr 2020 04:47:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FABC09B045
        for <linux-raid@vger.kernel.org>; Fri, 24 Apr 2020 01:47:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f11so4503369ljp.1
        for <linux-raid@vger.kernel.org>; Fri, 24 Apr 2020 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LsklMg8UWOuEXq1P7JGnJ6shOhqnM+JxdWvBI7kA+aY=;
        b=lzt1xHMIVKFPoI5c8KWvZjoFel5h3wHhZSFGsF6ShqPCvyNj0HBneUS/lcddoCPBvJ
         fsvjGSOyQ0VYexlM2OeRFYAFrFGqh+mXtbRsueejrwsQhy6S6napLBt0M5h181Xbzx93
         qEESxDCwxNwsTlxQP1kIKS6LYfGpNozX3VRbBBAHtBPmNL47JWi/oqJxvYZ6tGiwMc+J
         ZzvPzoVl8d2mAiWxj6V0XF1OotA0SHskV086JHAB0cwY68QD2ptWECrKrgqcOGK4a+9N
         t+MXzD4NMJdWj+Ds78gM8TkmXJ6y6IJb6evqsMegv7RfiXXAMf1xtUXnSQbBzgVYuDVX
         LObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LsklMg8UWOuEXq1P7JGnJ6shOhqnM+JxdWvBI7kA+aY=;
        b=n/4B5TG6+x3p56q07SH+H0kNOWO69d3u1iinZP2KRZFHriGV+wATffGi4a7bWVdRWb
         dmidiB/xtHI/yAyN4eID/5v7ZErXWOg39U2CcElxkiaAjNeMtAEfiJxoS5fvmxvBPTk0
         5dzBDCGgZ7D3XH07FJRZ8VlO+EoWb98H4WESB4UkVwTxh4JIpSijFQOHd9JeTmVBkB7I
         IkvDFiGd2MXY1tuUrv4k+4mjVbdwql3eViDPjyBZKda4ncpf/ur1cOYyNVmJU86KSXnu
         R3+Jm/iDJysliGxyP4wDXT3AI9T6WfNhHVUyO/qr12MXCOrdqjJIv8vc7YzuCs9sQ4UC
         KtAw==
X-Gm-Message-State: AGi0PuZQmzmJg6Ge/L5vw4mMo+rjOhkgbpEkQM0je8WpcJ4TL5tFY9ci
        sGIllg5Vf6vsEPKmyYWCvsaiS7/5FUPMYH40iIb0SrM/PUI=
X-Google-Smtp-Source: APiQypLGuqMnCH9PJ8UU1yAVR7TNxA1FdDM0MQlVSRRDc+k5wRg8de7PBv9bndjJFovrrh2txQZZmhzPghtOBXJfYQ8=
X-Received: by 2002:a2e:96d1:: with SMTP id d17mr5271326ljj.239.1587718060603;
 Fri, 24 Apr 2020 01:47:40 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0KHQtdGA0LPQtdC5INCg0YvQttC+0LI=?= 
        <ryzhovsergey@gmail.com>
Date:   Fri, 24 Apr 2020 11:47:24 +0300
Message-ID: <CAMk5DB3QbSaPkPzvwLdZp5HQaca8JYJrTS9ahfvOovFuhusPiw@mail.gmail.com>
Subject: Linux RAID reshaping hang, can somebody help me with this?
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I've RAID-5 on 4 disks.
I've added 1 new drive as spare and run a command to grow array to 5-disks.
In the beginning, everything was fine, but now reshaping very slow -
speed=77K/sec

Kernel is 4.18.0-147.3.1.el8_1.x86_64
mdadm - v4.1 - 2018-10-01

Commands what I used:
mdadm --manage /dev/md3 --add  /dev/sdb
mdadm --grow /dev/md3 --raid-devices=5

There is crypted volume on raid: md3 -> cryptvol -> FS
When I tryed unmount FS, umount command hung, however FS gone from
'df' output.  Also I can't stop cryptvol,  'cryptsetup close' hung.

What I should do to don't lose my raid data?

#  mdadm --detail /dev/md3
/dev/md3:
           Version : 1.2
     Creation Time : Mon Jan 11 14:32:08 2016
        Raid Level : raid5
        Array Size : 5860150272 (5588.67 GiB 6000.79 GB)
     Used Dev Size : 1953383424 (1862.89 GiB 2000.26 GB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Fri Apr 24 08:38:20 2020
             State : active, reshaping
    Active Devices : 5
   Working Devices : 5
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

    Reshape Status : 56% complete
     Delta Devices : 1, (4->5)

              Name : farm:3  (local to host farm)
              UUID : e3537ea8:892da052:bfb9cb85:93156ade
            Events : 59168

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync   /dev/sda
       4       8       48        1      active sync   /dev/sdd
       3       8       96        2      active sync   /dev/sdg
       5       8       32        3      active sync   /dev/sdc
       6       8       16        4      active sync   /dev/sdb

Regards,
Sergey
