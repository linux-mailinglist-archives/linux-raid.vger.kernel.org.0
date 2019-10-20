Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97522DDB94
	for <lists+linux-raid@lfdr.de>; Sun, 20 Oct 2019 02:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfJTAG5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 19 Oct 2019 20:06:57 -0400
Received: from MAIL.NPC-USA.COM ([173.160.187.9]:51044 "EHLO
        nautilus.npc-usa.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbfJTAG4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 19 Oct 2019 20:06:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by nautilus.npc-usa.com (Postfix) with ESMTP id 7EB121DC01B9
        for <linux-raid@vger.kernel.org>; Sat, 19 Oct 2019 17:06:55 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at npc-usa.com
Received: from nautilus.npc-usa.com ([127.0.0.1])
        by localhost (mail.npc-usa.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SBTFOxmoKbci for <linux-raid@vger.kernel.org>;
        Sat, 19 Oct 2019 17:06:53 -0700 (PDT)
Received: from [192.168.88.34] (c-73-254-66-50.hsd1.wa.comcast.net [73.254.66.50])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: curtis)
        by nautilus.npc-usa.com (Postfix) with ESMTPSA id B16341DC008F
        for <linux-raid@vger.kernel.org>; Sat, 19 Oct 2019 17:06:53 -0700 (PDT)
Reply-To: curtis@npc-usa.com
Subject: Re: Degraded RAID1
To:     linux-raid@vger.kernel.org
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
From:   Curtis Vaughan <curtis@npc-usa.com>
Organization: North Pacific Corporation
Message-ID: <5a153cf6-e53d-35d9-6775-e09028799721@npc-usa.com>
Date:   Sat, 19 Oct 2019 17:06:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9864d7bd-f2f7-b25e-fa6d-9ca06a9e6b87@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 10/16/19 2:33 PM, Wol wrote:
> On 16/10/2019 22:15, Curtis Vaughan wrote:
>> Think I got it working, just want to make sure I did this right. Using
>> fdisk I recreated the exact same partitions on sda as on sdb.
>>
>> Then I ran the mdadm --re-add for each partition to each raid volume. So
>> now here are some outputs to various commands. Does everything look 
>> right?
>
> Yup. Looks fine.
>
> Because we have two raids on one disk, the rebuild is throttled such 
> that only one rebuild is proceeding at a time.
>
> md1 is rebuilding, as it says. Once that completes then all the status 
> stuff will look normal, and md0 will start rebuilding.
>
> Don't know how long it will take, but because the raid doesn't know 
> what bits of the disk are used and what are not, the complete rebuild 
> will take however long it takes to read a 1gig drive from end to end, 
> and that is quite a long time ...
>
> Cheers,
> Wol
>
Actually, I still seem to have a problem.

After updates I decided to reboot, but it would never reboot until I 
removed the new drive. I'm wondering if it has something to do with 
needing to installl grub on the new drive?

Anyhow, now that I've pulled the new drive out and started the server, 
the old drive is now sda. So does that mean I should issue the commands 
to add the new drive back to the raid but as sdb?

