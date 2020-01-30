Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2ACD14D704
	for <lists+linux-raid@lfdr.de>; Thu, 30 Jan 2020 08:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgA3H12 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Jan 2020 02:27:28 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:27886 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgA3H12 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 Jan 2020 02:27:28 -0500
Received: from [81.153.122.72] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ix4EY-0003RM-3S; Thu, 30 Jan 2020 07:27:26 +0000
Subject: Re: Is it possible to break one full RAID-1 to two degraded RAID-1?
To:     Reindl Harald <h.reindl@thelounge.net>,
        Ram Ramesh <rramesh2400@gmail.com>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
 <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
 <2c4fedff-a1c9-6ca3-5385-72b542a4a0b4@gmail.com>
 <551449ed-49f9-e567-09d3-981f4cf9eea9@thelounge.net>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E32855D.3020906@youngman.org.uk>
Date:   Thu, 30 Jan 2020 07:27:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <551449ed-49f9-e567-09d3-981f4cf9eea9@thelounge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/01/20 06:30, Reindl Harald wrote:
>> Thanks. I thought of this, but both disk in question are nvme ssd with
>> > manually added heat sink. It will be a hassle to remove and reinstall. I
>> > think I will go with the back up rather than remove disk physically. 

> why would you remove it phyiscally to remove it rom the array? seriously?

Because if you physically remove it, BOTH disks will think they are the
surviving copy. You could "assemble" either disk on its own and recover
the array.

But if you remove a disk with --fail --remove, does that tamper with the
superblock? Would that prevent that disk being re-assembled on its own?
Seriously. I don't know. And were I in the OP's shoes I would be asking
the same question.

This is where you want something COW in the stack. Lvm. Btrfs. Where you
can just take a snapshot, upgrade the system, and if it all goes
pear-shaped you throw the snapshot away.

Cheers,
Wol
