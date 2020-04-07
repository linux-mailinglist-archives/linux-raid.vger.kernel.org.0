Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB821A0FE6
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgDGPIz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 11:08:55 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:20545 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbgDGPIz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Apr 2020 11:08:55 -0400
Received: from [81.153.42.4] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jLpqP-0001T9-4I; Tue, 07 Apr 2020 16:08:53 +0100
Subject: Re: Raid-6 cannot reshape
To:     Alexander Shenkin <al@shenkin.org>,
        Phil Turmel <philip@turmel.org>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
 <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
 <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
 <5E8B5865.9060107@youngman.org.uk>
 <08d66411-5045-56e1-cbad-7edefa94a363@turmel.org>
 <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
 <b9bb796e-08cd-e10a-d345-992e5f3abea7@turmel.org>
 <618f5171-785f-09b0-8748-d2549d22c0ab@shenkin.org>
 <38852671-9c5a-3807-0284-41f902e5f81b@turmel.org>
 <44069d88-f838-2b8b-1002-a1fff5502d2d@turmel.org>
 <61e30bc4-469f-32ed-06e8-d1b4e1fd6740@shenkin.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <572ec112-21ff-7da5-81d2-a91b08277a2c@youngman.org.uk>
Date:   Tue, 7 Apr 2020 16:08:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <61e30bc4-469f-32ed-06e8-d1b4e1fd6740@shenkin.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/04/2020 14:19, Alexander Shenkin wrote:
> Re re-growing, I was hoping that running on a newer mdadm (4.1) might
> fix the problem, and if i still encountered it, perhaps running the
> following might unstick it:
> 
> echo frozen > /sys/block/md0/md/sync_action
> echo reshape > /sys/block/md0/md/sync_action
> 
> But, I personally have no idea what happened (really), nor why...:-(

iirc pretty much all these reports come from oldish Ubuntu systems ...

What happened *could* be that you have an updated franken-kernel, plus 
an old mdadm, and the mess needs an Igor to stitch it all together...

If you ARE going to try the grow again, I'd use an up-to-date recovery 
system to run the grow, and then reboot back in to the old Ubuntu once 
your system is back.

And seriously think about upgrading your distro to the latest LTS.

Cheers,
Wol
