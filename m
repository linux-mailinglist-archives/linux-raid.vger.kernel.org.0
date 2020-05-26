Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F181F1E18F5
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 03:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbgEZBQk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 21:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbgEZBQj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 21:16:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F7C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 18:16:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e1so18773229wrt.5
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 18:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=sZdnq4HwIBN4D7zDs8Iaf75CHRc0eT27/q5BpO4Iu3Y=;
        b=X8vHgmh3DtPOvI7XIicsgMtAsrbKJZzVUWPPB8xSmaMi7zgk6JSnLjTiGSJXpEgGHW
         6vDfX+9lrNP6ygGGGjraygeEH5mMaYiDEPR7SniGEHQNevCDCsBgEF9S6efNdCpqaO0F
         ggZPQTlXY1vYxCtANr+jP3o+IcLsLTyXKBeTyub6u46vsGFlRe+hJd+JvnuwF0ezBsiV
         nq/6Oy3jv5nO2RXBX2sCoccKRLELYTrW34zqUqRLSOICgeawzIeysC0NsQ2gdqnYYZHQ
         7+dcIBsiVS+5MviSCHQ1X+TFaOBjOzFECTC9UA6QBf8Kf/sWeXs4mgjiYBkE/Vq0fK3w
         S7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sZdnq4HwIBN4D7zDs8Iaf75CHRc0eT27/q5BpO4Iu3Y=;
        b=gAhXEikQq8vs6dARMgQUVYnk9IJ3eXuanXBLm6G1qFmwm0Qe3LixA3UXaDbhMmN5lX
         GYr2yb1h6MOmxxux3LNjCpVUgL7HWw1+fl0z6Cizp7L1kgp7LIkfpdtwl9JjYiNgrPF3
         StDfDNKOCkBoe6pEOzNeRaMMEXbyB74atf9sVsqEiy7bzAJQkx+IIrUdeSbGMw+FMnw0
         rak2ckZ5Y5mi2wmzvKkRWaS/NC/a0qUSpbaShsTtvm78p04Z0mMsz0hWi5F0wy8JsFSR
         r0SKF84hDeSWSb/esF9xcIn3Wi5nUI7kfNY+Nx2pt4QISLcE6m7350aicDm6OfgNcifc
         7UWQ==
X-Gm-Message-State: AOAM5325GeG7ZZQ2YzqwLMzf2nkVtbF1Gz+45cnQwR5ge08zn8u7IApk
        4oCdu9e8GfhoVEQk0FVuRpYh0qX3l9A=
X-Google-Smtp-Source: ABdhPJxbCvAXCy5X+wKpjxEVQ074VWzdoAtPVCYFg3G7kNRlufakVoNucAzKwISpgeHklU+oRZfA7Q==
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr17918179wrv.205.1590455796661;
        Mon, 25 May 2020 18:16:36 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id h1sm20883125wme.42.2020.05.25.18.16.36
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 18:16:36 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
To:     linux-raid@vger.kernel.org
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
Message-ID: <30b23c20-d16e-95d4-4460-96137ba4faa5@gmail.com>
Date:   Tue, 26 May 2020 03:16:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <37636c91-9baf-4565-9849-f8aca54e392e@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Finally, the solution:

as mentioned earlier, I reverted the reshape

mdadm --assemble /dev/md0 --force --verbose --update=revert-reshape 
--invalid-backup /dev/sda1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1

This restarted the md auto-read-only. So I had to manually start the md

mdadm --readwrite /dev/md0

which resulted in bad superblock.

mke2fs won´t work here, because it´s limited to 16TB of diskspace, where 
my md is 36TiB big. Because I´m a bit lazy to google some more, I 
started gparted at the machine, choosed the md0 und initiated filesystem 
integrity check.

This took 5 minutes, afterwards I was able to mount my md.

So I unmounted the md again in order to grow it again:

root@nas:~# mdadm --grow --raid-devices=5 /dev/md0 
--backup-file=/tmp/bu_neu.bak
mdadm: Need to backup 6144K of critical section..
root@nas:~# mdadm -D /dev/md0
/dev/md0:
            Version : 1.2
      Creation Time : Sun May 17 00:23:42 2020
         Raid Level : raid5
         Array Size : 35156256768 (33527.62 GiB 36000.01 GB)
      Used Dev Size : 11718752256 (11175.87 GiB 12000.00 GB)
       Raid Devices : 5
      Total Devices : 5
        Persistence : Superblock is persistent

      Intent Bitmap : Internal

        Update Time : Tue May 26 02:08:22 2020
              State : clean, reshaping
     Active Devices : 5
    Working Devices : 5
     Failed Devices : 0
      Spare Devices : 0

             Layout : left-symmetric
         Chunk Size : 512K

Consistency Policy : bitmap

     Reshape Status : 0% complete
      Delta Devices : 1, (4->5)

               Name : nas:0  (local to host nas)
               UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
             Events : 38631

     Number   Major   Minor   RaidDevice State
        0       8        1        0      active sync   /dev/sda1
        1       8       33        1      active sync   /dev/sdc1
        2       8       49        2      active sync   /dev/sdd1
        4       8       65        3      active sync   /dev/sde1
        5       8       81        4      active sync   /dev/sdf1
root@nas:~#

As we see in mdadm details, reshaping is running. Have a look at mdstat:

root@nas:~# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4] [linear] [multipath] [raid0] 
[raid1] [raid10]
md0 : active raid5 sda1[0] sdf1[5] sde1[4] sdd1[2] sdc1[1]
       35156256768 blocks super 1.2 level 5, 512k chunk, algorithm 2 
[5/5] [UUUUU]
       [>....................]  reshape =  0.8% (93989376/11718752256) 
finish=8260.4min speed=23454K/sec
       bitmap: 0/88 pages [0KB], 65536KB chunk

unused devices: <none>

Seems to be a bit slowly right now. I had expected a speed arount 
60MByte due to 6G-Sata drives. However.. it´s running again.

I will dig into speed later.

Again: Thanks to everyone who helped me with ideas and / or advice. You 
guys saved my ass :)

