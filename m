Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8055046C92
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFNW4p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:56:45 -0400
Received: from smtp03.mail.qldc.ch ([212.60.46.172]:51480 "EHLO
        smtp03.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfFNW4p (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 14 Jun 2019 18:56:45 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 18:56:44 EDT
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp03.mail.qldc.ch (Postfix) with ESMTPS id D479F23016
        for <linux-raid@vger.kernel.org>; Sat, 15 Jun 2019 00:47:50 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id 14068344A8F
        for <linux-raid@vger.kernel.org>; Sat, 15 Jun 2019 00:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1560552470;
        bh=bupq9NAAzjFwkXqDBMOwJoIRuTDwXx9OrMD6Mu2+3+M=;
        h=To:From:Subject:Date:From;
        b=GCYEwSXLRwKfhebbarLwRNu1jMODLzi99IWNxmLbL1mSLQpFGLneK9QZfV3nKWlqM
         deNMNlvg6kgD3trUHqAn6Kr/yTpQwX0h0mDfCTLY1S3Gwf+HcZJvV6xrtOH9yzkdtZ
         0/y0DeyNRdw4I+vH+Cu/piuBLFEhcNwMYFpt8wUw=
To:     linux-raid@vger.kernel.org
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Subject: md0: bitmap file is out of date, resync
Openpgp: preference=signencrypt
Message-ID: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
Date:   Sat, 15 Jun 2019 00:47:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tuxedo.ath.cx
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello together

For a long time now (surely since the beginning of 2018) I have the
problem that every now and then after a reboot of the system (PC
workstation) the RAID-1 is resynchronized.

Possibly the problem occurs mostly or always after an kernel update
kernel, but there are cases (like today) where no update was made.

The RAID-1 consisting of 2x 2TB SATA HDD

The RAID is built with mdadm, at the earlier days with header version
0.x, but also completely rebuilt (because of this problem) with header
version 1.2

The Linux system is a Debian "testing" (version 10.0)

Current kernel version: 4.19.0-5-amd64 #1 SMP Debian 4.19.37-3
(2019-05-15) x86_64 GNU/Linux

But the problem was already at version: 4.17.0-1-amd64 #1 SMP Debian
4.17.8-1 (2018-07-20) x86_64 GNU/Linux

The log entry in kern.log (after restart) when the RAID needs to be
resynchronized:
> Jun 14 23:11:01 $hostname kernel: [    2.132085] md/raid1:md0: not clean -- starting background reconstruction
> Jun 14 23:11:01 $hostname kernel: [    2.132088] md/raid1:md0: active with 2 out of 2 mirrors
> Jun 14 23:11:01 $hostname kernel: [    2.132245] md0: bitmap file is out of date (228834 < 228835) -- forcing full recovery
> Jun 14 23:11:01 $hostname kernel: [    2.132297] md0: bitmap file is out of date, doing full recovery

The new synchronization will look like this (today):
> $ cat /proc/mdstat 
> Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10] 
> md0 : active raid1 sdb1[0] sdc1[3]
>       1953382464 blocks super 1.2 [2/2] [UU]
>       [=====>...............]  resync = 25.7% (502785344/1953382464) finish=216.8min speed=111498K/sec
>       bitmap: 13/15 pages [52KB], 65536KB chunk
> 
> unused devices: <none>

I suspected once that something would not stop correctly before shutting
down, but how could you debug something like that?

I already tried to replug all SATA cables - without success. In the
meantime even a new mainboard/CPU/RAM is installed and one of the two
SATA 2TB disks is replaced by a new one. But the the problem remained :-/

While searching the internet I found a partially similar problem [1] but
without an solution.

Does anyone have any idea how I could narrow down or fix the problem?

Thanks a lot!

[1] https://www.spinics.net/lists/raid/msg47475.html
-- 
kind regards
 mathias
