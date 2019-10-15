Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694B3D8110
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfJOUcM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 16:32:12 -0400
Received: from MAIL.NPC-USA.COM ([173.160.187.9]:37086 "EHLO
        nautilus.npc-usa.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726590AbfJOUcM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 15 Oct 2019 16:32:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by nautilus.npc-usa.com (Postfix) with ESMTP id 643361DC0196
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 13:32:11 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at npc-usa.com
Received: from nautilus.npc-usa.com ([127.0.0.1])
        by localhost (mail.npc-usa.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zJH-QrvDa0v1 for <linux-raid@vger.kernel.org>;
        Tue, 15 Oct 2019 13:32:09 -0700 (PDT)
Received: from [10.0.1.65] (unknown [10.0.1.65])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: curtis)
        by nautilus.npc-usa.com (Postfix) with ESMTPSA id 2CA831DC0084
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 13:32:09 -0700 (PDT)
Reply-To: curtis@npc-usa.com
Subject: Re: Degraded RAID1
From:   Curtis Vaughan <curtis@npc-usa.com>
To:     linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
Openpgp: preference=signencrypt
Autocrypt: addr=curtis@npc-usa.com; keydata=
 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
Organization: North Pacific Corporation
Message-ID: <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
Date:   Tue, 15 Oct 2019 13:32:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 10/14/19 5:44 PM, Wols Lists wrote:
> On 15/10/19 00:56, Curtis Vaughan wrote:
>> I have reason to believe one HD in a RAID1 is dying. But I'm trying to 
>> understand what the logs and results of various commands are telling me. 
>> Searching on the Internet is very confusing. BTW, this is for and Ubuntu 
>> Server 18.04.2 LTS.
> Ubuntu LTS ... hmmm. What does "mdadm --version" tell you?
mdadm - v4.1-rc1 - 2018-03-22

>> It seems to me that the following information is telling me on device is 
>> missing. It would seem to me that sda is gone.
> Have you got any diagnostics for sda? Is it still in /dev? has it been
> kicked from the system? Or just the raid?
It is still on the system, so I guess it's just kicked off the raid.
>
> Take a look at
> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> Especially the "asking for help" page. It gives you loads of diagnostics
> to run.
Ok, I already went through most of those tests, but still not sure what
they are telling me.
> Basically, we need to know whether sda has died, or whether it's a
> problem with raid (especially with older mdadm, like I suspect you may
> have, the problem could lie there).
>> Anyhow, for example, I received an email:
>>
>> A DegradedArray event had been detected on md device /dev/md0.
> Do you have a spare drive to replace sda? If you haven't, it might be an
> idea to get one - especially if you think sda might have failed. In that
> case, fixing the raid should be pretty easy. So long as fixing it
> doesn't tip sdb over the edge ...

The replacement drive is coming tomorrow. I'm certain now there's a
major issue

with the drive and will be replacing it.

My intent is to basically follow these instructions for replacing the
drive.

sudo mdadm --remove /dev/md1 /dev/sda2
sudo mdadm --remove /dev/md0 /dev/sda1

Remove the bad drive, install new drive
 
sudo mdadm --add /dev/md1 /dev/sda2
sudo mdadm --add /dev/md1 /dev/sda1


Would that be the correct approach?

Finally could you tell me how to subscribe to this newsgroup through an NNTP client? 
I was using it through the gmane server, which seems to have issues of whether it's 
being continued or not. And although I can see some recent posts from last week, 
there has been nothing new. I've been searching for a NNTP server, but can't find one.
Thanks!

