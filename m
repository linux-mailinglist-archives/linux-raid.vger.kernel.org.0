Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3841AAD19
	for <lists+linux-raid@lfdr.de>; Wed, 15 Apr 2020 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410223AbgDOQKo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410221AbgDOQKn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Apr 2020 12:10:43 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CA5C061A0C
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 09:10:42 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jOkca-0004tt-PZ; Wed, 15 Apr 2020 18:10:40 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
To:     "J. Brian Kelley" <jbk@teksavvy.com>, linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <394a3255-251c-41d1-8a65-2451e5503ef9@teksavvy.com>
 <71886beb-495f-d7d5-75f2-f91a53ed4bd3@peter-speer.de>
Message-ID: <bab00844-905a-8a2e-6063-d28d21adde34@peter-speer.de>
Date:   Wed, 15 Apr 2020 18:10:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <71886beb-495f-d7d5-75f2-f91a53ed4bd3@peter-speer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1586967042;4979e3e7;
X-HE-SMSGID: 1jOkca-0004tt-PZ
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 15.04.20 17:53, Stefanie Leisestreichler wrote:
> Your hint about btrfs is new to me also even I read the docs in their 
> wiki before. I bet I will find myself in a situation/environment which 
> will be hard to administrate because of a gap of information I was 
> overseeing when I took an action which I shouldn't.

For example, found this right now in the arch forums:
https://bbs.archlinux.org/viewtopic.php?id=246390
I don't know if this is still a case but you'd probably need battery 
backup for your system. I've had cases where a power outage borks btrfs 
irrecoverably.

Post is from 2019...

Really don't know if I should cross this road...
