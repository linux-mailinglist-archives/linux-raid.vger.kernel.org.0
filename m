Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347FC1751AF
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 03:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBCAm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Mar 2020 21:00:42 -0500
Received: from omta04.suddenlink.net ([208.180.40.74]:37981 "EHLO
        omta04.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBCAm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 1 Mar 2020 21:00:42 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 21:00:40 EST
Received: from [192.168.6.104] (really [66.76.46.195])
          by dalofep02.suddenlink.net
          (InterMail vM.8.04.03.22.02 201-2389-100-169-20190213) with ESMTP
          id <20200302015004.INLG6906.dalofep02.suddenlink.net@[192.168.6.104]>
          for <linux-raid@vger.kernel.org>; Sun, 1 Mar 2020 19:50:04 -0600
To:     mdraid <linux-raid@vger.kernel.org>
From:   "David C. Rankin" <drankinatty@suddenlinkmail.com>
Subject: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable I/O
Openpgp: preference=signencrypt
Autocrypt: addr=drankinatty@suddenlinkmail.com; prefer-encrypt=mutual;
 keydata=
 xsBNBFkinL8BCADU5H9ZxEu+IIMb75pSmVXhW7ujTM7p2TzjZiyTT3Lfbxuoso1rWyAaAti6
 Jyfw2pk0SJYw+8afn1+Ag/BtmSGm7wiuGdpHlDL0e/2sbyCYoFExpFLecgd5+mU+M6GCNUaM
 vZ79BaM2wn+c4r1r0LcPmy7uweHhaVXGlocfMChd2fBweonL2jd4bX64XZbB5YErpkzxFN69
 kM+I4CmkzOaSSLfN6//EUgc2zBKGVJhM6fpZjVE4Wm8S+khvrJwFG0ZoaPC1Ol/b47iyqZcf
 jFZs75i2Tjd3AYyQ6Ai3ZNGrwv2PJSAawR+hfZLeNf5aMaIqoG099SsAN3j8wW97DDjbABEB
 AAHNRERhdmlkIEMuIFJhbmtpbiwgSi5ELixQLkUuICh3aXphcmQpIDxkcmFua2luYXR0eUBz
 dWRkZW5saW5rbWFpbC5jb20+wsCOBBMBCAA4FiEEUoo6wDEaJyRJMG0RyQVv1wIPCIcFAlki
 nL8CGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQyQVv1wIPCId/wgf/b+9BBzhRr2i+
 LDa5qHwlxmRbvQZp9yYzFbJV6s4Djyukir7CGYrzAvuFUWBIFiExBspGdHuQ3b/UA66/uupf
 6DlzRRTs62WMjK9DTZbQfFxqnx+EWCDKbBlXMsaIu/FjtBtc13uOzza967OdE8l2uxUH7+B4
 /S8ReppJ+FXm2pzo4qlq1YYNtX0cd7BymZdn0G2ogeHos2Ay5bYOfiYWFVwb7fnZ54DCsOfb
 H0M9RUIhA5ZKeChsCOAZvtiMMemIr/xihE8Ds7INbtEXxm00o4xgRiWSSJeuoOfeSilHbVjJ
 Ry26E/KhKvkZbcnGCJsQRo8DPq5P/O5UQn0HVvGyTs7ATQRZIpy/AQgAwX/4Z6vfnfWsr8WA
 qV6WYKK8FtIrWXBjEeztxiCAJydMwZkPQRbOJlZElLpZvWLHFp68mbMfrcv23dMJCH+jE5XB
 La/p7XZp10IHzBhedZbI2MBBsnfrqqCdrf0KNPfS9bD6+37ued+O8ONm4ELhzHfjlGojNddB
 vMEu7EQKY19u/X2sINiYvrAOX6ss21E4r4AoVojQqaL7fmrRCD2uI76z7O9zC3mQ0/JpkuEo
 0Yi97H+P3d3qSDb0IovPPyfioMAy7KIGSAYCHzxd47zvkYWlfSEWQ1aenAAvGgqKrZ3/KP9a
 V1ekGimYYIpnT/JJ67DPDx9gKlQD9f1YZVcQvwARAQABwsB2BBgBCAAgFiEEUoo6wDEaJyRJ
 MG0RyQVv1wIPCIcFAlkinL8CGwwACgkQyQVv1wIPCIffjwf/YXoinAWabuqugYxSNafvBcXA
 GEE5arTYSGSXhUWBER1Oz0U5BjeWAKKtan88pHkFrdHYW8su5A6Dn7jDxUWAVjXzRvA0LNbJ
 fKOrBw7knGJSqYQD7gdeBJZOSLf0Mt9g9evkxhR4cLFHG0mWH07H1yIreLNFTs+i0B3tKY44
 P5bsNcAzMwD2G1rJehiFTbxRlAiCc6v61rzu80XaDKLEJFHVYhCJRXrla04DoGZdZKfc6urF
 g/aUn+7z1pO70uumOnKvLViitsJ6IsxAsfhZp4KPBbbkTjixcTPfJAQGzQhcoZS22jGTPg1N
 7G4xtqMT/M34TbodTbaIO0HkA4n1Hw==
Organization: Rankin Law Firm, PLLC
Message-ID: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
Date:   Sun, 1 Mar 2020 19:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at dalofep02.suddenlink.net from [66.76.46.195] using ID drankinatty@suddenlinkmail.com at Sun, 1 Mar 2020 19:50:04 -0600
X-CM-Analysis: v=2.3 cv=L91jvNb8 c=1 sm=1 tr=0 cx=a_idp_d a=/cos1G3ae6AqFCvJLv+j9g==:117 a=/cos1G3ae6AqFCvJLv+j9g==:17 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=A1jyNYAxBm8A:10 a=p2QsaepqAAAA:8 a=0J2z3HuiUpYaYiRbJfQA:9 a=QEXdDO2ut3YA:10 a=j9OoCblBdpqwJjV1eg_H:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-CM-Envelope: MS4wfLv7p125vwY460f1o1rfx0GUhKFDlf3fzBVgMvwLwcH+pUysObL6wji+qCpNoavSkTn3MvNFhvWuYPZjpeaXmqe3iNgCZgT2kgEc9s/HaSW0j3SZ/8CU TV3OAb6zT0PhsEBRABE/MTw0cEKXJABG635YopmHVuEVco56aTV9xSUQBrpCjPVhYHWkUr0d3lLpYQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Mayday....

OS:     Archlinux
Kernel: 5.5
mdadm:  4.1-2
RAID 1: 2-disk 3T on devices sdc, sdd (not on partitions, on device)
        (see mdadm -E on both disks and mdadm -D on array below message)
array:  /dev/md4


  After update to Linux 5.5 kernel, a 2-disk 3T Raid1 on devices /sdc and /sdd
I/O on the array has dropped from ~speed=85166K/sec during scrub to
~speed=2022K/sec with speed as low as speed=737K/sec. There are no errors.
This array takes exacty 5 hours 10 minutes to scrub normally and has for the
past 4 years. The scrub has now been running for over 14 hours (without error)
and is only 2.8% complete, e.g.

cat /proc/mdstat
Personalities : [raid1]
md4 : active raid1 sdc[0] sdd[2]
      2930135488 blocks super 1.2 [2/2] [UU]
      [>....................]  check =  2.8% (82114752/2930135488)
finish=38635.1min speed=1228K/sec
      bitmap: 0/22 pages [0KB], 65536KB chunk
<snip>

  The last 3 months of logging the scrub shows the scrub completing in 5:10
every month (the timestamp is the completion time for the scrub, just subtract
the difference between /dev/md4 and /dev/md2 for the scrub time on /dev/md4):

Dec  1 03:01:02 '/dev/md0' mismatch_cnt = 0
Dec  1 03:10:02 '/dev/md1' mismatch_cnt = 0
Dec  1 07:10:03 '/dev/md2' mismatch_cnt = 0
Dec  1 12:20:03 '/dev/md4' mismatch_cnt = 0
Jan  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Jan  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Jan  1 05:04:02 '/dev/md2' mismatch_cnt = 0
Jan  1 10:14:03 '/dev/md4' mismatch_cnt = 0
Feb  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Feb  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Feb  1 05:01:02 '/dev/md2' mismatch_cnt = 0
Feb  1 10:11:02 '/dev/md4' mismatch_cnt = 0

  After the 5.5 kernel update I have noticed apps such as the virtualbox
guests on the drive becoming unusably slow and thought initiially it was a
problem with Oracle virtualbox and the 5.5 kernel. The iowate is over 99% at
times running top on the Archlinux guest at times, and iostat on the guest shows:

Linux 5.5.5-arch1-1 (vl1)       02/24/2020      _x86_64_        (2 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.14    0.00    0.18   54.55    0.00   45.14

(I have a screenshot of the top wa over 98% if you need that too)

  Originally, I opened a bug with Oracle
https://www.virtualbox.org/ticket/19311, but that has left them scratching
thier head, and it wasn't until my scrub kicked of and I saw that it would
take a month to complete that I snapped to the fact it was a kernel Raid issue.

  I check the scrub regularly and have it log completion of each array.
Checking right at the end of /dev/md2 (the array before before this one starts
scrubbing), all is normal, speed is fine and it completed in normal time:

05:00 valkyrie:~/tmp> cat /proc/mdstat
Personalities : [raid1]
md4 : active raid1 sdc[0] sdd[2]
      2930135488 blocks super 1.2 [2/2] [UU]
      bitmap: 0/22 pages [0KB], 65536KB chunk

md2 : active raid1 sda7[0] sdb7[1]
      921030656 blocks super 1.2 [2/2] [UU]
      [===================>.]  check = 99.8% (919643456/921030656)
finish=0.2min speed=85166K/sec
      bitmap: 2/7 pages [8KB], 65536KB chunk

md1 : active raid1 sda6[0] sdb6[1]
      52396032 blocks super 1.2 [2/2] [UU]

md3 : active raid1 sda8[0] sdb8[1]
      2115584 blocks super 1.2 [2/2] [UU]

md0 : active raid1 sda5[0] sdb5[1]
      511680 blocks super 1.2 [2/2] [UU]

unused devices: <none>

  However, checking at the beginning of /dev/md4, speed plunged to
speed=2022K/sec (What??)

05:00 valkyrie:~/tmp> cat /proc/mdstat
Personalities : [raid1]
md4 : active raid1 sdc[0] sdd[2]
      2930135488 blocks super 1.2 [2/2] [UU]
      [>....................]  check =  0.0% (155712/2930135488)
finish=24141.2min speed=2022K/sec
      bitmap: 0/22 pages [0KB], 65536KB chunk

md2 : active raid1 sda7[0] sdb7[1]
      921030656 blocks super 1.2 [2/2] [UU]
      bitmap: 0/7 pages [0KB], 65536KB chunk

md1 : active raid1 sda6[0] sdb6[1]
      52396032 blocks super 1.2 [2/2] [UU]

md3 : active raid1 sda8[0] sdb8[1]
      2115584 blocks super 1.2 [2/2] [UU]

md0 : active raid1 sda5[0] sdb5[1]
      511680 blocks super 1.2 [2/2] [UU]

unused devices: <none>

  The perplexing problem is I have rolled the Archlinux install back to the
5.4 kenel before this problem originally appeared, but for reasons I cannot
explain, the array remains unusably slow. (I don't know if something was
written that changes the array for Linux 5.5 or what, but there is no question
it was like a switch was thrown on the 5.5 kernel update that crippled this
array, but left the other 3 arrays that are on partitions instead of devices
fine).

  There are no errors logged to the journal, but it is like I/O to this array
is coming through a Dixie Straw and most of the time it is like there is a
race-condition somewhere causing the thing to just sit and spin.

  Here are the mdadm -E and mdadm -D details:

[14:17 valkyrie:/home/david/tmp] # mdadm -E /dev/sdc
/dev/sdc:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 6e520607:f152d8b9:dd2a3bec:5f9dc875
           Name : valkyrie:4  (local to host valkyrie)
  Creation Time : Mon Mar 21 02:27:21 2016
     Raid Level : raid1
   Raid Devices : 2

 Avail Dev Size : 5860271024 (2794.39 GiB 3000.46 GB)
     Array Size : 2930135488 (2794.39 GiB 3000.46 GB)
  Used Dev Size : 5860270976 (2794.39 GiB 3000.46 GB)
    Data Offset : 262144 sectors
   Super Offset : 8 sectors
   Unused Space : before=262056 sectors, after=48 sectors
          State : clean
    Device UUID : e15f0ea7:7e973d0c:f7ae51a1:9ee4b3a4

Internal Bitmap : 8 sectors from superblock
    Update Time : Sun Mar  1 14:18:07 2020
  Bad Block Log : 512 entries available at offset 72 sectors
       Checksum : 62472be - correct
         Events : 8193


   Device Role : Active device 0
   Array State : AA ('A' == active, '.' == missing, 'R' == replacing)
[14:18 valkyrie:/home/david/tmp] # mdadm -E /dev/sdd
/dev/sdd:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 6e520607:f152d8b9:dd2a3bec:5f9dc875
           Name : valkyrie:4  (local to host valkyrie)
  Creation Time : Mon Mar 21 02:27:21 2016
     Raid Level : raid1
   Raid Devices : 2

 Avail Dev Size : 5860271024 (2794.39 GiB 3000.46 GB)
     Array Size : 2930135488 (2794.39 GiB 3000.46 GB)
  Used Dev Size : 5860270976 (2794.39 GiB 3000.46 GB)
    Data Offset : 262144 sectors
   Super Offset : 8 sectors
   Unused Space : before=262056 sectors, after=48 sectors
          State : clean
    Device UUID : f745d11a:c323f477:71f8a0d9:27d8c717

Internal Bitmap : 8 sectors from superblock
    Update Time : Sun Mar  1 14:18:15 2020
  Bad Block Log : 512 entries available at offset 72 sectors
       Checksum : 9101220e - correct
         Events : 8194


   Device Role : Active device 1
   Array State : AA ('A' == active, '.' == missing, 'R' == replacing)
[14:18 valkyrie:/home/david/tmp] # mdadm -D /dev/md4
/dev/md4:
           Version : 1.2
     Creation Time : Mon Mar 21 02:27:21 2016
        Raid Level : raid1
        Array Size : 2930135488 (2794.39 GiB 3000.46 GB)
     Used Dev Size : 2930135488 (2794.39 GiB 3000.46 GB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Sun Mar  1 14:18:32 2020
             State : clean, checking
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : bitmap

      Check Status : 1% complete

              Name : valkyrie:4  (local to host valkyrie)
              UUID : 6e520607:f152d8b9:dd2a3bec:5f9dc875
            Events : 8194

    Number   Major   Minor   RaidDevice State
       0       8       32        0      active sync   /dev/sdc
       2       8       48        1      active sync   /dev/sdd

  A current mdstat (the scrub began at 05:00):

19:39 valkyrie:/home/david/tmp] # cat /proc/mdstat
Personalities : [raid1]
md4 : active raid1 sdc[0] sdd[2]
      2930135488 blocks super 1.2 [2/2] [UU]
      [>....................]  check =  2.8% (84842176/2930135488)
finish=28990.7min speed=1635K/sec
      bitmap: 0/22 pages [0KB], 65536KB chunk

md2 : active raid1 sda7[0] sdb7[1]
      921030656 blocks super 1.2 [2/2] [UU]
      bitmap: 0/7 pages [0KB], 65536KB chunk

md1 : active raid1 sda6[0] sdb6[1]
      52396032 blocks super 1.2 [2/2] [UU]

md3 : active raid1 sda8[0] sdb8[1]
      2115584 blocks super 1.2 [2/2] [UU]

md0 : active raid1 sda5[0] sdb5[1]
      511680 blocks super 1.2 [2/2] [UU]

unused devices: <none>

  Here is the complete scrub log for the past year.

Feb  1 03:07:02 '/dev/md1' mismatch_cnt = 0
Feb  1 05:02:02 '/dev/md2' mismatch_cnt = 0
Feb  1 10:12:03 '/dev/md4' mismatch_cnt = 0
Mar  1 03:01:02 '/dev/md0' mismatch_cnt = 0
Mar  1 03:07:02 '/dev/md1' mismatch_cnt = 0
Mar  1 05:05:02 '/dev/md2' mismatch_cnt = 0
Mar  1 10:15:03 '/dev/md4' mismatch_cnt = 0
Apr  1 03:01:02 '/dev/md0' mismatch_cnt = 0
Apr  1 03:07:02 '/dev/md1' mismatch_cnt = 0
Apr  1 05:03:02 '/dev/md2' mismatch_cnt = 0
Apr  1 10:13:03 '/dev/md4' mismatch_cnt = 0
May  1 03:01:01 '/dev/md0' mismatch_cnt = 0
May  1 03:07:01 '/dev/md1' mismatch_cnt = 0
May  1 05:06:02 '/dev/md2' mismatch_cnt = 0
May  1 10:16:02 '/dev/md4' mismatch_cnt = 0
Jun  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Jun  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Jun  1 05:02:02 '/dev/md2' mismatch_cnt = 0
Jun  1 10:12:02 '/dev/md4' mismatch_cnt = 0
Jul  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Jul  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Jul  1 05:01:02 '/dev/md2' mismatch_cnt = 0
Jul  1 10:11:02 '/dev/md4' mismatch_cnt = 0
Aug  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Aug  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Aug  1 05:01:02 '/dev/md2' mismatch_cnt = 0
Sep  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Sep  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Sep  1 05:01:02 '/dev/md2' mismatch_cnt = 0
Sep  1 10:11:02 '/dev/md4' error: mismatch_cnt = 256
Oct  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Oct  1 03:06:01 '/dev/md1' mismatch_cnt = 0
Oct  1 05:00:02 '/dev/md2' mismatch_cnt = 0
Oct  1 10:10:02 '/dev/md4' error: mismatch_cnt = 128
Nov  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Nov  1 03:06:01 '/dev/md1' mismatch_cnt = 0
Nov  1 05:00:02 '/dev/md2' mismatch_cnt = 0
Nov  1 10:10:02 '/dev/md4' error: mismatch_cnt = 3584
Dec  1 03:01:02 '/dev/md0' mismatch_cnt = 0
Dec  1 03:10:02 '/dev/md1' mismatch_cnt = 0
Dec  1 07:10:03 '/dev/md2' mismatch_cnt = 0
Dec  1 12:20:03 '/dev/md4' mismatch_cnt = 0
Jan  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Jan  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Jan  1 05:04:02 '/dev/md2' mismatch_cnt = 0
Jan  1 10:14:03 '/dev/md4' mismatch_cnt = 0
Feb  1 03:01:01 '/dev/md0' mismatch_cnt = 0
Feb  1 03:07:01 '/dev/md1' mismatch_cnt = 0
Feb  1 05:01:02 '/dev/md2' mismatch_cnt = 0
Feb  1 10:11:02 '/dev/md4' mismatch_cnt = 0

  I need help, I don't know what else to check or what else to send you? I've
tried to think of the most relevant informatation I can provide. I so have
straces between the virtualbox host and guest on that machne if that would
help. There is nothing in the journal to send of any disk error, etc... It's
just like the 5.5 kernel doesn't handle Raid1 on a device (instead of
partition) the same way did before 5.5 that is brining I/O to it's knees.

  Let me know if there is anything else I can send, and let me know if I
should stop the scrub or just let it run. I'm happy to run any diagnostic you
can think of that might help. Thanks.


-- 
David C. Rankin, J.D.,P.E.
