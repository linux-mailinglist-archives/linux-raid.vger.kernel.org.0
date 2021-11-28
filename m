Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F954607C7
	for <lists+linux-raid@lfdr.de>; Sun, 28 Nov 2021 18:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhK1RFG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 28 Nov 2021 12:05:06 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:17383 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243266AbhK1RDF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 28 Nov 2021 12:03:05 -0500
Received: from host81-132-12-162.range81-132.btcentralplus.com ([81.132.12.162] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1mrNWl-0002cU-93
        for linux-raid@vger.kernel.org; Sun, 28 Nov 2021 16:59:48 +0000
Message-ID: <12dd9f53-aab2-c487-9663-b799c2d0e8dd@youngman.org.uk>
Date:   Sun, 28 Nov 2021 16:59:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Nothing wrong, but is my website advice wonky?
Content-Language: en-GB
From:   Wol <antlists@youngman.org.uk>
To:     linux-raid <linux-raid@vger.kernel.org>
References: <1c63e476-b253-cb17-3299-f9d09453ee19@youngman.org.uk>
In-Reply-To: <1c63e476-b253-cb17-3299-f9d09453ee19@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Problem solved! My usual problem of missing the detail...

I'd described starting with a 2-drive mirror and converting it to a 
3-drive raid-5. I was actually starting with a 2-active-1-spare mirror ...

Cheers,
Wol

On 28/11/2021 09:25, Wols Lists wrote:
> Finally upgrading my system to raid-5 - two Seagate Ironwolves and a 
> Barracuda ... :-(
> 
> As per my own advice, I added the third drive as a spare, then grew the 
> array to raid-5 in two separate commands.
> 
> Trying to track what's going on, "cat /proc/mdstat" just shows two 
> drives as sync'ing. "mdadm --detail" shows two active drives and a spare.
> 
> The drives are quite clearly working away - as I would expect.
> 
> So. What I *think* is happening is that my mirror is upgrading to a 
> 2-disk raid-5, and when that's finished it will add the spare and 
> upgrade to a full 3-disk raid-5. Does that sound right?
> 
> What I *hoped* would happen (and thought *should* happen) was that it 
> would spot the third drive, add it, and just resync straight away to 
> full raid-5.
> 
> So at 7 or 8hrs per pass (3TB per drive) I'm now looking at my upgrade 
> taking about 15 hours. Whoops.
> 
> So basically, does my scenario sound right? Would have explicitly 
> changing raid-devices to 3 at the same time as converting to raid-5 
> improved matters?
> 
> Okay, I'm going to build a new raid-testing computer in the near future 
> so testing this sort of thing will be easy, but that is predicated on me 
> finding enough time without upsetting the wife ...
> 
> Cheers,
> Wol
