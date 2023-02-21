Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCE69D966
	for <lists+linux-raid@lfdr.de>; Tue, 21 Feb 2023 04:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjBUDmf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Feb 2023 22:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBUDme (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Feb 2023 22:42:34 -0500
X-Greylist: delayed 609 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 19:41:52 PST
Received: from out-62.mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA1024C8B
        for <linux-raid@vger.kernel.org>; Mon, 20 Feb 2023 19:41:51 -0800 (PST)
Message-ID: <fd88c91e-f501-005d-3eb2-98a019d3db9e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676950298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzBg0TUaaK3whFH2bi9OBf7ZAjpdNsxkbV4yL17sC7Q=;
        b=Bggb451wueDx36BTxMzIOrZcz2twGAQ3jYHIalfYyMo3JzUAvJdv6MSPm3VDT1DCRhpN56
        6ATflZ+1BTK2RADQw9r+UsdnN1G6JROkXtiedniUBVNjKkiB9EfJKKtf63kJjNmAVnUDPq
        rRCxupNilQEVHi8e4Yme37RssXxHm2w=
Date:   Mon, 20 Feb 2023 20:31:38 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2] md: Use optimal I/O size for last bitmap page
Content-Language: en-US
To:     Xiao Ni <xni@redhat.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Sushma Kalakota <sushma.kalakota@intel.com>
References: <20230217183139.106-1-jonathan.derrick@linux.dev>
 <CALTww2-3t-Tyjh1yAZhM+6Rwgh7t2=EFk1hOpvnTuiN91yyfDg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <CALTww2-3t-Tyjh1yAZhM+6Rwgh7t2=EFk1hOpvnTuiN91yyfDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2/20/2023 7:38 PM, Xiao Ni wrote:
> On Sat, Feb 18, 2023 at 2:36 AM Jonathan Derrick
> <jonathan.derrick@linux.dev> wrote:
>>
>> From: Jon Derrick <jonathan.derrick@linux.dev>
>>
>> If the bitmap space has enough room, size the I/O for the last bitmap
>> page write to the optimal I/O size for the storage device. The expanded
>> write is checked that it won't overrun the data or metadata.
>>
>> This change helps increase performance by preventing unnecessary
>> device-side read-mod-writes due to non-atomic write unit sizes.
> 
> Hi Jonathan
> 
> Thanks for your patch.
> 
> Could you explain more about the how the optimal io size can affect
> the device-side read-mod-writes?

The effects of device-side read-mod-writes are a device-specific implementation detail.
This is not something expected to be universal as its an abstracted detail.

However the NVMe spec allows the storage namespace to provide implementation
hints about its underlying media.

Both NPWA and NOWS are used in the NVMe driver, where NOWS provides the
optimal_io hint:

Per NVMe Command Set 1.0b, Figure 97
Namespace Preferred Write Alignment (NPWA): This field indicates the recommended
write alignment in logical blocks for this namespace

Namespace Optimal Write Size (NOWS): This field indicates the size in logical blocks
for optimal write performance for this namespace. 

Per 5.8.2.1 Improved I/O examples (non-normative)
When constructing write operations, the host should minimally construct writes
that meet the recommendations of NPWG and NPWA, but may achieve optimal write
performance by constructing writes that meet the recommendation of NOWS.


It then makes sense that an NVMe drive would provide optimal io size hints
that matches its underlying media unit size, such that sub-4k writes might
invoke a device-side read-mod-write whereas 4k writes become atomic.

