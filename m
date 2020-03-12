Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD83D1831C5
	for <lists+linux-raid@lfdr.de>; Thu, 12 Mar 2020 14:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCLNkl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Mar 2020 09:40:41 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33736 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLNkl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Mar 2020 09:40:41 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so5512598ilg.0
        for <linux-raid@vger.kernel.org>; Thu, 12 Mar 2020 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6fRFcMHQQvgXUMu9ji5eLUkSQJ3mpFpcehi61CBMmK0=;
        b=q21WvNG+GvuYoEsq+TO9ASqezouRrFYukS0qs9+/FVkQ/489coT/AQ8ax1hFwqHRJU
         MRhWI8dBvnOqOCK8t7K4nymV9ovnw2DZ6ITSGhPcQl9cZO6PZEj2yf52T8wlLvemuVxF
         F/ioKw6MzcvahxTLKevhohlkvYngYaJYf8uDkmlqredqzJAnozwoBnCdnnC8RI79G1Ug
         LMnNNfOeiZFkQQuOGDJl1NkUIAaMwERSX0o0ZZVRxHuhsVXTFuTO/Q+s6c8Cn4boo6Ip
         Mk6LYop6Mw/YDwISqv03OiREVPKhgO/nwF4l77xSI5oZ+exFIKxvT+PwyJBbPdHIqVnl
         lUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6fRFcMHQQvgXUMu9ji5eLUkSQJ3mpFpcehi61CBMmK0=;
        b=d+Lom4Xvp0p89Z1tqRGjPgFLcaytComKbBIeF7At8tE3dHgxUw1vlDSuJgdpm2EDfS
         dUrxbqw6UDaqTDxqvkpu0PkU5jPxxQ4RO0bixYeUwU7zM3+hVnBdujPCOKJvJ8bgxOKz
         kh89xgOJ43hT6BFvwCJERUJIK9ezs9KYiE286ZoBcHSdJ7cZLgTVgXk3rIA2orKcfsI7
         jM2cYBmZiHYL4+Ulk4reWD6uiO7aUhvsM7k1b9sctFhr3HSr43f4+npbJL2jSlXtuscS
         Qj2B3rl7CKzL49HuLxap83oFWYpvkdw5sKYSbRwiOSFamdbGTLc8LEpJ9vOklX+rjKYE
         hh2g==
X-Gm-Message-State: ANhLgQ0BupmCE83ctaeJQgR8n+uQFTCQjrfxLIVYzp1LaZvv4BvKyMI4
        AoJwzwOcn+VuxvelhQv/U+t8Mg==
X-Google-Smtp-Source: ADFU+vvEvnILZdmJhTtPhXDESn8Hgad55q7JHk/nlWdWJ6hY9yEkpLu3FDp2aj8u4ZaG/1zMS5fIZA==
X-Received: by 2002:a92:c851:: with SMTP id b17mr2678052ilq.194.1584020440417;
        Thu, 12 Mar 2020 06:40:40 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g88sm1381275ila.47.2020.03.12.06.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:40:39 -0700 (PDT)
Subject: Re: [PATCH] block: keep bdi->io_pages in sync with max_sectors_kb for
 stacked devices
To:     Song Liu <song@kernel.org>, Bob Liu <bob.liu@oracle.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158290150891.4423.13566449569964563258.stgit@buzz>
 <7133c4fb-38d5-cf1f-e259-e12b50efcb32@oracle.com>
 <CAPhsuW6xJeX3=0j69_hdaUnYXPm7VeaXHB06JM=fRZsxPweQng@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecc07195-872b-1c49-d423-873cfd7243fe@kernel.dk>
Date:   Thu, 12 Mar 2020 07:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6xJeX3=0j69_hdaUnYXPm7VeaXHB06JM=fRZsxPweQng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/10/20 3:40 PM, Song Liu wrote:
> On Mon, Mar 2, 2020 at 4:16 AM Bob Liu <bob.liu@oracle.com> wrote:
>>
>> On 2/28/20 10:51 PM, Konstantin Khlebnikov wrote:
>>> Field bdi->io_pages added in commit 9491ae4aade6 ("mm: don't cap request
>>> size based on read-ahead setting") removes unneeded split of read requests.
>>>
>>> Stacked drivers do not call blk_queue_max_hw_sectors(). Instead they setup
>>> limits of their devices by blk_set_stacking_limits() + disk_stack_limits().
>>> Field bio->io_pages stays zero until user set max_sectors_kb via sysfs.
>>>
>>> This patch updates io_pages after merging limits in disk_stack_limits().
>>>
>>> Commit c6d6e9b0f6b4 ("dm: do not allow readahead to limit IO size") fixed
>>> the same problem for device-mapper devices, this one fixes MD RAIDs.
>>>
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> ---
>>>  block/blk-settings.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>>> index c8eda2e7b91e..66c45fd79545 100644
>>> --- a/block/blk-settings.c
>>> +++ b/block/blk-settings.c
>>> @@ -664,6 +664,8 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
>>>               printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
>>>                      top, bottom);
>>>       }
>>> +
>>> +     t->backing_dev_info->io_pages = t->limits.max_sectors >> (PAGE_SHIFT-9);
>>>  }
>>>  EXPORT_SYMBOL(disk_stack_limits);
>>>
>>>
>>
>> Nitpick.. (PAGE_SHIFT - 9)
>> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> 
> Thanks for the fix. I fixed it based on the comments and applied it to md-next.
> 
> Jens, I picked the patch to md-next because md is the only user of
> disk_stack_limits().
> 
> Please let me know if you prefer routing it via the block tree.

That's fine, thanks.

-- 
Jens Axboe

