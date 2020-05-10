Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F91CCAAC
	for <lists+linux-raid@lfdr.de>; Sun, 10 May 2020 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEJMHe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 10 May 2020 08:07:34 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35400 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEJMHe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 10 May 2020 08:07:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49KjVq3k8Gz1qrfD
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 14:07:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49KjVq3dnqz1qrKq
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 14:07:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5O1RDhOKuzai for <linux-raid@vger.kernel.org>;
        Sun, 10 May 2020 14:07:30 +0200 (CEST)
X-Auth-Info: vkhDQkXXFkWErTLJFu4kA6nwDp8rnzVWgdJGvlURx1k=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 14:07:30 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 30434A0250; Sun, 10 May 2020 14:07:30 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 63855A013C
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 14:07:25 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 20947240E1A
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 14:07:25 +0200 (CEST)
To:     linux-raid@vger.kernel.org
Subject: raid6check extremely slow ?
From:   Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
Date:   Sun, 10 May 2020 14:07:25 +0200
Message-Id: <20200510120725.20947240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I'm running raid6check on a 12 TB (8 x 2 TB harddisks)
RAID6 array and wonder why it is so extremely slow...
It seems to be reading the disks only a about 400 kB/s,
which results in an estimated time of some 57 days!!!
to complete checking the array.  The system is basically idle, there
is neither any significant CPU load nor any other I/o (no to the
tested array, nor to any other storage on this system).

Am I doing something wrong?


The command I'm running is simply:

# raid6check /dev/md0 0 0

This is with mdadm-4.1 on a Fedora 32 system (mdadm-4.1-4.fc32.x86_64).

The array data:

# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Thu Nov  7 19:30:03 2013
        Raid Level : raid6
        Array Size : 11720301024 (11177.35 GiB 12001.59 GB)
     Used Dev Size : 1953383504 (1862.89 GiB 2000.26 GB)
      Raid Devices : 8
     Total Devices : 8
       Persistence : Superblock is persistent

       Update Time : Mon May  4 22:12:02 2020
             State : active
    Active Devices : 8
   Working Devices : 8
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 16K

Consistency Policy : resync

              Name : atlas.denx.de:0  (local to host atlas.denx.de)
              UUID : 4df90724:87913791:1700bb31:773735d0
            Events : 181544

    Number   Major   Minor   RaidDevice State
      12       8       64        0      active sync   /dev/sde
      11       8       80        1      active sync   /dev/sdf
      13       8      112        2      active sync   /dev/sdh
       8       8      128        3      active sync   /dev/sdi
       9       8      144        4      active sync   /dev/sdj
      10       8      160        5      active sync   /dev/sdk
      14       8      176        6      active sync   /dev/sdl
      15       8      192        7      active sync   /dev/sdm

# iostat /dev/sd[efhijklm]
Linux 5.6.8-300.fc32.x86_64 (atlas.denx.de)     2020-05-07      _x86_64_        (8 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.18    0.01    1.11    0.21    0.00   98.49

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
sde              19.23       388.93         0.09         0.00  158440224      35218          0
sdf              19.20       388.94         0.09         0.00  158447574      34894          0
sdh              19.23       388.89         0.08         0.00  158425596      34178          0
sdi              19.23       388.99         0.09         0.00  158466326      34690          0
sdj              20.18       388.93         0.09         0.00  158439780      34766          0
sdk              19.23       388.88         0.09         0.00  158419988      35366          0
sdl              19.20       388.97         0.08         0.00  158457352      34426          0
sdm              19.21       388.92         0.08         0.00  158435748      34566          0


top - 09:08:19 up 4 days, 17:10,  3 users,  load average: 1.00, 1.00, 1.00
Tasks: 243 total,   1 running, 242 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.2 us,  0.5 sy,  0.0 ni, 98.5 id,  0.1 wa,  0.6 hi,  0.1 si,  0.0 st
MiB Mem :  24034.6 total,  11198.4 free,   1871.8 used,  10964.3 buff/cache
MiB Swap:   7828.5 total,   7828.5 free,      0.0 used.  21767.6 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  19719 root      20   0    2852   2820   2020 D   5.1   0.0 285:40.07 raid6check
   1123 root      20   0       0      0      0 S   0.3   0.0  25:47.54 md0_raid6
  37816 root      20   0       0      0      0 I   0.3   0.0   0:00.08 kworker/3:1-events
  37903 root      20   0  219680   4540   3716 R   0.3   0.0   0:00.02 top
...


HDD in use:

/dev/sde : ST2000NM0033-9ZM175
/dev/sdf : ST2000NM0033-9ZM175
/dev/sdh : ST2000NM0033-9ZM175
/dev/sdi : ST2000NM0033-9ZM175
/dev/sdj : ST2000NM0033-9ZM175
/dev/sdk : ST2000NM0033-9ZM175
/dev/sdl : ST2000NM0033-9ZM175
/dev/sdm : ST2000NM0008-2F3100


3 days later:

# iostat /dev/sd[efhijklm]
Linux 5.6.8-300.fc32.x86_64 (atlas.denx.de)     2020-05-10      _x86_64_        (8 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.18    0.00    1.07    0.17    0.00   98.57

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
sde              20.15       370.73         0.10         0.00  253186948      68154          0
sdf              20.13       370.74         0.10         0.00  253194646      68138          0
sdh              20.15       370.71         0.10         0.00  253172656      67738          0
sdi              20.15       370.77         0.10         0.00  253213854      68158          0
sdj              20.72       370.73         0.10         0.00  253187084      68066          0
sdk              20.15       370.70         0.10         0.00  253166960      69286          0
sdl              20.13       370.76         0.10         0.00  253204572      68070          0
sdm              20.14       370.73         0.10         0.00  253182964      68070          0


I've tried playing with speed_limit_min/speed_limit_max, but this
didn't change anything:

# cat /proc/sys/dev/raid/speed_limit_max
2000000
cat /proc/sys/dev/raid/speed_limit_min
10000

Any ideas welcome!

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The inappropriate cannot be beautiful.
             - Frank Lloyd Wright _The Future of Architecture_ (1953)
