Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CA6B8F0
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGQJIn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 05:08:43 -0400
Received: from hmm.wantstofly.org ([138.201.34.84]:59588 "EHLO
        mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQJIn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 17 Jul 2019 05:08:43 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 05:08:42 EDT
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id AC3387F2D8; Wed, 17 Jul 2019 12:02:00 +0300 (EEST)
Date:   Wed, 17 Jul 2019 12:02:00 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     linux-raid@vger.kernel.org
Subject: slow BLKDISCARD on RAID10 md block devices
Message-ID: <20190717090200.GD2080@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello!

I've been running into an issue with background fstrim on large xfs
filesystems on RAID10d SSDs taking a lot of time to complete and
starving out other I/O to the filesystem.  There seem to be a few
different issues involved here, but the main one appears to be that
BLKDISCARD on a RAID10 md block device sends many small discard
requests down to the underlying component devices (while this doesn't
seem to be an issue for RAID0 or for RAID1).

It's quite easy to reproduce this with just using in-memory loop
devices, for example by doing:

        cd /dev/shm
        touch loop0
        touch loop1
        touch loop2
        touch loop3
        truncate -s 7681501126656 loop0
        truncate -s 7681501126656 loop1
        truncate -s 7681501126656 loop2
        truncate -s 7681501126656 loop3
        losetup /dev/loop0 loop0
        losetup /dev/loop1 loop1
        losetup /dev/loop2 loop2
        losetup /dev/loop3 loop3

        mdadm --create -n 4 -c 512 -l 0 --assume-clean /dev/md0 /dev/loop[0123]
        time blkdiscard /dev/md0

        mdadm --stop /dev/md0

        mdadm --create -n 4 -c 512 -l 1 --assume-clean /dev/md0 /dev/loop[0123]
        time blkdiscard /dev/md0

        mdadm --stop /dev/md0

        mdadm --create -n 4 -c 512 -l 10 --assume-clean /dev/md0 /dev/loop[0123]
        time blkdiscard /dev/md0

This simulates trimming RAID0/1/10 arrays with 4x7.68TB component
devices, and the blkdiscard completion times are as follows:

        RAID0   0m0.213s
        RAID1   0m2.667s
        RAID10  10m44.814s

For the RAID10 case, it spends almost 11 minutes pegged at 100% CPU
(in the md0_raid10 and loop[0123] threads), and as expected, the
completion time is somewhat inversely proportional to the RAID chunk
size.  Doing this on actual 4x7.68TB or 6x7.68TB SSD arrays instead
of with loop devices takes many many hours.

Any ideas on what I can try to speed this up?  I'm seeing this on
4.15 and on 5.1.

Thank you in advance!


Cheers,
Lennert
