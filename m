Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA32494A9E
	for <lists+linux-raid@lfdr.de>; Mon, 19 Aug 2019 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHSQk4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Aug 2019 12:40:56 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:43653 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSQk4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 19 Aug 2019 12:40:56 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1hzkiE-00073z-3x by authid <merlin>; Mon, 19 Aug 2019 09:40:54 -0700
Date:   Mon, 19 Aug 2019 09:40:54 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top of Perc 5/i raid0/jbod
Message-ID: <20190819164053.GF5431@merlins.org>
References: <20190819070823.GH12521@merlins.org> <5DCAD3D8-07B6-4A5D-A3C1-A1DF4055C5BD@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DCAD3D8-07B6-4A5D-A3C1-A1DF4055C5BD@linaro.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 19, 2019 at 11:18:13AM +0200, Paolo Valente wrote:
> Solving this kind of problem is one of the goals of the BFQ I/O scheduler [1].
> Have you tried?  If you want to, then start by swathing to BFQ in both the
> physical and the virtual block devices in your stack.
 
I sure was not aware of it, thank you for pointing it out.

> Thanks,
> Paolo
> 
> [1] https://algo.ing.unimo.it/people/paolo/BFQ/

I did the following below and when the swraid is rebuilding, I'm still
getting terrible overall throughput:
newmagic:~# hdparm -t /dev/md2
/dev/md2:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
  Timing buffered disk reads:   2 MB in  5.76 seconds = 355.42 kB/sec

I think things hang a bit less, which I suppose it good, but the system is
still unusable overall.

 
newmagic:~# modprobe bfq
newmagic:~# for i in /sys/block/*/queue/scheduler; do echo $i; echo bfq > $i; cat $i; done
/sys/block/bcache0/queue/scheduler
none
/sys/block/md0/queue/scheduler
none
/sys/block/md1/queue/scheduler
none
/sys/block/md2/queue/scheduler
none
/sys/block/md3/queue/scheduler
none                     
/sys/block/sda/queue/scheduler
[bfq] none
/sys/block/sdb/queue/scheduler
[bfq] none
/sys/block/sdc/queue/scheduler
[bfq] none
/sys/block/sdd/queue/scheduler
[bfq] none
/sys/block/sde/queue/scheduler
[bfq] none
/sys/block/sdf/queue/scheduler
[bfq] none
/sys/block/sdg/queue/scheduler
[bfq] none
/sys/block/sdh/queue/scheduler
[bfq] none
/sys/block/sdi/queue/scheduler
[bfq] none
/sys/block/sr0/queue/scheduler
[bfq] none


Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
