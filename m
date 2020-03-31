Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5D1988D7
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 02:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgCaAYo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 20:24:44 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40640 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgCaAYo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Mar 2020 20:24:44 -0400
Received: from [81.153.42.4] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jJ4hu-0007LA-77; Tue, 31 Mar 2020 01:24:42 +0100
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Daniel Jones <dj@iowni.com>, linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
Date:   Tue, 31 Mar 2020 01:24:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 31/03/2020 01:04, Daniel Jones wrote:
> I am genuinely over my head at this point and unsure how to proceed.
> My logic tells me the best choice is to attempt a --create to try to
> rebuild the missing superblocks, but I'm not clear if I should try
> devices=4 (the true size of the array) or devices=3 (the size it was
> last operating in).  I'm also not sure of what device order to use
> since I have likely scrambled /dev/sd[bcde] and am concerned about
> what happens when I bring the previously disable drive back into the
> array.

Don't even THINK of --create until the experts have chimed in !!!

https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

The lsdrv information is crucial - that recovers pretty much all the 
config information that is available, and massively increases the 
chances of a successful --create, if you do have to go down that route...

If your drives are 1TB, I would *seriously* consider getting hold of a 
4TB drive - they're not expensive - to make a backup. And read up on 
overlays.

Hopefully we can recover your data without too much grief, but this will 
all help.

Cheers,
Wol
