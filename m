Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F19212C36
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGBSXI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 14:23:08 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48079 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbgGBSXE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 14:23:04 -0400
Received: from [192.168.0.6] (ip5f5af2b2.dynamic.kabel-deutschland.de [95.90.242.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3FDF2206442E6;
        Thu,  2 Jul 2020 20:23:01 +0200 (CEST)
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
To:     Song Liu <song@kernel.org>, Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <20200702120628.777303-2-yuyufen@huawei.com>
 <CAPhsuW7cSue8BtWhmWMgOTjw42ChTm4cM+gApj_s02rq=YGRkQ@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3bf71b7a-b457-c5e4-34df-bdea5cf2abc3@molgen.mpg.de>
Date:   Thu, 2 Jul 2020 20:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7cSue8BtWhmWMgOTjw42ChTm4cM+gApj_s02rq=YGRkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Yufen,


Am 02.07.20 um 20:15 schrieb Song Liu:
> On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>
>> We covert STRIPE_SIZE, STRIPE_SHIFT and STRIPE_SECTORS to stripe_size,
>> stripe_shift and stripe_sectors as members of struct r5conf. Then each
>> raid456 array can config different stripe_size. This patch is prepared
>> for following configurable stripe_size.
>>
>> Simply replace word STRIPE_ with conf->stripe_ and add 'conf' argument
>> for function stripe_hash_locks_hash() and r5_next_bio() to get stripe_size.
>> After that, we initialize stripe_size into setup_conf().
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> 
> This patch looks good. Please fix the warning found by the kernel test bot.
> Also a nitpick below.

Please also fix the typo *covert* to *Convert* in the commit message 
summary, and maybe use *to* instead of *as*.

 > Convert macro define of STRIPE_* to members of struct r5conf

[…]


Kind regards,

Paul
