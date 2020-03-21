Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3218E50F
	for <lists+linux-raid@lfdr.de>; Sat, 21 Mar 2020 23:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCUWM0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Mar 2020 18:12:26 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42210 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUWM0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 21 Mar 2020 18:12:26 -0400
Received: by mail-lf1-f49.google.com with SMTP id t21so7286942lfe.9
        for <linux-raid@vger.kernel.org>; Sat, 21 Mar 2020 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58dBzlBIYia38UTDYhPeRPa9gMp0VhquNj7p3rvj89w=;
        b=KUNONHYaPEknpHXCdqzFhf0/sM73mRly/GHDrGY34eQHYMn6OgPCGDnNJvn3XDYXsD
         b5JsRbT/syBF69NsIsxETUE6+WEfmIPBIqpjfboFeOJ7qhZw8VTV7Q4EjgS3pyF9DT/l
         yjz849lXZg0iT0Ez/fPXjuJTRh7rhIymV0dqkykP9XPE22eyqq5+OrpdJTMaOqXMHOfX
         lnl2MK8z9iq4H9rjVNgSY8Sjz7b3sLrAYlETkIl3BTDglOm5yq7n1cuqRvtVKb16OMtl
         Yta+HgKTd78+vLwTZ8Q3rmNQzWr8wW94ay74/igzlLXGUdHbHcgWkrsCDO1gSE7H6qeQ
         FerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58dBzlBIYia38UTDYhPeRPa9gMp0VhquNj7p3rvj89w=;
        b=UbonduvGKaRzW2eygktmE7geuNyu4sOQcQ5oe2iIFlTXnFpXDyiyCCiAtpUjIentbI
         2Ru7tUSih8LIV4x2lJMEuWZTBWdjfRYlO/AYAlgSiZ6VLlzlw4ERfxhSHzgfgDISZF3C
         nohTGYizwrJ+vIBF4Cg8t1mnqjRoYHDrRVQYDMW7azKwjCkpwtydoS1KkStvadchwCMp
         /ZgGq3CqOB7pcgI4RsBJFj+GrYk6psSI+txdaIbkkkgHqMAuoaClnqlr/xxB2RSVUxck
         OncqbGMpT9VV8WBT1COB9G9F/og7X/GPj+pQNHezv3lK4YtzVAG+Y/mLl8I4BB9zlS4i
         DJ5w==
X-Gm-Message-State: ANhLgQ3L3PqpdhlXghec1e9jFj7l8qpSij2VYV25p0b2rmJM2wBKasN5
        Cu4yKx6HAcAz70xg2GUaDog0bplH5mxQxHT0+0s=
X-Google-Smtp-Source: ADFU+vt03rp9JaTl1NUWYNY/fEKJ8gYE2VPFc6SLjEcKwVjtNu9OHGr1z0FfuZbGD1lJIXgEvXpIsM8QdAMQqBO+m2U=
X-Received: by 2002:a19:ee0f:: with SMTP id g15mr8841656lfb.213.1584828744292;
 Sat, 21 Mar 2020 15:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
 <5E75163B.2050602@youngman.org.uk> <CA+9eyigMV-E=FwtXDWZszSsV6JOxxFOFVh6WzmeH=OC3heMUHw@mail.gmail.com>
 <ab2a40b6-b4ab-9ff8-aef6-02d8cce8d587@youngman.org.uk> <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
 <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
In-Reply-To: <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
From:   Glenn Greibesland <glenngreibesland@gmail.com>
Date:   Sat, 21 Mar 2020 23:12:12 +0100
Message-ID: <CA+9eyiicKrPh9YTrGN5FjOU7zMVMqO3=8yGszWkV67fJxrtKrw@mail.gmail.com>
Subject: Re: Raid6 recovery
To:     Phil Turmel <philip@turmel.org>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

l=C3=B8r. 21. mar. 2020 kl. 20:24 skrev Phil Turmel <philip@turmel.org>:
> {Convention on kernel.org lists is to interleave replies or bottom post,
> and to trim non-relevant quoted material.  Please do so in the future.}

Sorry about that.

> Since you seem comfortable reading source code, you might consider byte
> editing that drive's superblock to restore it to "active device 10".
> That is what I would do.  With that corrected, --assemble --force should
> give you a running array.

I did some more digging in the source code, but it looks like the
superblock is replicated onto all drives and that I probably would
have to edit the superblock of all disks, but I'm not sure.
With newfound confidence (thanks) I decided to try the --create
--asume-clean option instead.
It worked fine and I am now copying the data that is not already backed up.

I'll wait until the data is copied onto other drives before I add the
last two disks to the array and start rebuilding.

> I also noted the drives with Error Recovery Control turned off.  That is
> not an issue while your array has no redundancy, but is catastrophic in
> any normal array.  It is as bad as having a drive that doesn't do ERC at
> all.  Don't do that.  Do read the "Timeout Mismatch" documentation that
> Anthony recommended, if you haven't yet.

I'll read up on this documentation to ensure reliable operation in the
future. Thanks Phil and Anthony.

So to summarize what happened and what I've learned:
I had a RAID6 array with only 16 out of 18 working drives.
I received an email from mdadm saying another drive failed.
I ran a full offline smart test that completed successfuly.

The drive was in F (failed) state. I used --re-add and mdadm overwrote
the superblock turning it into a spare drive instead of putting the
drive back into slot 10.
I should have used --assemble --force.

Am I correct?

Glenn
