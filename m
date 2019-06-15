Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26A46EFA
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfFOI1b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 15 Jun 2019 04:27:31 -0400
Received: from smtp03.mail.qldc.ch ([212.60.46.172]:33971 "EHLO
        smtp03.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFOI1b (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 15 Jun 2019 04:27:31 -0400
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp03.mail.qldc.ch (Postfix) with ESMTPS id 20F142029D;
        Sat, 15 Jun 2019 10:27:28 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id 8FCB3344405;
        Sat, 15 Jun 2019 10:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1560587248;
        bh=7VXqBEGOWBl8o0VukQxwf3Dc5S0sagyAVBXNGwGfF/A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LjINZ3xKZph2VDkV2BhyE3gaowlNCbB8a/CiL8NqOn379udh/Q6BqmAVJaf0jGd7R
         yeWEsfAasTB04SxdgultpRMLwzxWrs+0R0ART9Hdhd9LSMfcLQqVLtnkI+mZXo27kQ
         /4IWYCjmRzyZgivHEEX2jMkzqfNfQ9k8/+mUHdzg=
Subject: Re: md0: bitmap file is out of date, resync
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Message-ID: <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
Date:   Sat, 15 Jun 2019 10:27:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tuxedo.ath.cx
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song

Thanks for your reply.

On 15.06.19 02:39, Song Liu wrote:
> To be clear, this does not happen every time, right?
This is correct. There are alot of shutdown/reboot sequences without any
issues.

> And the bitmap is stored in a file? And the file is on a different disk, right?
No, the bitmap is stored internal.

An printout of the mdadm details:
> # mdadm --detail /dev/md0 
> /dev/md0:
>            Version : 1.2
>      Creation Time : Wed May 16 00:35:33 2018
>         Raid Level : raid1
>         Array Size : 1953382464 (1862.89 GiB 2000.26 GB)
>      Used Dev Size : 1953382464 (1862.89 GiB 2000.26 GB)
>       Raid Devices : 2
>      Total Devices : 2
>        Persistence : Superblock is persistent
> 
>      Intent Bitmap : Internal
> 
>        Update Time : Sat Jun 15 10:20:19 2019
>              State : clean, resyncing 
>     Active Devices : 2
>    Working Devices : 2
>     Failed Devices : 0
>      Spare Devices : 0
> 
> Consistency Policy : bitmap
> 
>      Resync Status : 32% complete
> 
>               Name : $hostname:0  (local to host $hostname)
>               UUID : 4635f0fe:f2676778:6e9451dc:92a18ede
>             Events : 233032
> 
>     Number   Major   Minor   RaidDevice State
>        0       8       17        0      active sync   /dev/sdb1
>        3       8       33        1      active sync   /dev/sdc1

Let me know if you need more details.
-- 
thanks alot!

regards,
 mathias
