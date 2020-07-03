Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60C72136B3
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgGCIuZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jul 2020 04:50:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:63761 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCIuZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 3 Jul 2020 04:50:25 -0400
IronPort-SDR: g7OSuFvUBzEodK9ng7d9XcZGFx3qHMtuhygH7tc+IU1Kxuu1jeXfBt+f2HvUGRme5QHlIDiZRZ
 +CZcAd3MRhmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="127212931"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="127212931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 01:50:25 -0700
IronPort-SDR: pQb/moQUE/VmyGr5hwYwF8jeR0T3mR0gyap59E70JnMVA3lv98XPHhqHm1jVDnUVMmNGMGkJIa
 CzEFKl8gjxyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="426233917"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2020 01:50:23 -0700
Subject: Re: [PATCH v3] md: improve io stats accounting
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200702142926.4419-1-artur.paszkiewicz@intel.com>
 <CAPhsuW5eMPMH1HcMXi67Ci0rbWhVyiuLodVZB_oaGbrR7abTJQ@mail.gmail.com>
 <aea49756-c6f6-a4a3-3e23-9928e0878c80@cloud.ionos.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <cf1b6354-3c97-a2e3-2f7b-d5c15205bb6a@intel.com>
Date:   Fri, 3 Jul 2020 10:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <aea49756-c6f6-a4a3-3e23-9928e0878c80@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/3/20 10:33 AM, Guoqing Jiang wrote:
> On 7/2/20 11:25 PM, Song Liu wrote:
>> I run quick test with this. Seems it only adds proper statistics to
>> raid5 array, but
>> not to raid0 array. Is this expected?

Oh, sorry about that. Of course it should work.

> Because bio_endio is not called, and it is same for linear and faulty.
> I think we have to  clone bio for them ..., then it is better to do the
> job in the personality layer.

It's not that bad actually. The issue is simply because those
personalities change the original bio's bi_disk and then
bio_end_io_acct() uses a different gendisk. So I think we can either use
disk_{start,end}_io_acct() instead of bio_{start,end}_io_acct(), or
change bio->bi_disk back to mddev->gendisk before calling
bio_end_io_acct(). I prefer the first option. What do you think?

Thanks,
Artur
