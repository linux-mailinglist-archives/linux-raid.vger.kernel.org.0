Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2382E2313CD
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 22:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgG1UXl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgG1UXk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 16:23:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162FCC061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 13:23:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t142so777529wmt.4
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zEDwmC+YKEMt817sQJSVBJW9E1RvYIUlJbscC6HcUM=;
        b=cvIgTsyC2xPLfgAUfrNt1jgBZrTxEJPwmnxjImy08pD180ZTrb8dFwV9gC4lq1IyxT
         mYt95Hhy9veDIDqDTFLOzOrvtMs/McX2wA09wH6iMUXYlJu2JbKgbZzCMYZrndjy2MPC
         PCp5B3Jnat8UQqVyO6idOcfg4eNLlfrlq2u9gf47i7rcXCdTP/jqRGBUcSEAeWFE7nAQ
         shrCcuAf64BdbcHS13dmPmgHuzVYNbs+3v5U+WkUgQJvgGWAfPFVdajlIcIg0znnfQLN
         3uCuHDPmHMqUcQcdMIo67b4TXiRCYoTDfbok03Rt9VTYXZZMcgjBjO5Ua3p5AB9ZSM7w
         CEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zEDwmC+YKEMt817sQJSVBJW9E1RvYIUlJbscC6HcUM=;
        b=a90cVPbY+FSrS3BFtWIP2amilzifVlwGtQKeRMZGP4cGB875tYNm8W9A1Al7XmcZbm
         fpjhL2Fk7YFFmB1Q24VuSKCegQICq5s+5cvB82pkS2hxU4LuvED+vUj/hJMoZeynBBVq
         CI9lUk7XvoXclpk5LJh8lLHqseDDPxq7ngzx0/h00MQzk2TZBK/Kq8r7Fdr8nQhDUqaT
         uY89P/3MIk5FRhHXfT58r08cIq/ouH5NzpVYqL1ZW+eTNSKLqeqEGh7nc6A+CScSMhUY
         WtBWv4UOqlfjuqUqFUdLf152p7JS+EJ6Zo6WzlXkSv8gWsIxRa0O7oX8SYYhYYLZJIWA
         Mq3Q==
X-Gm-Message-State: AOAM531e+h7VO0JqzO/OAuIdYez95h0vE8UpZPD48xfZCE9PZ3SLA6H7
        YautdZP5QEc/9kUBazZesCQIkubScAyeSCaDm9Bcgou4E40=
X-Google-Smtp-Source: ABdhPJyx+hBN+DmxbsK21voLvEI38Jw4mAzPScS2DeJAoAfobnXfbJ93pYjPYO4aHdAJSSbsS4VBHtNEouxRtjkEgpo=
X-Received: by 2002:a1c:a756:: with SMTP id q83mr5334722wme.168.1595967818765;
 Tue, 28 Jul 2020 13:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com> <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz>
In-Reply-To: <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 28 Jul 2020 14:23:22 -0600
Message-ID: <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 28, 2020 at 7:31 AM Vojtech Myslivec <vojtech@xmyslivec.cz> wrote:

> > dmesg
> > mdadm -E
> > mdadm -D
> > btrfs filesystem usage /mountpoint
> > btrfs device stats /mountpoint

These all look good.


> > SCT Error Recovery Control:
> >            Read:    100 (10.0 seconds)
> >           Write:    100 (10.0 seconds)
>
> It is higher than you expect, yet still below kernel 30 s timeout, right?

It's good.


> > It's not related, but your workload might benefit from
> > 'compress=zstd:1' mount option. Compress everything across the board.
> > Chances are these backups contain a lot of compressible data. This
> > isn't important to do right now. Fix the problem first. Optimize
> > later. But you have significant CPU capacity relative to the hardware.
>
> OK, thanks for the tip. Overall CPU utilization is not high at the
> moment. The server is dedicated to backups so I can try this.
>
> In fact, I am scared a bit of any compression related to btrfs. I do not
> to blame anyone, I just read some recommendation about disabling
> compression on btrfs (Debian wiki, kernel wiki, ...).

That's based on ancient kernels. Also the last known bug was really
obscure, I never hit it. You had to have some combination of inline
extents and also holes. You're using 5.5, and that has all bug fixes
for that. At least Facebook folks are using compress=zstd:1 pretty
much across the board and have a metric s ton of machines they're
doing this with, so it's reliable.

> In most cases backups are pretty fast and it runs only one at a time.
> From the logs on the server, I can see it it get stuck when only one
> backup process is running.
>
> But I am not able to tell if a background btrfs-cleaner procces is
> running at that moment. I can focus on this if it helps.

Your dmesg contains
[ 9667.449898] INFO: task md1_reclaim:910 blocked for more than 120 seconds.

It might be helpful to reproduce and take sysrq+w at the time of the
blocking. Sometimes it's best to have the sysrq trigger command ready
in a hell, but don't hit enter until the blocked task happens.
Sometimes during blocked tasks it takes forever to issue a command.

It would be nice if an md kernel developer can comment on what's going on.

Does this often happen when a btrfs snapshot is created? That will
cause a flush to happen and I wonder if that's instigating the problem
in the lower layers.


-- 
Chris Murphy
