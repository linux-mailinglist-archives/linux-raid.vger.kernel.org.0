Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6E2C6E52
	for <lists+linux-raid@lfdr.de>; Sat, 28 Nov 2020 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgK1B6w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Nov 2020 20:58:52 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:48744 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgK1B6A (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 27 Nov 2020 20:58:00 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 20:57:57 EST
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 0AS1vXLv016469;
        Sat, 28 Nov 2020 01:57:33 GMT
From:   Nix <nix@esperi.org.uk>
To:     Mukund Sivaraman <muks@mukund.org>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Subject: Re: RAID-6 and write hole with write-intent bitmap
References: <20201124072039.GA381531@jurassic.vpn.mukund.org>
        <5FBCDC18.9050809@youngman.org.uk>
        <20201124185004.GA27132@jurassic.vpn.mukund.org>
Emacs:  the definitive fritterware.
Date:   Sat, 28 Nov 2020 01:57:33 +0000
In-Reply-To: <20201124185004.GA27132@jurassic.vpn.mukund.org> (Mukund
        Sivaraman's message of "Wed, 25 Nov 2020 00:20:04 +0530")
Message-ID: <878samckfm.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-wuwien-Metrics: loom 1290; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 24 Nov 2020, Mukund Sivaraman told this:
[...]
> (a) With RAID-5, assuming there are 4 member disks A, B, C, D, a write
> operation with its data on disk A and stripe's parity on disk B may
> involve:
>
> 1. a read of the stripe
> 2. update of data on A
> 3. computation and update of parity A^C^D on B
>
> These are not atomic updates. If power is lost between steps 2 and 3,

The writes usually proceed in parallel (because anything else would be
abominably slow). But... the problem is that the writes to the component
disks are also not atomic, and will likely not proceed at the same
rates: only with spindle-synched drives is there anything like a
guarantee of that, and those have been unobtainable for decades. So a
power loss could well lead to 500 sectors of the stripe written on disk
A, 430 sectors written on disk B... and the sectors between sector 430
and 500 are not consistent. (Disk C might well be up around sector 600,
disk D around sector 450 and there's no *way* mere parity or RAID 6
syndromes can recover from the wildly-varying mess between sectors 430
and 600... it's not like it gets recorded anywhere where a disk write
got up to before the power went out, either. But the journal avoids this
in the usual fashion for a journal, by writing out the whole thing first
and committing it to stable storage, so that on restart the incomplete
writes can just be replayed.)

-- 
NULL && (void)
