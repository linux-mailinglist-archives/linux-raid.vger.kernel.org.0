Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532C71A5DD4
	for <lists+linux-raid@lfdr.de>; Sun, 12 Apr 2020 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgDLJiu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Apr 2020 05:38:50 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13622 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgDLJiu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 12 Apr 2020 05:38:50 -0400
Received: from [81.157.200.200] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jNZ4i-000BXj-41; Sun, 12 Apr 2020 10:38:48 +0100
Subject: Re: Is it possible to create a single zone RAID0 with different size
 member disks?
To:     Roman Mamedov <rm@romanrm.net>,
        Fisher <fisherthepooh@protonmail.com>
References: <5ng5lZpZoJjtdf9Xkshn3CSzsLIErcNWAzPPARDbDdzNY9Kr-tgMjy6djUaqRVo9r9KmB2HMV0ZQuurdV7wNDYGOP4azAiw1jPkcoF10-SM=@protonmail.com>
 <20200412141259.14955b2e@natsu>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E92E1A6.5000107@youngman.org.uk>
Date:   Sun, 12 Apr 2020 10:38:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200412141259.14955b2e@natsu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/04/20 10:12, Roman Mamedov wrote:
> You can make one 4x2TB RAID0, and one 2x1TB RAID0 from the tails of 3TB disks.
> 
> Or 4x2TB RAID5 and 2x1TB RAID1.

This last would be way the best.

Remember, with raid-0 you only need ONE failure to trash your partition.
And with say four disks, you quadruple your chances of said failure.

What size are these disks? And given the price of disks, if you're
trying to combine small disks ( <1TB typically) what's the point? It'll
probably cost more in electric to run all these disks than to just buy a
new large disk and bin the old ones.

Cheers,
Wol
