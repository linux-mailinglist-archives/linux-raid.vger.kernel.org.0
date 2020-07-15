Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6266E220255
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 04:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGOC2n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 22:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOC2n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jul 2020 22:28:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD9C061755
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 19:28:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls15so1454629pjb.1
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VCdnnccWnr/xbnQwCg15kACDKaaoTuZdTr91ztpaXwk=;
        b=P0aoQ/WzxC0xdM6xkoXG4RHLLk/eY6NU5c08bwKWcKLq/gwGRUcBOHDA70S/EZn/ML
         XshbBc3fOv1mY/6a4KhSwHoBm4VHmNAz9kOIzr1rGGULODajYa9O41kflegWmjGYit1d
         36/4dsBoQ067CL6gsLitO6jZwyrGVRs1EpfZQq9f49yTrY5jCmGqdJ/4KO0Hg/b46yA6
         iAQWoxFACl4xX4D52vwGmzRMWSJK4oCNCPabqHLw79QYtLUyOq8wqKWWcEbPqQxXM+k7
         OWJpbaL9+YGZBalhisdcx/mfaBN8GPuhHvPG1XAoUjA6x6/CR/h1D6zQL2hlZbpuiUlo
         gI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VCdnnccWnr/xbnQwCg15kACDKaaoTuZdTr91ztpaXwk=;
        b=bUojXjhR6s3xAUrOdl1jSKz967HTbSWr3h6+sV7zttnFivb6TgRnVKE1X4MQkI2mLv
         1Za8gZeIKugDleS7pX630VhiADp8wqc4RvyZqIQIXIajaqh9zNnGusvgrAVbER/Vp3cU
         2oTo1SYsmA68zASxHwZrY/nVdZR6Y/a+nWkIIhyOYA7kWS3ZXtB0KY56R8A8g3c/YZjl
         zocvslGEr4jBnkjkB/X3OXtoAwc9yxVwBXEE81Z+ViilM9+BtwN+TFVjcbaBnNIqGE8u
         RO1/4fLoOv7arrUFYZkRJhL3DYMLyKFMuQIQBEYdnT9zPFvD7VpSqFeaj+9RznzA8E+f
         cAgQ==
X-Gm-Message-State: AOAM530LU8vgJyRqdfqqIM2W4UW2eaP6RFtvCSrVeV+dBXM5jdkFNG/z
        SRPBaIBXRnJmSpZHqh+auzY8hXfWuvRLJA==
X-Google-Smtp-Source: ABdhPJwuIITM06s+sUVpWLNmUA8RrYzHZWmvTxqAWNJ/MWTSvfq2mmTiFSQhIVAgZl3kJaEP+pBXGg==
X-Received: by 2002:a17:902:d215:: with SMTP id t21mr6327978ply.136.1594780122196;
        Tue, 14 Jul 2020 19:28:42 -0700 (PDT)
Received: from [192.168.86.21] ([136.60.136.8])
        by smtp.gmail.com with ESMTPSA id t188sm383050pfc.198.2020.07.14.19.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:28:41 -0700 (PDT)
Subject: Re: Reshape using drives not partitions, RAID gone after reboot
To:     Roger Heflin <rogerheflin@gmail.com>,
        antlists <antlists@youngman.org.uk>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
References: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
 <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk>
 <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
From:   Adam Barnett <adamtravisbarnett@gmail.com>
Message-ID: <8373f6a8-f0d9-02de-268d-64bddc4b9aa2@gmail.com>
Date:   Tue, 14 Jul 2020 20:28:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks for all the the replies. The drives had single gpt partitions 
that were created before adding the drives to the arrays. So I'll give 
removing the partition tables a try and forcing reassembly.

I also tried stopping the array before forcing reassembly but this issue 
is that the newly added drives appear to have no superblocks, so mdadm 
aborts the assembly.

My current plan is to try to --create --assume-clean the array, but I 
have been reading about using overlay files to preserve the drives. If 
anyone could help me understand exactly how that is done I would be very 
appreciative.

I don't think the list allows links(?) but I'm following the steps on 
the kernel wiki under "Recovering_a_failed_software_RAID" but the bash 
commands are a bit confusing due to the use of the parallel command.

Thanks again all!

-Adam

On 7/14/20 5:27 PM, Roger Heflin wrote:
> Did you create the partition before you added the disk to mdadm or
> after?  If after was it a dos or a gpt?  Dos should have only cleared
> the first 512byte block.  If gpt it will have written to the first
> block and to at least 1 more location on the disk, possibly causing
> data loss.
>
> If before then you at least need to get rid of the partition table
> completely.   Having a partition on a device will often cause a number
> of things to ignore the whole disk.  I have debugged "lost" pv's where
> the partition effectively "blocked" lvm from even looking at the
> entire device that the pv was one.
>
> If it is a dos partition table then:
> save a backup of each disk first (always a good idea, you can dd it
> back if you screwed up so long as you carefully create the backups and
> name them properly).
> dd if=/dev/sdx of=/root/sdxbackup.img bs=512 count=1
> then clear the partition table space, rebooting is probably the
> easiest way to clear out the mappings, it can be done without
> rebooting but I have to do it trial and error to figure out the exact
> order and commands.
> dd if=/dev/zero of=/dev/sdX bs=512 count=1
>
> On Tue, Jul 14, 2020 at 6:11 PM antlists <antlists@youngman.org.uk> wrote:
>> On 14/07/2020 20:50, Adam Barnett wrote:
>>> Forcing the assembly does not work:
>>>
>>> $ sudo mdadm /dev/md1 --assemble --force /dev/sd[ijmop]1 /dev/sd[kln]
>>> mdadm: /dev/sdi1 is busy - skipping
>>> mdadm: /dev/sdj1 is busy - skipping
>>> mdadm: /dev/sdm1 is busy - skipping
>>> mdadm: /dev/sdo1 is busy - skipping
>>> mdadm: /dev/sdp1 is busy - skipping
>>> mdadm: Cannot assemble mbr metadata on /dev/sdk
>>> mdadm: /dev/sdk has no superblock - assembly aborted
>> Did you do an "mdadm --stop /dev/md1" before trying that? That's a
>> classic error from an array that's previously been partially assembled
>> and failed ...
>>
>> The other thing I'd do is make sure there aren't any other unepected
>> partially assembled arrays. I doubt it applies here, but I have come
>> across mirrors that get broken in half and you get two failed arrays
>> instead of one working one ...
>>
>> Cheers,
>> Wol
