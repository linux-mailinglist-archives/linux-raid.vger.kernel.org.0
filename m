Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1C598DF
	for <lists+linux-raid@lfdr.de>; Fri, 28 Jun 2019 12:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF1K6B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Jun 2019 06:58:01 -0400
Received: from smtp05.mail.qldc.ch ([212.60.46.174]:35296 "EHLO
        smtp05.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1K6B (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 28 Jun 2019 06:58:01 -0400
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp05.mail.qldc.ch (Postfix) with ESMTPS id 963F1202DD;
        Fri, 28 Jun 2019 12:57:58 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id 30B0E344B49;
        Fri, 28 Jun 2019 12:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1561719478;
        bh=w3/oHz3cBRumeJGX9HsCPK0texkkrzl8WOVtEltDMvE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=AMJM9hAZcpsDDI7jActOXNdVIMvhFEB1Yrq28hvJ2Kec/VRWIlkEAuaeA+btZMdVa
         zqSmVGV7dNB5zZHCaRWyY4qO0VHiPP5XIrhOaF4TIPXQMwVqGj0BqqMJuOh1P+ebI1
         If+ibVSxB/L1EzWglshZBGDMro9Rx57+TQCVt68E=
Subject: Re: md0: bitmap file is out of date, resync
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
Openpgp: preference=signencrypt
Message-ID: <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
Date:   Fri, 28 Jun 2019 12:57:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
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

On 21.06.19 21:51, Mathias G wrote:
>> Question: are you running the two drives with write cache on?
>> If yes, and if your application is not heavy on writes, could you try
>> turn off HDD write cache and see if the issue repros?
> Thanks for this. I just disabled the write cache with hdparm in rc.local
> for both RAID members and will let you know if the problem occurs again.

Today the problem occurred again:

kern.log
> Jun 28 12:39:11 $hostname kernel: [    2.098096] md/raid1:md0: not clean -- starting background reconstruction
> Jun 28 12:39:11 $hostname kernel: [    2.098099] md/raid1:md0: active with 2 out of 2 mirrors
> Jun 28 12:39:11 $hostname kernel: [    2.098201] md0: bitmap file is out of date (236662 < 236663) -- forcing full recovery
> Jun 28 12:39:11 $hostname kernel: [    2.098252] md0: bitmap file is out of date, doing full recovery

And the write cache is disabled for both RAID members:
> # hdparm -i /dev/sdb |grep WriteCache
>  AdvancedPM=yes: disabled (255) WriteCache=disabled

> # hdparm -i /dev/sdc |grep WriteCache
>  AdvancedPM=no WriteCache=disabled

I'm a little at a loss..
-- 
kind regards
 mathias
