Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3BA1E4720
	for <lists+linux-raid@lfdr.de>; Wed, 27 May 2020 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgE0PRW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 May 2020 11:17:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbgE0PRV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 27 May 2020 11:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590592639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=542pn8U9TAUdljRLQc18bmPzdiysvvvmB0TKE2BKGlY=;
        b=dvgLabVBj8FJaCScpYPZQ7dD5ogNqyRhKjNLa/DZRFPT114ZnX3hGfQGPV2gmfj5t8syST
        EMhtmztsWvms6HqJ9ThOwuEm2Oi2KFzlenKys/G9LTA3+UnJ5gmVGDrNNsmGpGQRKanq6Z
        9Zbac9Two9kBfp7ghc3HYw0yvKKuDmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-KmWv8ZvKPKeYrXGaHm4v_g-1; Wed, 27 May 2020 11:17:13 -0400
X-MC-Unique: KmWv8ZvKPKeYrXGaHm4v_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E3E7107ACCA;
        Wed, 27 May 2020 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EAF75D9E5;
        Wed, 27 May 2020 15:16:30 +0000 (UTC)
Subject: Re: [PATCH v3 01/11] md/raid5: add CONFIG_MD_RAID456_STRIPE_SHIFT to
 set STRIPE_SIZE
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de, houtao1@huawei.com
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <20200527131933.34400-2-yuyufen@huawei.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <71d6df77-6abf-dec5-46b7-ebc7cd6f6b54@redhat.com>
Date:   Wed, 27 May 2020 23:16:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200527131933.34400-2-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 05/27/2020 09:19 PM, Yufen Yu wrote:
> In RAID5, if issued bio size is bigger than STRIPE_SIZE, it will be split
> in the unit of STRIPE_SIZE and process them one by one. Even for size
> less then STRIPE_SIZE, RAID5 also request data from disk at least of
> STRIPE_SIZE.
>
> Nowdays, STRIPE_SIZE is equal to the value of PAGE_SIZE. Since filesystem
> usually issue bio in the unit of 4KB, there is no problem for PAGE_SIZE as
> 4KB. But, for 64KB PAGE_SIZE, bio from filesystem requests 4KB data while
> RAID5 issue IO at least STRIPE_SIZE (64KB) each time. That will waste
> resource of disk bandwidth and compute xor.
>
> To avoding the waste, we want to add a new CONFIG option to adjust
> STREIPE_SIZE. Default value is 4096. User can also set the value bigger
> than 4KB for some special requirements, such as we know the issued io
> size is more than 4KB.
>
> To evaluate the new feature, we create raid5 device '/dev/md5' with
> 4 SSD disk and test it on arm64 machine with 64KB PAGE_SIZE.
>
> 1) We format /dev/md5 with mkfs.ext4 and mount ext4 with default
>   configure on /mnt directory. Then, trying to test it by dbench with
>   command: dbench -D /mnt -t 1000 10. Result show as:
>
>   'STRIPE_SIZE = 64KB'
>
>    Operation      Count    AvgLat    MaxLat
>    ----------------------------------------
>    NTCreateX    9805011     0.021    64.728
>    Close        7202525     0.001     0.120
>    Rename        415213     0.051    44.681
>    Unlink       1980066     0.079    93.147
>    Deltree          240     1.793     6.516
>    Mkdir            120     0.004     0.007
>    Qpathinfo    8887512     0.007    37.114
>    Qfileinfo    1557262     0.001     0.030
>    Qfsinfo      1629582     0.012     0.152
>    Sfileinfo     798756     0.040    57.641
>    Find         3436004     0.019    57.782
>    WriteX       4887239     0.021    57.638
>    ReadX        15370483     0.005    37.818
>    LockX          31934     0.003     0.022
>    UnlockX        31933     0.001     0.021
>    Flush         687205    13.302   530.088
>
>   Throughput 307.799 MB/sec  10 clients  10 procs  max_latency=530.091 ms
>   -------------------------------------------------------
>
>   'STRIPE_SIZE = 4KB'
>
>    Operation      Count    AvgLat    MaxLat
>    ----------------------------------------
>    NTCreateX    11999166     0.021    36.380
>    Close        8814128     0.001     0.122
>    Rename        508113     0.051    29.169
>    Unlink       2423242     0.070    38.141
>    Deltree          300     1.885     7.155
>    Mkdir            150     0.004     0.006
>    Qpathinfo    10875921     0.007    35.485
>    Qfileinfo    1905837     0.001     0.032
>    Qfsinfo      1994304     0.012     0.125
>    Sfileinfo     977450     0.029    26.489
>    Find         4204952     0.019     9.361
>    WriteX       5981890     0.019    27.804
>    ReadX        18809742     0.004    33.491
>    LockX          39074     0.003     0.025
>    UnlockX        39074     0.001     0.014
>    Flush         841022    10.712   458.848
>
>   Throughput 376.777 MB/sec  10 clients  10 procs  max_latency=458.852 ms
>   -------------------------------------------------------
>
>   It show that setting STREIP_SIZE as 4KB has higher thoughput, i.e.
>   (376.777 vs 307.799) and has smaller latency (530.091 vs 458.852)
>   than that setting as 64KB.
>
>   2) We try to evaluate IO throughput for /dev/md5 by fio with config:
>
>   [4KB randwrite]
>   direct=1
>   numjob=2
>   iodepth=64
>   ioengine=libaio
>   filename=/dev/md5
>   bs=4KB
>   rw=randwrite
>
>   [64KB write]
>   direct=1
>   numjob=2
>   iodepth=64
>   ioengine=libaio
>   filename=/dev/md5
>   bs=1MB
>   rw=write
>
>   The result as follow:
>
>                 +                   +
>                 | STRIPE_SIZE(64KB) | STRIPE_SIZE(4KB)
>   +----------------------------------------------------+
>   4KB randwrite |     15MB/s        |      100MB/s
>   +----------------------------------------------------+
>   1MB write     |   1000MB/s        |      700MB/s
>
>   The result show that when size of io is bigger than 4KB (64KB),
>   64KB STRIPE_SIZE has much higher IOPS. But for 4KB randwrite, that
>   means, size of io issued to device are smaller, 4KB STRIPE_SIZE
>   have better performance.
>
> Thus, we provide a configure to set STRIPE_SIZE when PAGE_SIZE is bigger
> than 4096. Normally, default value (4096) can get relatively good
> performance. But if each issued io is bigger than 4096, setting value more
> than 4096 may get better performance.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   drivers/md/Kconfig | 21 +++++++++++++++++++++
>   drivers/md/raid5.h |  4 +++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index d6d5ab23c088..629324f92c42 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -157,6 +157,27 @@ config MD_RAID456
>   
>   	  If unsure, say Y.
>   
> +config MD_RAID456_STRIPE_SHIFT
> +	int "RAID4/RAID5/RAID6 stripe size shift"
> +	default "1"
> +	depends on MD_RAID456
> +	help
> +	  When set the value as 'N', stripe size will be set as 'N << 9',
> +	  which is a multiple of 4KB.
> +
> +	  The default value is 1, that means the default stripe size is
> +	  4096(1 << 9). Just setting as a bigger value when PAGE_SIZE is
> +	  bigger than 4096. In that case, you can set it as 2(8KB),
> +	  4(16K), 16(64K).
> +
> +	  When you try to set a big value, likely 16 on arm64 with 64KB
> +	  PAGE_SIZE, that means, you know size of each io that issued to
> +	  raid device is more than 4096. Otherwise just use default value.
> +
> +	  Normally, using default value can get better performance.
> +	  Only change this value if you know what you are doing.
> +
> +
>   config MD_MULTIPATH
>   	tristate "Multipath I/O support"
>   	depends on BLK_DEV_MD
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index f90e0704bed9..b25f107dafc7 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -472,7 +472,9 @@ struct disk_info {
>    */
>   
>   #define NR_STRIPES		256
> -#define STRIPE_SIZE		PAGE_SIZE
> +#define CONFIG_STRIPE_SIZE	(CONFIG_MD_RAID456_STRIPE_SHIFT << 9)
> +#define STRIPE_SIZE		\
> +	(CONFIG_STRIPE_SIZE > PAGE_SIZE ? PAGE_SIZE : CONFIG_STRIPE_SIZE)
Hi Yufen

Is it what you want? Or it should be:

+#define STRIPE_SIZE \
+ (CONFIG_STRIPE_SIZE > PAGE_SIZE ? CONFIG_STRIPE_SIZE : PAGE_SIZE)
>   #define STRIPE_SHIFT		(PAGE_SHIFT - 9)
>   #define STRIPE_SECTORS		(STRIPE_SIZE>>9)
>   #define	IO_THRESHOLD		1

