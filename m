Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A833A199610
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgCaMOY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 08:14:24 -0400
Received: from atl.turmel.org ([74.117.157.138]:40099 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbgCaMOY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 31 Mar 2020 08:14:24 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJFmh-0003I0-H9; Tue, 31 Mar 2020 08:14:23 -0400
Subject: Re: mdcheck: slow system issues
To:     Peter Grandi <pg@mdraid.list.sabi.co.UK>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
 <24195.8467.378436.7747@base.ty.sabi.co.uk>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <dbbd010e-3648-c72c-ce44-ed570f6eb8be@turmel.org>
Date:   Tue, 31 Mar 2020 08:14:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24195.8467.378436.7747@base.ty.sabi.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/31/20 6:53 AM, Peter Grandi wrote:
>> Dear Linux folks, When `mdcheck` runs on two 100 TB software
>> RAIDs our users complain about being unable to open files in a
>> reasonable time. [...]
>>        109394518016 blocks super 1.2 level 6, 512k chunk,
>> algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]
> 
> Unsurprisingly it is a 16-wide RAID6 of 8TB HDDs.

With a 512k chunk.  Definitely not suitable for anything but large media 
file streaming.

>> [...] The article *Software RAID check - slow system issues*
>> [1] recommends to lower `dev.raid.speed_limit_max`, but the
>> RAID should easily be able to do 200 MB/s as our tests show
>> over 600 MB/s during some benchmarks.
> 
> Many people have to find out the hard way that on HDDs
> sequential and random IO rates differ by "up to" two orders of
> magnitude, and that RAID6 gives an "interesting" tradeoff
> between read and write speed with random vs. sequential access.

The random/streaming threshold is proportional to the address stride on 
one device--the raid sector number gap between one chunk and the next 
chunk on that (approximately).  Which is basically chunk * (n-2).  With 
so many member devices, the transition from random-access performance 
and streaming performance requires that much larger accesses.

I configure any raid6 that might have some random loads with a 16k or 
32k chunk size.

Finally, the stripe cache size should be optimized on the system in 
question.  More is generally better, unless it starves the OS of 
buffers.  Adjust and test, with real loads.

>> How do you run `mdcheck` in production without noticeably
>> affecting the system?
> 
> Fortunately the only solution that works well is quite simple:
> replace the storage system with one with much increased
> IOPS-per-TB (that is SSDs or much smaller HDDs, 1TB or less)
> *and* switch from RAID6 to RAID10.

These are good choices too, though not cheap.

Phil
