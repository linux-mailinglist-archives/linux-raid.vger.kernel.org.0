Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41AD17D065
	for <lists+linux-raid@lfdr.de>; Sat,  7 Mar 2020 23:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGWIV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 7 Mar 2020 17:08:21 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35013 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCGWIV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 7 Mar 2020 17:08:21 -0500
X-Originating-IP: 84.92.49.234
Received: from esprimo.zbmc.eu (chrisisbd01.plus.com [84.92.49.234])
        (Authenticated sender: smtp@zbmc.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BFAE2FF802
        for <linux-raid@vger.kernel.org>; Sat,  7 Mar 2020 22:08:20 +0000 (UTC)
Received: by esprimo.zbmc.eu (Postfix, from userid 1000)
        id 60A9A2C14E3; Sat,  7 Mar 2020 22:08:20 +0000 (GMT)
Date:   Sat, 7 Mar 2020 22:08:20 +0000
From:   Chris Green <cl@isbd.net>
To:     linux-raid@vger.kernel.org
Subject: Re: Failed SBOD RAID on old NAS, how to diagnose/resurrect?
Message-ID: <20200307220820.GA31559@esprimo>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20200307215811.GA27305@esprimo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307215811.GA27305@esprimo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

More information, from dmesg:-


md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: Scanned 8 and added 8 devices.
md: autorun ...
md: considering sdb4 ...
md:  adding sdb4 ...
md: sdb3 has different UUID to sdb4
md: sdb2 has different UUID to sdb4
md: sdb1 has different UUID to sdb4
md: sda4 has different UUID to sdb4
md: sda3 has different UUID to sdb4
md: sda2 has different UUID to sdb4
md: sda1 has different UUID to sdb4
md: created md4
md: bind<sdb4>
md: running: <sdb4>
raid1: raid set md4 active with 1 out of 2 mirrors
raid1 not hw raidable, needs two working disks.
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md: sda4 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
md: created md3
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md3 active with 2 out of 2 mirrors
raid1 using hardware RAID 0x00000001
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md: sda4 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md1 active with 2 out of 2 mirrors
raid1 using hardware RAID 0x00000001
md: considering sdb1 ...
md:  adding sdb1 ...
md: sda4 has different UUID to sdb1
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
raid1 using hardware RAID 0x00000001
md: considering sda4 ...
md:  adding sda4 ...
md: created md2
md: bind<sda4>
md: running: <sda4>
raid1: raid set md2 active with 1 out of 2 mirrors
raid1 not hw raidable, needs two working disks.
md: ... autorun DONE.

-- 
Chris Green
