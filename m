Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2791F257D
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 03:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKGChj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 21:37:39 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:12572 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfKGChj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 6 Nov 2019 21:37:39 -0500
Received: from [81.148.226.176] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iSXg0-0000m5-46; Thu, 07 Nov 2019 02:37:37 +0000
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Roger Heflin <rogerheflin@gmail.com>
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
 <dc736544-465e-f4eb-ca6d-e7b135074839@redhat.com>
 <5DC2FA31.6060503@youngman.org.uk>
 <CAAMCDeeki_a8cXaOGKynBjzUwdkj3bqLndowAK00gPQs++-goQ@mail.gmail.com>
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DC3836F.7040302@youngman.org.uk>
Date:   Thu, 7 Nov 2019 02:37:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDeeki_a8cXaOGKynBjzUwdkj3bqLndowAK00gPQs++-goQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/11/19 00:57, Roger Heflin wrote:
> A lot would depend on what you get back from the disk.  If it reports
> an actual confirmed media error generally it means the disk tried up
> to it set time, if you get a failed to respond that would be something
> to retry, but I think a failure to respond is not generally retried.
> At one second with a average seek time of 10ms that means it attempted
> to reread that sector close to 100 times without success.

And if the problem is down to the drive firmware, tearing down the read
and starting again from scratch stands every chance of succeeding ...

All I know is that anecdata says that cancelling the read and issuing a
new read is often successful. Your logic is  impeccable, but to the best
of my (poor) knowledge reality says otherwise ... :-)

Hopefully someone with experience of how drives behave "in the wild"
will chime in and tell us what really happens.

Cheers,
Wol
