Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10744F745
	for <lists+linux-raid@lfdr.de>; Sun, 14 Nov 2021 09:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKNIy4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Nov 2021 03:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhKNIyy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 14 Nov 2021 03:54:54 -0500
X-Greylist: delayed 270 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Nov 2021 00:51:58 PST
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C103C061746
        for <linux-raid@vger.kernel.org>; Sun, 14 Nov 2021 00:51:57 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 46335626;
        Sun, 14 Nov 2021 08:47:24 +0000 (UTC)
Date:   Sun, 14 Nov 2021 13:47:23 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     David T-G <davidtg+robot@justpickone.org>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: overlays on dd images of 4T drives
Message-ID: <20211114134723.46092368@nvm>
In-Reply-To: <20211114022924.GA21337@opal1.opalstack.com>
References: <20211114022924.GA21337@opal1.opalstack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, 14 Nov 2021 02:29:24 +0000
David T-G <davidtg+robot@justpickone.org> wrote:

>   diskfarm:/mnt/10Traid50md/tmp # ls -goh overlay-sd*
>   -rw-r--r-- 1 4.0T Nov 12 02:05 overlay-sda1
>   -rw-r--r-- 1 4.0T Nov 12 02:05 overlay-sdb1
>   -rw-r--r-- 1 4.0T Nov 12 02:05 overlay-sdc1
>   diskfarm:/mnt/10Traid50md/tmp # losetup -a
>   /dev/loop1: [66326]:1059 (/mnt/10Traid50md/tmp/overlay-sdb1)
>   /dev/loop2: [66326]:1060 (/mnt/10Traid50md/tmp/overlay-sdc1)
>   /dev/loop0: [66326]:1058 (/mnt/10Traid50md/tmp/overlay-sda1)
> 
> my overlay files and loopback devices.  But ...
> 
> It seems that blockdev does not like
> 
>   diskfarm:/mnt/10Traid50md/tmp # blockdev --getsize ./overlay-sda1
>   blockdev: ioctl error on BLKGETSIZE: Inappropriate ioctl for device
> 
> my files

It must be run on block devices, not files, so try: 

  blockdev --getsize /dev/loop0

-- 
With respect,
Roman
