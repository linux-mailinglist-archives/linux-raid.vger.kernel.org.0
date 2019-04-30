Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470D1FAD3
	for <lists+linux-raid@lfdr.de>; Tue, 30 Apr 2019 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfD3Nv4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 09:51:56 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:34226 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfD3Nv4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Apr 2019 09:51:56 -0400
Received: (qmail 11904 invoked from network); 30 Apr 2019 13:51:52 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 30 Apr 2019 13:51:52 -0000
Date:   Tue, 30 Apr 2019 15:51:52 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Julien ROBIN <julien.robin28@free.fr>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
Message-ID: <20190430135152.GA20515@metamorpher.de>
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
 <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
 <20190430092347.GA4799@metamorpher.de>
 <deffabb8-51e8-0120-8c63-ade9e5dfdf9b@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deffabb8-51e8-0120-8c63-ade9e5dfdf9b@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Apr 30, 2019 at 01:31:07PM +0200, Julien ROBIN wrote:
> The stackexchange statement is "the problem is that you don't know"

Yes, because it's not always that straightforward and the array 
you're trying to re-create might already be many years old.

So this is a reminder to double- and triple-check everything 
(and even then use overlays... they're so useful there should 
be an easier command to set them up.)

> For beginning with investigations, the only thing I did, this time, that was
> different from others time, was to use "dd if=/dev/urandom of=/dev/sdc
> bs=1024k status=progress" before preparing the disk, just to be sure its
> complete surface is working. Do you think this can be the cause of mdadm
> error? Should the new disk be always full of zeroes before preparing
> partition, then add and grow ?

Nah, as long as dd (and everyone else) was done with the drive 
by the time you passed it to mdadm, it's just fine.

Something else must have happened... either a bug (are you using 
latest mdadm / kernel versions?), or trying to store the backup 
file on the raid itself, or maybe something blocking mdadm 
(happened before with selinux/apparmor, I think) 
or otherwise something interfering with the process.

If you can reproduce the issue you could investigate in more detail...

Regards
Andreas Klauer
