Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA15A14FE4D
	for <lists+linux-raid@lfdr.de>; Sun,  2 Feb 2020 17:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBQae (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Feb 2020 11:30:34 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:38855 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgBBQae (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 2 Feb 2020 11:30:34 -0500
Received: by mail-vk1-f174.google.com with SMTP id w4so1844117vkd.5
        for <linux-raid@vger.kernel.org>; Sun, 02 Feb 2020 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11V8BlQR4un/x4UoGRRasqYv/c9dpmd8YzCJKbGUf+s=;
        b=axv73RAKPOMaI3GXGWRwfqStrWvzANm1UamAV1KAZHI3UsKL/a+IPrsy4DcvTmOcMk
         8ej056gsJeGfDvNlqUdLySdjmFgk5mBJ0muBTV/jotIUQ13IoYMA8lf3MdElvDLjikXu
         PTpKNjDuboFQVcHnC05LhKdt7fXx9zRgh99waE3Qwd6IDeiu1iQPYCkVHl3t7knjG9Ya
         1pgx07RjL/5V1Udzwwnb8kkDh0oXCEWKch6gAhNKTTzL0WhQWPWFv7/mH8Zdt2GjL4lq
         SWNgV7MHxg/uXkkz62Pzce+MXV/U6kOpOlUHUqM1RQ8L7dDwM3BTHyctJWvxNgfOXD1D
         VxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11V8BlQR4un/x4UoGRRasqYv/c9dpmd8YzCJKbGUf+s=;
        b=dMzaGHsjw528IkjSg6lvkOFxmQLgEr24vqEjYXxg98aJGRMt1LjQlhGPyDsiATDRWE
         9kE6L7KeXrTb9HQvcOtWTbwX0MVtEpGucgpr1nDh87aDdqAGJEzUOn0HlGqcv0F2+HSE
         O9Jdtv4hMzAHF/Q1Rg6V2lVIGxkMquiPJiDcSE3Iv3vi64PJQ57j+3m7aXafApBZ5puf
         vDEbm0MNo8XBDv7A5rUdf/Jedva6bqzV/weimGXF++yLDwcm2JG77CMQjKxiHaJ/oGmx
         HVJ6miVKG9/eBgIzgA2rM9uqb6XOlkbhSQZYsHFM8mIJcies1qIQ6pA62y7XIj9bXLA0
         ls4g==
X-Gm-Message-State: APjAAAXaoUCe03q7xsNI/QFB6XlnRytSHm6Nh1mk3hwRlFJyRiVUGybp
        18VbrZPaZ6vzrVm6Kpk7qVVC0WPbhfi/Yi9BCwuiLzRgFx+4Tw==
X-Google-Smtp-Source: APXvYqx7J5BV7fQ+I1jPP5fEBU4FjucuvIGxh6YnvQvkvUYwhv+N+kT9KEuoEfGdrfZHykYbhbjSD3vl+PFOg7mdfOw=
X-Received: by 2002:a1f:7cc2:: with SMTP id x185mr11546707vkc.1.1580661033486;
 Sun, 02 Feb 2020 08:30:33 -0800 (PST)
MIME-Version: 1.0
References: <CAC4UdkZoo=B2c-XmRwPA19gEsUtHYVhq2=Sqgs54mf2ZHerDxw@mail.gmail.com>
 <e6a3c4d6-bc2e-fe11-5ed5-310fa1b7526b@turmel.org>
In-Reply-To: <e6a3c4d6-bc2e-fe11-5ed5-310fa1b7526b@turmel.org>
From:   Rickard Svensson <myhex2020@gmail.com>
Date:   Sun, 2 Feb 2020 17:30:22 +0100
Message-ID: <CAC4UdkYqKQhehxZao3943jiWnDWK20T8SupEk_8+4jp1cd4Qvg@mail.gmail.com>
Subject: Re: All disk ar reported as spare disks
To:     Phil Turmel <philip@turmel.org>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Phil & Wol  and everyone else.

I just wanted to say a big thank you, --assemble --force solved the
problem and I got the raid running again :-D

And now after a fsck I am copying all the data to my new raid1.
And what I can see so far I don't seem to have lost anything :-)

The new disks were purchased since before (WD Red NAS 10TB), but
fortunately they have support for SCT "Error Recovery Control" ,
"Feature Control" , "Data Table".
And "Recovery Control" is set to 70.70, just as mentioned on:
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

But I will still put that script into the startup of my new server.


Once again, a big thanks for all the help!

Best regards Rickard

Den fre 31 jan. 2020 kl 14:57 skrev Phil Turmel <philip@turmel.org>:
>
> Hi Rickard,
>
> Good report.
>
> On 1/30/20 6:48 PM, Rickard Svensson wrote:
> > Hello
> >
> > Excuse me for asking again.
> >
> > But this is a simpler(?) follow-up question to:
> > https://marc.info/?t=157895855400002&r=1&w=2
> >
> > In short summary. I had a raid 1 0, there were too many write errors
> > on one disk (I call it DiskError1), which I did not notice, and then
> > two days later the same problem on another disk (I call it
> > DiskError2).
> >
> > I got good help here, and copy the disk portions of the 2 working
> > disks as well as disk DiskError2 with ddrescue to new disks.
> > Later I'll create a new raid 1, so I don't plan reuse the same raid 1 0 again.
> >
> >
> > My questions:
> > 1) I haven't copied the disk DiskError1, because it is older data, and
> > it shouldn't be needed.   Or is it better to add that one as well?
> >
> > 2) Everything looks pretty good :)
> > But all disk ar reported as spare disks in /proc/mdstat
> > A assume that is because "Events" count is not the same. It is same on
> > the good disks(2864) but not DiskError2 (2719).
>
> No, the array isn't running, so /proc/mdstat isn't complete.  Your three
> disks all have proper "Active device" roles per --examine.
>
> > I have been looking how I can "force add" disk DiskError2, use
> > "--force" or "--- zero-superblock"?
>
> Neither --add nor --zero-superblock is appropriate.  They will break
> your otherwise very good condition.
>
> > But would prefer to avoid making a mistake now,   what has the
> > greatest chance of being right :)
>
> First, ensure you do not have a timeout mismatch as evidenced in your
> original thread's smartctl output.  The wiki has some advice.  Hopefully
> your new drives are "NAS" rated and you need no special action.
>
> Then you should simply use --assemble --force with those three devices.
>
> That should get you running degraded.  Then immediately backup the most
> valuable data in the array before doing anything else.
>
> Finally, --add a fourth device and let your raid rebuild its redundancy.
>
> When all is safe, consider converting to a more durable redundancy
> setup, like raid6, or raid10,near=3.
>
> Phil
