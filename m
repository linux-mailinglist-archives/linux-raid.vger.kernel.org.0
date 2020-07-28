Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6A22FECA
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 03:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgG1BSY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jul 2020 21:18:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgG1BSY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Jul 2020 21:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595899102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJZ4Eol2bcknSSw7PyWtHB2hhMF1aMgGl5N+2h002aM=;
        b=FOi3dYtHibGh2OFBb9EaHe4IpoLnZjaxxgzvnutTaFDvHnHwgDTpjYUpzHqAiZUJWRSIs8
        xMJyOJi9JsIVBhwH/h2BI70S/Wam8A1jEJfc24jJHWaN/B+yPx1PWFwfi//ZLA0gpidvSS
        3Gli8ppiyi3tKOXx3AQGlK8ISK9zUGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-gCzRQrKjNF-SR_erMEItLQ-1; Mon, 27 Jul 2020 21:18:20 -0400
X-MC-Unique: gCzRQrKjNF-SR_erMEItLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F3CE100AA22;
        Tue, 28 Jul 2020 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 119FB712D7;
        Tue, 28 Jul 2020 01:18:16 +0000 (UTC)
Subject: Re: [PATCH 1/2] super1.0 calculates max sectors in a wrong way
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>
References: <1593503737-5067-1-git-send-email-xni@redhat.com>
 <1593503737-5067-2-git-send-email-xni@redhat.com>
 <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <9626595c-cdd8-f46d-629e-67f9b11d2b6a@redhat.com>
Date:   Tue, 28 Jul 2020 09:18:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/28/2020 01:33 AM, Song Liu wrote:
> On Tue, Jun 30, 2020 at 12:55 AM Xiao Ni <xni@redhat.com> wrote:
>> One super1.0 raid array wants to grow size, it needs to check the device max usable
>> size. If the requested size is bigger than max usable size, it will return an error.
>>
>> Now it uses rdev->sectors for max usable size. If one disk is 500G and the raid device
>> only uses the 100GB of this disk. rdev->sectors can't tell the real max usable size.
>> The max usable size should be dev_size-(superblock_size+bitmap_size+badblock_size).
>>
>> Signed-off-by: Xiao Ni <xni@redhat.com>
> Thanks for the fix!
>
>> ---
>>   drivers/md/md.c | 26 +++++++++++++++++++++++---
>>   1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index f567f53..d2c5984 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -2183,10 +2183,30 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
>>                  return 0;
>>          } else {
>>                  /* minor version 0; superblock after data */
>> -               sector_t sb_start;
>> -               sb_start = (i_size_read(rdev->bdev->bd_inode) >> 9) - 8*2;
>> +               sector_t sb_start, bm_space;
>> +               sector_t dev_size = i_size_read(rdev->bdev->bd_inode) >> 9;
>> +
>> +               /* 8K is for superblock */
>> +               sb_start = dev_size - 8*2;
>>                  sb_start &= ~(sector_t)(4*2 - 1);
>> -               max_sectors = rdev->sectors + sb_start - rdev->sb_start;
>> +
>> +               /* if the device is bigger than 8Gig, save 64k for bitmap usage,
>> +                * if bigger than 200Gig, save 128k
>> +                */
>> +               if (dev_size < 64*2)
>> +                       bm_space = 0;
>> +               else if (dev_size - 64*2 >= 200*1024*1024*2)
>> +                       bm_space = 128*2;
>> +               else if (dev_size - 4*2 > 8*1024*1024*2)
>> +                       bm_space = 64*2;
>> +               else
>> +                       bm_space = 4*2;
> Could you explain the handling of bitmap space?
Hi Song

This calculation of bitmap is decided by mdadm. In mdadm super1.c 
choose_bm_space function,
it uses this way to calculate bitmap space. Do I need to add comments 
here to describe this?
Something like "mdadm function choose_bm_space decides the bitmap space"?

Regards
Xiao

