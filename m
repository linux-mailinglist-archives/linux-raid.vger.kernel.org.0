Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2401AAC54
	for <lists+linux-raid@lfdr.de>; Wed, 15 Apr 2020 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414928AbgDOPxX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404240AbgDOPxV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Apr 2020 11:53:21 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA23C061A0C
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 08:53:20 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jOkLl-0008Sj-7l; Wed, 15 Apr 2020 17:53:17 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     "J. Brian Kelley" <jbk@teksavvy.com>, linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <394a3255-251c-41d1-8a65-2451e5503ef9@teksavvy.com>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <71886beb-495f-d7d5-75f2-f91a53ed4bd3@peter-speer.de>
Date:   Wed, 15 Apr 2020 17:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <394a3255-251c-41d1-8a65-2451e5503ef9@teksavvy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1586966000;86765668;
X-HE-SMSGID: 1jOkLl-0008Sj-7l
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 15.04.20 17:02, J. Brian Kelley wrote:
> As for the final heresy, BTRFS, really not the time or place...
> 
>    - But it does provide a 'swap FILE' capability (more memory is still 
> preferable).
>    - RAID1 is not affected by the "write-hole".
>    - extremely efficient snapshots
>    - everything in the file system (no LVM, no MDADM)
> 
> The only concern is that you MUST instruct BTRFS to NOT use the entire 
> available partition (btrfs shrink) to allow leeway for a resize.

I was thinking about using btrfs too, but I am afraid of loosing data 
and making inreversable faults which could cause data loss/fragmentation 
(for databases and kvm-images, i.e.) and so on.

I have found a lot of relevant information how to use it somewhere in 
the net and how to do this and that but not the one place where all the 
dos and donts are collected to start with :-(

Your hint about btrfs is new to me also even I read the docs in their 
wiki before. I bet I will find myself in a situation/environment which 
will be hard to administrate because of a gap of information I was 
overseeing when I took an action which I shouldn't.
