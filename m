Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F131DEC6
	for <lists+linux-raid@lfdr.de>; Wed, 17 Feb 2021 19:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhBQSEn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Feb 2021 13:04:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:45049 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234782AbhBQSE2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Feb 2021 13:04:28 -0500
Received: from host86-162-184-82.range86-162.btcentralplus.com ([86.162.184.82] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1lCRAt-0008Nr-BT; Wed, 17 Feb 2021 18:03:43 +0000
Subject: Re: use ssd as write-journal or lvm-cache?
To:     Peter Grandi <pg@mdraid.list.sabi.co.UK>,
        list Linux RAID <linux-raid@vger.kernel.org>
References: <CAC6SzHLHq9yX+dtcYwYyhfoTufFYohg_ZMmaSv6-HVt4e-m-hA@mail.gmail.com>
 <24620.56829.93946.65275@cyme.ty.sabi.co.uk>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <58ea0f6f-eb90-98e1-5f51-148fc0367843@youngman.org.uk>
Date:   Wed, 17 Feb 2021 18:03:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <24620.56829.93946.65275@cyme.ty.sabi.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 17/02/2021 09:12, Peter Grandi wrote:
>> I was to use ssd to cache my mdadm-raid5 + lvm storage.

> Not that sure that layering MDADM on top of DM/LVM2 is always a
> good idea, I tend to prefer to keep things simple.
> 
Is that what the OP is doing? I don't think putting raid on top of lvm 
is a good idea, which is why I'm putting lvm on top of raid.

Whatever, I guess you're better putting the cache on the bottom layer, 
just above the actual hardware. In my case, that would be caching the raid.

Cheers,
Wol
