Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269B41DED38
	for <lists+linux-raid@lfdr.de>; Fri, 22 May 2020 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgEVQ0v (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 22 May 2020 12:26:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:10295 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbgEVQ0v (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 22 May 2020 12:26:51 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jcAVV-000Awt-7P
        for linux-raid@vger.kernel.org; Fri, 22 May 2020 17:26:49 +0100
Subject: Re: WD Red drives are now SMR drives?
From:   antlists <antlists@youngman.org.uk>
To:     Linux RAID <linux-raid@vger.kernel.org>
References: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
Message-ID: <b183a091-da81-0832-f1b6-a53738024eb1@youngman.org.uk>
Date:   Fri, 22 May 2020 17:26:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/05/2020 00:38, antlists wrote:
> Has anyone else picked up on this? Apparently 1TB and 8TB drives are 
> still CMR, but new drives between 2 and 6 TB are now SMR drives.
> 
> https://www.extremetech.com/computing/309730-western-digital-comes-clean-shares-which-hard-drives-use-smr 
> 
> 
> What impact will this have on using them in raid arrays?
> 
Following up, two more articles ...

https://blocksandfiles.com/2020/04/15/shingled-drives-have-non-shingled-zones-for-caching-writes/

https://blocksandfiles.com/2020/04/15/seagate-2-4-and-8tb-barracuda-and-desktop-hdd-smr/

https://blocksandfiles.com/2020/04/16/toshiba-desktop-disk-drives-undocumented-shingle-magnetic-recording/

Note that for both Seagate and Toshiba it's only Desktop drives, and 
their raid lines are unaffected.

It's interesting to note that the interviewee in the first article is 
assuming that the WD firmware is buggy ... :-)

Cheers,
Wol
