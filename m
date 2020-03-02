Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD07017534C
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 06:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgCBFZo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 00:25:44 -0500
Received: from len.romanrm.net ([91.121.86.59]:48398 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgCBFZo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Mar 2020 00:25:44 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 887D243397;
        Mon,  2 Mar 2020 05:25:42 +0000 (UTC)
Date:   Mon, 2 Mar 2020 10:25:42 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>
Cc:     mdraid <linux-raid@vger.kernel.org>
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable
 I/O
Message-ID: <20200302102542.309e2d19@natsu>
In-Reply-To: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, 1 Mar 2020 19:50:03 -0600
"David C. Rankin" <drankinatty@suddenlinkmail.com> wrote:

>   Let me know if there is anything else I can send, and let me know if I
> should stop the scrub or just let it run. I'm happy to run any diagnostic you
> can think of that might help. Thanks.

It doesn't seem convincing that the issue is raw devices vs partitions, or
even kernel version related, especially since you rolled it back and the issue
remains.

What else you could send is "smartctl -a" of all devices;

and most importantly, while the "slow" scrub is running on md4, start:

  iostat -x 2 /dev/sdc /dev/sdd

(enlarge the terminal window) and see if any of the 2 devices is pegged into
100.0 in the last "%util" column, or just showing much higher values there
than the other one.

-- 
With respect,
Roman
