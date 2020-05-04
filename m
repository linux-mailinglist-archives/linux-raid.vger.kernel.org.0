Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881D51C4A4B
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 01:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgEDX2n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDX2n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 19:28:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101CC061A0E
        for <linux-raid@vger.kernel.org>; Mon,  4 May 2020 16:28:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g13so488769wrb.8
        for <linux-raid@vger.kernel.org>; Mon, 04 May 2020 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DpxKTgK8VdQzSgqpqi+paL4cklPNlqZ4C02j5kZH94=;
        b=1VXwwo2PEPtP9RA69YK6YrsCQZd7HOmT2MLlajuiA0zuv/7fvcj4Z/G0FYX3Hi9EA+
         3juu8O1EjSvmN54xonZ0XE4V0CTP10qw9NAPzjLOTEZFKd9V6vKbpE1YoRh/LqVjk+Tt
         Lq0hUpMCk4NnrDw7c7ALIy2vHhNLIiZN/V6BHk2C2YPHA49S+q7EUu8bqjA+teW1LQ+U
         avG2BWAemQjRVth/M/Ev58AZy6WpgqKY4FiIZWj9d534V6ds4qrl8rEwV6GdSEwr/0N0
         ARFdMPqK+I1FG5Sdv2XLAkG5FY41/6Ea8PBhSo2KgozigUCWQB6utoepHHIj9IuYW2RT
         DFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DpxKTgK8VdQzSgqpqi+paL4cklPNlqZ4C02j5kZH94=;
        b=o1dNODohI46pO3RhPqGT07ccxCjR5kQNYTMDfIbtIeVNnRu6MQpbTd7wMkl0/WloKs
         CE2yxD1ngtwok6B7EfvvB0nM8APqlibd/pZCaCWZd3AVdqKTSG4n/tOeRlCimksns93Z
         lwVUzjSgNqrocfyZwj1NT/TVihOiGd+sEHzNqd9jLmWdIBy3KMQ7qYkrFbMyxwn4JB4D
         EeDXn52WPWPHJTbkMnuQRX7I1GXUCt81qqDkbzkTGL0HX7zjbMywZZY3+XbhpFBr/zek
         ieLYPdf1DGP4fNDh+LHpFelUIXDtLwljeUHIGPsKcoAKHsT1plsmItNJbRGZ5oY+68Hr
         G1uQ==
X-Gm-Message-State: AGi0Pua4gOjqaosbsDBQrjst78+UIYURuWs6d1tlAJDhNL+oSDxjQOP3
        eigRzZhqUpkjxfA1E49jH6cqvU14rJMsV4qGOkCgOJsE
X-Google-Smtp-Source: APiQypJ6TjI5deKYjBz6tJ78Ogp79660Y8c1gs398wpczXY3iAa822qjuzzHptisHndN1snW+o73JbKMQylfknusjDM=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr310365wrc.42.1588634920194;
 Mon, 04 May 2020 16:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
 <20200504162138.GA4791@lazy.lzy> <CAJCQCtQaCq+D0YUa-smGqCDAeOQQcq1rM5RJ+xCGsWrCrrnM4A@mail.gmail.com>
In-Reply-To: <CAJCQCtQaCq+D0YUa-smGqCDAeOQQcq1rM5RJ+xCGsWrCrrnM4A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 17:28:24 -0600
Message-ID: <CAJCQCtRinqCeCV1OS0BrObcm4Vc4ymZ6NcXwVhuGWFHBbgYhCA@mail.gmail.com>
Subject: Re: WD Red drives are now SMR drives?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        antlists <antlists@youngman.org.uk>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 4, 2020 at 2:11 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, May 4, 2020 at 10:21 AM Piergiorgio Sartor
> <piergiorgio.sartor@nexgo.de> wrote:
> >
> > On Mon, May 04, 2020 at 12:38:04AM +0100, antlists wrote:
> > > Has anyone else picked up on this? Apparently 1TB and 8TB drives are still
> > > CMR, but new drives between 2 and 6 TB are now SMR drives.
> > >
> > > https://www.extremetech.com/computing/309730-western-digital-comes-clean-shares-which-hard-drives-use-smr
> > >
> > > What impact will this have on using them in raid arrays?
> >
> > https://www.smartmontools.org/ticket/1313
> >
>
> I think it is defective abstraction that's the problem, not SMR per se.
>
> For a drive in normal use to fail with write errors like this? It's defective.
> [20809.396284] blk_update_request: I/O error, dev sdd, sector
> 3484334688 op 0x1:(WRITE) flags 0x700 phys_seg 2 prio class 0
>
> As to what kind of performance guarantees they've made or implied, I
> think they have an obligation to perform no worse than the slowest
> speed of CMR "inside track" performance. However, they want to achieve
> that is their technical problem. They market DM-SMR as handling
> ordinary file systems without local mitigations.
>

This same issue came up on the Btrfs list today. And one suggestion is
stratospheric SCSI block layer timeout settings beyond 10 minutes, to
avoid link resets. That's not what's reported in this thread so far,
so I think we need more information about the exact failure modes.
Link resets, however untenable for some workflows, can be changed. But
discrete write errors, that strikes me as a bug/defect.

-- 
Chris Murphy
