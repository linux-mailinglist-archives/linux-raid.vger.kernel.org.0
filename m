Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7323C1B5C
	for <lists+linux-raid@lfdr.de>; Fri,  9 Jul 2021 00:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGHWKP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 8 Jul 2021 18:10:15 -0400
Received: from tn-76-7-174-50.sta.embarqhsd.net ([76.7.174.50]:55362 "EHLO
        animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGHWKP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 8 Jul 2021 18:10:15 -0400
X-Greylist: delayed 1115 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 18:10:14 EDT
Received: from wakko by animx.eu.org with local 
        id 1m1btA-00005V-4T
        for linux-raid@vger.kernel.org; Thu, 08 Jul 2021 17:48:56 -0400
Date:   Thu, 8 Jul 2021 17:48:56 -0400
From:   Wakko Warner <wakko@animx.eu.org>
To:     linux-raid@vger.kernel.org
Subject: bad sector and unused area.
Message-ID: <YOdyyGBnFKHr7Xyc@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have a raid5 of 3 disks.

2 of them have bad sectors.  Sector 1110 and 1118.

I'm curious to know if these sectors actually contain any data or if they
can just be overwritten.

All 3 disks are partitioned with partition starting at sector 128.

The raid was created some time ago.  I have never replaced any of the disks.

mdadm -E of one of the disks shows the following information (just relevent
to the question)
        Version : 1.1
    Data Offset : 262144 sectors
   Super Offset : 0 sectors
   Unused Space : before=262072 sectors, after=290 sectors

Doing the math, from offset 0 to 71 I would assume is the superblock.  Given
the bad sectors as shown by the kernel logs, 1110 and 1118 would fall in the
unused space.

So if I were to dd if=/dev/zero of=/dev/sda count=262072 seek=200, would
this break my array?  This command would be against the whole disk, not
partition.

I do have multiple backups of this system.

FYI, I did initiate a check to verify the data area, and there's no bad
sectors there.
