Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C95B82F9
	for <lists+linux-raid@lfdr.de>; Thu, 19 Sep 2019 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfISUzd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Thu, 19 Sep 2019 16:55:33 -0400
Received: from mail.ugal.ro ([193.231.148.6]:47226 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbfISUzc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 19 Sep 2019 16:55:32 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 16:55:28 EDT
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id C9DD213A2ED6A
        for <linux-raid@vger.kernel.org>; Thu, 19 Sep 2019 20:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wvk_8ikvjBHO for <linux-raid@vger.kernel.org>;
        Thu, 19 Sep 2019 23:45:47 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 6AF3913A276FF
        for <linux-raid@vger.kernel.org>; Thu, 19 Sep 2019 23:45:47 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     <linux-raid@vger.kernel.org>
Subject: RAID 10 with 2 failed drives
Date:   Thu, 19 Sep 2019 23:45:56 +0300
Organization: =?UTF-8?Q?Universitatea_=E2=80=9EDunarea_de_Jos=E2=80=9D_d?=
        =?UTF-8?Q?in_Gala=3Fi?=
Message-ID: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdVvKzv1iQqcb9bCRTS96XeHx9ssow==
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

Please let me know if in this situation detailed below, there are chances of restoring the RAID 10 array and how I can do it safely. 
Thank you!

Liviu Petcu

# mdadm --examine /dev/sd[abcdef]2

/dev/sda2:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
  Creation Time : Fri Aug 14 12:11:48 2015
     Raid Level : raid10
  Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
     Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 1

    Update Time : Thu Sep 19 21:05:15 2019
          State : active
 Active Devices : 4
Working Devices : 4
 Failed Devices : 2
  Spare Devices : 0
       Checksum : e528c455 - correct
         Events : 271498

         Layout : offset=2
     Chunk Size : 256K

      Number   Major   Minor   RaidDevice State
this     5       8        2        5      active sync   /dev/sda2

   0     0       8       18        0      active sync   /dev/sdb2
   1     1       0        0        1      faulty removed
   2     2       0        0        2      faulty removed
   3     3       8       66        3      active sync   /dev/sde2
   4     4       8       82        4      active sync   /dev/sdf2
   5     5       8        2        5      active sync   /dev/sda2
/dev/sdb2:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
  Creation Time : Fri Aug 14 12:11:48 2015
     Raid Level : raid10
  Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
     Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 1

    Update Time : Thu Sep 19 21:05:15 2019
          State : active
 Active Devices : 4
Working Devices : 4
 Failed Devices : 2
  Spare Devices : 0
       Checksum : e528c45b - correct
         Events : 271498

         Layout : offset=2
     Chunk Size : 256K

      Number   Major   Minor   RaidDevice State
this     0       8       18        0      active sync   /dev/sdb2

   0     0       8       18        0      active sync   /dev/sdb2
   1     1       0        0        1      faulty removed
   2     2       0        0        2      faulty removed
   3     3       8       66        3      active sync   /dev/sde2
   4     4       8       82        4      active sync   /dev/sdf2
   5     5       8        2        5      active sync   /dev/sda2
/dev/sde2:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
  Creation Time : Fri Aug 14 12:11:48 2015
     Raid Level : raid10
  Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
     Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 1

    Update Time : Thu Sep 19 21:05:16 2019
          State : clean
 Active Devices : 4
Working Devices : 4
 Failed Devices : 2
  Spare Devices : 0
       Checksum : e52ce91f - correct
         Events : 271499

         Layout : offset=2
     Chunk Size : 256K

      Number   Major   Minor   RaidDevice State
this     3       8       66        3      active sync   /dev/sde2

   0     0       8       18        0      active sync   /dev/sdb2
   1     1       0        0        1      faulty removed
   2     2       0        0        2      faulty removed
   3     3       8       66        3      active sync   /dev/sde2
   4     4       8       82        4      active sync   /dev/sdf2
   5     5       8        2        5      active sync   /dev/sda2
/dev/sdf2:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : df4ee56a:547f33ee:32bb33b1:ae294b6e
  Creation Time : Fri Aug 14 12:11:48 2015
     Raid Level : raid10
  Used Dev Size : 1945124864 (1855.02 GiB 1991.81 GB)
     Array Size : 5835374592 (5565.05 GiB 5975.42 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 1

    Update Time : Thu Sep 19 21:05:16 2019
          State : clean
 Active Devices : 4
Working Devices : 4
 Failed Devices : 2
  Spare Devices : 0
       Checksum : e52ce931 - correct
         Events : 271499

         Layout : offset=2
     Chunk Size : 256K

      Number   Major   Minor   RaidDevice State
this     4       8       82        4      active sync   /dev/sdf2

   0     0       8       18        0      active sync   /dev/sdb2
   1     1       0        0        1      faulty removed
   2     2       0        0        2      faulty removed
   3     3       8       66        3      active sync   /dev/sde2
   4     4       8       82        4      active sync   /dev/sdf2
   5     5       8        2        5      active sync   /dev/sda2

