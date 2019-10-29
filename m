Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871A7E9113
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfJ2UwO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 16:52:14 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47634 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfJ2UwO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 16:52:14 -0400
Received: from [86.155.171.62] (helo=[192.168.1.78])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iPYTL-00036z-6t; Tue, 29 Oct 2019 20:52:11 +0000
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
To:     Anssi Hannula <anssi.hannula@iki.fi>,
        Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <25373b220163b01b8990aa049fec9d18@iki.fi>
 <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi>
 <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
 <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi>
 <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
 <0d3573affc5c44ff169120f8667f5780@iki.fi>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <ed49e70f-ddb7-e399-a130-105649494b86@youngman.org.uk>
Date:   Tue, 29 Oct 2019 21:52:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0d3573affc5c44ff169120f8667f5780@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/10/2019 19:05, Anssi Hannula wrote:
> As mentioned in my first message and seen in 
> http://onse.fi/files/reshape-infloop-issue/examine-all.txt , the MD bad 
> block lists contain blocks (suspiciously identical across devices).
> So maybe the code can't properly handle the case where 10 devices have 
> the same block in their bad block list. Not quite sure what "handle" 
> should mean in this case but certainly something else than a 
> handle_stripe() loop :)
> There is a "bad" block on 10 devices on sector 198504960, which I guess 
> matches sh->sector 198248960 due to data offset of 256000 sectors (per 
> --examine).
> 
> I've wondered if "dd if=/dev/md0 of=/dev/md0" for the affected blocks 
> would clear the bad blocks and avoid this issue, but I haven't tried 
> that yet so that the infinite loop issue can be investigated/fixed 
> first. I already checked that /dev/md0 is fully readable (which also 
> confuses me a bit since md(8) says "Attempting to read from a known bad 
> block will cause a read error"... maybe I'm missing something).

Hmmm ...

Bear in mind that bad-blocks is considered by many an anti-feature, and 
it's strongly suspected that identical bad-block lists across multiple 
disks is a bug ...

I hesitate to suggest trying to clear the bad-blocks but doing a dd will 
definitely not do what you want - the md bad blocks list is implemented 
within the md layer, so doing something with dd is unlikely to touch it.

Plus, as a software implementation, you should NEVER under normal 
circumstances have any bad blocks - it doesn't make sense - so it's 
pretty certain you've fallen foul of a bug in the bad blocks setup.

Sorry I can't offer any solutions, other than very hesitantly suggesting 
just a --remove-badblocks --force or whatever the option is.

Hopefully this gives you a few ideas ...

Cheers,
Wol
