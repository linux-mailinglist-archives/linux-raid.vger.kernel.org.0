Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121848016C
	for <lists+linux-raid@lfdr.de>; Fri,  2 Aug 2019 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393600AbfHBTw7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 2 Aug 2019 15:52:59 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40467 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732050AbfHBTw7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 2 Aug 2019 15:52:59 -0400
Received: from [10.0.101.109] (unknown [62.214.191.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7F5DE201A3C37;
        Fri,  2 Aug 2019 21:52:56 +0200 (CEST)
Subject: Re: Kernel 4.14 + has 100 times higher IO latency than Kernel 4.4
 with raid1
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de>
Date:   Fri, 2 Aug 2019 21:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Jinpu,


On 02.08.19 16:48, Jinpu Wang wrote:

> We found a problem regarding much higher IO latency when running
> kernel 4.4.131 compare to 4.14.133, tried with latest upstream
> 5.3-rc2, same result.
> 
> Reproducer:
> 1 create md raid1 with 2 ram disks:
> sudo mdadm -C /dev/md0 -l1 -n2 -e1.2 --bitmap=internal /dev/ram[0-1]
> 2 run fio command with rate_iops:
> fio  --rw=write --ioengine=libaio --iodepth=32  --size=1000MB
> --rate_iops=5000 --direct=1 --numjobs=1 --runtime=20 --time_based
> --name=write-test --filename=/dev/md0
> 
> result on 4.4 kernel:
> root@ib2:~# fio  --rw=write --ioengine=libaio --iodepth=32
> --size=1000MB --rate_iops=5000 --direct=1 --numjobs=1 --runtime=20
> --time_based --name=write-test --filename=/dev/md0
> write-test: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
> fio-2.2.10
> Starting 1 process
> Jobs: 1 (f=1), CR=5000/0 IOPS: [W(1)] [100.0% done] [0KB/20008KB/0KB
> /s] [0/5002/0 iops] [eta 00m:00s]
> write-test: (groupid=0, jobs=1): err= 0: pid=3351: Fri Aug  2 15:31:26 2019
>    write: io=400004KB, bw=19999KB/s, iops=4999, runt= 20001msec
>      slat (usec): min=3, max=26, avg= 3.12, stdev= 0.36
>      clat (usec): min=0, max=116, avg= 2.04, stdev= 1.33
>       lat (usec): min=3, max=141, avg= 5.19, stdev= 1.39
>      clat percentiles (usec):
>       |  1.00th=[    1],  5.00th=[    2], 10.00th=[    2], 20.00th=[    2],
>       | 30.00th=[    2], 40.00th=[    2], 50.00th=[    2], 60.00th=[    2],
>       | 70.00th=[    2], 80.00th=[    2], 90.00th=[    2], 95.00th=[    3],
>       | 99.00th=[    3], 99.50th=[    3], 99.90th=[    3], 99.95th=[    3],
>       | 99.99th=[   86]
>      bw (KB  /s): min=20000, max=20008, per=100.00%, avg=20005.54, stdev= 3.74
>      lat (usec) : 2=3.37%, 4=96.60%, 10=0.01%, 20=0.01%, 50=0.01%
>      lat (usec) : 100=0.01%, 250=0.01%
>    cpu          : usr=4.25%, sys=0.00%, ctx=198550, majf=0, minf=11
>    IO depths    : 1=100.0%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=0.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       issued    : total=r=0/w=100001/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>       latency   : target=0, window=0, percentile=100.00%, depth=32
> 
> Run status group 0 (all jobs):
>    WRITE: io=400004KB, aggrb=19999KB/s, minb=19999KB/s, maxb=19999KB/s,
> mint=20001msec, maxt=20001msec
> 
> Disk stats (read/write):
>      md0: ios=61/99539, merge=0/0, ticks=0/0, in_queue=0, util=0.00%,
> aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0,
> aggrutil=0.00%
> 
> result on 5.3 kernel
> root@ib1:/home/jwang# fio  --rw=write --ioengine=libaio --iodepth=32
> --size=1000MB --rate_iops=5 --direct=1 --numjobs=1 --runtime=20
> --time_based --name=write-test --filename=/dev/md0
> write-test: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
> fio-2.2.10
> Starting 1 process
> Jobs: 1 (f=1), CR=5/0 IOPS: [W(1)] [100.0% done] [0KB/20KB/0KB /s]
> [0/5/0 iops] [eta 00m:00s]
> write-test: (groupid=0, jobs=1): err= 0: pid=1651: Fri Aug  2 17:16:18 2019
>    write: io=413696B, bw=20683B/s, iops=5, runt= 20001msec
>      slat (usec): min=2, max=51803, avg=1028.62, stdev=7250.96
>      clat (usec): min=0, max=91, avg=17.76, stdev=28.07
>       lat (usec): min=3, max=51892, avg=1046.50, stdev=7254.89
>      clat percentiles (usec):
>       |  1.00th=[    0],  5.00th=[    0], 10.00th=[    0], 20.00th=[    0],
>       | 30.00th=[    1], 40.00th=[    1], 50.00th=[    1], 60.00th=[    1],
>       | 70.00th=[   19], 80.00th=[   44], 90.00th=[   68], 95.00th=[   80],
>       | 99.00th=[   88], 99.50th=[   91], 99.90th=[   91], 99.95th=[   91],
>       | 99.99th=[   91]
>      bw (KB  /s): min=   20, max=   21, per=100.00%, avg=20.04, stdev= 0.21
>      lat (usec) : 2=67.33%, 10=0.99%, 20=1.98%, 50=11.88%, 100=17.82%
>    cpu          : usr=0.00%, sys=0.00%, ctx=77, majf=0, minf=10
>    IO depths    : 1=68.3%, 2=2.0%, 4=4.0%, 8=7.9%, 16=15.8%, 32=2.0%, >=64=0.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       issued    : total=r=0/w=101/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>       latency   : target=0, window=0, percentile=100.00%, depth=32
> 
> Run status group 0 (all jobs):
>    WRITE: io=404KB, aggrb=20KB/s, minb=20KB/s, maxb=20KB/s,
> mint=20001msec, maxt=20001msec
> 
> Disk stats (read/write):
>      md0: ios=0/100, merge=0/0, ticks=0/0, in_queue=0, util=0.00%,
> aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0,
> aggrutil=0.00%
>    ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
>    ram1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
> 
> During the tests the following kernel parameters are applied:
> processor.max_cstate=0 idle=poll mitigations=off
> 
> Could anyone give us a hint, what could lead to such a huge difference?

Sorry, I have no idea, but as you can easily reproduce it with RAM 
disks, bisecting the commit causing this quite easily.

Your tests should also be added to some test suite (kselftest)?


Kind regards,

Paul
