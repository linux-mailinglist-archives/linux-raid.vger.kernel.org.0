Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F56E99C0
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 11:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ3KM5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 06:12:57 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:58058 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJ3KM5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 06:12:57 -0400
Received: (qmail 26092 invoked from network); 30 Oct 2019 10:12:55 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 30 Oct 2019 10:12:55 -0000
Date:   Wed, 30 Oct 2019 11:12:55 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Tim Small <tim@buttersideup.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Roman Mamedov <rm@romanrm.net>, linux-raid@vger.kernel.org
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
Message-ID: <20191030101255.GA3373@metamorpher.de>
References: <20191029172747.7cbe6e32@natsu>
 <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
 <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com>
 <20191030025346.GA24750@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030025346.GA24750@merlins.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 29, 2019 at 07:53:46PM -0700, Marc MERLIN wrote:
> I can wipe the whole drive, but this puts me in degraded mode for a
> while without actually needing to be from what I can tell, so it's not
> my first choice.

Use mdadm --replace to get it out of your RAID without degrading it.
Then you can safely use secure erase and other forms of scrubbing to 
see if it changes anything.

> But wouldn't that show real errors when I'm reading the whole drive?
> SMART Self-test log structure revision number 1
> Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
> # 1  Extended offline    Completed without error       00%     21804         -
> # 5  Extended offline    Completed: read failure       10%     21731         3457756336
> #13  Extended offline    Completed: read failure       10%     21562         2905616752

> 2 of 2 failed self-tests are outdated by newer successful extended offline self-test # 1

"Outdated" (few hours apart) is a very optimistic way of looking 
at these test results. At least it shows the drive didn't just 
invent those pending sectors.

Regards
Andreas Klauer
