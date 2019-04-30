Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD281EED7
	for <lists+linux-raid@lfdr.de>; Tue, 30 Apr 2019 04:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfD3Ct3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Apr 2019 22:49:29 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:6223 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfD3Ct3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 29 Apr 2019 22:49:29 -0400
Received: from [10.8.0.6] (unknown [88.136.184.21])
        (Authenticated sender: julien.robin28)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id DF01320036C
        for <linux-raid@vger.kernel.org>; Tue, 30 Apr 2019 04:49:19 +0200 (CEST)
Subject: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete) and
 cannot assemble anymore
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
To:     linux-raid@vger.kernel.org
From:   Julien ROBIN <julien.robin28@free.fr>
X-Forwarded-Message-Id: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
Message-ID: <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
Date:   Tue, 30 Apr 2019 04:49:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
Content-Type: multipart/mixed;
 boundary="------------21CC9F886982B82DD75ADC5A"
Content-Language: fr
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This is a multi-part message in MIME format.
--------------21CC9F886982B82DD75ADC5A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi everybody, I need some help to retrieve access to a very Big RAID 
volume, even if remote backups are existing for the most important part 
of the data into it, RAID volume is completely locked but nothing is 
destroyed, so I guess you can help me.

No real change has been written to the disks : the reshape (from 3 to 4 
disk) didn't actually started (it was stuck at 0%). No disk is defective 
and I guess nothing wrong or stupid has been attempted. And no power 
failure.
I saved information that were available into dmesg (some lines below). I 
also used --backup-file=/root/grow_md0.bak but it does not seem to 
contain anything useful (3 149 824 null bytes), or I don't know.

I have a RAID5 array, which was made of 3 disks : /dev/sdb1, /dev/sdd1 
and /dev/sde1
Each one is 8TB

sdc1 is a new disk (I created a GPT partition table and an empty 
partition, like I always did before placing a disk into a RAID). Then I 
played :

   * mdadm --add /dev/md0 /dev/sdc1
   * mdadm --detail /dev/md0 (fine, the new disk was shown as spare)
   * mdadm --grow --raid-devices=4 --backup-file=/root/grow_md0.bak /dev/md0

When playing mdadm --detail /dev/md0, it seemed to be fine, and was 
showing :

     State : clean, reshaping
     Reshape Status : 0% complete

But there was no activity on any disk (just few bytes read when I was 
reading some file), even after 10 minutes (according to bwm-ng and the 
HDD led). This question is exactly what happened to me : 
https://serverfault.com/questions/814025/mdadm-reshape-raid6-does-not-start

So I stopped services that were using the mount point, played umount 
/media/RAID-VOLUME.
Still no activity : I played mdadm --stop /dev/md0 and restarted the 
computer

I can't manage to mount the array anymore, with or without backup file, 
with or without the /dev/sdb1 new disk :

     mdadm --assemble /dev/md0 /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1
     mdadm: Failed to restore critical section for reshape, sorry.

Here is attached the commands and results, and just below, some things 
that are may be useful to re-enable access to the data.

Can someone help me into the recovery of this situation ?
If something risky has to be attempted, I can remove the new disk, 
keeping only 3 drive in place. Then, I would have 2 spare drives (out of 
3) that should be enough to backup at least 2 disks before attempting 
anything risky... Using a 3 disk RAID5, having 2 disk in perfect 
condition should be fine to recover anything, isn't it ?

Thank you in advance !
Julien

