Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A62AACD8
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbfIEUPb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 16:15:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbfIEUPb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 16:15:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so4560013wme.2
        for <linux-raid@vger.kernel.org>; Thu, 05 Sep 2019 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hqYL3A1rUPQfHbpNDnVzWW2bqNvq+YRTPcu/zOwBOVI=;
        b=MMAg+pEWfJSszJ7lL7H+WYTaFBzIRJZFw5iGetExmloQI/unySpwr4HGkRQk3gHOi9
         stlTzOs/qW51Sg1Xy7iQSVQGQkbTZ6OBfiMn0QXGdCsFtnRZQfUwtJsJmUlqXtwgFebe
         lxSwIB/gkUb76FXR4ISnKWT5MdeJBf9Pq8ZPWXyCBYF9W2Q64z6H17h+p2S4JiKNkrF1
         wkN3jaTGJcmBAXLapnXkY/Heoy44wH+2lfQWk6giZ/QfvrO/rrlqMeeDgnspfv6bYt1u
         izVVtUpNt7nma/LiVifE3LQOXsl/fKgSRIamlt/h/DA9XswV87PSN3+0dH06Ln/FW3sK
         QYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hqYL3A1rUPQfHbpNDnVzWW2bqNvq+YRTPcu/zOwBOVI=;
        b=cQ1XBcpaIdcZ76xx/kx7d5eUczDIuU5PKaWAsXGUFuj0rRTCxuq+SGK+eGBCmhGlV9
         gpBlj1KWRhPCMOIP53kImQ98eHnvNx3bwWc8JxegCnavUomfkrDmWjs5WLELJuN6pxoy
         +MG3SSNpd4WJ9xU7xIulTbk3yZkLKvz342zpIiv75EmS1rVP9DfrkcLUZleE6EhGL8hs
         A4UNCXwO5PfcAf1lrBxTVepi4izQM+Xa397ONWdlQclyypeYMFw2ELJLEEDaCFaE9MpD
         WRbyNFxVKPeOnlUJ7srP0YqAmKPZ4ZKt5jZkyOI7tByxMYmp+nsH3qfE0/jTxtMLzhIs
         MIMA==
X-Gm-Message-State: APjAAAVWex9vAKkrb50uw3eYU62Dlzdh0BIUlLbLYBxvH8HRJGSTTYjU
        vzGfBwNprlj71jo90QK7kx37GCz3w5zlHHiHOXRA43J4M7pgLA==
X-Google-Smtp-Source: APXvYqy5TYkD2Hguef+rNwb9u4w9XmDznATVqwRRE9R1Ofd3DEJQKBRPCXN8FcjXa6uaAgJC/gn+ocxK6IW2K6YHVs8=
X-Received: by 2002:a7b:c3cc:: with SMTP id t12mr4360129wmj.176.1567714528266;
 Thu, 05 Sep 2019 13:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com> <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
 <20190905160512.GA17672@cthulhu.home.robinhill.me.uk> <CAJCQCtTiJS437Dc9FOiYNKr-=MX7xHabX-G0O=2TbgqR5nz+uw@mail.gmail.com>
 <20190905190558.GA8212@cthulhu.home.robinhill.me.uk>
In-Reply-To: <20190905190558.GA8212@cthulhu.home.robinhill.me.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 5 Sep 2019 14:15:17 -0600
Message-ID: <CAJCQCtRzUxGE9Y6g7pEDP5CnPPprW==Rjs=yeaz_cEdieKaVLA@mail.gmail.com>
Subject: Re: raid6 with dm-integrity should not cause device to fail
To:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Sep 5, 2019 at 1:06 PM Robin Hill <robin@robinhill.me.uk> wrote:
>
> It's definitely a policy question, yes, and more flexibility in how
> these errors are handled would indeed be good. The specific cases here
> are thousands of integrity mismatches artificially introduced into
> sequential blocks covering half the device though. I don't see any
> reasonable error-handling method doing anything other than kicking the
> drive in that case. Ignoring them on the basis that they're dm-integrity
> mismatches rather than read errors reported from the drive does not
> sound like the right fix (unless we're expecting dm-integrity, or the
> block-layer generally, to have built-in error counting and
> device-failing?).

I think that's reasonable, and also that's a lot of, what amounts to
as, spamming going into the journal. I would still say kernel code
should be able to handle it. If there are many in-sequence errors, I
think it's OK to drop a lot of those messages as part of e.g.
printk.devkmsg option. For sure by default no one wants so many
effectively redundant errors being reported that journald/syslog is
being blocked, such that other errors can't be quickly/reliably
logged.

And I defer to md/mdadm/lvm devs to pick a sane generic one size fits
all policy to eject a drive in this case. For sure if it's reading all
failures for even 10-20 seconds, that's GiB's of bad data with
spinning rust, and possibly hundreds of GiB's if it's flash, and I
absolutely agree - eject it. Or more correctly, demote it. Do not read
from it *unless* you arrive at a stripe read failure, and all you need
is just one more successful strip read to get a successful
reconstruction, and then in that case, why not try reading from that
demoted drive? If it's totally ejected, you have no chance.


> > > Admittedly, with dm-integrity we can probably trust that anything read
> > > from the disk which makes it past the integrity check is valid, so there
> > > may be cases where the data on there is needed to complete a stripe.
> > > That seems a rather theoretical and contrived circumstance though - in
> > > most cases you're better just kicking the drive from the array so the
> > > admin knows that it needs replacing.
> >
> > I don't agree that a heavy hammer is needed in order to send a notification.
> >
> You think that most people using this will be monitoring for
> dm-intergity reported errors? If all the errors are just rewritten
> silently then it's likely the only sign of an issue will be a
> performance impact, with no obvious sign as to where it's coming from.

I very well might want a policy that says, send a notification if more
than 10 errors of any nature are encountered within 1 minute or less.
Maybe that drive gets scheduled for swap out sooner than later, but
not urgently. But ejecting the drive, upon many errors, to act as the
notification of a problem, I don't like that design. Those are
actually two different problems, and I'm not being informed of the
initial cause only of the far more urgent "drive ejected" case.

-- 
Chris Murphy
