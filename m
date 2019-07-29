Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667AB79C7F
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jul 2019 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfG2WjI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 18:39:08 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:35844 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfG2WjI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 18:39:08 -0400
X-Greylist: delayed 3859 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 18:39:07 EDT
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x6TLMVPI010249;
        Mon, 29 Jul 2019 22:22:31 +0100
From:   Nix <nix@esperi.org.uk>
To:     pg@mdraid.list.sabi.co.UK (Peter Grandi)
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
References: <20190717090200.GD2080@wantstofly.org>
        <20190717113352.GA13079@metamorpher.de>
        <23855.33990.595530.291667@base.ty.sabi.co.uk>
        <26ef3b9b-54d0-e660-8614-a45ddd2a4b1e@thelounge.net>
        <23855.35565.981137.953275@base.ty.sabi.co.uk>
Emacs:  because you deserve a brk today.
Date:   Mon, 29 Jul 2019 22:34:45 +0100
In-Reply-To: <23855.35565.981137.953275@base.ty.sabi.co.uk> (Peter Grandi's
        message of "Wed, 17 Jul 2019 21:54:05 +0100")
Message-ID: <87mugwcyoa.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-x.dcc-servers-Metrics: loom 104; Body=2 Fuz1=2 Fuz2=2
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 17 Jul 2019, Peter Grandi said:
> I am aware that the opinion that "reboot at all and then check
> your filesystems" (and presumably other maintenance operations)
> should be or can be performed rarely is very popular among many
> sysadmins, being very low cost; to an extreme example I have
> seen systems in semi production use for which hardware and
> software went EOL in 2007 and untouched since then, and still
> "work". But some people get away with it, some don't.

The people who believe this include the developers of both the ext4 and
xfs filesystems. The recommended ext4 approach is to occasionally
snapshot the fs and fsck the snapshot to see if it needs to do anything,
and only if does raise the alarm so the sysadmin can schedule a later
fsck: the xfs recommendation is only to run a manual xfs_repair iff the
filesystem tells you to (and coming down the pipe for xfs is continuous
health monitoring and online fsck, hopefully in the end eliminating the
need to do xfs_repair ever).

Frankly, with modern filesystem sizes, it has become utterly impractical
to fsck everything while the system is not fully up and not responding
to requests: not unless you *like* your maintenance windows to include
multiple hours in which the system is doing nothing other than an fs
check that will almost certainly find *nothing whatsoever wrong*.

-- 
NULL && (void)
