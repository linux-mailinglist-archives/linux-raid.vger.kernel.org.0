Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88AE1B26D2
	for <lists+linux-raid@lfdr.de>; Tue, 21 Apr 2020 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgDUM4K (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 08:56:10 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38089 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbgDUM4K (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 08:56:10 -0400
Received: from [192.168.0.4] (ip5f5af6e9.dynamic.kabel-deutschland.de [95.90.246.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CB4EC206446BE;
        Tue, 21 Apr 2020 14:56:07 +0200 (CEST)
Subject: Re: [PATCH RFC v2 0/8] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com,
        guoqing.jiang@cloud.ionos.com, colyli@suse.de, xni@redhat.com,
        houtao1@huawei.com
References: <20200421123952.49025-1-yuyufen@huawei.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <67039bd4-1b24-a7f5-d82a-fabb3ebfce12@molgen.mpg.de>
Date:   Tue, 21 Apr 2020 14:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421123952.49025-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Yufen,


Thank you for your patch set.

Am 21.04.20 um 14:39 schrieb Yufen Yu:

>   For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5 will
>   issus echo bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64. However,

issue

>   filesystem usually issue bio in the unit of 4KB. Then, RAID5 will waste resource
>   of disk bandwidth.
> 
>   To solve the problem, this patchset provide a new config CONFIG_MD_RAID456_STRIPE_SIZE
>   to let user config STRIPE_SIZE. The default value is 4096.
> 
>   Normally, using default STRIPE_SIZE can get better performance. And NeilBrown have
>   suggested just to fix the STRIPE_SIZE as 4096. But, out test result show that
>   big value of STRIPE_SIZE may have better performance when size of issued IOs are
>   mostly bigger than 4096. Thus, in this patchset, we still want to set STRIPE_SIZE
>   as a configureable value.

configurable

>   In current implementation, grow_buffers() uses alloc_page() to allocate the buffers
>   for each stripe_head. With the change, it means we allocate 64K buffers but just
>   use 4K of them. To save memory, we try to 'compress' multiple buffers of stripe_head
>   to only one real page. Detail shows in patch #2.
> 
>   To evaluate the new feature, we create raid5 device '/dev/md5' with 4 SSD disk
>   and test it on arm64 machine with 64KB PAGE_SIZE.

[…]

So, what is affecting the performance? The size of the bio in the used 
file system? Shouldn’t it then be a run-time option (Linux CLI parameter 
and /proc) so the Linux kernel doesn’t need to be recompiled for 
different servers? Should the option be even per RAID, as each RAID5 
device might be using another filesystem?


Kind regards,

Paul
