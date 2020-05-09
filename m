Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5781E1CC092
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEIKzM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 May 2020 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgEIKzL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 9 May 2020 06:55:11 -0400
Received: from forward100p.mail.yandex.net (forward100p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20DBC061A0C
        for <linux-raid@vger.kernel.org>; Sat,  9 May 2020 03:55:09 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 3D7565980FCD
        for <linux-raid@vger.kernel.org>; Sat,  9 May 2020 13:55:07 +0300 (MSK)
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 3B25FCF40002
        for <linux-raid@vger.kernel.org>; Sat,  9 May 2020 13:55:07 +0300 (MSK)
Received: from vla1-61ce7aa04735.qloud-c.yandex.net (vla1-61ce7aa04735.qloud-c.yandex.net [2a02:6b8:c0d:3e86:0:640:61ce:7aa0])
        by mxback4q.mail.yandex.net (mxback/Yandex) with ESMTP id xL4m35Xv2g-t7cqxJCQ;
        Sat, 09 May 2020 13:55:07 +0300
Received: by vla1-61ce7aa04735.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ds2natQrnd-t6t4pgVl;
        Sat, 09 May 2020 13:55:06 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     linux-raid <linux-raid@vger.kernel.org>
From:   Michal Soltys <msoltyspl@yandex.pl>
Subject: Assemblin journaled array fails
Message-ID: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
Date:   Sat, 9 May 2020 12:54:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Looks like I have now another issue with journaled array that now fails 
to assemble - with related command used to assembly it (whether it would 
be mdadm --incremental called by udev, or manually from commandline) 
hanged and unkillable.

The array was previously running with different journal that was later 
replaced with different better disks. The journal device itself is 
healthy and assembles fine. Assembling (the below dump is when mdadm vis 
udev was doing it):


mdadm -D /dev/md126
/dev/md126:
            Version : 1.1
      Creation Time : Tue Mar  5 19:28:58 2019
         Raid Level : raid5
      Used Dev Size : 18446744073709551615
       Raid Devices : 4
      Total Devices : 5
        Persistence : Superblock is persistent

        Update Time : Sat May  9 09:34:58 2020
              State : active, FAILED, Not Started
     Active Devices : 4
    Working Devices : 5
     Failed Devices : 0
      Spare Devices : 0

             Layout : left-symmetric
         Chunk Size : 512K

Consistency Policy : journal

               Name : xs22:r5_big  (local to host xs22)
               UUID : d5995d76:67d7fabd:05392f87:25a91a97
             Events : 56283

     Number   Major   Minor   RaidDevice State
        -       0        0        0      removed
        -       0        0        1      removed
        -       0        0        2      removed
        -       0        0        3      removed

        -       8      145        3      sync   /dev/sdj1
        -       8      129        2      sync   /dev/sdi1
        -       9      127        -      spare   /dev/md/xs22:r1_journal_big
        -       8      113        1      sync   /dev/sdh1
        -       8       97        0      sync   /dev/sdg1



mdadm -Esv:

ARRAY /dev/md/r1_journal_big  level=raid1 metadata=1.1 num-devices=2 
UUID=c18b3996:49b21f49:3ee18e92:a8240f7f name=xs22:r1_journal_big
    devices=/dev/sdv1,/dev/sdu1
ARRAY /dev/md/r5_big  level=raid5 metadata=1.1 num-devices=4 
UUID=d5995d76:67d7fabd:05392f87:25a91a97 name=xs22:r5_big
    spares=1 
devices=/dev/md/xs22:r1_journal_big,/dev/sdg1,/dev/sdh1,/dev/sdj1,/dev/sdi1


When I was changing journal some time ago (successfully, everything was 
working fine afterwards) this is what I did:

echo [write-through] >/sys/md126/md/journal_mode
mdadm /dev/md126 --fail /dev/md/r1_journal_big --remove 
/dev/md/r1_journal_big
echo resync >/sys/md126/md/consistency_policy

# here i created new journal from new disks, the name was the same

mdadm --readonly /dev/md126
mdadm /dev/md126 --add-journal /dev/md/r1_journal_big
echo [write-back] >/sys/md126/md/journal_mode
# At this point mdadm confirmed everything went fine

After the reboot I'm in the situation as outlined above. Any suggestion 
how to assemble this array now ?
