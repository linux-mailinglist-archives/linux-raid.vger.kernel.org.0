Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7394F4D
	for <lists+linux-raid@lfdr.de>; Mon, 19 Aug 2019 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfHSUrv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Aug 2019 16:47:51 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44543 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfHSUrv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 19 Aug 2019 16:47:51 -0400
Received: by mail-wr1-f52.google.com with SMTP id p17so10072989wrf.11
        for <linux-raid@vger.kernel.org>; Mon, 19 Aug 2019 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=creamfinance.com; s=google;
        h=from:to:subject:date:message-id:references:mime-version;
        bh=6D0VCl8+DUv2+LIx4CKo3tTlz76xOemLqlmt5BlB/Wo=;
        b=CdDJDKU3KCNzjCe+mXszNyl0WByMeJ+nSOF83yfaYb4B/JUcOgJZK8PUKhcm4hloZ0
         Zrsjqp5tR6W1Cd6LOZuZYGQhDdqt4uqRnuxOSDWgvgwD0Ee2Q1nprxker+geIQZqSeaf
         lIobXvHdBdBzj7KRTQFImb7iIr5PfDhbIhfY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:references
         :mime-version;
        bh=6D0VCl8+DUv2+LIx4CKo3tTlz76xOemLqlmt5BlB/Wo=;
        b=VKFzcXzd5PLdzAZcWZxUCepMPROIWkFE6bHhpbQcA6J4Y0JBgGmbEbVytyEWXrilrf
         ebzTN6txZlIQky8otrL9DN1+cTnSlHjeLlTSrOj9entAtBm4PdU4nNH2UBQfGgCu5HY/
         BVqkjflhyNBuCKEF5oLKLtiEs4Ezn/G8pgESyBIpEAPyhvC6QY0ObzRSsnDK53z9T7Oz
         exr+renHkxkmSIPQPH002EIDW3Xqy36h9860NdH3bgPEMNh6SLIgg/hN0mqrgYqdbBWz
         YItNyAuoQuvId4yp+0tlBilZzcJ5mdTnAXcoD2ROH4BDaQjOP+FbZqOr/LzkFs5sBtQW
         hwwg==
X-Gm-Message-State: APjAAAWZEwjgpT6JTCo1dNkrUz4fy1QsdqG8i//1w/DPYzim2tJCVXo2
        a7UZ06rp//z5IRbyNx+yI+TMwG8nJZkh
X-Google-Smtp-Source: APXvYqz48+AxotDjmSzYO+FBRF8DVS3UOY43lbrO4e5ckmmHoKCJ+8gPzl/0oT0CD3MHt8RoNgU8CQ==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr16778984wrp.150.1566247668543;
        Mon, 19 Aug 2019 13:47:48 -0700 (PDT)
Received: from [10.21.110.2] (ip-185.208.132.9.cf-it.at. [185.208.132.9])
        by smtp.gmail.com with ESMTPSA id e11sm43925973wrc.4.2019.08.19.13.47.47
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 13:47:48 -0700 (PDT)
From:   "Thomas Rosenstein" <thomas.rosenstein@creamfinance.com>
To:     linux-raid@vger.kernel.org
Subject: md-cluster + raid1 and raid0 / clvm
Date:   Mon, 19 Aug 2019 22:47:44 +0200
X-Mailer: MailMate (1.12.5r5643)
Message-ID: <5525707C-4E38-4BC7-AE98-A49AB32994C8@creamfinance.com>
References: <3E14570C-1408-450E-96A1-D82EE80A6394@creamfinance.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I'm trying to provide a bunch of storage based on SAS3 Shared SSD (12x 
WD SS530), so far I have enabled mq-blk and scsi-mq and also md-cluster 
and clvm.

I created 6 raid1 arrays out of the 12 disks and now want to join them.

I have tried CLVM and non-clustered raid0 to get some performance 
numbers, but it seems that as soon as I activate them, the performance 
is abysmal.

For the testing command:

fio --ioengine=libaio --direct=1 --name=test --filename=test --bs=4k 
--iodepth=128 --size=64G --runtime=10000 --readwrite=randwrite 
--numjobs=2
I vary the numjobs (1 - 16) and iodepth (1 - 128) to find the sweet spot 
- this is a purely synthetic benchmark to get what's possible.

Since it affects both mdadm and clvm I might have to post this to both 
lists, but let's start here.

mdadm --create /dev/md20 --metadata=1.2 --level=0 --raid-devices=6 
/dev/md10 /dev/md11 /dev/md12 /dev/md13 /dev/md14 /dev/md15
Since I'm only using it on 1 server, even though it would be available 
on both, I think we are good - btw. I noticed a immense degredation in 
performance when it was mounted on 2 servers (like 90% less)

So, on the RAID10

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=randwrite --numjobs=8

Jobs: 8 (f=8): [w(8)][0.5%][r=0KiB/s,w=228MiB/s][r=0,w=58.2k IOPS][eta 
40m:03s]

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=write --numjobs=8
Jobs: 8 (f=8): [W(8)][0.6%][r=0KiB/s,w=197MiB/s][r=0,w=50.4k IOPS][eta 
37m:41s]


The disks are practically ideling at 10 - 15% utilization, and around 
10k/reqs per raid1 volume, below we see that more is possible - how to 
reach it?

CPU load per process is 20% - it's a 8 core Intel Xeon Silver 4110 with 
256 GB Ram.

on the RAID1

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=randwrite --numjobs=8
Jobs: 8 (f=8): [w(8)][1.5%][r=0KiB/s,w=182MiB/s][r=0,w=46.6k IOPS][eta 
50m:12s]

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=write --numjobs=8
Jobs: 8 (f=8): [W(8)][2.4%][r=0KiB/s,w=609MiB/s][r=0,w=156k IOPS][eta 
13m:08s]


So, the 6x 45k IOPS end up as 58k IOPS, and the sequential read if even 
worse? - something seems wrong!

Let's also check read:

RAID10

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=randread --numjobs=8
Jobs: 8 (f=8): [r(8)][33.3%][r=8015MiB/s,w=0KiB/s][r=2052k,w=0 IOPS][eta 
00m:44s]

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=read --numjobs=8
Jobs: 8 (f=8): [R(8)][7.3%][r=3063MiB/s,w=0KiB/s][r=784k,w=0 IOPS][eta 
02m:57s]

Huch!, What's happening here? For the first test only 700MB/s are 
actually hitting md20 (via iostat -xk), who is caching here with 
DIRECT=1 ?! What's going on??
Second Read test seems okay, but let's check raid1:

RAID1:

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=randread --numjobs=8
Jobs: 8 (f=8): [r(8)][36.4%][r=8178MiB/s,w=0KiB/s][r=2094k,w=0 IOPS][eta 
00m:42s]

fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test 
--filename=test --bs=4k --iodepth=128 --size=64G --runtime=10000 
--readwrite=read --numjobs=8
Jobs: 8 (f=8): [R(8)][30.6%][r=8547MiB/s,w=0KiB/s][r=2188k,w=0 IOPS][eta 
00m:43s]


The same, around 100MB/s hit the disks actually.
I tested this beforehand and the IO was always hitting the disks, until 
I started to play around with raid0 and clvm - how could that influence 
RAID1?

Can someone explain to me what's happening here?
Or how can I analyze what's going on with the RAID0?
What options are there to make it faster - use all disks accordingly?
What options are there to make the RAID1 write faster? (schedulers? 
something? - the disks should do 220k IOPS @4k)

Thanks
Thomas
