Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C82216A8
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 22:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgGOU40 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 16:56:26 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:38546 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOU40 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Jul 2020 16:56:26 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 16:56:25 EDT
Received: from [192.168.50.137] ([24.64.114.53])
        by shaw.ca with ESMTPA
        id voJzjgNzqFXePvoK9jkvIG; Wed, 15 Jul 2020 14:48:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1594846097;
        bh=c/3EQ6KxJDyG+5gdkDv1y77xKpwUOvwNdt2HluCq2tY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JkPKwCKZiqqOR0dJmvIcFgxhxi07gZiL92MZoH9hMVCgOSEUiCLkLl2nAd5/SD+jb
         h55k39yMBLTplXgbLe/Z8/rCAiSeDZTRTymAdCFE6IX6703PJgvZryTHEpJa0UpceE
         bDQZ9FDyinp9qZxCJp3WPk87H/OfnTvKZ+UMOaKmBLaM4eIT/AemAGu/To/evzFcB2
         vlggvOSMrxRPzjsyjuq44I6M1usk9Cjn9hTiGU/F5elIyI+mFxqW4qjjHZ3OqP8EFW
         NF7nrn3FNRP61LolAxwizJ9qBCmVubTkvKaToSGVjZtOZ88fowJJFp4mLz03bVWLFd
         VHqtHOK5i9wXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1594846097;
        bh=c/3EQ6KxJDyG+5gdkDv1y77xKpwUOvwNdt2HluCq2tY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JkPKwCKZiqqOR0dJmvIcFgxhxi07gZiL92MZoH9hMVCgOSEUiCLkLl2nAd5/SD+jb
         h55k39yMBLTplXgbLe/Z8/rCAiSeDZTRTymAdCFE6IX6703PJgvZryTHEpJa0UpceE
         bDQZ9FDyinp9qZxCJp3WPk87H/OfnTvKZ+UMOaKmBLaM4eIT/AemAGu/To/evzFcB2
         vlggvOSMrxRPzjsyjuq44I6M1usk9Cjn9hTiGU/F5elIyI+mFxqW4qjjHZ3OqP8EFW
         NF7nrn3FNRP61LolAxwizJ9qBCmVubTkvKaToSGVjZtOZ88fowJJFp4mLz03bVWLFd
         VHqtHOK5i9wXg==
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=aoFTOZhfXO3lFit9ECvAag==:117 a=aoFTOZhfXO3lFit9ECvAag==:17
 a=IkcTkHD0fZMA:10 a=emMDOMd8YtTwtsb0pTUA:9 a=QEXdDO2ut3YA:10
Subject: Re: Reshape using drives not partitions, RAID gone after reboot
To:     antlists <antlists@youngman.org.uk>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Adam Barnett <adamtravisbarnett@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
 <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk>
 <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
 <730bb16a-235d-9186-a486-7ed0018121ab@youngman.org.uk>
From:   AdsGroup <AdsGroup@shaw.ca>
Message-ID: <6e3ea2d1-9bfe-f388-9b6d-b6ca801391af@shaw.ca>
Date:   Wed, 15 Jul 2020 14:48:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <730bb16a-235d-9186-a486-7ed0018121ab@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfMH0j5COvh/3cCIF+Cp48ZrIeWJNwuPLoRkzUBrbC3B5zsuZDmIbZWzXtUOBSaSrf+0MvDFLUXuN/LeJWmJOOhOo6VQMfZ5+sxtyrrFDZ0iTZAZ56mdH
 YSfQcr3QiBaKngiYMqEJmgSXhAbQnLMeax0LtW/7hg2iM79TAg3fefyHuY+Dock2pdvdwSwQD+o8P5A80x0lX2DPAhlZc0A+NfMdYT+EOXyyq7qHTna+DcNS
 LUyhto666LGDotmTXEei9rzD+4Uwfk6ftuS91qhiDgJIBdG6cjrodiRKpLPZ52fA
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020-07-14 6:24 p.m., antlists wrote:
> On 15/07/2020 00:27, Roger Heflin wrote:
>> Did you create the partition before you added the disk to mdadm or
>> after?  If after was it a dos or a gpt?  Dos should have only cleared
>> the first 512byte block.  If gpt it will have written to the first
>> block and to at least 1 more location on the disk, possibly causing
>> data loss.
>>
>> If before then you at least need to get rid of the partition table
>> completely.   Having a partition on a device will often cause a number
>> of things to ignore the whole disk.  I have debugged "lost" pv's where
>> the partition effectively "blocked" lvm from even looking at the
>> entire device that the pv was one.
>
> If an explicit assemble works, then if you can get hold of a temporary 
> spare/loan disk, I'd slowly move the new disks across to partitions by 
> doing a --replace, not a --remove / --add. A replace will both keep 
> the array protected against failure, and also not stress the array 
> because it will just copy the old disk to the new, rather than 
> rebuilding the new disk from all the others.
>
> I'm not sure about the commands, but iirc mdadm has a 
> --wipe-superblock command or something, as does fdisk have something 
> to wipe a gpt, so make sure you clear that stuff out before 
> re-initialising a disk.
>
> Cheers,
> Wol

The mdadm command is --zero-superblock.

Gdisk has an expert command (option x) called zap (z) that wipes both 
the gpt and mbr.

I also in addition use dd when 're-using/re-purposing' a disk.

