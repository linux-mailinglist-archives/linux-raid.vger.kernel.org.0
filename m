Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E21BDCC6
	for <lists+linux-raid@lfdr.de>; Wed, 29 Apr 2020 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD2M5W (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Apr 2020 08:57:22 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:33828 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2M5W (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 Apr 2020 08:57:22 -0400
Received: from srv.home ([10.8.0.1] ident=heh4857)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1jTmG2-0005GG-Jd; Wed, 29 Apr 2020 20:56:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=wYUPOHqKxac/+9pxir2IC5/728S8ro7dWI8ZpSwJ0js=;
        b=l8IXF/4JQkorywi71CvcVMTB41gd0BnXQP1QP24N2ERb6NRziOOnGrO/RbTq/8+XIEPgV9rc3iKOQGSvUv4OVHdT0WquexB0QtQItBcsrpI4wZjZeaucKOiEYIxcOb4bn+BJ/t+QI2wrzMJ9aTCOUxRtkUQTkUNgreCTmy8vCZw=;
Subject: Re: Does a "check" of a RAID6 actually read all disks in a stripe?
To:     Phil Turmel <philip@turmel.org>, linux-raid@vger.kernel.org
References: <18271293-9866-1381-d73e-e351bf9278fd@fnarfbargle.com>
 <1ccd57ba-9d9a-d10e-4efd-dc0e8a5cf162@fnarfbargle.com>
 <e02412eb-d7f3-cea8-7398-4e5c0d749f43@turmel.org>
 <1d7fe96e-d87a-185d-1599-84cc445383cf@fnarfbargle.com>
 <f45df6fc-63eb-a1da-ca0c-5a3db08b454a@turmel.org>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <a1ebabac-6674-2907-55a6-41479c469232@fnarfbargle.com>
Date:   Wed, 29 Apr 2020 20:56:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f45df6fc-63eb-a1da-ca0c-5a3db08b454a@turmel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 28/4/20 10:41 pm, Phil Turmel wrote:
> On 4/28/20 10:00 AM, Brad Campbell wrote:
>>
>> On 28/4/20 9:47 pm, Phil Turmel wrote:
>
>>> The bad block log misfeature is turned on.  Any blocks recorded in it will never be read again by MD, last I looked.  This might explain what you are seeing.
>>>

test:/sys/block/md3/md# mdadm --examine-badblocks /dev/sd[ceghijklm]
Bad-blocks list is empty in /dev/sdc
Bad-blocks list is empty in /dev/sde
Bad-blocks list is empty in /dev/sdg
Bad-blocks list is empty in /dev/sdh
Bad-blocks list is empty in /dev/sdi
Bad-blocks list is empty in /dev/sdj
Bad-blocks list is empty in /dev/sdk
Bad-blocks list is empty in /dev/sdl
Bad-blocks list is empty in /dev/sdm

>> While I see where you are going, the fact it corrected the bad sector by re-writing it during the re-build would intimate that isn't/wasn't the case.
>
> Ah, yes.  Any chance you have set the sysfs sector limits on a check and haven't reset them?
>
> Phil
>
No. Each run was triggered by an :

echo check > /sys/block/md3/md/sync_action

No other interaction with sysfs.

I have a few drives in another machine I can abuse, so I have some time put aside on the weekend to set up a couple of small test arrays. When I last tried (admittedly years ago now) it was easy enough to "create" bad blocks with hdparm.

I think Piergiorgio was on the money with something not reading one of the parity blocks, but I've read the code several times and can't see obviously how that might be the case. I suppose examining a check with blktrace would highlight it if that were the case. I might try that first.

On the topic of the bbl. Is there any way to remove it or mark it for removal while an array is active? For example, on an array used as the root filesystem, where stopping and restarting is a "take the machine down and boot from a live-cd" sort of affair. All of my arrays have the bbl enabled. It has never caused me an issue, but looking at it I can see how that might be possible.

Regards,

Brad

