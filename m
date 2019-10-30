Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598F4E951C
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 03:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJ3Cxx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 22:53:53 -0400
Received: from magic.merlins.org ([209.81.13.136]:33072 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfJ3Cxw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 22:53:52 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1iPe7G-0007GJ-60 by authid <merlin>; Tue, 29 Oct 2019 19:53:46 -0700
Date:   Tue, 29 Oct 2019 19:53:46 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Tim Small <tim@buttersideup.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Roman Mamedov <rm@romanrm.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
Message-ID: <20191030025346.GA24750@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029172747.7cbe6e32@natsu>
 <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
 <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 29, 2019 at 11:04:21AM +0000, Tim Small wrote:
> I've seen this a few times.  Sometimes there is a pending sector, but
> it's not user-addressable, sometimes the firmware seems to get the count
> wrong.
> You could try doing a full-self-test and see if that terminates without
> error.

See below

> If you can temporarily take the drive out of service, you could also try
> doing a secure erase using hdparm, to see if that gets the count to zero.

I can wipe the whole drive, but this puts me in degraded mode for a
while without actually needing to be from what I can tell, so it's not
my first choice.

On Tue, Oct 29, 2019 at 12:05:02PM +0000, Jorge Bastos wrote:
> Same, especially with WD drives, they appear to be false positives, if
> you can take the disk offline a full disk write will usually get rid
> of them.

I see. So somehow reading all the sectors with hdrecover does not
trigger anything, but dd'ing 0s over the entire drive would reset this?

On Tue, Oct 29, 2019 at 05:27:47PM +0500, Roman Mamedov wrote:
> Oh and talking of "especially WD" and especially Green, such transient errors
> are a a sure symptom of rust developing on PCB contact pads:
> https://www.youtube.com/watch?v=tDTt_yjYYQ8
> 
> E.g. Hitachi doesn't have this issue (they have drops of solder on each
> contact pad); not much experience with Seagate; and WD themselves later
> improved the design of this connection (redesigned type seen at least on a 6TB
> WD Red).

But wouldn't that show real errors when I'm reading the whole drive?
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     21804         -
# 2  Short offline       Completed without error       00%     21788         -
# 3  Short offline       Completed without error       00%     21765         -
# 4  Short offline       Completed without error       00%     21742         -
# 5  Extended offline    Completed: read failure       10%     21731         3457756336
# 6  Short offline       Completed without error       00%     21717         -
# 7  Short offline       Completed without error       00%     21693         -
# 8  Short offline       Completed without error       00%     21670         -
# 9  Short offline       Completed without error       00%     21646         -
#10  Short offline       Completed without error       00%     21623         -
#11  Short offline       Completed without error       00%     21599         -
#12  Short offline       Completed without error       00%     21575         -
#13  Extended offline    Completed: read failure       10%     21562         2905616752
#14  Short offline       Completed without error       00%     21551         -
#15  Short offline       Completed without error       00%     21527         -
#16  Short offline       Completed without error       00%     21503         -
#17  Short offline       Completed without error       00%     21479         -
#18  Short offline       Completed without error       00%     21455         -
#19  Short offline       Completed without error       00%     21431         -
#20  Short offline       Completed without error       00%     21408         -
#21  Extended offline    Completed without error       00%     21398         -
2 of 2 failed self-tests are outdated by newer successful extended offline self-test # 1

That said my pending sectors is still 9:
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always       -       9

This is still perplexing. Would a full offline test verify every sector?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
