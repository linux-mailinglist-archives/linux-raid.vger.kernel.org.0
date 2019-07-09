Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7E63E42
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 01:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGIXIQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 19:08:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:34549 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfGIXIQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 9 Jul 2019 19:08:16 -0400
X-Greylist: delayed 1266 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 19:08:15 EDT
Received: from [81.155.195.121] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hkyt9-0003B3-4U; Tue, 09 Jul 2019 23:47:07 +0100
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Luca Lazzarin <luca.lazzarin@gmail.com>, linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5D25196A.9020606@youngman.org.uk>
Date:   Tue, 9 Jul 2019 23:47:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 09/07/19 23:17, Luca Lazzarin wrote:
> Hi all,
> 
> actually a server of mine has a 2x1TB Raid 1 array.
> The disks are becoming old and to avoid possible problems I would like
> to replace them.
> 
> Moving from 1TB of space to 2TB could be enough, but since I have to buy
> the new disks I am considering different possibilities, which are:
> 1) 2x2TB Raid 1 array;
> 2) 3x2TB Raid 1 array;
> 3) 3x1TB Raid 5 array;
> 4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
> probably are enough for the next 10 year);
> 5) 4x1TB Raid 6 array.
> 
> Which one, in your opinion, would the the best solution?

What's the price difference between 1TB and 2TB drives? Significant, or
not much? If the price difference isn't that much I'd go for the larger
drives every time.
> 
> Thank you for your suggestions.
> 
Do you have spare disks to back up on to? The problem with both raids 1
and 5 is that if you have an error, you don't know which data is
correct, unless you run a check-summing file system on top or something
like that. At least with raid 6 you can run a repair utility that will
try to correct your data.

Is speed important? raid 1 is probably best. I wouldn't run raid 1 over
three disks - if you're thinking of that you're probably better off with
raid 10.

If you want more definite answers than this, though, you're going to
have to provide more information about how the server is used - is it
home or business, is speed or resilience more important, what do you
actually want from the array? Each version has pros and cons.

Cheers,
Wol