> 
> Regards
> Xiao
>>
>> Example Intel/Solidigm P5520
>> Raid10, Chunk-size 64M, bitmap-size 57228 bits
>>
>> $ mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/nvme{0,1,2,3}n1 --assume-clean --bitmap=internal --bitmap-chunk=64M
>> $ fio --name=test --direct=1 --filename=/dev/md0 --rw=randwrite --bs=4k --runtime=60
>>
>> Without patch:
>>   write: IOPS=1676, BW=6708KiB/s (6869kB/s)(393MiB/60001msec); 0 zone resets
>>
>> With patch:
>>   write: IOPS=15.7k, BW=61.4MiB/s (64.4MB/s)(3683MiB/60001msec); 0 zone resets
>>
>> Biosnoop:
>> Without patch:
>> Time        Process        PID     Device      LBA        Size      Lat
>> 1.410377    md0_raid10     6900    nvme0n1   W 16         4096      0.02
>> 1.410387    md0_raid10     6900    nvme2n1   W 16         4096      0.02
>> 1.410374    md0_raid10     6900    nvme3n1   W 16         4096      0.01
>> 1.410381    md0_raid10     6900    nvme1n1   W 16         4096      0.02
>> 1.410411    md0_raid10     6900    nvme1n1   W 115346512  4096      0.01
>> 1.410418    md0_raid10     6900    nvme0n1   W 115346512  4096      0.02
>> 1.410915    md0_raid10     6900    nvme2n1   W 24         3584      0.43
>> 1.410935    md0_raid10     6900    nvme3n1   W 24         3584      0.45
>> 1.411124    md0_raid10     6900    nvme1n1   W 24         3584      0.64
>> 1.411147    md0_raid10     6900    nvme0n1   W 24         3584      0.66
>> 1.411176    md0_raid10     6900    nvme3n1   W 2019022184 4096      0.01
>> 1.411189    md0_raid10     6900    nvme2n1   W 2019022184 4096      0.02
>>
>> With patch:
>> Time        Process        PID     Device      LBA        Size      Lat
>> 5.747193    md0_raid10     727     nvme0n1   W 16         4096      0.01
>> 5.747192    md0_raid10     727     nvme1n1   W 16         4096      0.02
>> 5.747195    md0_raid10     727     nvme3n1   W 16         4096      0.01
>> 5.747202    md0_raid10     727     nvme2n1   W 16         4096      0.02
>> 5.747229    md0_raid10     727     nvme3n1   W 1196223704 4096      0.02
>> 5.747224    md0_raid10     727     nvme0n1   W 1196223704 4096      0.01
>> 5.747279    md0_raid10     727     nvme0n1   W 24         4096      0.01
>> 5.747279    md0_raid10     727     nvme1n1   W 24         4096      0.02
>> 5.747284    md0_raid10     727     nvme3n1   W 24         4096      0.02
>> 5.747291    md0_raid10     727     nvme2n1   W 24         4096      0.02
>> 5.747314    md0_raid10     727     nvme2n1   W 2234636712 4096      0.01
>> 5.747317    md0_raid10     727     nvme1n1   W 2234636712 4096      0.02
>>
>> Signed-off-by: Jon Derrick <jonathan.derrick@linux.dev>
>> ---
>> v1->v2: Add more information to commit message
>>
>>  drivers/md/md-bitmap.c | 27 ++++++++++++++++++---------
>>  1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index e7cc6ba1b657..569297ea9b99 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -220,6 +220,7 @@ static int write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
>>         rdev = NULL;
>>         while ((rdev = next_active_rdev(rdev, mddev)) != NULL) {
>>                 int size = PAGE_SIZE;
>> +               int optimal_size = PAGE_SIZE;
>>                 loff_t offset = mddev->bitmap_info.offset;
>>
>>                 bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
>> @@ -228,9 +229,14 @@ static int write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
>>                         int last_page_size = store->bytes & (PAGE_SIZE-1);
>>                         if (last_page_size == 0)
>>                                 last_page_size = PAGE_SIZE;
>> -                       size = roundup(last_page_size,
>> -                                      bdev_logical_block_size(bdev));
>> +                       size = roundup(last_page_size, bdev_logical_block_size(bdev));
>> +                       if (bdev_io_opt(bdev) > bdev_logical_block_size(bdev))
>> +                               optimal_size = roundup(last_page_size, bdev_io_opt(bdev));
>> +                       else
>> +                               optimal_size = size;
>>                 }
>> +
>> +
>>                 /* Just make sure we aren't corrupting data or
>>                  * metadata
>>                  */
>> @@ -246,9 +252,11 @@ static int write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
>>                                 goto bad_alignment;
>>                 } else if (offset < 0) {
>>                         /* DATA  BITMAP METADATA  */
>> -                       if (offset
>> -                           + (long)(page->index * (PAGE_SIZE/512))
>> -                           + size/512 > 0)
>> +                       loff_t off = offset + (long)(page->index * (PAGE_SIZE/512));
>> +                       if (size != optimal_size &&
>> +                           off + optimal_size/512 <= 0)
>> +                               size = optimal_size;
>> +                       else if (off + size/512 > 0)
>>                                 /* bitmap runs in to metadata */
>>                                 goto bad_alignment;
>>                         if (rdev->data_offset + mddev->dev_sectors
>> @@ -257,10 +265,11 @@ static int write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
>>                                 goto bad_alignment;
>>                 } else if (rdev->sb_start < rdev->data_offset) {
>>                         /* METADATA BITMAP DATA */
>> -                       if (rdev->sb_start
>> -                           + offset
>> -                           + page->index*(PAGE_SIZE/512) + size/512
>> -                           > rdev->data_offset)
>> +                       loff_t off = rdev->sb_start + offset + page->index*(PAGE_SIZE/512);
>> +                       if (size != optimal_size &&
>> +                           off + optimal_size/512 <= rdev->data_offset)
>> +                               size = optimal_size;
>> +                       else if (off + size/512 > rdev->data_offset)
>>                                 /* bitmap runs in to data */
>>                                 goto bad_alignment;
>>                 } else {
>> --
>> 2.27.0
>>
> 
