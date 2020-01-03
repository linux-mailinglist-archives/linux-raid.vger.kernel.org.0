Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870EB12FBCF
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgACRvP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 12:51:15 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35433 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgACRvP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 12:51:15 -0500
Received: by mail-lj1-f182.google.com with SMTP id j1so37244045lja.2
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7xUsI1dn7ntRMRoVI9v4qeEwDMRbxgPkrtRkkwPLCNk=;
        b=GN0nZBLPySQbY1KTHebMyg0yfOO6Ib0Weho9LEPV9WalanMAjkmZz1L1QJTRCJa5Wv
         r53OfxXeB7SiynJEhFj1xw5tobAvzIRNRXwZHjeDgX5OCjXbmAgyd13cyGctaciIpXBC
         fn7l1wT+FeXNXtPmblcowELm8/H2mhiB3brFN52nNBFBJHg+882gnAFiJ9qhZ2viPZJ0
         jTWC/B+SDaG1LNiP0C2Z+b1x96SmSZnGpn06DOk5H01QN4C68o2sj0rdcGDmkJO+fVBZ
         Nz1mRHKOqV0M7ubYwru4nynURzAP4V505gB26ZfkZvvFmN0HX6mTB07jN2vrzUIOOXM/
         tF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7xUsI1dn7ntRMRoVI9v4qeEwDMRbxgPkrtRkkwPLCNk=;
        b=umXPAGwNobXt3xno+SucCiIsA6pqMDldHNL55PaKksf3eL7JDEmbDuLWon6/228WRX
         t60nsuLoTvuR3ckjFBENdz5Gx4xVtBTZF8mWIJ2F9JXW/SYDLJ6jLjLagrfXM0Q8un2d
         oMn0vbr2RwNTg8K5N+gHuostFyP+5H1eqO7pGQITNy4oWpbf2HFJY+Ukms0nhXu34x4B
         h/j/zoyoD0TrNOtMoMYfMfdOOKvpKTWoz0keIS9Gz1mnu2cqUoDFqyDk9kAsRV64nnWM
         o+QvJaUeGl9EOpYbRyb0a1YO+1fXbQz+b/613Rx1H+Ipy1f3YTwtSBLour6pef95cC3I
         AxWQ==
X-Gm-Message-State: APjAAAVkm6Ao0hzu6aSjAtOmA97tupsHJhM+Rl7Wpr8iQE0XYSO7PGY8
        d+a3gNp0P85de4bRrPs2SyrpSYy0/WrC3JG1xd39Pg==
X-Google-Smtp-Source: APXvYqxhsUQGXiSsAwyh7UHSAAkgCXOj2LnVIwz57cHyneI/Oj/CdjCIjfwCIxrW+uk9E2mEImyEPbPyr57GSmeqaMw=
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr50751578ljc.246.1578073872829;
 Fri, 03 Jan 2020 09:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20191122172502.vffyfxlqejthjib6@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20191122172502.vffyfxlqejthjib6@macbook-pro-91.dhcp.thefacebook.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 09:51:00 -0800
Message-ID: <CAPhsuW4K=EBPrDzLAcz_AJiUnr8F-Fxm=W05d79JFjPfPaKwUQ@mail.gmail.com>
Subject: Fwd: LSF/MM/BPF: 2020: Call for Proposals
To:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

---------- Forwarded message ---------
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, Nov 22, 2019 at 9:25 AM
Subject: LSF/MM/BPF: 2020: Call for Proposals
To: <lsf-pc@lists.linuxfoundation.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
<linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
<linux-nvme@lists.infradead.org>, <bpf@vger.kernel.org>,
<linux-kernel@vger.kernel.org>


The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2020 will be held from April 27 - April 29 at
The Riviera Palm Springs, A Tribute Portfolio Resort in Palm Springs,
California. LSF/MM/BPF is an invitation-only technical workshop to map
out improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

LSF/MM/BPF 2020 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic
as soon as possible.

This year will be a little different for requesting attendance.  Please
do the following by February 15th, 2020.

1) Fill out the following Google form to request attendance and
suggest any topics

        https://forms.gle/voWi1j9kDs13Lyqf9

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

        lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

        FS:     linux-fsdevel@vger.kernel.org
        MM:     linux-mm@kvack.org
        Block:  linux-block@vger.kernel.org
        ATA:    linux-ide@vger.kernel.org
        SCSI:   linux-scsi@vger.kernel.org
        NVMe:   linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

There will be no recording or audio bridge. However, we expect that
written minutes will be published as we did in previous years:

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

        lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)
