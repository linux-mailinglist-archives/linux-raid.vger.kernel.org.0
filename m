Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAE474940
	for <lists+linux-raid@lfdr.de>; Tue, 14 Dec 2021 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhLNRZR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Dec 2021 12:25:17 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:59832 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236449AbhLNRZQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Dec 2021 12:25:16 -0500
Received: from host81-132-12-162.range81-132.btcentralplus.com ([81.132.12.162] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1mxA8h-0008vL-52
        for linux-raid@vger.kernel.org; Tue, 14 Dec 2021 15:54:51 +0000
Message-ID: <d8a0d8c9-f8cc-a70a-03a0-aae2fd6c68c2@youngman.org.uk>
Date:   Tue, 14 Dec 2021 15:54:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     linux-raid <linux-raid@vger.kernel.org>
From:   Wols Lists <antlists@youngman.org.uk>
Subject: Debugging system hangs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Don't know if this is off-topic or not, seeing as my system is very much 
reliant on raid ...

But basically I'm seeing the system just stop responding. Typically it's 
in screensaver mode, I've got a blank screen, and it won't wake up. (I 
used to think it was something to do with Thunderbird, it mostly 
happened while TB was hammering the system, but no ...)

Today, I had it happen while the system was idle but not in screensaver, 
I run xosview, and everything was clearly frozen - including xosview.

As you might know, my stack is ext4 over lvm (over raid over 
dm-integrity for /home) over spinning rust.

And I run gentoo/systemd - currently on the latest stable kernel afaik, 
5.10.76-gentoo-r1 SMP x86_64.

Any advice on how to debug a hang - basically I need something that'll 
just sit there so when it crashes (and I press the reset button to 
recover) I'll have some sort of trace. It would be nice to prove it's 
not the disk stack at fault ...

Obviously, "set these options in the kernel" won't faze me ...

Cheers,
Wol
