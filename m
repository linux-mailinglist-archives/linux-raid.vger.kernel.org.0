Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8024208B
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgHKTtN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 15:49:13 -0400
Received: from lavender.maple.relay.mailchannels.net ([23.83.214.99]:37434
        "EHLO lavender.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbgHKTtM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Aug 2020 15:49:12 -0400
X-Sender-Id: xxlwebhosting|x-authuser|rudy+zijlstra-cable.nl@ams109.yourwebhoster.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 67CDC640EC4;
        Tue, 11 Aug 2020 19:49:11 +0000 (UTC)
Received: from ams109.yourwebhoster.com (100-96-23-21.trex.outbound.svc.cluster.local [100.96.23.21])
        (Authenticated sender: xxlwebhosting)
        by relay.mailchannels.net (Postfix) with ESMTPA id D687B6413CA;
        Tue, 11 Aug 2020 19:49:09 +0000 (UTC)
X-Sender-Id: xxlwebhosting|x-authuser|rudy+zijlstra-cable.nl@ams109.yourwebhoster.com
Received: from ams109.yourwebhoster.com (ams109.yourwebhoster.com
 [109.71.54.20])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.8);
        Tue, 11 Aug 2020 19:49:11 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: xxlwebhosting|x-authuser|rudy+zijlstra-cable.nl@ams109.yourwebhoster.com
X-MailChannels-Auth-Id: xxlwebhosting
X-Snatch-Bitter: 75d1ae824b145ee9_1597175351210_3444579201
X-MC-Loop-Signature: 1597175351210:1438724458
X-MC-Ingress-Time: 1597175351210
Received: from [2001:470:7b31:0:f88e:cb0:1865:772f] (port=54750 helo=althalus.local)
        by ams109.yourwebhoster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <rudy@grumpydevil.homelinux.org>)
        id 1k5aGd-004qC8-VD; Tue, 11 Aug 2020 21:49:04 +0200
Subject: Re: Recommended filesystem for RAID 6
To:     Roman Mamedov <rm@romanrm.net>,
        Reindl Harald <h.reindl@thelounge.net>
Cc:     George Rapp <george.rapp@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <20200811212305.02fec65a@natsu>
 <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
 <20200812003305.6628dd6e@natsu>
From:   Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Message-ID: <e662446e-33e4-81fa-18ab-516fd140d51a@grumpydevil.homelinux.org>
Date:   Tue, 11 Aug 2020 21:49:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812003305.6628dd6e@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: nl
X-AuthUser: rudy+zijlstra-cable.nl@ams109.yourwebhoster.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Op 11-08-2020 om 21:33 schreef Roman Mamedov:
> On Tue, 11 Aug 2020 20:57:15 +0200
> Reindl Harald <h.reindl@thelounge.net> wrote:
>
>>> Whichever filesystem you choose, you will end up with a huge single point of
>>> failure, and any trouble with that FS or the underlying array put all your
>>> data instantly at risk.
>> calling an array where you can lose *two* disks as
>> single-point-of-failure is absurd
> As noted before, not just *disks* can fail, plenty of other things to fail in
> a storage server, and they can easily take down, say, a half of all disks, or
> random portions of them in increments of four. Even if temporarily -- that
> surely will be "unexpected" to that single precious 20TB filesystem. How will
> it behave, who knows. Do you know? For added fun, reconnect the drives back 30
> seconds later. Oh, let's write to linux-raid for how to bring back a half of
> RAID6 from the Spare (S) status. Or find some HOWTO suggesting a random
> --create without --assume-clean. And if the FS goes corrupt, now you suddenly
> need *all* your backups, not just 1 drive worth of them.
actually, recovering from such an occasion is not the difficult part. 
The difficult part is controlling the human doing the recovery. Too 
often time pressure results in panic and the wrong choices. Which is 
where having a good backup is so very valuable.
Yes, i have had problems like that, and recovered. mdadm -A -f is your 
friend :)
>
>> no raid can replace backups anyways
> All too often I've seen RAID being used as an implicit excuse to be lenient
> about backups. Heck, I know from personal experience how enticing that can be.
Is the backup not automatic? in that case it is no backup.
>
>>> Most likely you do not. And the RAID's main purpose in that case is to just
>>> have a unified storage pool, for the convenience of not having to manage free
>>> space across so many drives. But given the above, I would suggest leaving the
>>> drives with their individual FSes, and just running MergerFS on top:
>>> https://www.teknophiles.com/2018/02/19/disk-pooling-in-linux-with-mergerfs/
>> you just move the complexity to something not used by many people for
>> what exactly to gain? the rives are still in the same machine
> To gain total independence of drives from each other, you can pull any drive
> out of the machine, plug it in somewhere else, and it will have a proper
> filesystem and readable files on it. Writable, even.
>
> Compared to a 16-drive RAID6, where you either have a whopping 14 disks
> present, connected, powered, spinning, healthy, online, OR you have useless
> binary junk instead of any data.
>
> Of course I do not insist my way is the best for everyone, but I hope now you
> can better understand the concerns and reasons for choosing it. :)
You have simply chosen a different set of mistakes to make. Considering 
you need to update the "what is where" list regularly (is that 
automated?) you may actually have more options for mistakes.

My biggest raid currently is a 6 disk raid10

Cheers

Rudy




