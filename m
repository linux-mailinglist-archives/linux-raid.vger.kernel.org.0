Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD87138DEF
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 10:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMJlG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 04:41:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJlG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 04:41:06 -0500
Received: from [10.11.0.129] ([82.194.117.200]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ml6i2-1jVjbW0TkK-00lYkl for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020
 10:41:02 +0100
To:     linux-raid@vger.kernel.org
From:   Christian Deufel <christian.deufel@inview.de>
Subject: Reassembling Raid5 in degraded state
Message-ID: <54384251-9978-eb99-e7ec-2da35f41566c@inview.de>
Date:   Mon, 13 Jan 2020 10:41:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gcdi+s2tE0tGn6pXC9YzmUr7yTaM7aRYi2to75BRFBQNpKbBYVq
 JNdVx8Cvknsu+SnHbdWPrY99SO9heFtJvmNPRpOODTrSFTtuZHtnPR+Ifi15a4lBGQVwyXh
 E/HMzC9/8x5WOcOve8TqsRFp43SP7zMJA1Ts48n8Ti0m8OGc9yosF3o4Cl8VXQG1uy5MxyQ
 Uv/noB1JA3wDvEmkYciHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WUdbWrHOfGg=:zbu16cCVN9Ra8GH5+R6E7t
 hjJ3+yC4+ToqiaeyaptL8knF+kzz2tHvOTpZXbNZuvmqPQdUfE+icZe1gXQCmGseSTq82dCwa
 VdSsSzsS+q2gG4GsuYI3czgD/S/HX61+KjT9HjAEdKibKYryVdEvbJT9Z4eromylungDYNs1E
 ezahPd6QJvHizE4qEJeuGK4Dq/zhP8ftRHjD4DPu3Io0k9Q4f/tLI/JnfyNkPJzahz0YBFSQL
 lMD2a8CzS57WjQEUJ/c85T8yiqo9u8lYo0CJL3e4JXWiFkWnGKctBi8+Iv79lPkmPycadXnFC
 vEUV0TCMYWblfvuR63EtIUy2ayrVsLhDeNfIlkNihH4/6kw2xHBgpn12y9eSFEUlunda7aRLG
 sWuzjDFkJQhSmDmUWfXf1nMmMzjDFsZRxeAPjeL2UaJ8KOCJqROE2Tr7+Miw8GcobFKx/smwh
 bvCxD3n03wjRysnhqf7PmjUK2ukMwjMvbkQhUz6IbzsauabkBpMlgfrNCDQtYF9GhjYhZvs7w
 iWki9tKXz0m+RusNJy5a3hqSnFuBXLpH2aYLxpvJq7r5NJE5UByqghlswQrcB0EBjSM2YhxL5
 Pv8iexvm4dv7TcwHJVo9uFHjGg9l+/zHG4qM0aRjUeVZCKyjKjCFrDVILI5qIpH2vFedE+UQR
 PYF2ObYLnImoi1sqsQgIA7yOZiAk0oyatXqGWxSaVV2orFPFWY2HvU1tnxfRk3m/cVOCLaEbG
 5S6wEJezXRUXyNmMH1XXDG/AYWtE6onkGa5v+GOHMX+FT/9ha60wGVgw3tOXj0QuhLTQxBf+W
 AfnLATMLvCBvtEOq6J+SXn123VFwFNna0EH9FKFHzGtE9ERXHqhg+ecxLjRsLhGMew0Ta13QW
 6pCk243xWPGVutWtmYTHA576al2Eq0mj6mslUDwkg=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi

I'm having a problem with a 4 disk Raid 5 MD-Array.
After a crash it didn't reassemble correctly, by that I mean it crashed 
during the reassemble, and cat /proc/mdstat reads as follows:

[root@dirvish ~]# cat /proc/mdstat
Personalities : [raid1] [raid0] [raid6] [raid5] [raid4]
...
md3 : inactive sdd1[0] sde1[5] sdf1[3] sdc1[2]
       7814047744 blocks
...

mdadm --examine for the disks in the Raid reads as follows:

[root@dirvish ~]# mdadm -E /dev/sdc1
/dev/sdc1:
           Magic : a92b4efc
         Version : 0.90.00
            UUID : 84b70068:58203635:60d8aaf0:b60ee018
   Creation Time : Mon Feb 28 18:46:58 2011
      Raid Level : raid5
   Used Dev Size : 1953511936 (1863.01 GiB 2000.40 GB)
      Array Size : 5860535808 (5589.04 GiB 6001.19 GB)
    Raid Devices : 4
   Total Devices : 4
Preferred Minor : 3

     Update Time : Wed Jan  8 12:26:35 2020
           State : clean
  Active Devices : 3
Working Devices : 4
  Failed Devices : 1
   Spare Devices : 1
        Checksum : bd93dda1 - correct
          Events : 5995154

          Layout : left-symmetric
      Chunk Size : 64K

       Number   Major   Minor   RaidDevice State
this     2       8       33        2      active sync   /dev/sdc1

    0     0       8       49        0      active sync   /dev/sdd1
    1     1       0        0        1      faulty removed
    2     2       8       33        2      active sync   /dev/sdc1
    3     3       8       81        3      active sync   /dev/sdf1
    4     4       8       65        4      spare   /dev/sde1
[root@dirvish ~]# mdadm -E /dev/sdd1
/dev/sdd1:
           Magic : a92b4efc
         Version : 0.90.00
            UUID : 84b70068:58203635:60d8aaf0:b60ee018
   Creation Time : Mon Feb 28 18:46:58 2011
      Raid Level : raid5
   Used Dev Size : 1953511936 (1863.01 GiB 2000.40 GB)
      Array Size : 5860535808 (5589.04 GiB 6001.19 GB)
    Raid Devices : 4
   Total Devices : 3
Preferred Minor : 3

     Update Time : Wed Jan  8 13:30:15 2020
           State : clean
  Active Devices : 2
Working Devices : 2
  Failed Devices : 2
   Spare Devices : 0
        Checksum : bd93ec60 - correct
          Events : 5995162

          Layout : left-symmetric
      Chunk Size : 64K

       Number   Major   Minor   RaidDevice State
this     0       8       49        0      active sync   /dev/sdd1

    0     0       8       49        0      active sync   /dev/sdd1
    1     1       0        0        1      faulty removed
    2     2       0        0        2      faulty removed
    3     3       8       81        3      active sync   /dev/sdf1
[root@dirvish ~]# mdadm -E /dev/sde1
/dev/sde1:
           Magic : a92b4efc
         Version : 0.90.00
            UUID : 84b70068:58203635:60d8aaf0:b60ee018
   Creation Time : Mon Feb 28 18:46:58 2011
      Raid Level : raid5
   Used Dev Size : 1953511936 (1863.01 GiB 2000.40 GB)
      Array Size : 5860535808 (5589.04 GiB 6001.19 GB)
    Raid Devices : 4
   Total Devices : 3
Preferred Minor : 3

     Update Time : Wed Jan  8 13:30:15 2020
           State : clean
  Active Devices : 2
Working Devices : 2
  Failed Devices : 2
   Spare Devices : 0
        Checksum : bd93ecbd - correct
          Events : 5995162

          Layout : left-symmetric
      Chunk Size : 64K

       Number   Major   Minor   RaidDevice State
this     5       8       65       -1      spare   /dev/sde1

    0     0       8       49        0      active sync   /dev/sdd1
    1     1       0        0        1      faulty removed
    2     2       0        0        2      faulty removed
    3     3       8       81        3      active sync   /dev/sdf1
[root@dirvish ~]# mdadm -E /dev/sdf1
/dev/sdf1:
           Magic : a92b4efc
         Version : 0.90.00
            UUID : 84b70068:58203635:60d8aaf0:b60ee018
   Creation Time : Mon Feb 28 18:46:58 2011
      Raid Level : raid5
   Used Dev Size : 1953511936 (1863.01 GiB 2000.40 GB)
      Array Size : 5860535808 (5589.04 GiB 6001.19 GB)
    Raid Devices : 4
   Total Devices : 3
Preferred Minor : 3

     Update Time : Wed Jan  8 13:30:15 2020
           State : clean
  Active Devices : 2
Working Devices : 2
  Failed Devices : 2
   Spare Devices : 0
        Checksum : bd93ec86 - correct
          Events : 5995162

          Layout : left-symmetric
      Chunk Size : 64K

       Number   Major   Minor   RaidDevice State
this     3       8       81        3      active sync   /dev/sdf1

    0     0       8       49        0      active sync   /dev/sdd1
    1     1       0        0        1      faulty removed
    2     2       0        0        2      faulty removed
    3     3       8       81        3      active sync   /dev/sdf1

My plan now would be to run mdadm --assemble --force /dev/md3 with 3 
disk, to get the Raid going in a degraded state.
Does anyone have any experience in doing so and can recommend which 3 
disks I should use. I would use sdc1 sdd1 and sdf1, since sdd1 and sdf1 
are displayed as active sync in every examine and sdc1 as it is also 
displayed as active sync.
Do you think that by doing it this way I have a chance to get my Data 
back or do you have any other suggestion as to get the Data back and the 
Raid running again?

Greetings
Christian

  -------------------------------------------------------------------
| Christian Deufel
|
|
| inView Groupware und Datentechnik GmbH
| Emmy-Noether-Str.2
| 79110 Freiburg
|
| https://www.inView.de
| christian.deufel@inView.de
| Tel. 0761 - 45 75 48-22
| Fax. 0761 - 45 75 48-99
|
| Amtsgericht Freiburg HRB-6769
| Ust-ID DE 219531868
| Geschäftsführer: Caspar Fromelt, Frank Kopp
  -------------------------------------------------------------------

