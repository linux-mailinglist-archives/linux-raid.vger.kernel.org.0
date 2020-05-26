Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1674E1C5EE9
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgEERcj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 13:32:39 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46352 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbgEERcj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 May 2020 13:32:39 -0400
Received: from [81.153.126.158] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jW1Qq-0006Ej-Em; Tue, 05 May 2020 18:32:36 +0100
Subject: Re: [PATCH 0/4] eliminate SECTOR related magic numbers and duplicated
 conversions
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <ea522f15-991d-6f67-ba8b-9cb4954a1064@youngman.org.uk>
Date:   Tue, 5 May 2020 18:32:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505115543.1660-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/05/2020 12:55, Zhen Lei wrote:
> When I studied the code of mm/swap, I found "1 << (PAGE_SHIFT - 9)" appears
> many times. So I try to clean up it.
> 
> 1. Replace "1 << (PAGE_SHIFT - 9)" or similar with SECTORS_PER_PAGE
> 2. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT
> 3. Replace "9" with SECTOR_SHIFT
> 4. Replace "512" with SECTOR_SIZE

Naive question - what is happening about 4096-byte sectors? Do we need 
to forward-plan?

Cheers,
Wol
