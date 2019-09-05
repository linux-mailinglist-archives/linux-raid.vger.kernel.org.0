Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FCAADD0
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 23:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbfIEV11 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 17:27:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:36554 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbfIEV10 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 5 Sep 2019 17:27:26 -0400
Received: from [81.153.82.187] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1i5zHn-0001T8-7q
        for linux-raid@vger.kernel.org; Thu, 05 Sep 2019 22:27:23 +0100
Subject: Re: raid6 with dm-integrity should not cause device to fail
To:     Linux-RAID <linux-raid@vger.kernel.org>
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
 <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
 <20190905160512.GA17672@cthulhu.home.robinhill.me.uk>
 <CAJCQCtTiJS437Dc9FOiYNKr-=MX7xHabX-G0O=2TbgqR5nz+uw@mail.gmail.com>
 <20190905190558.GA8212@cthulhu.home.robinhill.me.uk>
 <CAJCQCtRzUxGE9Y6g7pEDP5CnPPprW==Rjs=yeaz_cEdieKaVLA@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5D717DBA.2030506@youngman.org.uk>
Date:   Thu, 5 Sep 2019 22:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRzUxGE9Y6g7pEDP5CnPPprW==Rjs=yeaz_cEdieKaVLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/09/19 21:15, Chris Murphy wrote:
>> You think that most people using this will be monitoring for
>> > dm-intergity reported errors? If all the errors are just rewritten
>> > silently then it's likely the only sign of an issue will be a
>> > performance impact, with no obvious sign as to where it's coming from.
> I very well might want a policy that says, send a notification if more
> than 10 errors of any nature are encountered within 1 minute or less.
> Maybe that drive gets scheduled for swap out sooner than later, but
> not urgently. But ejecting the drive, upon many errors, to act as the
> notification of a problem, I don't like that design. Those are
> actually two different problems, and I'm not being informed of the
> initial cause only of the far more urgent "drive ejected" case.

My immediate reaction, on reading this, was "has dm-integrity been set
up on a disk with old data, and the drive not been initialised?"

That would lead, I presume, to exactly this scenario ... think of raid's
--assume-clean option if the drive isn't clean ... the OP made me think
this could well be the scenario. In which case, of course, it sounds
like an implementation error in dm-integrity, or a user mistake. Do we
need more information about the scenario that is generating this?

Otherwise, we do have a seriously corrupt disk, and while it might be
nice to have some option to force-override what's going on, it also is
not wise to continue without at least seeking to diagnose the cause of
the corruption!

I think we need to know why dm-integrity is blowing up - if we don't
know that then we shouldn't try to deal with it in the raid layer.

Cheers,
Wol
