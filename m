Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967D5A5EBA
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfICBDu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 21:03:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfICBDu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 21:03:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 116ED54D418B88D496B0;
        Tue,  3 Sep 2019 09:03:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 09:03:45 +0800
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
 <949eebea-e4b7-7f89-da16-d227fa8521f9@huawei.com>
 <03e58a31-8f47-22d2-51c5-91214f63c544@tuxedo.ath.cx>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <523fd84a-905b-95fb-6fb2-d9eee87e9e39@huawei.com>
Date:   Tue, 3 Sep 2019 09:03:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <03e58a31-8f47-22d2-51c5-91214f63c544@tuxedo.ath.cx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Mathias,

On 2019/9/1 20:49, Mathias G wrote:
> Hi Tao
> 
> On 23.08.19 14:15, Hou Tao wrote:
>> Could you please save the following script as /usr/lib/systemd/system-shutdown/md_debug.sh and make it executable:
>>
>> #!/bin/bash
>> mount -o remount,rw /
>> mdadm -D /dev/md* > /md_debug.txt
>> mdadm -S /dev/md* >> /md_debug.txt
>> mount -o remount,ro /
>>
>> The script will dump the details of md devices to the /md_debug.txt and stop the md devices forcibly before shutdown or reboot.
>> And we can check the content of md_debug.txt if the problem reoccurs.
> 
> Thanks for the code snipped. I tried to put the script to

As showed in the following lines, we should use "&>" and "&>>" to save the
output from both the standard output and standard error output:

mdadm -D /dev/md* &> /md_debug.txt
mdadm -S /dev/md* &>> /md_debug.txt

Could you please update the code snippet accordingly ?

Regards,
Tao

> /usr/lib/systemd/system-shutdown/
> 
> but it was not executed at all.
> 
> I remembered that I tried to create some debug info by myself and I had
> to put the script to:
> /lib/systemd/system-shutdown/
> instead to make it working. No idea why, the execute bit was set.
> 
> This is what I also did, I'll let you know about the debug output.
> 

