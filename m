Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0D14C52A
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jan 2020 05:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA2EYe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jan 2020 23:24:34 -0500
Received: from mail.thelounge.net ([91.118.73.15]:32887 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2EYe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jan 2020 23:24:34 -0500
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 23:24:33 EST
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 486qjz6y2FzXQV;
        Wed, 29 Jan 2020 05:09:06 +0100 (CET)
Subject: Re: Is it possible to break one full RAID-1 to two degraded RAID-1?
To:     Ram Ramesh <rramesh2400@gmail.com>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
Date:   Wed, 29 Jan 2020 05:09:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 29.01.20 um 04:17 schrieb Ram Ramesh:
> I have my entire debian 9.0 installation (root/usr/home etc) in two nvme
> RAID-1 mirror. Is it possible to break them in to two degraded arrays?
> 
> Specifically I want to do this.
> 
> 1. Break current debian 9 full RAID1 into two degraded RAID1 A & RAID1  B
> 2. Boot only A and upgrade to debian 10 and make sure it works
> 3. If it works, add B back into A and get Debian 10 in fully complete RAID1
> 4. If it does not work, I boot B and add A back and get back debian 9
>    in full working RAID1

i would simply remove one disk completly and in case i want to keep the
upgraded system wipe it and resync afterwards or when i want back to the
old one put it back and wipe the modified

full resync, done
