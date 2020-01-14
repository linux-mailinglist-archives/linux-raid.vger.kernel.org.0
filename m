Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC513A869
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANL2O (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 06:28:14 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANL2N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jan 2020 06:28:13 -0500
Received: from [10.11.0.129] ([82.194.117.200]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwwuJ-1jbkzN3YQV-00yPGH; Tue, 14 Jan 2020 12:28:06 +0100
To:     linux-raid <linux-raid@vger.kernel.org>,
        Wols Lists <antlists@youngman.org.uk>
From:   Christian Deufel <christian.deufel@inview.de>
Subject: Re: Reassembling Raid5 in degraded state
Message-ID: <13b11d17-a23a-3063-70cb-de63d9fa7d09@inview.de>
Date:   Tue, 14 Jan 2020 12:28:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bE3aI60c9iNK0k0kGM5CjkzZac6MHcc8QCKvODTAREtmRasxv+l
 oC0kagq8YPJa46xOo6IkmZjUknJrIB4V6TVBMxhYfJJXRFg8luWHmerJpKp+QWiyaC3z/Dn
 XaChX/jlgofdFIdz37cL/t/lohZ5xN6NpWzH1l3MR9CHTQQbFlDqUYwHcReAvEgIjCV5FIn
 Xz1o3A5EigHp39UxoC2kA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2S/gJmJbE8=:9ucJ4+qAk5KAa5xokyR0We
 j6OieosuX/EWpvDsniBtu+ssG51ZC+0R9Ps6YdUstOsl9TarZOmQmSm6MfUI8HRJMNjbnskFa
 eUGBjXDL0LmhG3bH4Al+597INArJt2Wv7HljOnItd9jjuT0TeFf63BXI0Moho0JDJTOG7/cdo
 5iHvdsPu/pwURV22oi8AevVuUz5hYdKQfjbDbrSaeReMvzxnq40trekXBAuPY9TIiX79uRnz8
 /eMr1CwYFmYr91yo0biQoNlvLugA9Djai8g1cpAL1uiiKeDwXJklzBA0ey4zmlS2y1SXTkyW/
 7YnwVXHda7QH4ejfi129CUJAcJjCHtnDmpeRbo6ivHtEmI7CBwke2LRozEtofVEUnjpvjbTBY
 e/BP56y+er8Jwi4uUwod3I4hnwfD6/zTSdcHaJEZ7q/21z7pwmZn88pVsXloZ0Yo8dtGGuWqO
 50nyd5VvUlKLR0tKwUfo+J6k/MMSYp9LRFFxTkff+NRjKMtnSsmSvU0XcoDn6wvi3JvT+O5Pp
 SeSUjU9iR6FquHCIXr2pcC3xnrDPudjVkjD2DfFGOPNg6zHRHEhXyTNYkWT9r/laoWvVasNhV
 +xKFHoA4TgiCf1702lejNEe0tFRn2qvZmwHpEa38Yd1wn65ZKBexdPwnDRxilaADwQviIAIkc
 8iI61RWTVHuRvBPfHReiY3Je6G+S0RHK29hnEglfKR6aSo/ufN/iyuSIZuPGtqeRNHmqD16IK
 pyCvNHaWAkl2GS3bAy7oEZ0augJ+c1+weH3pqU6WhNsFIupyzfFL3IV+q95+Hgx8rMoqDq8nQ
 Cg9zrUOgfcMdekuocA2g6S+BE44MtD4wZSFnNUoo/EjHqPdrv1X1BAvpej5uiBiXJXpWu03DH
 WdwVXC/orHUtoLS2WecLsEzy8zXVBGOkwUhbenZnc=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hey Wol

 > My plan now would be to run mdadm --assemble --force /dev/md3 with 3
 > disk, to get the Raid going in a degraded state.

 >Yup, this would almost certainly work. I would recommend overlays and
 >running a fsck just to check it's all okay before actually doing it on
 >the actual disks. The event counts say to me that you'll probably lose
 >little to nothing.

So as I was trying to reassemble my Raid it crashed again. But this time 
sdc vanished.

I get the following output:

[root@dirvish ~]# mdadm --stop /dev/md3
mdadm: stopped /dev/md3
[root@dirvish ~]# mdadm --assemble --force /dev/md3 /dev/sdc1 /dev/sdd1 
/dev/sdf            1
mdadm: forcing event count in /dev/sdc1(2) from 5995154 upto 5995162
mdadm: clearing FAULTY flag for device 0 in /dev/md3 for /dev/sdc1
mdadm: failed to add /dev/sdc1 to /dev/md3: Invalid argument
mdadm: /dev/md3 assembled from 2 drives - not enough to start the array.

and when I checked with fdisk sdc wasn't there anymore.

[root@dirvish ~]# fdisk -l

Disk /dev/sda: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          13      104391   fd  Linux raid 
autodetect
/dev/sda2              14         535     4192965   fd  Linux raid 
autodetect
/dev/sda3             536       30401   239898645   fd  Linux raid 
autodetect

Disk /dev/sdb: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sdb1   *           1          13      104391   fd  Linux raid 
autodetect
/dev/sdb2              14         535     4192965   fd  Linux raid 
autodetect
/dev/sdb3             536       30401   239898645   fd  Linux raid 
autodetect

Disk /dev/sdd: 2000.3 GB, 2000398934016 bytes
255 heads, 63 sectors/track, 243201 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sdd1   *           1      243201  1953512001   fd  Linux raid 
autodetect

Disk /dev/sde: 2000.3 GB, 2000398934016 bytes
255 heads, 63 sectors/track, 243201 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sde1   *           1      243201  1953512001   fd  Linux raid 
autodetect

Disk /dev/sdf: 2000.3 GB, 2000398934016 bytes
255 heads, 63 sectors/track, 243201 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/sdf1               1      243201  1953512001   83  Linux

...

After a reboot of the system sdc was back again but vanished again after 
I retried the assembly.

Would the assembly also work with my 4th HDD, sde1 although in the mdadm 
--eaxmine it is labeld as spare?

Greetings

Christian


