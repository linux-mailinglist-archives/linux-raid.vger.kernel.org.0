Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB752836F7
	for <lists+linux-raid@lfdr.de>; Mon,  5 Oct 2020 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJENwo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 5 Oct 2020 09:52:44 -0400
Received: from rin.romanrm.net ([51.158.148.128]:41922 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgJENwm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 5 Oct 2020 09:52:42 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 09:52:42 EDT
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id EEF398D7;
        Mon,  5 Oct 2020 13:44:49 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:44:49 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Daniel Sanabria <sanabria.d@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: do i need to give up on this setup
Message-ID: <20201005184449.54225175@natsu>
In-Reply-To: <CAHscji30ACa2d0qz-nr5vqPYOP642dwjS5BY07g2DQS7GBG-2A@mail.gmail.com>
References: <CAHscji30ACa2d0qz-nr5vqPYOP642dwjS5BY07g2DQS7GBG-2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 5 Oct 2020 14:10:25 +0100
Daniel Sanabria <sanabria.d@gmail.com> wrote:

> Hi all,
> 
> Scrubbing ( # echo check >
> /sys/devices/virtual/block/md1/md/sync_action) is killing my array :(
> 
> I'm attaching details of the array and disks (bloody wd greens) as
> well as journalctl errors providing some details about the issue.
> 
> If you have any pointers on what might be the cause of this as well as
> any recommendations on how to improve things please let me thank you
> in advance ...
> 
> I have backups of the data so happy to move this to a different setup
> you might recommend (apps will be mostly reading from the array via
> NFS since most of the content will be media).
> 
> My suspicion is that a timer service is kicking in and disrupting the
> scrubbing somehow but can't pinpoint what causes this.

It looks like a drive is dropping off the bus and then failing to reidentify,
could be bad cabling/controller/PSU, or just a bad drive. You should post
"smartctl -a" of all drives as well.

-- 
With respect,
Roman
