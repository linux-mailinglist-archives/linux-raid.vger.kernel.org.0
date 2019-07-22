Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B940270067
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2019 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfGVNB3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 09:01:29 -0400
Received: from hmm.wantstofly.org ([138.201.34.84]:33694 "EHLO
        mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVNB3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 09:01:29 -0400
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id F18177F39C; Mon, 22 Jul 2019 16:01:27 +0300 (EEST)
Date:   Mon, 22 Jul 2019 16:01:27 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Subject: Re: slow BLKDISCARD on RAID10 md block devices
Message-ID: <20190722130127.GH2080@wantstofly.org>
References: <20190717090200.GD2080@wantstofly.org>
 <20190717113352.GA13079@metamorpher.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717113352.GA13079@metamorpher.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 17, 2019 at 01:33:52PM +0200, Andreas Klauer wrote:

> > Any ideas on what I can try to speed this up?
> 
> I can't help with the kernel side of things.
> Hopefully it can be improved somehow.
> 
> But until there is a fix you could maybe work around it 
> with fstrim --offset and --length and --minimum options 
> to trim a smaller segment at a time instead of everything.
> 
> (You get this behavior for free with ext4, as long as 
>  you don't reboot/remount the filesystem it avoids 
>  trimming the same areas over and over - XFS trims all.)
> 
> Total time (this is tmpfs-backed, no real I/O)
> 
> | # time fstrim -v /mnt/tmp/
> | /mnt/tmp/: 14 TiB (15360592805888 bytes) trimmed
> |
> | real	4m8.962s
> | user	0m0.000s
> | sys	0m44.533s
> 
> Segment time (pick a size that works for you)
> 
> (Why XFS trims 900G when I said 500G is a bit of a mystery...
>  this option is only rarely used, perhaps some testing is in order?
>  Not sure if it's perfectly safe...!)
> 
> | # time fstrim -v --minimum 64M --offset 0G --length 500G /mnt/tmp/
> | /mnt/tmp/: 894.2 GiB (960171012096 bytes) trimmed
> | 
> | real	0m16.183s
> | user	0m0.004s
> | sys	0m2.782s
> 
> And instead of offset 0G you could give (if it's a daily cron) 
> it as "$(( $(date +%j) % totalsegments * length ))G" or something 
> of the like, to cover the entire array every so many days.
> 
> Not a fix in any way but maybe a workaround to make it more bearable.

Thanks for your reply!

I tried something like this, and indeed, as you say, xfs seems to trim
more than you ask it to.  From looking at the code, it seems benign --
it just seems to trim allocation groups (AGs) that overlap with your
range, and so it can end up trimming a larger range than intended.
Unfortunately, my allocation groups are sized such that trimming the
minimum range at a time still produces long stalls. :-/

ext4 indeed seems to remember what it has trimmed before, which is
probably why I haven't run into this issue before on ext4.  It does
appear to reproduce on ext4 after a remount or a reboot.
