Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92A2195A5E
	for <lists+linux-raid@lfdr.de>; Fri, 27 Mar 2020 16:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0PzP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Mar 2020 11:55:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34022 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0PzP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 27 Mar 2020 11:55:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id e7so8281722lfq.1
        for <linux-raid@vger.kernel.org>; Fri, 27 Mar 2020 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9I+4eF7JHuKDhpKvsgVjhHUZ9wjeEGwq7Ps2JDI4RI0=;
        b=mkenees7KRfsc6epWw8PknLF2vkMUSyhivaeAa9i38e1eFTr3T3ELUPx2HNZhYeCau
         j/1lWKWZzJeJeVPjMrr0frYQYC4blpB1+EvDYzzjHTvvWQG/sycGPfIy3yBYjyscU9kG
         RfP13xpB+ZgiuRnE95Oho/rQ4UyBDeYh0NKKkERPaMvUJVVClXgA8DYny8APjWHDPOL3
         n1SRM63G/rVtgErp6uDHjkySmHxNh7xHRkvUrjuuPE4XdM7yaSfsdvJlSeDs1ZQF5xHo
         O5cHbiD6JtfcVT/CxZoA17Yvk8SjzFytw3DEfY6F2LRf22rTgs+O+HTqLFTtGfAd0oAz
         EMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9I+4eF7JHuKDhpKvsgVjhHUZ9wjeEGwq7Ps2JDI4RI0=;
        b=fNLGT+Wabrl5d8HEDDf6lBAILiefndRgzOZrJES4X/txpyUe9fO8Gg/ceggA7XGYC1
         0MR+Wg16PXXK/61JY397sKVFSa0I9qRefKsZmMB7+bXT7fGW/9gU/zxQK0E2qTK6AZbg
         FZLUxj0Ed32jg7hxaKlMDZ6m4kaw59jdqAlgTXpGObHzUsScIoGAFLKHoRN49EoS2/P2
         VmMlomIelcWT2jZkxyq5QGM4CZwLWr4c2re9pWJ7L2lxpENCegCvwaVjJa7gaIwxF1L4
         J93HxE7oEUyqUBLOK6Z+SYyY0hyKqY3H3rUUPky9oB2wmmRThHV/anEDC0sCx7MJgRqS
         uMsQ==
X-Gm-Message-State: ANhLgQ2WfXFakMOB56WUtT6tE4qBH3hPVBZTx+Y14lWk82vsib2knb2v
        wrsYbANjqGi72eu0OrzaHgbsF1AKjhcPjRdFy5QaaA==
X-Google-Smtp-Source: ADFU+vtoo6q0aRg0eOPG5bJVvVb8FZFjyX3pRHnTnpeovqy6zd15ZAY3LY2ZLZlRRw8anaXBP2L+DJueyI9hTlp6G0g=
X-Received: by 2002:a19:ac8:: with SMTP id 191mr9598082lfk.77.1585324513853;
 Fri, 27 Mar 2020 08:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
In-Reply-To: <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Fri, 27 Mar 2020 10:55:02 -0500
Message-ID: <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

A non-assembled array always reports raid1.

I would run "dmesg | grep md126" to start with and see what it reports it saw.

On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> Thanks Wol,
>
> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> reported.  The first (md126) in reported as inactive with all 7 disks
> listed as spares.  The second (md127) is reported as active
> auto-read-only with all 7 disks operational.  Also, the only
> "personality" reported is Raid1.  I could go ahead with your suggestion
> of mdadm --stop array and then mdadm --assemble, but I thought the
> reporting of just the Raid1 personality was a bit strange, so wanted to
> check in before doing that...
>
> Thanks,
> Allie
>
> On 3/26/2020 10:00 PM, antlists wrote:
> > On 26/03/2020 17:07, Alexander Shenkin wrote:
> >> I surely need to boot with a rescue disk of some sort, but from there,
> >> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >
> > Okay. Find a liveCD that supports raid (hopefully something like
> > SystemRescueCD). Make sure it has a very recent kernel and the latest
> > mdadm.
> >
> > All being well, the resync will restart, and when it's finished your
> > system will be fine. If it doesn't restart on its own, do an "mdadm
> > --stop array", followed by an "mdadm --assemble"
> >
> > If that doesn't work, then
> >
> > https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >
> > Cheers,
> > Wol
