Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFFCF4CB
	for <lists+linux-raid@lfdr.de>; Tue,  8 Oct 2019 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJHIQb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Oct 2019 04:16:31 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:46514 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbfJHIQb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 8 Oct 2019 04:16:31 -0400
Received: (qmail 14161 invoked from network); 8 Oct 2019 08:16:29 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 8 Oct 2019 08:16:29 -0000
Date:   Tue, 8 Oct 2019 10:16:28 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     "David F." <df7729@gmail.com>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: Re: md/raid0: avoid RAID0 data corruption due to layout confusion. ?
Message-ID: <20191008081628.GA5526@metamorpher.de>
References: <CAGRSmLtoqBrW40rVwazwC464ma_qjPxnJ3uobpfPRbCOagnnJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRSmLtoqBrW40rVwazwC464ma_qjPxnJ3uobpfPRbCOagnnJQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 08, 2019 at 12:09:12AM -0700, David F. wrote:
> Hi,
> 
> "So we add a module parameter to allow the old (0) or new (1) layout
> to be specified, and refused to assemble an affected array if that
> parameter is not set."

Not 100% sure about this but I think it's new (1) and old (2) vs. unset (0).

You can set it like any other kernel/module parameter 
or with sysfs in /sys/module/raid0/parameters/default_layout
 
> Why couldn't it use an integrity logic check to determine which layout
> version is used so it just works?

Define integrity logic check. Check what and how?
Same reason why md can't decide correctness on parity mismatch.

So unfortunately this is outsourced to the sysadmins great 
and unmatched wisdom. Which is a difficult choice to make, 
as if I understand correctly, the corruption would be at 
the end of the device where it's harder to notice than if 
the superblock at the start was missing...

Unless you know the mismatch-size raid0 was created a long 
time ago or running off old kernel, try new first, then old.

(
    What happens if you happen to have one RAID of each type?
    Shouldn't this be recorded in metadata then...?
)

Regards
Andreas Klauer
