Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE0222399D
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 12:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQKo1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 06:44:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:38183 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQKo0 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jul 2020 06:44:26 -0400
IronPort-SDR: Rx9yfC9vxjd/0WvQUWK9Rv1Y90XDTO39doOJA7ujzYI0Znt5V6wYH4hZKixjFAVWEpK/gaLbCX
 dD0BgCeBgaKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129652588"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129652588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 03:44:26 -0700
IronPort-SDR: sFPTlIHAKfwvbUv0aLM5N1sFOJ556SHsfnhBSR/n1JQLv7L7CGYjMZ16T3XKG82s+7JWuA6VL4
 1dYI7UZm+D0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="486927722"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2020 03:44:25 -0700
Subject: Re: [PATCH v4] md: improve io stats accounting
To:     Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
 <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com>
 <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
 <CAPhsuW6HjN0hZ8E998XBpg+WxP5uhZO0on-M-tQ45kpFO5XHqg@mail.gmail.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <db93b8ae-25a1-5b50-7360-1f9c8e0661c3@intel.com>
Date:   Fri, 17 Jul 2020 12:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6HjN0hZ8E998XBpg+WxP5uhZO0on-M-tQ45kpFO5XHqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/16/20 7:29 PM, Song Liu wrote:
> I just noticed another issue with this work on raid456, as iostat
> shows something
> like:
> 
> Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
> avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> nvme0n1        6306.50 18248.00  636.00 1280.00    45.11    76.19
> 129.65     3.03    1.23    0.67    1.51   0.76 145.50
> nvme1n1       11441.50 13234.00 1069.50  961.00    71.87    55.39
> 128.35     3.32    1.30    0.90    1.75   0.72 146.50
> nvme2n1        8280.50 16352.50  971.50 1231.00    65.53    68.65
> 124.77     3.20    1.17    0.69    1.54   0.64 142.00
> nvme3n1        6158.50 18199.50  567.00 1453.50    39.81    76.74
> 118.13     3.50    1.40    0.88    1.60   0.73 146.50
> md0               0.00     0.00 1436.00 1411.00    89.75    88.19
> 128.00    22.98    8.07    0.16   16.12   0.52 147.00
> 
> md0 here is a RAID-6 array with 4 devices. %util of > 100% is clearly
> wrong here.
> This only doesn't happen to RAID-0 or RAID-1 in my tests.
> 
> Artur, could you please take a look at this?

Hi Song,

I think it's not caused by this patch, because %util of the member
drives is affected as well. I reverted the patch and it's still
happening:

Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
md0             20.00      2.50     0.00   0.00    0.00   128.00   21.00      2.62     0.00   0.00    0.00   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
nvme0n1         13.00      1.62   279.00  95.55    0.77   128.00    4.00      0.50   372.00  98.94 1289.00   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    5.17 146.70
nvme1n1         15.00      1.88   310.00  95.38    0.53   128.00   21.00      2.62   341.00  94.20 1180.29   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   24.80 146.90
nvme2n1         16.00      2.00   310.00  95.09    0.69   128.00   19.00      2.38   341.00  94.72  832.89   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   15.84 146.80
nvme3n1         18.00      2.25   403.00  95.72    0.72   128.00   16.00      2.00   248.00  93.94  765.69   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   12.26 114.30

I was only able to reproduce it on a VM, it doesn't occur on real
hardware (for me). What was your test configuration?

Thanks,
Artur
