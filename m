Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB69680FF
	for <lists+linux-raid@lfdr.de>; Sun, 14 Jul 2019 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfGNTVL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Jul 2019 15:21:11 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:51240 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfGNTVL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 14 Jul 2019 15:21:11 -0400
Received: from [81.155.195.121] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hmk3Z-0006yI-7S; Sun, 14 Jul 2019 20:21:09 +0100
Subject: Re: Weird behaviour of md, maybe a bug in 4.19.xx kernel?
To:     Tito <farmatito@tiscali.it>, linux-raid@vger.kernel.org
References: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
 <5D2B3FF9.8000806@youngman.org.uk>
 <4f572716-abd7-5a4e-709c-285a330a92c4@tiscali.it>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D2B80A4.1040507@youngman.org.uk>
Date:   Sun, 14 Jul 2019 20:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <4f572716-abd7-5a4e-709c-285a330a92c4@tiscali.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/07/19 18:05, Tito wrote:
> 
> /dev/sda
> smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-9-amd64] (local build)
> Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Western Digital Green
> Device Model:     WDC WD10EZRX-00A3KB0
> Serial Number:    WD-WCC4J6AL8ZKE
> LU WWN Device Id: 5 0014ee 20b8a1e1e
> Firmware Version: 01.01A01
> User Capacity:    1,000,204,886,016 bytes [1.00 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    5400 rpm
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   ACS-2, ACS-3 T13/2161-D revision 3b
> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
> Local Time is:    Sun Jul 14 17:56:58 2019 CEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> SCT Error Recovery Control command not supported

That's not a good sight. I notice your WD Blue is the same.

So long as you run that timeout script every boot, then your arrays
should be safe, but I'd get rid of those drives out of the array asap.
If they happen to play up, any application reading from those drives is
going to appear to hang for between 2 and 3 minutes - not nice.

I notice the Barracuda is apparently okay! I also notice it's a 1GB
model? So it's probably old. Normally seeing "Barracuda" makes me worry,
but if this drive is ticking over fine, then it's probably all right.

Cheers,
Wol
