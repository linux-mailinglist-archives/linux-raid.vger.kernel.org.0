Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2368C158A9
	for <lists+linux-raid@lfdr.de>; Tue,  7 May 2019 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfEGE6d (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 May 2019 00:58:33 -0400
Received: from len.romanrm.net ([91.121.75.85]:36270 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfEGE6d (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 May 2019 00:58:33 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id A61EB20319;
        Tue,  7 May 2019 04:58:31 +0000 (UTC)
Date:   Tue, 7 May 2019 09:58:31 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Locating slow drives
Message-ID: <20190507095831.30f9cdf6@natsu>
In-Reply-To: <892824910.12274529.1557192807487.JavaMail.zimbra@karlsbakk.net>
References: <892824910.12274529.1557192807487.JavaMail.zimbra@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 7 May 2019 03:33:27 +0200 (CEST)
Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:

> Hi all
> 
> I have sometimes vitnessed a RAID set slowing down tremendously and after some research, finding a single drive performing very badly (often down to 1-2% of what it should do). In zfs, I found this with zpool iostat (IIRC, that was some time back), but I'm not using zfs at home, just md. A friend just had a similar issue, so I tried nosing around looking for some counters to tell me what was lagging, but found none. Luckily, the raid only had six drives, so we tried hdparm -t on each of them, and one of them stood out with a speed of well below 1MB/s (the others were around 100MB/s, these being a diversity of old 1TB drives). Then I checked a drive that was kicked out of my home raid the other day, apparently for no reason (smart data looking ok etc, same thing with my friend's disk) and same thing there - perhaps 2MB/s on a Western Digital RE4 (6 years spinning time in one hour at this moment), which should be something like 150MB/s or thereabout.

If you catch this slowdown event while it is occuring, you can run

  iostat -x /dev/sd? 2

to get a summary of disk I/O stats, including "utilization" percentage. The
slow disks will display 100% in the rightmost column, while others will be
mostly idle.


-- 
With respect,
Roman
