Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB96242B59
	for <lists+linux-raid@lfdr.de>; Wed, 12 Aug 2020 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHLOZD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Aug 2020 10:25:03 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:41598 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgHLOZD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 12 Aug 2020 10:25:03 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 07CE7Y63021849;
        Wed, 12 Aug 2020 15:07:34 +0100
From:   Nix <nix@esperi.org.uk>
To:     Michael Fritscher <michael@fritscher.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Recommended filesystem for RAID 6
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
        <1381759926.21710099.1597158389614.JavaMail.zimbra@karlsbakk.net>
        <4a7bfca8-af6e-cbd1-0dc4-feaf1a0288be@fritscher.net>
Emacs:  if SIGINT doesn't work, try a tranquilizer.
Date:   Wed, 12 Aug 2020 15:07:33 +0100
In-Reply-To: <4a7bfca8-af6e-cbd1-0dc4-feaf1a0288be@fritscher.net> (Michael
        Fritscher's message of "Tue, 11 Aug 2020 21:19:07 +0200")
Message-ID: <87wo24arfe.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1102; Body=2 Fuz1=2 Fuz2=2
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11 Aug 2020, Michael Fritscher told this:
> ext4 is fine. In my experience, it is rock-solid, and also fsck.ext4 is
> fairly qick (don't know what Roy is doing that it is so slow - do you
> really made a full-fledged ext4 with journal or a old ext2 file system?^^)

I note that modern mkext2fs leaves whole block groups uninitialized if
it can, and any block groups that end up with no files in again get
marked uninitalized once more (as of e2fsprogs 1.43). If an older
e2fsprogs than that is in use, or if this is an fs too old to support
unintialized block groups, or if the fs simply doesn't have uninit_bg
enabled (which requires explicit action at creation time, these days),
e2fsprogs will be massively slower than if it can exploit the
uninitialized bgs to (basically) skip huge chunks of the fsck work on
most of the fs that is known to be empty.

Without this optimization, one component of fsck time is linear in the
total size of the fs: with it, it's linear in the *allocated* space used
on the fs. (There are other passes that scale as number of allocated
inodes, number of directories, etc.)

-- 
NULL && (void)
