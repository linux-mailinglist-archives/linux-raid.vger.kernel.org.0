Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CF8AABB8
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfIETGG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 15:06:06 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:49958 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731188AbfIETGF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 15:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cL9CjwKGQAU09sD9CtAEEslAqCF9Y9cb7WSnyatHgMA=; b=Ur5Kxy5RQvcK5untGo4JIut/P
        b4vs9juQH7gm9ZQLMpXgfP4UYZDnOZtGUEcF8qC5HVw5x+nr0QyFXufz1HSDsrSVpXXEgzgXfd6XO
        Rgc+e1GN0MMV4Wp8qEbNDjgw9BtWvZAMfsbuJRd33H1H2T6eun7uXD9PAGDS/FfUXeOBc=;
Received: by exim4; Thu, 05 Sep 2019 21:06:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cL9CjwKGQAU09sD9CtAEEslAqCF9Y9cb7WSnyatHgMA=; b=Ur5Kxy5RQvcK5untGo4JIut/P
        b4vs9juQH7gm9ZQLMpXgfP4UYZDnOZtGUEcF8qC5HVw5x+nr0QyFXufz1HSDsrSVpXXEgzgXfd6XO
        Rgc+e1GN0MMV4Wp8qEbNDjgw9BtWvZAMfsbuJRd33H1H2T6eun7uXD9PAGDS/FfUXeOBc=;
Received: by exim4; Thu, 05 Sep 2019 21:06:02 +0200
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id 7494D6A74D7; Thu,  5 Sep 2019 20:05:58 +0100 (BST)
Date:   Thu, 5 Sep 2019 20:05:58 +0100
From:   Robin Hill <robin@robinhill.me.uk>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: raid6 with dm-integrity should not cause device to fail
Message-ID: <20190905190558.GA8212@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: Chris Murphy <lists@colorremedies.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
 <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
 <20190905160512.GA17672@cthulhu.home.robinhill.me.uk>
 <CAJCQCtTiJS437Dc9FOiYNKr-=MX7xHabX-G0O=2TbgqR5nz+uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTiJS437Dc9FOiYNKr-=MX7xHabX-G0O=2TbgqR5nz+uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu Sep 05, 2019 at 12:19:19PM -0600, Chris Murphy wrote:

> On Thu, Sep 5, 2019 at 10:15 AM Robin Hill <robin@robinhill.me.uk> wrote:
> >
> >
> > I'm not clear what you (or the author of the article) are expecting
> > here. You've got a disk (or disks) with thousands of read errors -
> > whether these are dm-integrity mismatches or disk-level read errors
> > doesn't matter - the disk is toast and needs replacing ASAP (or it's in
> > an environment where it - and you - probably shouldn't be).
> 
> That sounds to me like a policy question. The kernel code should be
> able to handle the errors, including even rate limiting if the errors
> are massive. It's a policy question whether X number errors per unit
> time, or Y:Z ratio bad to good sectors have been read, is the limit.
> And it's reasonable for md developers to pick a sane default for that
> policy. But to just say 1000's of corruptions are inherently a device
> failure, when easily 1 million more in the same time frame are good?
> You'd be giving up a better chance of recovery during rebuilds/device
> replacements by flat out ejecting such a device. Also the device could
> be network. It could be transient. Or the problem discovered and fixed
> way before the device is ejected, and manually readded and rebuilt.
> 
It's definitely a policy question, yes, and more flexibility in how
these errors are handled would indeed be good. The specific cases here
are thousands of integrity mismatches artificially introduced into
sequential blocks covering half the device though. I don't see any
reasonable error-handling method doing anything other than kicking the
drive in that case. Ignoring them on the basis that they're dm-integrity
mismatches rather than read errors reported from the drive does not
sound like the right fix (unless we're expecting dm-integrity, or the
block-layer generally, to have built-in error counting and
device-failing?).

Also, a transient issue of this size is likely to cause the drive to be
kicked anyway - don't forget that each of these read errors will trigger
a write, and if that fails the drive is kicked regardless of whether
it's the first error or the thousandth.

> > Admittedly, with dm-integrity we can probably trust that anything read
> > from the disk which makes it past the integrity check is valid, so there
> > may be cases where the data on there is needed to complete a stripe.
> > That seems a rather theoretical and contrived circumstance though - in
> > most cases you're better just kicking the drive from the array so the
> > admin knows that it needs replacing.
> 
> I don't agree that a heavy hammer is needed in order to send a notification.
> 
You think that most people using this will be monitoring for
dm-intergity reported errors? If all the errors are just rewritten
silently then it's likely the only sign of an issue will be a
performance impact, with no obvious sign as to where it's coming from.

Cheers,
    Robin
-- 
     ___        
    ( ' }     |       Robin Hill        <robin@robinhill.me.uk> |
   / / )      | Little Jim says ....                            |
  // !!       |      "He fallen in de water !!"                 |
