Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A892B4EFA4
	for <lists+linux-raid@lfdr.de>; Fri, 21 Jun 2019 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUTvj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 21 Jun 2019 15:51:39 -0400
Received: from smtp04.mail.qldc.ch ([212.60.46.173]:57748 "EHLO
        smtp04.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUTvj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 21 Jun 2019 15:51:39 -0400
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp04.mail.qldc.ch (Postfix) with ESMTPS id 7EEB620277;
        Fri, 21 Jun 2019 21:51:36 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id B1F8A344240;
        Fri, 21 Jun 2019 21:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1561146695;
        bh=NRnkP9eSBVCwVPRUAbbnyPuQCLhIv/BWp5MxEssqPpg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aEz1ql9qJ4IsFS4TKjrAgwzGGJNuHr5rRSlwMUr3q3lw6hXD2TZ9yKEg1UoVl2D31
         emI6AJ7ylWhhT5ON7iWDJ7EZUNdtDs+jjOu7m9FTYTP3vqDVRhYsyPVsF2M4EyrPXT
         BJnxABfc4/MRB1Hvtn0lpaCBfrK8gPwYQrewow/4=
Subject: Re: md0: bitmap file is out of date, resync
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Message-ID: <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
Date:   Fri, 21 Jun 2019 21:51:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
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

Hi Song

On 15.06.19 17:30, Song Liu wrote:
> The events count is just off by 1, so it looks like the bitmap's super
> block didn't got update properly. From the code in latest upstream,
> we write the superblock with REQ_SYNC, but not REQ_OP_FLUSH
> or REQ_FUA, so this _might_ be the problem.
Ok

> Question: are you running the two drives with write cache on?
> If yes, and if your application is not heavy on writes, could you try
> turn off HDD write cache and see if the issue repros?
Thanks for this. I just disabled the write cache with hdparm in rc.local
for both RAID members and will let you know if the problem occurs again.
-- 
kind regards
 mathias
