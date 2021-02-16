Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6131CBF5
	for <lists+linux-raid@lfdr.de>; Tue, 16 Feb 2021 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBPObT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Feb 2021 09:31:19 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38621 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229924AbhBPObN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 16 Feb 2021 09:31:13 -0500
Received: from torchwood.molgen.mpg.de (torchwood.molgen.mpg.de [141.14.21.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kreitler)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9F65120647939;
        Tue, 16 Feb 2021 15:30:30 +0100 (CET)
Subject: Re: mdxxx_raid6 kernel thread frozen
To:     "Michael D. O'Brien" <obrienmd@gmail.com>,
        linux-raid@vger.kernel.org
References: <CACs3Z9oqWPRt4uT1pYKMHzH+7JHNtsk_stE_-OmQZSQsy4n46g@mail.gmail.com>
From:   Thomas Kreitler <kreitler@molgen.mpg.de>
Message-ID: <0d37d776-ef5e-8a8d-ab45-bd0addd17184@molgen.mpg.de>
Date:   Tue, 16 Feb 2021 15:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CACs3Z9oqWPRt4uT1pYKMHzH+7JHNtsk_stE_-OmQZSQsy4n46g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 2021-02-15 22:31, Michael D. O'Brien wrote:
> Hi, I have a single mdadm raid6 in a 56-drive raid60 (7x8) with a
> kernel thread stuck at 100% cpu. The stuck thread typically happens
> during array checks, but is not the resync thread - md122_raid6 is at
> 100% cpu, whereas md122_resync is at ~0%. When this happens, the
> reported sync speed drops until it reaches 4K/sec. Setting sync_action
> to idle gets stuck.
> 
> iostat shows backing devices aren't doing anything i/o wise, SMART is
> clean for all member drives, and dmesg doesn't say anything useful
> (until the thread is hung for a long time, then it tells me as much -
> I'll post that message when the current issue times out). A reboot
> typically clears the issue, but takes quite a long time, as the raid
> 60 is the backing device for a bcache device (with an optane cache)
> that has a large mounted xfs file system in place.
> 
> I figured I could strace the process, but I learned that's impossible
> with kernel threads :)
> 
[...]

Hello Michael,

This sounds pretty much the same what we have experienced whilst 
checking raid6 assemblies.

The issue is actively tackled in the moment, c.f the "[PATCH V2] md: 
don't unregister sync_thread with reconfig_mutex held" thread.

And more details in the link:
https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc1ac@molgen.mpg.de/T/#t


Kind regards,

	Thomas


-- 
Thomas Kreitler - Information Retrieval
kreitler@molgen.mpg.de
49/30/8413 1702
