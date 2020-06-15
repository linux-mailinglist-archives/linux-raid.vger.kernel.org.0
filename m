Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453EB1F8F44
	for <lists+linux-raid@lfdr.de>; Mon, 15 Jun 2020 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFOHR4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 15 Jun 2020 03:17:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5889 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbgFOHRz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 15 Jun 2020 03:17:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E851330869BD0E311BB;
        Mon, 15 Jun 2020 15:17:50 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 15 Jun 2020 15:17:41 +0800
Subject: Re: [PATCH v4 01/15] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
To:     Xiao Ni <xni@redhat.com>, <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>
References: <20200612114220.13126-1-yuyufen@huawei.com>
 <20200612114220.13126-2-yuyufen@huawei.com>
 <00ffbcfe-1cc1-470b-d1a7-718e09f4f922@redhat.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <277990d4-f4b9-ab5e-1707-b0c529b86674@huawei.com>
Date:   Mon, 15 Jun 2020 15:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <00ffbcfe-1cc1-470b-d1a7-718e09f4f922@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/6/14 10:28, Xiao Ni wrote:
> Hi Yufen
> 
> It looks like there is something wrong. I try to apply these patches based on latest upstream, but it fails.
> 
> [xni@xiao md]$ git am big-page/\[PATCH\ v4\ 01_15\]\ md_raid456\:\ covert\ macro\ define\ of\ STRIPE_\*\ as\ members\ of\ struct\ r5conf\ -\ Yufen\ Yu\ \<yuyufen@huawei.com\>\ -\ 2020-06-12\ 1942.eml
> Applying: md/raid456: covert macro define of STRIPE_* as members of struct r5conf
> error: patch failed: drivers/md/raid5.c:2267
> error: drivers/md/raid5.c: patch does not apply
> Patch failed at 0001 md/raid456: covert macro define of STRIPE_* as members of struct r5conf
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> [xni@xiao md]$ cat .git/config
> snip..
> [remote "origin"]
>      url = https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git
> [xni@xiao md]$ git branch
>    master
> * md-next
> 

Sorry for this. I have forgotten to rebase my own development branch
with latest upstream. I will solve it in next version.

Thanks,
Yufen
