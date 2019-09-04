Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D60A7C81
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfIDHQy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Sep 2019 03:16:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfIDHQy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Sep 2019 03:16:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id v38so15523098edm.7
        for <linux-raid@vger.kernel.org>; Wed, 04 Sep 2019 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cJyLGCEmNqfScuKgFySnlLnreYW8XhDgNCyhVwVPj8=;
        b=BqK7vyJ2dCNdMGp+wiOSvuz86aCzCoDk7zlUxJElmGZV1vged755/ja4QiZ0h6SjfE
         IaOh8yaPkt0wp4/DdT4fHdyyrEnsz2fQKchU4uTR7irmzxiTy40X6UFKRDw9lLBqplZ/
         PVuuAYGFohbmIWWNcnFghkb4bPObLcspBqRH0YaDOVB/IJBYpbMc1MkKKmMtb7/juliF
         /jvsAmfmt6ZnRtDRVmspzSRTSFKi0PoMnS/8bfM+ibb5VY1iT8s0rs3wOrkecX0hBXKd
         ahYUGiUq6lPCM8S3JQ2pdjxQU0M2DYiiyffTSr0up6KKinzU3hTxappxFuQGBlsAO3X4
         xvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cJyLGCEmNqfScuKgFySnlLnreYW8XhDgNCyhVwVPj8=;
        b=oBY+yZFZ5S7EoiSYMXfaOAz9ivdx/WQKvBASvomovLQIZB59jdnHQKzwRcoPScQWr/
         /jPBkwJbuZYyMCIInXn0LpuwlF/Pv5XqjmtqYq8R0UgaPkNKPsZhVAtLbU5MORODsNpn
         HssVGyjey5Eq8QInPjyXHTSLl5YCMI4Q+kPc+8Is1K+tZzM9JBrcP5WAbVIsFxPQWpZa
         LIYqokhkGb+AkJ4nZPmqUPmAzk8Y82QCBs/wWknTZBMPNk08fx9DjUvGCa2kCD55fDuM
         EyhDlYgDQy3TWrww1OPLQkROc6lLlYlHs/TYnLSUlypA8SzEBmgBqe9bvDLRV1rCEiOv
         H5YQ==
X-Gm-Message-State: APjAAAXGMfW0j/zbUqjdw+JAl0kE/aPsUWwczPsNfmdHJCLexU1IH7yl
        GHdAhPVNkfphXhttG4vpw3ATPeU5V3p8bfFVH80=
X-Google-Smtp-Source: APXvYqyNxWdHcZxg20NQkk/naUoheo8PVOohAJYLLNGhwWW1KJBMhSdx2dzApNpxpWjKVACSfJ9AOT4pQuN2w2xxApM=
X-Received: by 2002:a17:906:1d11:: with SMTP id n17mr23011882ejh.68.1567581412590;
 Wed, 04 Sep 2019 00:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk> <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
 <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org> <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
 <87h85udyfs.fsf@notabene.neil.brown.name> <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
 <d9a08687-0225-407f-dff0-f7f440786654@turmel.org> <20190904111803.56669fde@natsu>
In-Reply-To: <20190904111803.56669fde@natsu>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Wed, 4 Sep 2019 09:16:26 +0200
Message-ID: <CA+ojRw=su87MbupvnWdXBfmbUzDGMRYjB8fnzPfo3T7UjS_P=Q@mail.gmail.com>
Subject: Re: mdadm RAID5 to RAID6 migration thrown exceptions, access to data lost
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Phil Turmel <philip@turmel.org>, NeilBrown <neilb@suse.de>,
        Neil F Brown <nfbrown@suse.com>, linux-raid@vger.kernel.org,
        Wols Lists <antlists@youngman.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Roman,

> See: https://bugzilla.redhat.com/show_bug.cgi?id=1013708#c7
>
> This is not caused by running the userland "perf" tool. Happens on a few of my
> machines too, shortly after each reboot. I guess you don't check dmesg often
> enough, probably on yours too.

To be honest this message doesn't appear on my outdated host. Here we
can see it in the output of `dmesg`, because I'm running live
SystemRescueCD distro with the more modern kernel.
