Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695562057DE
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgFWQsn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 12:48:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:45521 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733172AbgFWQsm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jun 2020 12:48:42 -0400
IronPort-SDR: cbTl0BhsEldCQnjmI7Ku+5+qV5fSSFxaAFdp9sITSDdDNkGOg2JK8fU1Mw95OB8woSWjLuhIpR
 4fDzix1oykmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="162217643"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="162217643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:48:42 -0700
IronPort-SDR: 5+UST+Lmqku/uj8n8BjuOHmKyQU1etTpWlDVJGf1a5dCe6o7k7whyfWVnAAbMqUhUWKmTdRKtQ
 qLNcGLLX5+bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="319204761"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2020 09:48:40 -0700
Subject: Re: [PATCH] mdraid: fix read/write bytes accounting
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, jeffm@suse.com,
        linux-raid@vger.kernel.org, song@kernel.org
Cc:     nfbrown@suse.com, colyli@suse.com
References: <20200605201953.11098-1-jeffm@suse.com>
 <ed552b4b-b19a-cc85-05f4-0a0dc0d6fac2@intel.com>
 <fb3b18e6-9dda-6633-e25e-a141718f630b@cloud.ionos.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <ac89af6c-1610-61b5-d275-304e6e54947f@intel.com>
Date:   Tue, 23 Jun 2020 18:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fb3b18e6-9dda-6633-e25e-a141718f630b@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/23/20 4:21 PM, Guoqing Jiang wrote:
> Hi Artur,
> 
> On 6/8/20 9:13 AM, Artur Paszkiewicz wrote:
>> On 6/5/20 10:19 PM, jeffm@suse.com wrote:
>>> The i/o accounting published in /proc/diskstats for mdraid is currently
>>> broken.  md_make_request does the accounting for every bio passed but
>>> when a bio needs to be split, all the split bios are also submitted
>>> through md_make_request, resulting in multiple accounting.
>> Hi Jeff,
>>
>> I sent a patch a few days ago which should fix this issue. Can you check
>> it out?
>>
>> https://marc.info/?l=linux-raid&m=159102814820539
> 
> I need to account some extra statistics for bio such as latency and size,
> so it is kind of relies on your patch, then I read the code again.
> 
> And besides my previous comment. I think you don't need clone bio for all
> personalities. For md-multipath, raid1 and raid10, you can track the start
> time by add it to those structures (multipath_bh, r1bio and r10bio), then
> one extra copy could be avoided.
> 
> What do you think?

You're right, cloning can be avoided for those personalities. I wanted
to keep it clean and centralized in the generic md code. I think we
should have a common completion callback and some common request
structure for all md personalities, like struct md_io which I'm using in
my patch. How about we add it to the existing stucts like r1bio etc. and
use that for io accounting, and clone the bio with the struct otherwise?
Or maybe remove the cloning from the personalities and instead make the
bio cloned in md_make_request available to them? Does this make sense?

Thanks,
Artur
