Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84CCE9AEE9
	for <lists+linux-raid@lfdr.de>; Fri, 23 Aug 2019 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbfHWMQA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 23 Aug 2019 08:16:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389773AbfHWMQA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 23 Aug 2019 08:16:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43EC396A55D25CD0E97A;
        Fri, 23 Aug 2019 20:15:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 20:15:55 +0800
Subject: Re: md0: bitmap file is out of date, resync
To:     Mathias G <newsnet-mg-2016@tuxedo.ath.cx>,
        Song Liu <liu.song.a23@gmail.com>
CC:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
 <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
 <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
 <4e2077ec-454b-2adc-69bc-4e04cf7f24ea@tuxedo.ath.cx>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <949eebea-e4b7-7f89-da16-d227fa8521f9@huawei.com>
Date:   Fri, 23 Aug 2019 20:15:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4e2077ec-454b-2adc-69bc-4e04cf7f24ea@tuxedo.ath.cx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 2019/8/23 15:16, Mathias G wrote:
> Hi Song, Hi Tao
> I kept an eye on the RAID status after the last update I did on the system.
> The first boot after the update was ok, the RAID was clean. I did a
> clean shutdown and the next as I switched on the computer the RAID was
> rebuilding again (this was yesterday)
> 
> I have no more ideas what to do - maybe reinstall the whole system and
> start from scratch?
> 

Could you please save the following script as /usr/lib/systemd/system-shutdown/md_debug.sh and make it executable:

#!/bin/bash
mount -o remount,rw /
mdadm -D /dev/md* > /md_debug.txt
mdadm -S /dev/md* >> /md_debug.txt
mount -o remount,ro /

The script will dump the details of md devices to the /md_debug.txt and stop the md devices forcibly before shutdown or reboot.
And we can check the content of md_debug.txt if the problem reoccurs.

Regards,
Tao

