Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A880DA497E
	for <lists+linux-raid@lfdr.de>; Sun,  1 Sep 2019 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfIAMuC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Sep 2019 08:50:02 -0400
Received: from smtp05.mail.qldc.ch ([212.60.46.174]:35824 "EHLO
        smtp05.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIAMuB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 1 Sep 2019 08:50:01 -0400
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp05.mail.qldc.ch (Postfix) with ESMTPS id 1850923AAC;
        Sun,  1 Sep 2019 14:49:58 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id 05C55344B49;
        Sun,  1 Sep 2019 14:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1567342197;
        bh=2acswb5HtsbfPv0u/VxRauZ2FetIbhVhieFcdd5heG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N7nkTjEeEPE2cM4e5qYOqX0Nyjm4sqm1DvjBZZNtWAzRfFqn4sn4lTKZ5sqHMDBWt
         FJaqcKLo4PJmB5aYcX9NYCg1NdagYp5i682QU01alUhmaSLjx4zJ8EB/vbGOmPBNfK
         /ZXQR/N89FgyVcugZCuktdFdKdR1Adwe1tagZ8H4=
Subject: Re: md0: bitmap file is out of date, resync
To:     Hou Tao <houtao1@huawei.com>, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
 <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
 <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
 <4e2077ec-454b-2adc-69bc-4e04cf7f24ea@tuxedo.ath.cx>
 <949eebea-e4b7-7f89-da16-d227fa8521f9@huawei.com>
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Message-ID: <03e58a31-8f47-22d2-51c5-91214f63c544@tuxedo.ath.cx>
Date:   Sun, 1 Sep 2019 14:49:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <949eebea-e4b7-7f89-da16-d227fa8521f9@huawei.com>
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

On 23.08.19 14:15, Hou Tao wrote:
> Could you please save the following script as /usr/lib/systemd/system-shutdown/md_debug.sh and make it executable:
> 
> #!/bin/bash
> mount -o remount,rw /
> mdadm -D /dev/md* > /md_debug.txt
> mdadm -S /dev/md* >> /md_debug.txt
> mount -o remount,ro /
> 
> The script will dump the details of md devices to the /md_debug.txt and stop the md devices forcibly before shutdown or reboot.
> And we can check the content of md_debug.txt if the problem reoccurs.

Thanks for the code snipped. I tried to put the script to
/usr/lib/systemd/system-shutdown/

but it was not executed at all.

I remembered that I tried to create some debug info by myself and I had
to put the script to:
/lib/systemd/system-shutdown/
instead to make it working. No idea why, the execute bit was set.

This is what I also did, I'll let you know about the debug output.
-- 
kind regards
 mathias
