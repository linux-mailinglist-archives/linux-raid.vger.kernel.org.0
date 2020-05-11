Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30EB1CD753
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEKLLv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 07:11:51 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:56087 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgEKLLv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 07:11:51 -0400
Received: from mxback16o.mail.yandex.net (mxback16o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::67])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 357009409AB;
        Mon, 11 May 2020 14:11:48 +0300 (MSK)
Received: from iva8-174eb672ffa9.qloud-c.yandex.net (iva8-174eb672ffa9.qloud-c.yandex.net [2a02:6b8:c0c:b995:0:640:174e:b672])
        by mxback16o.mail.yandex.net (mxback/Yandex) with ESMTP id ZV1BNcSITM-BmOKB1Dj;
        Mon, 11 May 2020 14:11:48 +0300
Received: by iva8-174eb672ffa9.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 8BWtEuNnZy-Bl2mAKpE;
        Mon, 11 May 2020 14:11:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
From:   Michal Soltys <msoltyspl@yandex.pl>
To:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
Cc:     song@kernel.org
Message-ID: <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
Date:   Mon, 11 May 2020 13:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/10/20 1:57 AM, Michal Soltys wrote:
> Anyway, I did some tests with manually snapshotted component devices 
> (using dm snapshot target to not touch underlying devices).
> 
> The raid manages to force assemble in read-only mode with missing 
> journal device, so we probably will be able to recover most data 
> underneath this way (as a last resort).
> 
> The situation I'm in now is likely from uncelan shutdown after all (why 
> the machine failed to react to ups properly is another subject).
> 
> I'd still want to find out why is - apparently - a journal device giving 
> issues (contrary to what I'd expect it to do ...), with notable mention of:
> 
> 1) mdadm hangs (unkillable, so I presume in kernel somewhere) and eats 1 
> cpu when trying to assemble the raid with journal device present; once 
> it happens I can't do anything with the array (stop, run, etc.) and can 
> only reboot the server to "fix" that
> 
> 2) mdadm -D shows nonsensical device size after assembly attempt (Used 
> Dev Size : 18446744073709551615)
> 
> 3) the journal device (which itself is md raid1 consisting of 2 ssds) 
> assembles, checks (0 mismatch_cnt) fine - and overall looks ok.
> 
> 
>  From other interesting things, I also attempted to assemble the raid 
> with snapshotted journal. From what I can see it does attempt to do 
> something, judging from:
> 
> dmsetup status:
> 
> snap_jo2: 0 536870912 snapshot 40/33554432 16
> snap_sdi1: 0 7812500000 snapshot 25768/83886080 112
> snap_jo1: 0 536870912 snapshot 40/33554432 16
> snap_sdg1: 0 7812500000 snapshot 25456/83886080 112
> snap_sdj1: 0 7812500000 snapshot 25928/83886080 112
> snap_sdh1: 0 7812500000 snapshot 25352/83886080 112
> 
> But it doesn't move from those values (with mdadm doing nothing eating 
> 100% cpu as mentioned earlier).
> 
> 
> Any suggestions how to proceed would very be appreciated.


I've added Song to the CC. If you have any suggestions how to 
proceed/debug this (mdadm stuck somewhere in kernel as far as I can see 
- while attempting to assembly it).

For the record, I can assemble the raid successfully w/o journal (using 
snapshotted component devices as above), and we did recover some stuff 
this way from some filesystems - but for some other ones I'd like to 
keep that option as the very last resort.