Apr 30 02:48:37 Pix-Server-Sorel kernel: [47933.831101] md: bind<sdc1>
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106022] RAID conf printout:
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106025]  --- level:5 
rd:3 wd:3
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106028]  disk 0, o:1, 
dev:sdd1
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106029]  disk 1, o:1, 
dev:sde1
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106031]  disk 2, o:1, 
dev:sdb1
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904011] RAID conf printout:
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904014]  --- level:5 
rd:4 wd:4
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904016]  disk 0, o:1, 
dev:sdd1
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904017]  disk 1, o:1, 
dev:sde1
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904018]  disk 2, o:1, 
dev:sdb1
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904019]  disk 3, o:1, 
dev:sdc1
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904087] md: reshape of 
RAID array md0
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904090] md: minimum 
_guaranteed_  speed: 1000 KB/sec/disk.
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904092] md: using 
maximum available idle IO bandwidth (but not more than 200000 KB/sec) 
for reshape.
Apr 30 02:49:26 Pix-Server-Sorel kernel: [47982.904096] md: using 128k 
window, over a total of 7813894144k.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48773.766672] md: md0: reshape 
interrupted.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48773.827995] md: reshape of 
RAID array md0
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48773.827997] md: minimum 
_guaranteed_  speed: 1000 KB/sec/disk.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48773.827999] md: using 
maximum available idle IO bandwidth (but not more than 200000 KB/sec) 
for reshape.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48773.828021] md: using 128k 
window, over a total of 7813894144k.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.027993] md: md0: reshape 
interrupted.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.112612] md0: detected 
capacity change from 16002855206912 to 0
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.112850] md: md0 stopped.
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.112860] md: unbind<sdc1>
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.132027] md: 
export_rdev(sdc1)
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.132073] md: unbind<sdb1>
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.148016] md: 
export_rdev(sdb1)
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.148261] md: unbind<sde1>
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.164018] md: 
export_rdev(sde1)
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.164268] md: unbind<sdd1>
Apr 30 03:02:37 Pix-Server-Sorel kernel: [48774.200025] md: 
export_rdev(sdd1)



--------------21CC9F886982B82DD75ADC5A
Content-Type: text/plain; charset=UTF-8;
 name="commands-and-results.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="commands-and-results.txt"

