Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB741E17E7
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgEYWch (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 18:32:37 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43040 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgEYWch (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 18:32:37 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdLe7-0003ln-4C; Mon, 25 May 2020 23:32:35 +0100
Subject: Re: help requested for mdadm grow error
To:     Thomas Grawert <thomasgrawert0282@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
 <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
 <e1ad56b2-df70-bc6a-9a81-333230d558c2@gmail.com>
 <358e9f6b-a989-0e4a-04c4-6efe2666159f@youngman.org.uk>
 <b5e5c7af-9d1b-3eca-f3a1-f03f8d308015@gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <37636c91-9baf-4565-9849-f8aca54e392e@youngman.org.uk>
Date:   Mon, 25 May 2020 23:32:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b5e5c7af-9d1b-3eca-f3a1-f03f8d308015@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25/05/2020 23:18, Thomas Grawert wrote:
> 
>> Okay, so we need to grep dmesg looking for a message like that above 
>> about reshaping.
>>
>> So let's grep for "md/raid" and see what we get ...
> 
> root@nas:~# dmesg | grep md/raid
> [  321.819562] md/raid:md0: not clean -- starting background reconstruction
> [  321.819564] md/raid:md0: reshape_position too early for auto-recovery 
> - aborting.
> 
> 
> (again: thanks a lot for your help. I never expected that! :-) )
> 
> 
Okay, so go back to the previous email for an example of how to revert 
the reshape - it's done exactly what I expected and the reshape has 
failed to start.

Once you've reverted the reshape, it should start fine. And with an 
up-to-date mdadm and kernel, it should start and finish reshaping fine.

So step 1, revert the reshape. Step 2, get the array back running. Step 
3, start the reshape again.

Cheers,
Wol
