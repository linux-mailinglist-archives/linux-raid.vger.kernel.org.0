Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71ABD6C63
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 02:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJOAPF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 20:15:05 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:41174
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfJOAPF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 14 Oct 2019 20:15:05 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <linux-raid@m.gmane.org>)
        id 1iKAUQ-000KfN-0U
        for linux-raid@vger.kernel.org; Tue, 15 Oct 2019 02:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-raid@vger.kernel.org
From:   Curtis Vaughan <curtis@npc-usa.com>
Subject: Degraded RAID1
Date:   Mon, 14 Oct 2019 23:56:17 -0000 (UTC)
Message-ID: <qo31v1$31rr$2@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.145 (Duplicitous mercenary valetism; d7e168a
 git.gnome.org/pan2)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have reason to believe one HD in a RAID1 is dying. But I'm trying to 
understand what the logs and results of various commands are telling me. 
Searching on the Internet is very confusing. BTW, this is for and Ubuntu 
Server 18.04.2 LTS.

It seems to me that the following information is telling me on device is 
missing. It would seem to me that sda is gone.

Anyhow, for example, I received an email:

A DegradedArray event had been detected on md device /dev/md0.

Faithfully yours, etc.

P.S. The /proc/mdstat file currently contains the following:

Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] 
[raid4] [raid10] 
md1 : active raid1 sdb2[1]
      968949696 blocks [2/1] [_U]
      
md0 : active raid1 sdb1[1]
      7811008 blocks [2/1] [_U]
      
unused devices: <none>


Looking at the logs:
[    3.305090] md: kicking non-fresh sda2 from array!
[    3.314209] md: kicking non-fresh sda1 from array!
[    3.337251] md/raid1:md1: active with 1 out of 2 mirrors
[    3.337270] md/raid1:md0: active with 1 out of 2 mirrors
[    3.337296] md1: detected capacity change from 0 to 992204488704
[    3.337305] md0: detected capacity change from 0 to 7998472192



The following command hopefully provides more info:

mdadm --examine /dev/sdb*
/dev/sdb:
   MBR Magic : aa55
Partition[0] :     15622144 sectors at         2048 (type fd)
Partition[1] :   1937899520 sectors at     15624192 (type fd)
/dev/sdb1:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : 7414ac79:580af0ce:e6bbe02b:915fa44a
  Creation Time : Wed Jul 18 15:00:44 2012
     Raid Level : raid1
  Used Dev Size : 7811008 (7.45 GiB 8.00 GB)
     Array Size : 7811008 (7.45 GiB 8.00 GB)
   Raid Devices : 2
  Total Devices : 1
Preferred Minor : 0

    Update Time : Mon Oct 14 16:28:54 2019
          State : clean
 Active Devices : 1
Working Devices : 1
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 9b89db2a - correct
         Events : 417


      Number   Major   Minor   RaidDevice State
this     1       8       17        1      active sync   /dev/sdb1

   0     0       0        0        0      removed
   1     1       8       17        1      active sync   /dev/sdb1
/dev/sdb2:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : ac37ca92:939d7053:3b802bf3:08298597
  Creation Time : Wed Jul 18 15:00:53 2012
     Raid Level : raid1
  Used Dev Size : 968949696 (924.06 GiB 992.20 GB)
     Array Size : 968949696 (924.06 GiB 992.20 GB)
   Raid Devices : 2
  Total Devices : 1
Preferred Minor : 1

    Update Time : Mon Oct 14 16:39:46 2019
          State : clean
 Active Devices : 1
Working Devices : 1
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 1418e24f - correct
         Events : 46734


      Number   Major   Minor   RaidDevice State
this     1       8       18        1      active sync   /dev/sdb2

   0     0       0        0        0      removed
   1     1       8       18        1      active sync   /dev/sdb2

