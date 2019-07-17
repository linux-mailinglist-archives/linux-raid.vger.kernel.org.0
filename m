Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC996BB81
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 13:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfGQLdz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 07:33:55 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:41208 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQLdz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 17 Jul 2019 07:33:55 -0400
Received: (qmail 812 invoked from network); 17 Jul 2019 11:33:53 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 17 Jul 2019 11:33:53 -0000
Date:   Wed, 17 Jul 2019 13:33:52 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: slow BLKDISCARD on RAID10 md block devices
Message-ID: <20190717113352.GA13079@metamorpher.de>
References: <20190717090200.GD2080@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717090200.GD2080@wantstofly.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 17, 2019 at 12:02:00PM +0300, Lennert Buytenhek wrote:
> Any ideas on what I can try to speed this up?

I can't help with the kernel side of things.
Hopefully it can be improved somehow.

But until there is a fix you could maybe work around it 
with fstrim --offset and --length and --minimum options 
to trim a smaller segment at a time instead of everything.

(You get this behavior for free with ext4, as long as 
 you don't reboot/remount the filesystem it avoids 
 trimming the same areas over and over - XFS trims all.)

Total time (this is tmpfs-backed, no real I/O)

| # time fstrim -v /mnt/tmp/
| /mnt/tmp/: 14 TiB (15360592805888 bytes) trimmed
|
| real	4m8.962s
| user	0m0.000s
| sys	0m44.533s

Segment time (pick a size that works for you)

(Why XFS trims 900G when I said 500G is a bit of a mystery...
 this option is only rarely used, perhaps some testing is in order?
 Not sure if it's perfectly safe...!)

| # time fstrim -v --minimum 64M --offset 0G --length 500G /mnt/tmp/
| /mnt/tmp/: 894.2 GiB (960171012096 bytes) trimmed
| 
| real	0m16.183s
| user	0m0.004s
| sys	0m2.782s

And instead of offset 0G you could give (if it's a daily cron) 
it as "$(( $(date +%j) % totalsegments * length ))G" or something 
of the like, to cover the entire array every so many days.

Not a fix in any way but maybe a workaround to make it more bearable.

Regards
Andreas Klauer
