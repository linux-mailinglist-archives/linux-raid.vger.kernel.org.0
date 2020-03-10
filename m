Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1D180A37
	for <lists+linux-raid@lfdr.de>; Tue, 10 Mar 2020 22:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJVUR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Mar 2020 17:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgCJVUR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Mar 2020 17:20:17 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6755B215A4
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583875215;
        bh=+cTY7wxe57/U9h1ZYygra4mSlRBO+mCciu52rgqlEbM=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=UO9ec2njqhb53zMvR1VyGIGTDuKAx5fIQZVdRDH8BLMKDcuhLp/LZixMTGORy9Lbb
         zlnVouSOw7O9sKH4v6S+jIAKVYX3n1ccXVab5DTySdjJT+kJ2yuKu/1O9SMJWBdSXW
         k3FuxmRNwOWD7CAL33+JfEMcwhJG9edHH5L57Udg=
Received: by mail-lj1-f176.google.com with SMTP id f10so15921287ljn.6
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 14:20:15 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0+H4CQHrVRAoL1viYgVm0Vu5R5XyebUdZcSNtQ7ID9Svkulixi
        vL/mFCfCxkVVJ+ydfV0mGJP/K6fgpmHBPW9n/Lw=
X-Google-Smtp-Source: ADFU+vveSa8lU9QDvnznS57GZJkfGy3pF97GqmUL40A4x/e4w4aD4wrpXgJ9yrHf4nMsIsH6QrJUWp3Od9uYzR0bcvo=
X-Received: by 2002:a2e:7e09:: with SMTP id z9mr96179ljc.109.1583875213466;
 Tue, 10 Mar 2020 14:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200307215811.GA27305@esprimo> <20200307220820.GA31559@esprimo> <20200308141427.GA15739@esprimo>
In-Reply-To: <20200308141427.GA15739@esprimo>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Mar 2020 14:20:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Kh7YxxarBKNKtTh=3Kef7cBxtEMEzEB_6jPkAiAor1Q@mail.gmail.com>
Message-ID: <CAPhsuW4Kh7YxxarBKNKtTh=3Kef7cBxtEMEzEB_6jPkAiAor1Q@mail.gmail.com>
Subject: Re: Failed JBOD RAID on old NAS, how to diagnose/resurrect?
To:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Mar 8, 2020 at 7:15 AM Chris Green <cl@isbd.net> wrote:
>
> Well I've got it working again but I'm very confused as to *why* it
> failed the way it did.
>
> A 'cat /proc/mdstat' produced:-
>
>     Personalities : [linear] [raid0] [raid1]
>     md4 : active raid1 sda4[0]
>           973522816 blocks [2/1] [U_]
>
>     md1 : active raid1 sdb2[0] sda2[1]
>           256960 blocks [2/2] [UU]
>
>     md3 : active raid1 sdb3[0] sda3[1]
>           987904 blocks [2/2] [UU]
>
>     md2 : active raid1 sdb4[0]
>           973522816 blocks [2/1] [U_]
>
>     md0 : active raid1 sdb1[0] sda1[1]
>           1959808 blocks [2/2] [UU]
>
> So md2 and md4 (the main parts of the two 1Tb disk drives) seemed to
> be OK from the RAID point of view.  But I noticed that the block
> device for /dev/md4 didn't exist:-
>
>     ~ # ls -l /dev/md*
>     brw-r-----    1 root     root       9,   0 Sep 29  2011 /dev/md0
>     brw-r-----    1 root     root       9,   1 Sep 29  2011 /dev/md1
>     brw-r-----    1 root     root       9,  10 Sep 29  2011 /dev/md10
>     brw-r-----    1 root     root       9,  11 Sep 29  2011 /dev/md11
>     brw-r-----    1 root     root       9,  12 Sep 29  2011 /dev/md12
>     brw-r-----    1 root     root       9,  13 Sep 29  2011 /dev/md13
>     brw-r-----    1 root     root       9,  14 Sep 29  2011 /dev/md14
>     brw-r-----    1 root     root       9,  15 Sep 29  2011 /dev/md15
>     brw-r-----    1 root     root       9,  16 Sep 29  2011 /dev/md16
>     brw-r-----    1 root     root       9,  17 Sep 29  2011 /dev/md17
>     brw-r-----    1 root     root       9,  18 Sep 29  2011 /dev/md18
>     brw-r-----    1 root     root       9,  19 Sep 29  2011 /dev/md19
>     brw-r-----    1 root     root       9,   2 Sep 29  2011 /dev/md2
>     brw-r-----    1 root     root       9,  20 Sep 29  2011 /dev/md20
>     brw-r-----    1 root     root       9,  21 Sep 29  2011 /dev/md21
>     brw-r-----    1 root     root       9,  22 Sep 29  2011 /dev/md22
>     brw-r-----    1 root     root       9,  23 Sep 29  2011 /dev/md23
>     brw-r-----    1 root     root       9,  24 Sep 29  2011 /dev/md24
>     brw-r-----    1 root     root       9,  25 Sep 29  2011 /dev/md25
>     brw-r-----    1 root     root       9,  26 Sep 29  2011 /dev/md26
>     brw-r-----    1 root     root       9,  27 Sep 29  2011 /dev/md27
>     brw-r-----    1 root     root       9,  28 Sep 29  2011 /dev/md28
>     brw-r-----    1 root     root       9,  29 Sep 29  2011 /dev/md29
>     brw-r-----    1 root     root       9,   3 Sep 29  2011 /dev/md3
>     brw-r-----    1 root     root       9,   5 Sep 29  2011 /dev/md5
>     brw-r-----    1 root     root       9,   6 Sep 29  2011 /dev/md6
>     brw-r-----    1 root     root       9,   7 Sep 29  2011 /dev/md7
>     brw-r-----    1 root     root       9,   8 Sep 29  2011 /dev/md8
>     brw-r-----    1 root     root       9,   9 Sep 29  2011 /dev/md9
>
>
> The fix was simply to use 'mknod' to create the missing /dev/md4, now
> I can mount the drive and see the data.
>
> What I don't understand is where /dev/md4 went, how would it have got
> deleted?  I have yet to reboot the system to see if /dev/md4
> disappears again but if it does it's not a big problem to create it
> again.
>
> Should the RAID block devices get created as part of the RAID start
> up? Maybe there's something gone awry there.

Do you have proper /etc/md.conf?

Thanks,
Song
