Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6864337
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfGJIBw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 04:01:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:24062 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJIBw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 10 Jul 2019 04:01:52 -0400
Received: from [81.155.195.121] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hl7Xy-0002Rw-AD; Wed, 10 Jul 2019 09:01:50 +0100
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
 <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5D259B6C.8030401@youngman.org.uk>
Date:   Wed, 10 Jul 2019 09:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/07/19 00:22, Adam Goryachev wrote:
> I'm not sure why I disagree with you Wol... why is RAID10 so much better
> than a 3 disk RAID1? Linux MD you can use 3 disk RAID10 with 2 mirrors,
> but I don't think that is what you are suggesting, it would bring
> capacity up to 3TB but you can only lose one drive (same as the RAID5
> option).

Because in my very limited experience, most places have the implicit
assumption that raid-1 is two mirrors. When I was playing with raid for
writing the wiki, I tripped over that, and had a bunch of problems with
three drives. For example, you can't convert a 3-drive raid-1 to any
other raid ...
> 
> IMHO, if data resilience is your primary concern, than RAID1 x 3 drives,
> or potentially RAID10 x 3 drives with 3 mirrors if there is some
> technical implementation / performance difference I'm not aware of with
> these two options.

The problem with both raids 1 and 5 is that if a drive decides to
*corrupt* data, then as far as the raid goes you are up shit creek
without a paddle. Your data is toast. So if recovery from data
corruption is important you need to go raid 6. Given that the OP says he
takes regular backups, I'd probably go 3-drive raid-10 for speed, or
maybe 4-drive raid-6 for integrity. But you're probably better putting
an integrity-checking filesystem like btrfs on top of raid 10.

Cheers,
Wol
