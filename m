Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0134180C9C
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgCJXql (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Mar 2020 19:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgCJXql (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Mar 2020 19:46:41 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8434921927
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583883999;
        bh=zZk1Wjs73mcuEyjwwH+QICW/9L5MoXrF61qdNbfUFFA=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=r0CTTs+RkCd6SOZLQwg4v//evxnbAcBGTaz2MUVPlWWUrynMWmaZDoohIRAPA7S0X
         mUD/jVt+72FM4loq6mprbUYzwK7EBbk8D1LPsnbY+YeG7I0YKwCnwcdYftEOgaXrFT
         jljHxQyOhd++YAWcJyR6+M0UA3L2Xc+orpRFBDlk=
Received: by mail-lj1-f169.google.com with SMTP id f13so278215ljp.0
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 16:46:39 -0700 (PDT)
X-Gm-Message-State: ANhLgQ29LQg3RQkFz95qsBFgyoYQ08NtRmVohIqn+X3iai374tFOfJ8x
        o9iw/MpW6PbQ6MOXogKsHN7SIv36novLqXCCz64=
X-Google-Smtp-Source: ADFU+vvIxeOMeaiz9ok/YZpPbMJULVH334AcxgCETK5O2xCksw+MxFe8hL1qO9vFuwJMJOTqEQYaiFTJ5XFTQlGTCFU=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr348403ljl.48.1583883997616;
 Tue, 10 Mar 2020 16:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200307215811.GA27305@esprimo> <20200307220820.GA31559@esprimo>
 <20200308141427.GA15739@esprimo> <CAPhsuW4Kh7YxxarBKNKtTh=3Kef7cBxtEMEzEB_6jPkAiAor1Q@mail.gmail.com>
 <20200310221114.GA12719@esprimo>
In-Reply-To: <20200310221114.GA12719@esprimo>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Mar 2020 16:46:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW588Hq4mgnuLLk4hHU_xmKJf=-U9fZTERrQgx12z1T2-w@mail.gmail.com>
Message-ID: <CAPhsuW588Hq4mgnuLLk4hHU_xmKJf=-U9fZTERrQgx12z1T2-w@mail.gmail.com>
Subject: Re: Failed JBOD RAID on old NAS, how to diagnose/resurrect?
To:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Mar 10, 2020 at 3:11 PM Chris Green <cl@isbd.net> wrote:
>
> On Tue, Mar 10, 2020 at 02:20:02PM -0700, Song Liu wrote:
> > On Sun, Mar 8, 2020 at 7:15 AM Chris Green <cl@isbd.net> wrote:
> > >
> > > Well I've got it working again but I'm very confused as to *why* it
> > > failed the way it did.
> > >
> > > A 'cat /proc/mdstat' produced:-
> > >
> > >     Personalities : [linear] [raid0] [raid1]
> > >     md4 : active raid1 sda4[0]
> > >           973522816 blocks [2/1] [U_]
> > >
> > >     md1 : active raid1 sdb2[0] sda2[1]
> > >           256960 blocks [2/2] [UU]
> > >
> > >     md3 : active raid1 sdb3[0] sda3[1]
> > >           987904 blocks [2/2] [UU]
> > >
> > >     md2 : active raid1 sdb4[0]
> > >           973522816 blocks [2/1] [U_]
> > >
> > >     md0 : active raid1 sdb1[0] sda1[1]
> > >           1959808 blocks [2/2] [UU]
> > >
> > > So md2 and md4 (the main parts of the two 1Tb disk drives) seemed to
> > > be OK from the RAID point of view.  But I noticed that the block
> > > device for /dev/md4 didn't exist:-
> > >
> > >     ~ # ls -l /dev/md*
> > >     brw-r-----    1 root     root       9,   0 Sep 29  2011 /dev/md0
> > >     brw-r-----    1 root     root       9,   1 Sep 29  2011 /dev/md1
> > >     brw-r-----    1 root     root       9,  10 Sep 29  2011 /dev/md10
> > >     brw-r-----    1 root     root       9,  11 Sep 29  2011 /dev/md11
> > >     brw-r-----    1 root     root       9,  12 Sep 29  2011 /dev/md12
> > >     brw-r-----    1 root     root       9,  13 Sep 29  2011 /dev/md13
> > >     brw-r-----    1 root     root       9,  14 Sep 29  2011 /dev/md14
> > >     brw-r-----    1 root     root       9,  15 Sep 29  2011 /dev/md15
> > >     brw-r-----    1 root     root       9,  16 Sep 29  2011 /dev/md16
> > >     brw-r-----    1 root     root       9,  17 Sep 29  2011 /dev/md17
> > >     brw-r-----    1 root     root       9,  18 Sep 29  2011 /dev/md18
> > >     brw-r-----    1 root     root       9,  19 Sep 29  2011 /dev/md19
> > >     brw-r-----    1 root     root       9,   2 Sep 29  2011 /dev/md2
> > >     brw-r-----    1 root     root       9,  20 Sep 29  2011 /dev/md20
> > >     brw-r-----    1 root     root       9,  21 Sep 29  2011 /dev/md21
> > >     brw-r-----    1 root     root       9,  22 Sep 29  2011 /dev/md22
> > >     brw-r-----    1 root     root       9,  23 Sep 29  2011 /dev/md23
> > >     brw-r-----    1 root     root       9,  24 Sep 29  2011 /dev/md24
> > >     brw-r-----    1 root     root       9,  25 Sep 29  2011 /dev/md25
> > >     brw-r-----    1 root     root       9,  26 Sep 29  2011 /dev/md26
> > >     brw-r-----    1 root     root       9,  27 Sep 29  2011 /dev/md27
> > >     brw-r-----    1 root     root       9,  28 Sep 29  2011 /dev/md28
> > >     brw-r-----    1 root     root       9,  29 Sep 29  2011 /dev/md29
> > >     brw-r-----    1 root     root       9,   3 Sep 29  2011 /dev/md3
> > >     brw-r-----    1 root     root       9,   5 Sep 29  2011 /dev/md5
> > >     brw-r-----    1 root     root       9,   6 Sep 29  2011 /dev/md6
> > >     brw-r-----    1 root     root       9,   7 Sep 29  2011 /dev/md7
> > >     brw-r-----    1 root     root       9,   8 Sep 29  2011 /dev/md8
> > >     brw-r-----    1 root     root       9,   9 Sep 29  2011 /dev/md9
> > >
> > >
> > > The fix was simply to use 'mknod' to create the missing /dev/md4, now
> > > I can mount the drive and see the data.
> > >
> > > What I don't understand is where /dev/md4 went, how would it have got
> > > deleted?  I have yet to reboot the system to see if /dev/md4
> > > disappears again but if it does it's not a big problem to create it
> > > again.
> > >
> > > Should the RAID block devices get created as part of the RAID start
> > > up? Maybe there's something gone awry there.
> >
> > Do you have proper /etc/md.conf?
> >
> There is no /etc/md.conf or anything that I can see related to RAID
> configuration anywhere in the system.

Sorry, I meant mdadm.conf.

Please refer to https://raid.wiki.kernel.org/index.php/RAID_setup for
ways to set up the configuration.

Thanks,
Song
