Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D780F31FD2
	for <lists+linux-raid@lfdr.de>; Sat,  1 Jun 2019 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFAPnE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Jun 2019 11:43:04 -0400
Received: from open-std.org ([93.90.116.65]:48309 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfFAPnE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 1 Jun 2019 11:43:04 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id 73BBD356780; Sat,  1 Jun 2019 17:43:02 +0200 (CEST)
Date:   Sat, 1 Jun 2019 17:43:02 +0200
From:   keld@keldix.com
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190601154302.GA27756@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com> <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com> <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org> <2d01a882-0902-b7b6-a359-80e04a919aaa@thelounge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d01a882-0902-b7b6-a359-80e04a919aaa@thelounge.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Jun 01, 2019 at 04:03:05PM +0200, Reindl Harald wrote:
> 
> 
> Am 01.06.19 um 10:50 schrieb keld@keldix.com:
> > On Sat, Jun 01, 2019 at 05:39:25AM +0000, Andy Smith wrote:
> >> Hi,
> >>
> >> On Fri, May 31, 2019 at 09:43:35AM +0800, Guoqing Jiang wrote:
> >>> On 5/30/19 3:41 AM, Andy Smith wrote:
> >>>> By contrast RAID-10 seems to split the IOs much more evenly: 53% hit
> >>>> the NVMe, and the average IOPS was only 35% that of RAID-1.
> >>>>
> >>>> Is this expected?
> >>
> >> [???]
> >>
> >>> There are some optimizations in raid1's read_balance for ssd, unfortunately,
> >>> raid10 didn't have similar code.
> >>
> >> Thanks Guoqing, that certainly seems to explain it.
> >>
> >> Would it be worth mentioning in the man page and/or wiki that when
> >> there are devices that are very mismatched, performance wise, RAID-1
> >> is likely to be able to direct more reads to the faster device(s),
> >> whereas RAID-10 can't do that?
> >>
> >> Is it just that no one has tried to apply the same optimizations to
> >> RAID-10, or is it technically difficult/impossible to do this in
> >> RAID-10?
> > 
> > Still, Andy, you need to cover all layouts of md raid10.
> > 
> > L know that for the far layout we actually had something that meant choosing the faster drives
> > an thus it violated the striping on HDs, degrading read performance severely. A patch fixed that.
> > 
> > this patch did not apply  to the offset layout, so maybe that layout could satisfy your needs.
> > 
> > 
> > it seems that there may be special code for SSDs in the md drivers.
> > 
> > I would like if we could use more precise terminology, RAID-10 could easily be understood
> > as normal raid where you need 4 drives. The name "md raid10" is actually a bit misleading, 
> > as for the 4-drive version it is actually a RAID-01 layout, which has poorer redudancy properties.
> 
> well, it would be nice just skip optimizations for rotating disks
> entirely when the whole 4 disk RAID10 is built of SSD's

yes, possibly, if there is a gain in this.

as I wrote layout offset may already do the right thing.
and raid1 probably also does it.
I think raid10 offers extra functionlity over raid1 that could be useful
 for raids of drives with different speeds.
Even layout far may be advantageaous to use with ssds, this was reported to the list some time ago.


keld
