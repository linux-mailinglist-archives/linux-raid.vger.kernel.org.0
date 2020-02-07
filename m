Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603CC155A04
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGOtT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 09:49:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34452 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGOtT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 09:49:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so2392953otf.1
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 06:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=qmcxAhF5xQO/2A3OuQSJ4ofc4wh14ofVjpJUn+E9tgM=;
        b=O/DGsN5tVHoX0sHwR2lHK8rDGbe6wleveXW2N2LMw21dOCPWYexZ4nxEO1zeNFEyDY
         1eoUH4+5nX77fs6JOf3isWxI08ZB0SizD//zK0WiA/Z32JYb+5SpK44AZWvrI80hSHUr
         eIk6gyfqQIv3fAk4GlZljgTm5LmLYGJehbpFrbVpk9qKGNmCa3Fp4SSGzCl7MD1m5B/4
         fwhvubQz/QcaQ3JbL9h2zeYg+iq9KrFaUEZartihySVeSPdkcmMMBn0U7dKZ9z4qyL/6
         He6yUSn/8gqJvEtSYY91m5x+bmKuD0ep6aaKCozxgHt6/AE8kugeBGitKYvBbf/NHDZb
         5Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qmcxAhF5xQO/2A3OuQSJ4ofc4wh14ofVjpJUn+E9tgM=;
        b=X6cC+vuYCXABLtpEM1+Z3PVvOlE/8WfOf19i5oqJjjx0aOeaivnM1JcgRiTOQaSggu
         sv5BaaZEblCQ6v8VgEnyLg3754LtCGngT1Ikgo05onRvSRKe/8Who7WJUvr+Iwkg89Iu
         h9I58PYvwLJbWaZk4Oy/H70iJKko8r/22zG8pIYhLgxKlVcsfcJPxIm9FJvStUUIhCBk
         +bmmSTVM94GxVhHEPAZTqMYydMezswxsZTiMsOSnbSSTEiDcoUbKhGiR+8ocELLd0Rx1
         RFySyq2liUAYJJ2KrOQ48dHuaj+K7yZXa92j4XnVLgrdMeKpBf49W1TknDAOrS85cjCL
         n4tw==
X-Gm-Message-State: APjAAAWDDQqy5//AfBirXrcA70iD4aCq64nnSbuv8nwSO7DW3cjzBoEX
        E1Sh1CdocPy4R4ns/d0vsKENPjwW
X-Google-Smtp-Source: APXvYqzg4gLGhFz85znvpmx5+BmxGgToWFwc/LPZXVJkHqKe1CrCPL5NayV0ZJCNeirH3u/ehGKxRw==
X-Received: by 2002:a9d:268:: with SMTP id 95mr2995593otb.183.1581086958005;
        Fri, 07 Feb 2020 06:49:18 -0800 (PST)
Received: from [192.168.3.59] ([47.187.193.82])
        by smtp.googlemail.com with ESMTPSA id h1sm1130082otm.34.2020.02.07.06.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 06:49:17 -0800 (PST)
Subject: Re: Is it possible to break one full RAID-1 to two degraded RAID-1?
To:     Wols Lists <antlists@youngman.org.uk>,
        Reindl Harald <h.reindl@thelounge.net>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
 <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
 <2c4fedff-a1c9-6ca3-5385-72b542a4a0b4@gmail.com>
 <551449ed-49f9-e567-09d3-981f4cf9eea9@thelounge.net>
 <5E32855D.3020906@youngman.org.uk>
 <0c70c04f-d8d0-0c44-e603-46c101b21cc1@gmail.com>
 <5E3D2D9C.8020908@youngman.org.uk>
From:   Ram Ramesh <rramesh2400@gmail.com>
Message-ID: <42332f03-4c16-5f8f-0e9e-a21ddedd4f5b@gmail.com>
Date:   Fri, 7 Feb 2020 08:49:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E3D2D9C.8020908@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/7/20 3:27 AM, Wols Lists wrote:
> On 07/02/20 07:02, Ram Ramesh wrote:
>> I got no response on this and want to take a shot before going the
>> backup way.
>>
>> Assuming (hda1 and hdb1 in raid1 md0) Will the following work?
>>
>> 1. Fail and remove hdb1
>> 2. Create new RAID1 md1 with hdb1 and missing
>> 3. dd md0 onto md1
> I wouldn't bother with any of the above. Just shut down and physically
> remove a LIVE disk. That now is your backup.
>
> In fact, this might be a good excuse to get a 3rd disk and either go
> raid 5 or use it for backups.

Wol, you forgot the history in this thread. I already said removing disk 
is no-no due to the way it is installed nvme with manual install of 
heatsync etc.

Also, I do not understand RAID5 statement. Not seem to be relevant to 
original idea. Also, I only have two nvme slots and no PCIE x4 left. May 
be you have some point that I am not understanding. Please elaborate, if 
you can.
>
>> 4. Make both bootable. (I suppose I need to change UUID of md1
>>     partitions. I suppose that is easy)
> Yes it's easy. Yes it should have been done a LOOONG time ago.
Not if you break md0 into degraded md0 and md1. grub.cfg need to be 
updated after that fact and UUID update is only doable after breakup. 
Again not sure if I am missing something important implied by LOONG in 
your answer.
>
>> 5. Boot both and double check
> They'll be degraded, so you might have to do a forced assembly to make
> them run ...
I converted from from single to raid1. So this process is already 
tested, but yes your point is well taken.
>> 6. Now upgrade md0 without fear.
>> 7. Boot and test the new system for a couple of days to make sure
>>     everything is fine.
>> 8. If that fails, delete md0, and add hda1 to md1. If not delete md1
>>     and add hdb1 to md0
> Yup.
>> Regards
>> Ramesh
>>
> Cheers,
> Wol
>
Thanks for taking the time. I just want to pass it by to make sure that 
I do not assume something and go to point of no return.

Regards
Ramesh

