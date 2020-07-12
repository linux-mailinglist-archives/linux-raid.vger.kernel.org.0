Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5D21CBF0
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jul 2020 00:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgGLWzT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jul 2020 18:55:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40041 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgGLWzS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 12 Jul 2020 18:55:18 -0400
Received: from host86-157-102-29.range86-157.btcentralplus.com ([86.157.102.29] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1juksO-0003VC-4e; Sun, 12 Jul 2020 23:55:16 +0100
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Song Liu <song@kernel.org>,
        Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
References: <20200702120628.777303-1-yuyufen@huawei.com>
 <20200702120628.777303-2-yuyufen@huawei.com>
 <CAPhsuW7cSue8BtWhmWMgOTjw42ChTm4cM+gApj_s02rq=YGRkQ@mail.gmail.com>
 <3bf71b7a-b457-c5e4-34df-bdea5cf2abc3@molgen.mpg.de>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <61fe17a6-1c2c-7f95-eba7-167d8d0d30c2@youngman.org.uk>
Date:   Sun, 12 Jul 2020 23:55:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3bf71b7a-b457-c5e4-34df-bdea5cf2abc3@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02/07/2020 19:23, Paul Menzel wrote:
> Dear Yufen,
> 
> 
> Am 02.07.20 um 20:15 schrieb Song Liu:
>> On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
>>>
>>> We covert STRIPE_SIZE, STRIPE_SHIFT and STRIPE_SECTORS to stripe_size,
>>> stripe_shift and stripe_sectors as members of struct r5conf. Then each
>>> raid456 array can config different stripe_size. This patch is prepared
>>> for following configurable stripe_size.
>>>
>>> Simply replace word STRIPE_ with conf->stripe_ and add 'conf' argument
>>> for function stripe_hash_locks_hash() and r5_next_bio() to get 
>>> stripe_size.
>>> After that, we initialize stripe_size into setup_conf().
>>>
>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>>
>> This patch looks good. Please fix the warning found by the kernel test 
>> bot.
>> Also a nitpick below.
> 
> Please also fix the typo *covert* to *Convert* in the commit message 
> summary, and maybe use *to* instead of *as*.

Actually, if I understand the Pidgin correctly, "as" is correct grammar. 
"to" just doesn't work for me ...
> 
>  > Convert macro define of STRIPE_* to members of struct r5conf
> 
Cheers,
Wol
