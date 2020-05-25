Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6E71E1808
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgEYXBV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgEYXBU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 19:01:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B096C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 16:01:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x14so13193179wrp.2
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Yupb9jfltJbphQamrb0a8WRXLktYtE41SXYqi+JTpjk=;
        b=Vr3hO/ZSlJ8Pfu8/mrspwkm4LFQaBvTwijzbs7DKi4miFqMmJs9u2EB/AiH5XW+yyW
         ja7jI0UkmPj2wwHfY+x3wHDWVKxRmOvgLh1oPtTa6TC9T9+YFXCCVb9dcbQUmXEpu2I1
         Onh6G/RwRObKCSsRPA0+OraMmWzXbg2fPNdfH5zbzEL8v3dUmgvwE4sClSUrIsPI5Smd
         0voZ0KL5RZKh6kkhD/7DFLBOrH1WwjhXD2sL8amDlPrnkJ9svLahFzsikLjTYTDDXNT1
         DHRvwOu06hpQ8siJRCeU0vyJUgWRTDIcNgfUNQBmZt1+FuaGomqsLnBjjHddHsARU5oq
         qIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Yupb9jfltJbphQamrb0a8WRXLktYtE41SXYqi+JTpjk=;
        b=gqyx+Kf0GEaUZHUihVNYKMjFyUx+BeAAWg6hrboA26jPHu+BKYhiGSTekMfFOmvSpx
         VTRkHECmcAoNbRqUsm/Zht49jKkBLDXO2XtO4h7pq9n16oHy07pBONS22uDZUzVnQ8Gv
         ReR+xa/RcqTSkATxqDTrVDKXBl80l+h4x/dsmKwW6AKfnhzti0IqZnUSR1vWFt3jst3j
         05i7+LIMETzAOroAh5Mwa+IU3c2LKH8FakkGlnUTvaLpmshg37y6y/heUVmr6TvbGIE3
         RjppYL/pV0ms9skB93oZeEgamYtzgTNqhQVTqR4q/lim9o9dou0Kx2Hg2QXnCfMJhWuD
         R2Vw==
X-Gm-Message-State: AOAM5335nHPDYjqtKEW9ehoh6a46fYfB1YHA2rVoHZs6LgTGhQrKc5Ny
        bXZS0aDObUSRgg1qlFoFgJ0AD3gQxe0=
X-Google-Smtp-Source: ABdhPJyz9aKZhh/k8TDRqUBdjLoL2TEbhAl4arv0rglpq+pwlJCAqNycNMK5i5OulHPMSE6+y7+r6A==
X-Received: by 2002:adf:ab4e:: with SMTP id r14mr6678906wrc.147.1590447678760;
        Mon, 25 May 2020 16:01:18 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id i74sm19605561wri.49.2020.05.25.16.01.17
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 16:01:18 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
 <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
 <e1ad56b2-df70-bc6a-9a81-333230d558c2@gmail.com>
 <358e9f6b-a989-0e4a-04c4-6efe2666159f@youngman.org.uk>
 <b5e5c7af-9d1b-3eca-f3a1-f03f8d308015@gmail.com>
 <37636c91-9baf-4565-9849-f8aca54e392e@youngman.org.uk>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <abbe29b4-0837-f8a0-93d3-aecbe7b19655@gmail.com>
Date:   Tue, 26 May 2020 01:01:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <37636c91-9baf-4565-9849-f8aca54e392e@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


> So step 1, revert the reshape. Step 2, get the array back running. 
> Step 3, start the reshape again.

root@nas:~# mdadm --assemble /dev/md0 --force --verbose 
--update=revert-reshape --invalid-backup /dev/sda1 /dev/sdc1 /dev/sdd1 
/dev/sde1 /dev/sdf1
mdadm: looking for devices for /dev/md0
mdadm: /dev/sda1 is identified as a member of /dev/md0, slot 0.
mdadm: /dev/sdc1 is identified as a member of /dev/md0, slot 1.
mdadm: /dev/sdd1 is identified as a member of /dev/md0, slot 2.
mdadm: /dev/sde1 is identified as a member of /dev/md0, slot 3.
mdadm: /dev/sdf1 is identified as a member of /dev/md0, slot 4.
mdadm: clearing FAULTY flag for device 4 in /dev/md0 for /dev/sdf1
mdadm: Marking array /dev/md0 as 'clean'
mdadm: added /dev/sdc1 to /dev/md0 as 1
mdadm: added /dev/sdd1 to /dev/md0 as 2
mdadm: added /dev/sde1 to /dev/md0 as 3
mdadm: added /dev/sdf1 to /dev/md0 as 4
mdadm: added /dev/sda1 to /dev/md0 as 0
mdadm: /dev/md0 has been started with 4 drives and 1 spare.

=======================

WOW!

ok, let´s check the status again:

root@nas:~# mdadm -D /dev/md0
/dev/md0:
            Version : 1.2
      Creation Time : Sun May 17 00:23:42 2020
         Raid Level : raid5
         Array Size : 35156256768 (33527.62 GiB 36000.01 GB)
      Used Dev Size : 11718752256 (11175.87 GiB 12000.00 GB)
       Raid Devices : 4
      Total Devices : 5
        Persistence : Superblock is persistent

      Intent Bitmap : Internal

        Update Time : Mon May 25 16:05:38 2020
              State : clean, resyncing (PENDING)
     Active Devices : 4
    Working Devices : 5
     Failed Devices : 0
      Spare Devices : 1

             Layout : left-symmetric
         Chunk Size : 512K

Consistency Policy : bitmap

               Name : nas:0  (local to host nas)
               UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
             Events : 38602

     Number   Major   Minor   RaidDevice State
        0       8        1        0      active sync   /dev/sda1
        1       8       33        1      active sync   /dev/sdc1
        2       8       49        2      active sync   /dev/sdd1
        4       8       65        3      active sync   /dev/sde1

        5       8       81        -      spare   /dev/sdf1

===================================================

root@nas:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] 
[raid4] [raid10]
md0 : active (auto-read-only) raid5 sda1[0] sdf1[5](S) sde1[4] sdd1[2] 
sdc1[1]
       35156256768 blocks super 1.2 level 5, 512k chunk, algorithm 2 
[4/4] [UUUU]
         resync=PENDING
       bitmap: 0/88 pages [0KB], 65536KB chunk

unused devices: <none>

==================================================

root@nas:~# mount /dev/md0 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md0, 
missing codepage or helper program, or other error.
root@nas:~#


seems the filesystem got a hit. how to proceed now?

