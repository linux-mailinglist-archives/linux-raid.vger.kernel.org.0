Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE21EE9CB1
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfJ3NxB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 09:53:01 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39387 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfJ3NxB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 09:53:01 -0400
Received: by mail-lj1-f174.google.com with SMTP id y3so2773233ljj.6
        for <linux-raid@vger.kernel.org>; Wed, 30 Oct 2019 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfvL3qW5nIUyFkbvZFaZ0bq3aTO3outOnT8BedV0p5c=;
        b=FvuAaU28+gBazJJPB9+aiUgvUWGLUw3nCAs5z070unBxkpaeKATHh6D12Sbu+HtYp/
         rBfGIQXCfBdd6nIlxXGIa1Ykw+7uMAjLdoDDxwq2pLdKtpBkfuF2tiC3r3tZ1uBUvTba
         /5hFeRuosvQz9Mrx+TqG0Vf/k+uVWtU/A+jRultiLGoMmR9XRjsj2hiWf2wzZ1VjoJxl
         bMHN5LmZhTXEP3uHzvoDMg0+Zif0rocYhfJJkOe2WR/g8C6+EFJPONtCgOnSGy4lDAz3
         aLL84d9LefJaMWu8QOMEntyl7uImBNpCT646nO4u8dkxnoFY8erDoRCfV9yU8Pbbpk1Q
         XElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfvL3qW5nIUyFkbvZFaZ0bq3aTO3outOnT8BedV0p5c=;
        b=cI0xaJXy1NOEnMl4NLUKzyVMRTm5mVnRIgiJoSbzHDe/kye41qD3ADUxa2j+8JD9iH
         qMRqv6uy5txbzQmh/mFGT3jqgHxXTw+NQdt3w8LN5Dcd0m3diRKExM4UH/XHTOqxmWEN
         RT4M/ZangnADDSFAJfpGrj/ZW/jeaF2l6993Pg0kSXsVup53Yb9AAFRthTDpI57uTou8
         /Vo4QUPUPCp6Nv5442lCyUM50TrRr3jPVVi6KWduc2unKz0zf/3K4O6Cu+/Oy4tn/wbP
         IKklua58EoiabN7SiWdl3O5QioRR4uQqBmDed18Lllp7M4pDHVLoNAj19jAyCxdAHKc+
         fcsA==
X-Gm-Message-State: APjAAAVa+5hFXNtcoW94ZPQd+1k6bpp6HZANrCvsFD4lKNSpWEqo+7HC
        f9O262fJ7N249SrTM2RnnVYl5xoD9MP64kN932Q=
X-Google-Smtp-Source: APXvYqw9p005dhtX9BrAj8Y0RQCBADvYrA0/8cZKzbX+dAmjyrDujyEcehJN+klIlpUeWcqbTEp846aAIlppqNW+oH4=
X-Received: by 2002:a2e:a16d:: with SMTP id u13mr7159464ljl.214.1572443578901;
 Wed, 30 Oct 2019 06:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191029172747.7cbe6e32@natsu> <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
 <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com> <20191030025346.GA24750@merlins.org>
 <20191030101255.GA3373@metamorpher.de>
In-Reply-To: <20191030101255.GA3373@metamorpher.de>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Wed, 30 Oct 2019 08:52:47 -0500
Message-ID: <CAAMCDef7MNeSLhorLRiFZbdtTdWf+ZPQo=Z6CqDcKCCCcx1Pvg@mail.gmail.com>
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     Marc MERLIN <marc@merlins.org>, Tim Small <tim@buttersideup.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Roman Mamedov <rm@romanrm.net>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I would run repeated extended offline tests.  You should get several
tests a day, and if it is a normal failing sector, a number of the
tests should fail on the same few sector (or close to the same
sector).  Mine always seem to fail in 64sector groups.   I have also
had luck with a lot of extended tests seeming to catch errors and
correct them before the sectors go bad.  I have a troublesome disk
that I am aggressively testing and it seems to result in the disk
working better (less read failures to the kernel).

On Wed, Oct 30, 2019 at 5:15 AM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Tue, Oct 29, 2019 at 07:53:46PM -0700, Marc MERLIN wrote:
> > I can wipe the whole drive, but this puts me in degraded mode for a
> > while without actually needing to be from what I can tell, so it's not
> > my first choice.
>
> Use mdadm --replace to get it out of your RAID without degrading it.
> Then you can safely use secure erase and other forms of scrubbing to
> see if it changes anything.
>
> > But wouldn't that show real errors when I'm reading the whole drive?
> > SMART Self-test log structure revision number 1
> > Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
> > # 1  Extended offline    Completed without error       00%     21804         -
> > # 5  Extended offline    Completed: read failure       10%     21731         3457756336
> > #13  Extended offline    Completed: read failure       10%     21562         2905616752
>
> > 2 of 2 failed self-tests are outdated by newer successful extended offline self-test # 1
>
> "Outdated" (few hours apart) is a very optimistic way of looking
> at these test results. At least it shows the drive didn't just
> invent those pending sectors.
>
> Regards
> Andreas Klauer
