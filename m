Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54133DDBBA
	for <lists+linux-raid@lfdr.de>; Sun, 20 Oct 2019 02:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJTAai (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 19 Oct 2019 20:30:38 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41604 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfJTAai (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 19 Oct 2019 20:30:38 -0400
Received: from [81.153.126.205] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iLz7D-00067J-9w; Sun, 20 Oct 2019 01:30:35 +0100
Subject: Re: Degraded RAID1
To:     curtis@npc-usa.com, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
 <5DA648B9.7030506@youngman.org.uk>
 <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
 <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
 <ac4a6b63-b886-1c0c-3aad-f77b54246226@npc-usa.com>
 <9864d7bd-f2f7-b25e-fa6d-9ca06a9e6b87@youngman.org.uk>
 <5a153cf6-e53d-35d9-6775-e09028799721@npc-usa.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DABAAAA.4050904@youngman.org.uk>
Date:   Sun, 20 Oct 2019 01:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <5a153cf6-e53d-35d9-6775-e09028799721@npc-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20/10/19 01:06, Curtis Vaughan wrote:
> 
> On 10/16/19 2:33 PM, Wol wrote:
>> On 16/10/2019 22:15, Curtis Vaughan wrote:
>>> Think I got it working, just want to make sure I did this right. Using
>>> fdisk I recreated the exact same partitions on sda as on sdb.
>>>
>>> Then I ran the mdadm --re-add for each partition to each raid volume. So
>>> now here are some outputs to various commands. Does everything look
>>> right?
>>
>> Yup. Looks fine.
>>
>> Because we have two raids on one disk, the rebuild is throttled such
>> that only one rebuild is proceeding at a time.
>>
>> md1 is rebuilding, as it says. Once that completes then all the status
>> stuff will look normal, and md0 will start rebuilding.
>>
>> Don't know how long it will take, but because the raid doesn't know
>> what bits of the disk are used and what are not, the complete rebuild
>> will take however long it takes to read a 1gig drive from end to end,
>> and that is quite a long time ...
>>
>> Cheers,
>> Wol
>>
> Actually, I still seem to have a problem.
> 
> After updates I decided to reboot, but it would never reboot until I
> removed the new drive. I'm wondering if it has something to do with
> needing to installl grub on the new drive?
> 
> Anyhow, now that I've pulled the new drive out and started the server,
> the old drive is now sda. So does that mean I should issue the commands
> to add the new drive back to the raid but as sdb?
> 
If you haven't modified the array, it should just sort itself out.

If you *have* modified the array, I'm not sure if there's a re-add
command. If you've got a bitmap file or journal or anything like that,
it should just sort itself out.

As for not rebooting because of grub, I suspect you're right. Because
the two drives are mirrored, you probably mirrored grub on both drives.
When the original sda failed and was removed, sdb became sda as the
first drive found. When you replaced sda, that became the first drive
and didn't have grub on it.

Try moving sdb's cable to where sda was on the motherboard, and putting
the new drive where sdb was. I guess your system will now boot fine, but
you'll need to put grub on the new drive ready for the next failure ... :-)

Cheers,
Wol
