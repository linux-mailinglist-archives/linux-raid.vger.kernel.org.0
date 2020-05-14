Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F371D2402
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 02:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbgENAj6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 20:39:58 -0400
Received: from smtp1.onthe.net.au ([203.22.196.249]:39150 "EHLO
        smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgENAj6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 May 2020 20:39:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.onthe.net.au (Postfix) with ESMTP id AAE25616D5;
        Thu, 14 May 2020 10:39:54 +1000 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
        by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vBfiaVZ+JKzy; Thu, 14 May 2020 10:39:54 +1000 (EST)
Received: from athena.private.onthe.net.au (chris-gw2-vpn.private.onthe.net.au [10.9.3.2])
        by smtp1.onthe.net.au (Postfix) with ESMTP id 530D5616CA;
        Thu, 14 May 2020 10:39:54 +1000 (EST)
Received: by athena.private.onthe.net.au (Postfix, from userid 1026)
        id 3E1DD6804DE; Thu, 14 May 2020 10:39:54 +1000 (AEST)
Date:   Thu, 14 May 2020 10:39:54 +1000
From:   Chris Dunlop <chris@onthe.net.au>
To:     John Stoffel <john@stoffel.org>
Cc:     Michal Soltys <msoltyspl@yandex.pl>, linux-raid@vger.kernel.org
Subject: Re: [general question] rare silent data corruption when writing data
Message-ID: <20200514003954.GA23874@onthe.net.au>
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
 <20200513063127.GA2769@onthe.net.au>
 <24252.13078.107482.898516@quad.stoffel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <24252.13078.107482.898516@quad.stoffel.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 13, 2020 at 01:49:10PM -0400, John Stoffel wrote:
> I wonder if this problem can be replicated on loop devices?  Once
> there's a way to cause it reliably, we can then start doing a
> bisection of the kernel to try and find out where this is happening.

I ran a week or so of attempting to replicate the problem in a VM on loop 
devices replicating the lvm/raid config, without success. Basically just 
having a random bunch of 1-25 concurrent writers banging out middling to 
largish files.

The fact it wasn't replicable in that environment could be pointing 
towards the LSI driver or hardware - or I simply wasn't able to match  
the conditions well enough.

> So far, it looks like it happens sometimes on bare RAID6 systems
> without lv-thin in place, which is both good and bad.  And without
> using VMs on top of the storage either.  So this helps narrow down the
> cause.

Note: We don't have any bare RAID6 so I haven't seen it there: our main fs 
is xfs on sequential LVM on raid6 (6 x 11-disk sets), and we saw it once 
on xfs directly on HDD partition.

> Is there any info on the work load on these systems?  Lots of small
> fils which are added/removed?  Large files which are just written to
> and not touched again?

Large files written and not touched again. Most of the time 2-5 concurrent 
writers but regularly (daily) up to 20-25 concurrent.

> I assume finding a bad file with corruption and then doing a cp of the
> file keeps the same corruption?

Yep.
