Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB7230A9F
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgG1Mtt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 08:49:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59890 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729868AbgG1Mtt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 08:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595940587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2DUdbZlwgWcyhhEIaPp3ptqIoL5LXsbMiRoGm86++A=;
        b=aApVQHokcfHfERfVwoXCc3RDM8MghZo4cW4UI+/STNWsqrA/XHpq2DSVlfdxT497vOB5VZ
        tEECvEsMl1GYWbZlVSGvSAzSK7sEETwUFcv7OLqL4UbiV82jtzJfIdEp1BJ8eI30BWtL9Y
        juLtiztbYLcPT6rPjO0Ojmd29dShLd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-L8eDYic2NSK7pyVDyHsjHA-1; Tue, 28 Jul 2020 08:49:43 -0400
X-MC-Unique: L8eDYic2NSK7pyVDyHsjHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C01E3800479;
        Tue, 28 Jul 2020 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 583BA76216;
        Tue, 28 Jul 2020 12:49:38 +0000 (UTC)
Subject: Re: [PATCH V2 3/3] improve raid10 discard request
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
References: <1595920703-6125-1-git-send-email-xni@redhat.com>
 <1595920703-6125-4-git-send-email-xni@redhat.com>
 <81fdb14b-e292-8dfc-5228-c6bfaa800dfe@cloud.ionos.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <e4f1e2ca-c378-0890-8d3f-65fe35f263bf@redhat.com>
Date:   Tue, 28 Jul 2020 20:49:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <81fdb14b-e292-8dfc-5228-c6bfaa800dfe@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/28/2020 04:38 PM, Guoqing Jiang wrote:
>
>
> On 7/28/20 9:18 AM, Xiao Ni wrote:
>> Now the discard request is split by chunk size. So it takes a long time
>> to finish mkfs on disks which support discard function. This patch 
>> improve
>> handling raid10 discard request. It uses the similar way with patch
>> 29efc390b (md/md0: optimize raid0 discard handling).
>>
>> But it's a little complex than raid0. Because raid10 has different 
>> layout.
>> If raid10 is offset layout and the discard request is smaller than 
>> stripe
>> size. There are some holes when we submit discard bio to underlayer 
>> disks.
>>
>> For example: five disks (disk1 - disk5)
>> D01 D02 D03 D04 D05
>> D05 D01 D02 D03 D04
>> D06 D07 D08 D09 D10
>> D10 D06 D07 D08 D09
>> The discard bio just wants to discard from D03 to D10. For disk3, 
>> there is
>> a hole between D03 and D08. For disk4, there is a hole between D04 
>> and D09.
>> D03 is a chunk, raid10_write_request can handle one chunk perfectly. So
>> the part that is not aligned with stripe size is still handled by
>> raid10_write_request.
>
> One question, is far layout handled by raid10_write_request or the
> discard request?
>
>>
>> If reshape is running when discard bio comes and the discard bio 
>> spans the
>> reshape position, raid10_write_request is responsible to handle this
>> discard bio.
>>
>> I did a test with this patch set.
>> Without patch:
>> time mkfs.xfs /dev/md0
>> real4m39.775s
>> user0m0.000s
>> sys0m0.298s
>>
>> With patch:
>> time mkfs.xfs /dev/md0
>> real0m0.105s
>> user0m0.000s
>> sys0m0.007s
>>
>> nvme3n1           259:1    0   477G  0 disk
>> └─nvme3n1p1       259:10   0    50G  0 part
>> nvme4n1           259:2    0   477G  0 disk
>> └─nvme4n1p1       259:11   0    50G  0 part
>> nvme5n1           259:6    0   477G  0 disk
>> └─nvme5n1p1       259:12   0    50G  0 part
>> nvme2n1           259:9    0   477G  0 disk
>> └─nvme2n1p1       259:15   0    50G  0 part
>> nvme0n1           259:13   0   477G  0 disk
>> └─nvme0n1p1       259:14   0    50G  0 part
>>
>> v1:
>> Coly helps to review these patches and give some suggestions:
>> One bug is found. If discard bio is across one stripe but bio size is 
>> bigger
>> than one stripe size. After spliting, the bio will be NULL. In this 
>> version,
>> it checks whether discard bio size is bigger than 2*stripe_size.
>> In raid10_end_discard_request, it's better to check R10BIO_Uptodate 
>> is set
>> or not. It can avoid write memory to improve performance.
>> Add more comments for calculating addresses.
>>
>> v2:
>> Fix error by checkpatch.pl
>> Fix one bug for offset layout. v1 calculates wrongly split size
>> Add more comments to explain how the discard range of each component 
>> disk
>> is decided.
>
> The above change log are usually put under "---".

Thanks for reminding me about this.
>
>> Reviewed-by: Coly Li <colyli@suse.de>
>> Signed-off-by: Xiao Ni <xni@redhat.com>
>> ---
>
> [...]
>
>> +
>> +/* There are some limitations to handle discard bio
>> + * 1st, the discard size is bigger than stripe_size*2.
>> + * 2st, if the discard bio spans reshape progress, we use the old 
>> way to
>> + * handle discard bio
>> + */
>> +static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
>> +{
>
> [...]
>
>> +    /* For far offset layout, if bio is not aligned with stripe 
>> size, it splits
>> +     * the part that is not aligned with strip size.
>> +     */
>> +    if (geo.far_offset && (bio_start & stripe_mask)) {
>> +        sector_t split_size;
>> +        split_size = round_up(bio_start, stripe_size) - bio_start;
>> +        bio = raid10_split_bio(conf, bio, split_size, false);
>> +    }
>> +    if (geo.far_offset && (bio_end & stripe_mask)) {
>> +        sector_t split_size;
>> +        split_size = bio_sectors(bio) - (bio_end & stripe_mask);
>> +        bio = raid10_split_bio(conf, bio, split_size, true);
>> +    }
>
> So far layout is handled here. I think the hole issue is existed for 
> far layout,
> Just FYI.

It looks like I missed the far layout. Far layout is different with far 
offset layout.
It doesn't need to consider the write hole problem. This patch only 
consider the
write hole in one copy. For far layout, the discard region is 
sequential. So we just
need to find the start/end address of next copy. I'll fix this in next 
version.

Regards
Xiao

>
>> +
>> +    r10_bio = mempool_alloc(&conf->r10bio_pool, GFP_NOIO);
>> +    r10_bio->mddev = mddev;
>> +    r10_bio->state = 0;
>> +    memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * 
>> conf->geo.raid_disks);
>> +
>> +    wait_blocked_dev(mddev, geo.raid_disks);
>> +
>> +    r10_bio->master_bio = bio;
>> +
>> +    bio_start = bio->bi_iter.bi_sector;
>> +    bio_end = bio_end_sector(bio);
>> +
>> +    /* raid10 uses chunk as the unit to store data. It's similar 
>> like raid0.
>> +     * One stripe contains the chunks from all member disk (one 
>> chunk from
>> +     * one disk at the same HAB address). For layout detail, see 
>> 'man md 4'
>> +     */
>
> s/HAB/HBA/
>
> Thanks,
> Guoqing
>

