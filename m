Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47A3893FD
	for <lists+linux-raid@lfdr.de>; Wed, 19 May 2021 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355354AbhESQms (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 May 2021 12:42:48 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39950 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355170AbhESQmr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 19 May 2021 12:42:47 -0400
Received: from host109-154-217-227.range109-154.btcentralplus.com ([109.154.217.227] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ljPGA-0005ni-Eq; Wed, 19 May 2021 17:41:26 +0100
Subject: Re: My superblocks have gone missing, can't reassemble raid5
To:     Leslie Rhorer <lesrhorer@att.net>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <CA+o1gzBcQF_JeiC7Nv_zEBmJU2ypwQ_+RkbcZOOt0qOK1MkQww@mail.gmail.com>
 <c99e3bac-469a-0b48-31df-481754c477c7@att.net>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <cceec847-e2e2-3d7f-008e-e3f1fac9ca20@youngman.org.uk>
Date:   Wed, 19 May 2021 17:41:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c99e3bac-469a-0b48-31df-481754c477c7@att.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/05/2021 15:48, Leslie Rhorer wrote:
>      Then I would try recreating the RAID based upon the earlier Examine 
> report:
> 
> mdadm -C -f -n 3 -l 5 -e 1.2 -c 512 -p ls /dev/md99 /dev/loop2 
> /dev/loop0 /dev/loop1
> 
>      You may notice some of the command switches are defaults.  Remember 
> what I said about a belt and suspenders?  Personally, in such a case I 
> would not rely on defaults.

Because defaults change?
> 
>      Now try running a check on the assembled array:
> fsck /dev/md99
> 
>      If that fails, shutdown the array with
> 
> mdadm -S /dev/md99
> 
>      and then try creating the array with a different drive order.  
> There are only two other possible permutations of three disks.  If none 
> of those work, you have some more serious problems.

And here you are oversimplifying the problem immensely. If those three 
drives aren't the originals, then the chances are HIGH that a simple 
re-assembly/creation is going to fail your simplistic scenario.

That said, I couldn't agree more about getting new drive(s) to take a 
backup before attempting recovery ...

Cheers,
Wol
