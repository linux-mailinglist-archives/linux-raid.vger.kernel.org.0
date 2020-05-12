Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736A1CFFE3
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgELUyW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 16:54:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54111 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELUyV (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 12 May 2020 16:54:21 -0400
Received: from [86.146.232.119] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jYbut-0003Cd-FG; Tue, 12 May 2020 21:54:20 +0100
Subject: Re: raid6check extremely slow ?
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Peter Grandi <pg@lxraid.list.sabi.co.uk>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com>
 <24249.54587.74070.71273@base.ty.sabi.co.uk> <20200512160943.GC7261@lazy.lzy>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <34f66548-1fcf-d38b-4c2d-88d43c1b19d0@youngman.org.uk>
Date:   Tue, 12 May 2020 21:54:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512160943.GC7261@lazy.lzy>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/05/2020 17:09, Piergiorgio Sartor wrote:
> About the check -> maybe lock -> re-check,
> it is a possible workaround, but I find it
> a bit extreme.

This seems the best (most obvious?) solution to me.

If the system is under light write pressure, and the disk is healthy, it 
will scan pretty quickly with almost no locking.

If the system is under heavy pressure, chances are there'll be a fair 
few stripes needing rechecking, but even at it's worst it'll only be as 
bad as the current setup.

And if the system is somewhere inbetween, you still stand a good chance 
of a fast scan.

At the end of the day, the rule should always be "lock only if you need 
to" so looking for problems with an optimistic no-lock scan, then 
locking only if needed to check and fix the problem, just feels right.

Cheers,
Wol
