Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4505211F2EE
	for <lists+linux-raid@lfdr.de>; Sat, 14 Dec 2019 18:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLNRgd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 14 Dec 2019 12:36:33 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:48944 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLNRgd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 14 Dec 2019 12:36:33 -0500
Received: from [86.148.134.145] (helo=[192.168.1.162])
        by smtp.hosts.co.uk with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1igBLD-0005j4-3L; Sat, 14 Dec 2019 17:36:31 +0000
Subject: Re: Help recover from interrupted reshape.
To:     Angus Montgomery <sugna@gmx.com>, linux-raid@vger.kernel.org
References: <149182d7-7c9b-f40d-781a-8ba9f266959d@gmx.com>
From:   Wol <antlists@youngman.org.uk>
Message-ID: <84788a78-7526-33d7-f930-d82bdc9c826f@youngman.org.uk>
Date:   Sat, 14 Dec 2019 17:36:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <149182d7-7c9b-f40d-781a-8ba9f266959d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/12/2019 01:32, Angus Montgomery wrote:
> Hi RAIDers
> 
> I did a silly thing and now I'm stuck.
> I rebooted with an unstarted/in-progress raid5 reshape from 3 disks to 4
> (reshape position is 0).
> The backup file is gone.

This looks very promising. The fact it's stuck at zero means that it 
hasn't started, so if we can force the revert, everything will be fine. 
Plus it's actually a well-known problem - I'm sure if you search the 
list archives you'll find plenty of examples of it. I'm sorry, though, I 
can't give you the fix off the top of my head.

One important detail you appear to have missed, though, that would be 
good is what version of linux / mdadm you're running. Can you give us 
the output of "uname -a" and "mdadm --version"?

I can't say for certain that it will work, but I strongly suspect if you 
get an up-to-date rescue CD with the latest mdadm, it'll sort out your 
revert, and then fix your reshape.

Note that you shouldn't need a backup file, and you're much better 
without one unless mdadm insists.

Cheers,
Wol
