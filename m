Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06601E182B
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgEYXPp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbgEYXPp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 19:15:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF221C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 16:15:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i15so18545382wrx.10
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=l9NzFo6HlU0+lGNvN3zyEwEBVc88s37qBZ0sgzLN9Hw=;
        b=D0tVULUGzecTD2JvdheZbxn8KPC1JFLDeTQdhIu0eqOxeTkDMd/ja0shsc2Ze3DG6w
         ohqKhEOwolqpALdV79UwjPPeT3MwSv7mar+WJNIukgwLrxxJsXkdkW7GDIIWCBS6Rkdw
         YyLIrXib1kbkJniP8vkS7gf2QjtDcPryTHEbGHpW7BQ0KKZbVVgszeWCP6bruf9X+Hv2
         w/lL2IqvQQIVqErcFhu0EvPx7lAfkWmSVFISrOGhPsBY5ScSyCtKTGLHkpGFlxlKZLH1
         2ZZyi47ViR4Z7M0tQMYttgRDl/NPvAZB8RHTxqZTwrcEoCh986iXsfD32P+i8jELUPby
         CKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=l9NzFo6HlU0+lGNvN3zyEwEBVc88s37qBZ0sgzLN9Hw=;
        b=lkiK0snhOGy1xAHnFt8dKHO10hE039RK6iA0vKnMXtkiLHqUP/5omFkWqWNxqKoT4c
         PeM/JQGD0hw2RsFXuIIYZ6axc7bftYtq887LsX5EXBOuHxZygQ/wuoKC00XAo0XZ/ytx
         YUfUKc62RnVEHoYXJ2lxN8qFr/HP+aigCkE/v9PhnCCXUBhLejm0U6Dpl32o9oUpg1PW
         D0LQ0mjoJnneir9up2ZvmDCsDdZ9QFb7LaCqDTYL3fbRgiFqWlocXIxO7/EqJMdG1tkq
         TRcexuC21VrLi04VzsxTo5aQ0sPHWypBeqyUBd3cSdGBmhNKG26B/WaoPZLsW7Cx+6I+
         sJYg==
X-Gm-Message-State: AOAM530UQQf7oqPE55HiPomFjBqP+0H9+th21EZZtW2Eo5iBjnsTbi8+
        XOuJVsTt9OAsKxNfZzEBtLd8IiROs0Y=
X-Google-Smtp-Source: ABdhPJytksKPEHlvfQTjil7G5ax7jZGqKqM42FX+5Ff1KK4/3pkDwVJ/L8L7hBwG8lh8rVVPlKGtwA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr17256738wro.206.1590448543499;
        Mon, 25 May 2020 16:15:43 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id y185sm20026853wmy.11.2020.05.25.16.15.42
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 16:15:42 -0700 (PDT)
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
Message-ID: <333a650e-2345-0e09-b53e-57b6f2e6cc68@gmail.com>
Date:   Tue, 26 May 2020 01:15:41 +0200
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

root@nas:~# mdadm --readwrite /dev/md0
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

        Update Time : Tue May 26 01:13:08 2020
              State : clean
     Active Devices : 4
    Working Devices : 5
     Failed Devices : 0
      Spare Devices : 1

             Layout : left-symmetric
         Chunk Size : 512K

Consistency Policy : bitmap

               Name : nas:0  (local to host nas)
               UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
             Events : 38605

     Number   Major   Minor   RaidDevice State
        0       8        1        0      active sync   /dev/sda1
        1       8       33        1      active sync   /dev/sdc1
        2       8       49        2      active sync   /dev/sdd1
        4       8       65        3      active sync   /dev/sde1

        5       8       81        -      spare   /dev/sdf1
root@nas:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] 
[raid4] [raid10]
md0 : active raid5 sda1[0] sdf1[5](S) sde1[4] sdd1[2] sdc1[1]
       35156256768 blocks super 1.2 level 5, 512k chunk, algorithm 2 
[4/4] [UUUU]
       bitmap: 0/88 pages [0KB], 65536KB chunk

unused devices: <none>

=================================

ok, got a bit too scared :)

it´s now working again. so I can plugin a UPS and restart grow.

guys, thank you all very much for your help.