cm9vdEBQaXgtU2VydmVyLVNvcmVsOi9ob21lL3VzZXIjIG1kYWRtIC0tYXNzZW1ibGUgL2Rl
di9tZDAgL2Rldi9zZGIxIC9kZXYvc2RjMSAvZGV2L3NkZDEgL2Rldi9zZGUxCm1kYWRtOiBG
YWlsZWQgdG8gcmVzdG9yZSBjcml0aWNhbCBzZWN0aW9uIGZvciByZXNoYXBlLCBzb3JyeS4K
ICAgICAgIFBvc3NpYmx5IHlvdSBuZWVkZWQgdG8gc3BlY2lmeSB0aGUgLS1iYWNrdXAtZmls
ZQpyb290QFBpeC1TZXJ2ZXItU29yZWw6L2hvbWUvdXNlciMgbWRhZG0gLS1zdG9wIC9kZXYv
bWQwCm1kYWRtOiBzdG9wcGVkIC9kZXYvbWQwCnJvb3RAUGl4LVNlcnZlci1Tb3JlbDovaG9t
ZS91c2VyIyBtZGFkbSAtLWFzc2VtYmxlIC9kZXYvbWQwIC9kZXYvc2RiMSAvZGV2L3NkZDEg
L2Rldi9zZGUxCm1kYWRtOiBGYWlsZWQgdG8gcmVzdG9yZSBjcml0aWNhbCBzZWN0aW9uIGZv
ciByZXNoYXBlLCBzb3JyeS4KICAgICAgIFBvc3NpYmx5IHlvdSBuZWVkZWQgdG8gc3BlY2lm
eSB0aGUgLS1iYWNrdXAtZmlsZQpyb290QFBpeC1TZXJ2ZXItU29yZWw6L2hvbWUvdXNlciMg
bWRhZG0gLS1zdG9wIC9kZXYvbWQwCm1kYWRtOiBzdG9wcGVkIC9kZXYvbWQwCnJvb3RAUGl4
LVNlcnZlci1Tb3JlbDovaG9tZS91c2VyIyBtZGFkbSAtLWFzc2VtYmxlIC9kZXYvbWQwIC9k
ZXYvc2RiMSAvZGV2L3NkYzEgL2Rldi9zZGQxIC9kZXYvc2RlMSAtLWJhY2t1cC1maWxlIC9y
b290L2dyb3dfbWQwLmJhawptZGFkbTogRmFpbGVkIHRvIHJlc3RvcmUgY3JpdGljYWwgc2Vj
dGlvbiBmb3IgcmVzaGFwZSwgc29ycnkuCnJvb3RAUGl4LVNlcnZlci1Tb3JlbDovaG9tZS91
c2VyIyBtZGFkbSAtLXN0b3AgL2Rldi9tZDAKbWRhZG06IHN0b3BwZWQgL2Rldi9tZDAKcm9v
dEBQaXgtU2VydmVyLVNvcmVsOi9ob21lL3VzZXIjIG1kYWRtIC0tYXNzZW1ibGUgL2Rldi9t
ZDAgL2Rldi9zZGIxIC9kZXYvc2RkMSAvZGV2L3NkZTEgLS1iYWNrdXAtZmlsZSAvcm9vdC9n
cm93X21kMC5iYWsKbWRhZG06IEZhaWxlZCB0byByZXN0b3JlIGNyaXRpY2FsIHNlY3Rpb24g
Zm9yIHJlc2hhcGUsIHNvcnJ5Lgpyb290QFBpeC1TZXJ2ZXItU29yZWw6L2hvbWUvdXNlciMg
bWRhZG0gLS1leGFtaW5lIC0tc2NhbiAtLXZlcmJvc2UKQVJSQVkgL2Rldi9tZC8wICBsZXZl
bD1yYWlkNSBtZXRhZGF0YT0xLjIgbnVtLWRldmljZXM9NCBVVUlEPTI5M2M2YjZjOmRlNmFi
ZDYxOjBhNTQ2ZjQ2Ojk5OTZiYTE2IG5hbWU9UGl4LVNlcnZlci1Tb3JlbDowCiAgIGRldmlj
ZXM9L2Rldi9zZGMxLC9kZXYvc2RlMSwvZGV2L3NkYjEsL2Rldi9zZGQxCnJvb3RAUGl4LVNl
cnZlci1Tb3JlbDovaG9tZS91c2VyIyBtZGFkbSAtLWV4YW1pbmUgL2Rldi9tZDAKcm9vdEBQ
aXgtU2VydmVyLVNvcmVsOi9ob21lL3VzZXIjIG1kYWRtIC0tZXhhbWluZSAvZGV2L3NkYgov
ZGV2L3NkYjoKICAgTUJSIE1hZ2ljIDogYWE1NQpQYXJ0aXRpb25bMF0gOiAgIDQyOTQ5Njcy
OTUgc2VjdG9ycyBhdCAgICAgICAgICAgIDEgKHR5cGUgZWUpCnJvb3RAUGl4LVNlcnZlci1T
b3JlbDovaG9tZS91c2VyIyBtZGFkbSAtLWV4YW1pbmUgL2Rldi9zZGIxCi9kZXYvc2RiMToK
ICAgICAgICAgIE1hZ2ljIDogYTkyYjRlZmMKICAgICAgICBWZXJzaW9uIDogMS4yCiAgICBG
ZWF0dXJlIE1hcCA6IDB4NQogICAgIEFycmF5IFVVSUQgOiAyOTNjNmI2YzpkZTZhYmQ2MTow
YTU0NmY0Njo5OTk2YmExNgogICAgICAgICAgIE5hbWUgOiBQaXgtU2VydmVyLVNvcmVsOjAg
IChsb2NhbCB0byBob3N0IFBpeC1TZXJ2ZXItU29yZWwpCiAgQ3JlYXRpb24gVGltZSA6IFNh
dCBNYXIgMTcgMjI6MTg6MDIgMjAxOAogICAgIFJhaWQgTGV2ZWwgOiByYWlkNQogICBSYWlk
IERldmljZXMgOiA0CgogQXZhaWwgRGV2IFNpemUgOiAxNTYyNzc4ODI4OCAoNzQ1MS45MSBH
aUIgODAwMS40MyBHQikKICAgICBBcnJheSBTaXplIDogMjM0NDE2ODI0MzIgKDIyMzU1Ljcz
IEdpQiAyNDAwNC4yOCBHQikKICAgIERhdGEgT2Zmc2V0IDogMjYyMTQ0IHNlY3RvcnMKICAg
U3VwZXIgT2Zmc2V0IDogOCBzZWN0b3JzCiAgIFVudXNlZCBTcGFjZSA6IGJlZm9yZT0yNjIw
NTYgc2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzCiAgICAgICAgICBTdGF0ZSA6IGNsZWFuCiAg
ICBEZXZpY2UgVVVJRCA6IDY1NjE1MWM2OmE0NWJkNzM3OmQ2MDk5NjQxOjUyMGVkNDcyCgpJ
bnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBzdXBlcmJsb2NrCiAgUmVzaGFwZSBw
b3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoMy0+NCkKCiAgICBVcGRhdGUgVGltZSA6
IFR1ZSBBcHIgMzAgMDM6MDI6MzcgMjAxOQogIEJhZCBCbG9jayBMb2cgOiA1MTIgZW50cmll
cyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMKICAgICAgIENoZWNrc3VtIDogZThj
YzQzNWEgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6IDgwOTc4CgogICAgICAgICBMYXlv
dXQgOiBsZWZ0LXN5bW1ldHJpYwogICAgIENodW5rIFNpemUgOiA1MTJLCgogICBEZXZpY2Ug
Um9sZSA6IEFjdGl2ZSBkZXZpY2UgMgogICBBcnJheSBTdGF0ZSA6IEFBQUEgKCdBJyA9PSBh
Y3RpdmUsICcuJyA9PSBtaXNzaW5nLCAnUicgPT0gcmVwbGFjaW5nKQpyb290QFBpeC1TZXJ2
ZXItU29yZWw6L2hvbWUvdXNlciMgbWRhZG0gLS1leGFtaW5lIC9kZXYvc2RjMQovZGV2L3Nk
YzE6CiAgICAgICAgICBNYWdpYyA6IGE5MmI0ZWZjCiAgICAgICAgVmVyc2lvbiA6IDEuMgog
ICAgRmVhdHVyZSBNYXAgOiAweDUKICAgICBBcnJheSBVVUlEIDogMjkzYzZiNmM6ZGU2YWJk
NjE6MGE1NDZmNDY6OTk5NmJhMTYKICAgICAgICAgICBOYW1lIDogUGl4LVNlcnZlci1Tb3Jl
bDowICAobG9jYWwgdG8gaG9zdCBQaXgtU2VydmVyLVNvcmVsKQogIENyZWF0aW9uIFRpbWUg
OiBTYXQgTWFyIDE3IDIyOjE4OjAyIDIwMTgKICAgICBSYWlkIExldmVsIDogcmFpZDUKICAg
UmFpZCBEZXZpY2VzIDogNAoKIEF2YWlsIERldiBTaXplIDogMTU2Mjc3ODgyODggKDc0NTEu
OTEgR2lCIDgwMDEuNDMgR0IpCiAgICAgQXJyYXkgU2l6ZSA6IDIzNDQxNjgyNDMyICgyMjM1
NS43MyBHaUIgMjQwMDQuMjggR0IpCiAgICBEYXRhIE9mZnNldCA6IDI2MjE0NCBzZWN0b3Jz
CiAgIFN1cGVyIE9mZnNldCA6IDggc2VjdG9ycwogICBVbnVzZWQgU3BhY2UgOiBiZWZvcmU9
MjYyMDU2IHNlY3RvcnMsIGFmdGVyPTAgc2VjdG9ycwogICAgICAgICAgU3RhdGUgOiBjbGVh
bgogICAgRGV2aWNlIFVVSUQgOiAxYmE5OTc2YzoyNTQ3N2YxYjo0ZDhmMGY2NDo1NzgwYTIx
NwoKSW50ZXJuYWwgQml0bWFwIDogOCBzZWN0b3JzIGZyb20gc3VwZXJibG9jawogIFJlc2hh
cGUgcG9zJ24gOiAwCiAgRGVsdGEgRGV2aWNlcyA6IDEgKDMtPjQpCgogICAgVXBkYXRlIFRp
bWUgOiBUdWUgQXByIDMwIDAzOjAyOjM3IDIwMTkKICBCYWQgQmxvY2sgTG9nIDogNTEyIGVu
dHJpZXMgYXZhaWxhYmxlIGF0IG9mZnNldCA3MiBzZWN0b3JzCiAgICAgICBDaGVja3N1bSA6
IDNhMDI2ZTBlIC0gY29ycmVjdAogICAgICAgICBFdmVudHMgOiA4MDk3OAoKICAgICAgICAg
TGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBTaXplIDogNTEySwoKICAgRGV2
aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDMKICAgQXJyYXkgU3RhdGUgOiBBQUFBICgnQScg
PT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09IHJlcGxhY2luZykKcm9vdEBQaXgt
U2VydmVyLVNvcmVsOi9ob21lL3VzZXIjIG1kYWRtIC0tZXhhbWluZSAvZGV2L3NkZDEKL2Rl
di9zZGQxOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24gOiAx
LjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IDI5M2M2YjZjOmRl
NmFiZDYxOjBhNTQ2ZjQ2Ojk5OTZiYTE2CiAgICAgICAgICAgTmFtZSA6IFBpeC1TZXJ2ZXIt
U29yZWw6MCAgKGxvY2FsIHRvIGhvc3QgUGl4LVNlcnZlci1Tb3JlbCkKICBDcmVhdGlvbiBU
aW1lIDogU2F0IE1hciAxNyAyMjoxODowMiAyMDE4CiAgICAgUmFpZCBMZXZlbCA6IHJhaWQ1
CiAgIFJhaWQgRGV2aWNlcyA6IDQKCiBBdmFpbCBEZXYgU2l6ZSA6IDE1NjI3Nzg4Mjg4ICg3
NDUxLjkxIEdpQiA4MDAxLjQzIEdCKQogICAgIEFycmF5IFNpemUgOiAyMzQ0MTY4MjQzMiAo
MjIzNTUuNzMgR2lCIDI0MDA0LjI4IEdCKQogICAgRGF0YSBPZmZzZXQgOiAyNjIxNDQgc2Vj
dG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2VkIFNwYWNlIDogYmVm
b3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAgICAgIFN0YXRlIDog
Y2xlYW4KICAgIERldmljZSBVVUlEIDogNWIyZjYzMzI6YWRlOGQ0NzA6MmE2Njg3ZWI6NDM4
NmE3YTYKCkludGVybmFsIEJpdG1hcCA6IDggc2VjdG9ycyBmcm9tIHN1cGVyYmxvY2sKICBS
ZXNoYXBlIHBvcyduIDogMAogIERlbHRhIERldmljZXMgOiAxICgzLT40KQoKICAgIFVwZGF0
ZSBUaW1lIDogVHVlIEFwciAzMCAwMzowMjozNyAyMDE5CiAgQmFkIEJsb2NrIExvZyA6IDUx
MiBlbnRyaWVzIGF2YWlsYWJsZSBhdCBvZmZzZXQgNzIgc2VjdG9ycwogICAgICAgQ2hlY2tz
dW0gOiA2YmEwNzI5YyAtIGNvcnJlY3QKICAgICAgICAgRXZlbnRzIDogODA5NzgKCiAgICAg
ICAgIExheW91dCA6IGxlZnQtc3ltbWV0cmljCiAgICAgQ2h1bmsgU2l6ZSA6IDUxMksKCiAg
IERldmljZSBSb2xlIDogQWN0aXZlIGRldmljZSAwCiAgIEFycmF5IFN0YXRlIDogQUFBQSAo
J0EnID09IGFjdGl2ZSwgJy4nID09IG1pc3NpbmcsICdSJyA9PSByZXBsYWNpbmcpCnJvb3RA
UGl4LVNlcnZlci1Tb3JlbDovaG9tZS91c2VyIyBtZGFkbSAtLWV4YW1pbmUgL2Rldi9zZGUx
Ci9kZXYvc2RlMToKICAgICAgICAgIE1hZ2ljIDogYTkyYjRlZmMKICAgICAgICBWZXJzaW9u
IDogMS4yCiAgICBGZWF0dXJlIE1hcCA6IDB4NQogICAgIEFycmF5IFVVSUQgOiAyOTNjNmI2
YzpkZTZhYmQ2MTowYTU0NmY0Njo5OTk2YmExNgogICAgICAgICAgIE5hbWUgOiBQaXgtU2Vy
dmVyLVNvcmVsOjAgIChsb2NhbCB0byBob3N0IFBpeC1TZXJ2ZXItU29yZWwpCiAgQ3JlYXRp
b24gVGltZSA6IFNhdCBNYXIgMTcgMjI6MTg6MDIgMjAxOAogICAgIFJhaWQgTGV2ZWwgOiBy
YWlkNQogICBSYWlkIERldmljZXMgOiA0CgogQXZhaWwgRGV2IFNpemUgOiAxNTYyNzc4ODI4
OCAoNzQ1MS45MSBHaUIgODAwMS40MyBHQikKICAgICBBcnJheSBTaXplIDogMjM0NDE2ODI0
MzIgKDIyMzU1LjczIEdpQiAyNDAwNC4yOCBHQikKICAgIERhdGEgT2Zmc2V0IDogMjYyMTQ0
IHNlY3RvcnMKICAgU3VwZXIgT2Zmc2V0IDogOCBzZWN0b3JzCiAgIFVudXNlZCBTcGFjZSA6
IGJlZm9yZT0yNjIwNTYgc2VjdG9ycywgYWZ0ZXI9MCBzZWN0b3JzCiAgICAgICAgICBTdGF0
ZSA6IGNsZWFuCiAgICBEZXZpY2UgVVVJRCA6IDhjYTg5NDY0OmU0MzUzZGVhOmJkMWE0NWY0
OjhjYzdiOWE1CgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBzdXBlcmJsb2Nr
CiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoMy0+NCkKCiAgICBV
cGRhdGUgVGltZSA6IFR1ZSBBcHIgMzAgMDM6MDI6MzcgMjAxOQogIEJhZCBCbG9jayBMb2cg
OiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMKICAgICAgIENo
ZWNrc3VtIDogMWYwYTJlZTMgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6IDgwOTc4Cgog
ICAgICAgICBMYXlvdXQgOiBsZWZ0LXN5bW1ldHJpYwogICAgIENodW5rIFNpemUgOiA1MTJL
CgogICBEZXZpY2UgUm9sZSA6IEFjdGl2ZSBkZXZpY2UgMQogICBBcnJheSBTdGF0ZSA6IEFB
QUEgKCdBJyA9PSBhY3RpdmUsICcuJyA9PSBtaXNzaW5nLCAnUicgPT0gcmVwbGFjaW5nKQpy
b290QFBpeC1TZXJ2ZXItU29yZWw6L2hvbWUvdXNlciMgY2F0IC9wcm9jL21kc3RhdApQZXJz
b25hbGl0aWVzIDogW2xpbmVhcl0gW211bHRpcGF0aF0gW3JhaWQwXSBbcmFpZDFdIFtyYWlk
Nl0gW3JhaWQ1XSBbcmFpZDRdIFtyYWlkMTBdIAptZDAgOiBpbmFjdGl2ZSBzZGUxWzJdKFMp
IHNkZDFbMF0oUykgc2RiMVszXShTKQogICAgICAyMzQ0MTY4MjQzMiBibG9ja3Mgc3VwZXIg
MS4yCiAgICAgICAKdW51c2VkIGRldmljZXM6IDxub25lPgo=
--------------21CC9F886982B82DD75ADC5A--
