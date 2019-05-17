Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1449122003
	for <lists+linux-raid@lfdr.de>; Sat, 18 May 2019 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEQWEh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 May 2019 18:04:37 -0400
Received: from use.bitfolk.com ([85.119.80.223]:52039 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfEQWEh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 May 2019 18:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=GKHkvWwRl5ygv+NPnS/yCBUhmI+D+Emv/eycIBDdI+8=;
        b=XW97RTBHnyqxc2GIu2NAAwUTut1+X4kqrvyXkfEFJpUj2JXLus40Uk3OidTR/sPtyGYm0uWEu1viN0W1RKdHOQR3Eh2Q4WB/YEjOIvXyaulr3WOXDkadoBGSmy80QnV9S5qlK3xs3b4wKO6y7ubT4G6rFiaVZP7VNpxXakg8CThHSzSglv/6mo7gRp4OTsHecLCfWCllBzsFMr83aaWwjxDqKZ9LHteYTc4+hDqazI9yZC966I89UEB7s2zo2RuCJ41HIO/h9T2nJmou7Y2L0DJVYymveNznh4DYBJgzHKhEXeC5mpnanPHY0U2kW8KXHebFvAE54S4Q1j2CDzs+Ig==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hRkxw-0004tl-Io
        for linux-raid@vger.kernel.org; Fri, 17 May 2019 22:04:36 +0000
Date:   Fri, 17 May 2019 22:04:36 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Is --write-mostly supposed to do anything for SSD- and NVMe-class
 devices?
Message-ID: <20190517220436.GJ4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I have a machine with one SATA SSD and one NVMe device. Of course
even the SSD is pretty high performance and the NVMe is over 4 times
faster than that, if we're talking about IOPS.

I've never used --write-mostly before but I thought maybe if I put
them both in a RAID-10 but set the SSD device to --write-mostly then
most reads would come from the NVMe and benefit from its increased
performance. I have not, however, been able to demonstrate that. It
doesn't appear to do anything different compared to not using
--write-mostly.

Here's some fio stats:

    https://tools.bitfolk.com/wiki/User:Strugglers/write-mostly

Am I testing it incorrectly or are my expectations wrong? Is it just
not expected to do anything with devices like these?

I realised that I only tested things with a single fio process with
a queue depth of 32, so I tried some more tests with 4 processes and
a queue depth of 64, but again the results were indistinguishable.

Debian testing (buster), which has mdadm package version 4.1-1 and
kernel package version linux-image-4.19.0-4-amd64 4.19.28-2. The git
HEAD version of fio was used.

Cheers,
Andy
