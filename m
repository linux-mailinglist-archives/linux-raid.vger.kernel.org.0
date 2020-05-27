Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897A41E51D2
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 01:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgE0Xa0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Wed, 27 May 2020 19:30:26 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:56446 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0Xa0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 27 May 2020 19:30:26 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id ADE14207C8;
        Wed, 27 May 2020 19:30:23 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 21248A6428; Wed, 27 May 2020 19:30:23 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <24270.63502.994707.335011@quad.stoffel.home>
Date:   Wed, 27 May 2020 19:30:22 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org,
        linux-raid@vger.kernel.org, neilb@suse.com, colyli@suse.de,
        xni@redhat.com, houtao1@huawei.com
Subject: Re: [PATCH v3 01/11] md/raid5: add CONFIG_MD_RAID456_STRIPE_SHIFT to
 set STRIPE_SIZE
In-Reply-To: <5fe381f9-e3ce-c2f7-dfac-9f852316b38f@cloud.ionos.com>
References: <20200527131933.34400-1-yuyufen@huawei.com>
        <20200527131933.34400-2-yuyufen@huawei.com>
        <5fe381f9-e3ce-c2f7-dfac-9f852316b38f@cloud.ionos.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Guoqing" == Guoqing Jiang <guoqing.jiang@cloud.ionos.com> writes:

Guoqing> Hi,
Guoqing> On 5/27/20 3:19 PM, Yufen Yu wrote:
>> +config MD_RAID456_STRIPE_SHIFT
>> +	int "RAID4/RAID5/RAID6 stripe size shift"
>> +	default "1"
>> +	depends on MD_RAID456
>> +	help
>> +	  When set the value as 'N', stripe size will be set as 'N << 9',
>> +	  which is a multiple of 4KB.

Guoqing> If 'N  << 9', then seems you are convert it to sector, do you actually 
Guoqing> mean 'N << 12'?

Aren't there helpers that can be used here instead of semi-magic
numbers?  At the least, the 9 and 12 should be #defines with good
names, or using the standard PAGE_SIZE and other defines.  

>> +
>> +	  The default value is 1, that means the default stripe size is
>> +	  4096(1 << 9). Just setting as a bigger value when PAGE_SIZE is
>> +	  bigger than 4096. In that case, you can set it as 2(8KB),
>> +	  4(16K), 16(64K).

Guoqing> So with the above description, the algorithm should be 2 << 12 = 8KB and 
Guoqing> so on.

>> +
>> +	  When you try to set a big value, likely 16 on arm64 with 64KB
>> +	  PAGE_SIZE, that means, you know size of each io that issued to
>> +	  raid device is more than 4096. Otherwise just use default value.
>> +

Cheers,
John
