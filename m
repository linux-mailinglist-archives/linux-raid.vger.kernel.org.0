Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C55122A2F
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLQLfL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 06:35:11 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:51124 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQLfL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 06:35:11 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 06:35:10 EST
Received: (qmail 1551 invoked from network); 17 Dec 2019 11:28:28 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 17 Dec 2019 11:28:28 -0000
Date:   Tue, 17 Dec 2019 12:28:28 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Benjammin2068 <benjammin2068@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: Keeping existing RAID6's safe during upgrade from CentOS 6 to
 CentOS 8
Message-ID: <20191217112828.GA5090@metamorpher.de>
References: <e7e9ed61-c611-3b40-2c78-6c5c47f77148@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e9ed61-c611-3b40-2c78-6c5c47f77148@gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Dec 17, 2019 at 12:42:24AM -0600, Benjammin2068 wrote:
> SO.... What's the safest thing I could do to protect it when I do the upgrade (which is essentially a fresh install of v8)
> 
> I'm assuming I should:
>
> * PULL THE DRIVES FROM THE SYSTEM.
>

It's hard to beat pulling the drives when it comes to "safest thing to do".
Also very easy to understand / intuitive way of going about things.

Possible alternatives are:

- trust the installer to not meddle with unrelated drives ;-)
  * linux installers usually behave, the main concern is user error
- do a chroot install (what Debian calls debootstrap, not sure about CentOS)
  * you have to set up partitions, filesystems, bootloaders etc. manually
- do a virtual (qemu-kvm et al.) install
  * to a virtual disk, then migrate systems afterwards
  * pass through a raw physical disk directly, boot on bare metal afterwards

I used the latter to upgrade (fresh install) Windows 7 to Windows 10.
Completely unfamiliar with MS installer and too lazy to pull drives.
Worked out just fine. (All other drives must be partitioned to Linux 
partition types or Windows won't leave them alone even after install)

Preserving /etc/mdadm.conf is optional, unless you have a very special 
configuration, you can just generate a new one from on-disk metadata, 
then set MAILADDR and such for monitoring.

That said, you should always have backups for everything in any case.

Good luck,
Andreas Klauer
