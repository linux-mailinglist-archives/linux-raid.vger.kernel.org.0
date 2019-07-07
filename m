Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58875614F0
	for <lists+linux-raid@lfdr.de>; Sun,  7 Jul 2019 14:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGGMjT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 7 Jul 2019 08:39:19 -0400
Received: from smtp03.mail.qldc.ch ([212.60.46.172]:39450 "EHLO
        smtp03.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGGMjT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 7 Jul 2019 08:39:19 -0400
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp03.mail.qldc.ch (Postfix) with ESMTPS id B35AC20255;
        Sun,  7 Jul 2019 14:39:15 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id D806F345B5A;
        Sun,  7 Jul 2019 14:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1562503155;
        bh=3ItjQids/T7XD6EKlCln15oxc763GJWZf90SGgAha94=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=s5gMzAtDs3jhB75yjVLGGMmJfza6invCXGGRS53VoSvWLd/0VGsMHcw79XSsLoitd
         kDKyuywDM/aqTnK7rRWAGdYvSYZHkhcNmNPtnSajOOPMqibfv7aZJ2ic9znQ8O7uEv
         YGztyholfBxSLvT9bRZ4kex7iGR1cHm4m9mK4q1I=
Subject: Re: md0: bitmap file is out of date, resync
To:     Hou Tao <houtao1@huawei.com>, Song Liu <liu.song.a23@gmail.com>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
 <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
 <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Message-ID: <b2ba92ab-f97b-aab2-91a2-1a7dbbcab69d@tuxedo.ath.cx>
Date:   Sun, 7 Jul 2019 14:39:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tuxedo.ath.cx
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Tao

Thank you for your reply.

On 06.07.19 06:49, Hou Tao wrote:
> "not clean" means the resync has not been completed yet. Is the array still "not clean" in the previous boot/reboot or not ?
> If it is only "not clean" in the reproduced boot, that may mean the final update of MD super block is lost and the lagging
> behind of the events in bitmap super-block will be possible.
The array is in a clean state before the reboot.

> Is the RAID array (md0) used as rootfs or other fs ? And how do you reproduce the problem ? Just rebooting continuously
> until the problem reoccurs ? And not suddenly power-cut ?
Its not in use as root-fs, the array is mounted as /home/ dir.

I never tried to reboot until the problem occured again, just continuous
more or less daily usage (as workstation)

All reboots were clean reboots without power-cuts.
-- 
regards
 mathias
