Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54252205616
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbgFWPgy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 11:36:54 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:21214 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733031AbgFWPgx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jun 2020 11:36:53 -0400
Received: from host86-169-220-126.range86-169.btcentralplus.com ([86.169.220.126] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jnkyg-0008A6-Fp; Tue, 23 Jun 2020 16:36:51 +0100
Subject: Re: RAID types & chunks sizes for new NAS drives
To:     John Stoffel <john@stoffel.org>, Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <rco1i8$1l34$1@ciao.gmane.io>
 <24305.24232.459249.386799@quad.stoffel.home>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <290bc100-6fb4-84bc-83ac-eed1be3d8cb6@youngman.org.uk>
Date:   Tue, 23 Jun 2020 16:36:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <24305.24232.459249.386799@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 23/06/2020 02:45, John Stoffel wrote:
> In any case, make sure you get NAS rated disks, either the newest WD
> RED+ (or is it Blue?)  In any case, make sure to NOT get the SMR
> (Shingled Magnetic Recording) format drives.  See previous threads in
> this group, as well as the arstechnica.com discussion about it all
> that they disk last month.  Very informative.

I'd just avoid WD completely. They advertise REDs as raid-capable, and 
they are (mostly) SMR and unfit for purpose. BLUEs are supposedly the 
"desktop performance" drives, so sticking them in a raid is not advised 
anyway. But you've only got to start hammering your BLUE performance 
drive, and performance would be abysmal. If you are going for WD then 
RED PRO is what you need.

At least Seagate don't advertise unsuitable drives - DON'T touch 
Barracudas! They say Ironwolf or Ironwolf Pro for raid, both are fine to 
the best of my knowledge.

And nobody seems to buy Toshiba but - I think it's the N300 - they do a 
raid range as well.

Don't buy REDs or Barracudas or other known-problematic drives. They 
will appear to work fine until there's a problem, at which point they 
will bork the raid and lose your data. A good raid drive will tell the 
raid it's failed and let the raid recover. These problem drives DON'T 
tell the raid what's going on, and by the time the raid finds out it's 
too late.

Cheers,
Wol
