Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3053312CC17
	for <lists+linux-raid@lfdr.de>; Mon, 30 Dec 2019 04:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfL3DRJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Dec 2019 22:17:09 -0500
Received: from mail.freakix.de ([89.238.76.166]:52307 "EHLO mail.freakix.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfL3DRJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 29 Dec 2019 22:17:09 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Dec 2019 22:17:09 EST
Received: from Norberts-MacBook-Pro.fritz.box (unknown [37.120.66.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.freakix.de (Postfix) with ESMTPSA id 79316E8C77
        for <linux-raid@vger.kernel.org>; Mon, 30 Dec 2019 04:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=freakix.de; s=mail;
        t=1577675478; bh=hherEhRUJU8gvLUmroO1GuCx9tQ4MF9UK1wWo0n0UxU=;
        h=To:From:Subject:Date:From;
        b=OMhAOUtfFa5lPmJJXrortuvPT39FH/a8w4PS0IKILvSwkANvj9VXKjIKRluyGwlNO
         Oq5OTMvclJ2WFp55sxovWxjLLIJDp9hMVdQwDF9vyPqboo6v8eyJu949N7tWn34mCh
         vc5HHQhyohXNyxKFxmLwkj9DTe27XiCBUf19UKcc=
To:     linux-raid@vger.kernel.org
From:   Norbert Weinhold <lrko@freakix.de>
Subject: md*_raid5 keeps writing to disks
Message-ID: <0930b5c8-17b7-39fb-b6e6-10689a23aa1c@freakix.de>
Date:   Mon, 30 Dec 2019 04:11:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I currently experience a "problem" with a raid5 I built. As soon as I have mounted the filesystem on it (ext4)
a md127_raid5 process will do writes every few seconds to all the members:

md127_raid5(4044): WRITE block 16 on sdb1 (8 sectors)
md127_raid5(4044): WRITE block 16 on sdc1 (8 sectors)
md127_raid5(4044): WRITE block 16 on sda1 (8 sectors)
md127_raid5(4044): WRITE block 16 on sdg1 (8 sectors)
md127_raid5(4044): WRITE block 16 on sdh1 (8 sectors)
md127_raid5(4044): WRITE block 8 on sdb1 (1 sectors)
md127_raid5(4044): WRITE block 8 on sdc1 (1 sectors)
md127_raid5(4044): WRITE block 8 on sda1 (1 sectors)
md127_raid5(4044): WRITE block 8 on sdg1 (1 sectors)
md127_raid5(4044): WRITE block 8 on sdh1 (1 sectors)

Disabling the journal of the filesystem does not make a difference. Same for changing the bitmap to none for
the RAID. I'm wondering what is happening here that keeps my drives active. This only stops when unmounting
the filesystem. There are no logged writes/reads to the md devices itself at the same time.

I'm currently running Kernel 4.9.0-11

/dev/md127:
        Version : 1.2
  Creation Time : Sat Dec 21 22:20:21 2019
     Raid Level : raid5
     Array Size : 19534553088 (18629.60 GiB 20003.38 GB)
  Used Dev Size : 4883638272 (4657.40 GiB 5000.85 GB)
   Raid Devices : 5
  Total Devices : 5
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Mon Dec 30 03:31:26 2019
          State : clean
 Active Devices : 5
Working Devices : 5
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 512K

           Name : mediapc:myraid5  (local to host mediapc)
           UUID : 386efd19:1cc165f6:937ac197:810a3afa
         Events : 68301

    Number   Major   Minor   RaidDevice State
       0       8      113        0      active sync   /dev/sdh1
       1       8       97        1      active sync   /dev/sdg1
       3       8        1        2      active sync   /dev/sda1
       5       8       17        3      active sync   /dev/sdb1
       4       8       33        4      active sync   /dev/sdc1

Thanks,
Norbert
