Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE8E9218
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfJ2Vdk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 17:33:40 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:27004 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJ2Vdj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 17:33:39 -0400
Received: from [86.155.171.62] (helo=[192.168.1.78])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iPZ7R-0003mU-5f; Tue, 29 Oct 2019 21:33:38 +0000
Subject: Re: raid0 layout issue documentation / confusions
To:     Andreas <a@hegyi.info>, linux-raid@vger.kernel.org
References: <1389f13b-eaf0-7ae2-d99b-697ae008f2c9@hegyi.info>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <ea1d4d12-0b92-ab2f-3911-0de21f1a40ee@youngman.org.uk>
Date:   Tue, 29 Oct 2019 22:33:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1389f13b-eaf0-7ae2-d99b-697ae008f2c9@hegyi.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/10/2019 21:21, Andreas wrote:
> (I wanted to react to the thread "admin-guide page for raid0 layout 
> issue", but I just registered and I don't know how to respond to
> existing messages.)

Just read a message in your email client and hit "reply" - unless you're 
not reading the mailing list as email?
> 
> I would like to make some suggestions regarding the recent raid0 layout 
> patch, as it made my system unbootable, and it took me quite some time 
> to figure out what was wrong and how to fix it. I also encountered 
> confusion on the web. I am just a regular user, not a programmer or 
> linux guru, so take my suggestions as such.

Bear mind that the layout only changed as a result of a bug slipping 
through - the layout should not have changed. The problem is that once 
it got in to the wild, we have to live with it. There's nowhere in the 
metadata for it to go, because it shouldn't have been needed. It 
couldn't be reverted because that would break any arrays created with 
the "faulty" kernel. So what to do?

At the end of the day, the devs have done their best to fix an issue 
that should never have happened. But shit does happen, unfortunately.

Cheers,
Wol
