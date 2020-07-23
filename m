Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724722A60E
	for <lists+linux-raid@lfdr.de>; Thu, 23 Jul 2020 05:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgGWDdi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 23:33:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730837AbgGWDdi (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 23:33:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 72675D774F8D1E7436A4;
        Thu, 23 Jul 2020 11:33:36 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Jul 2020 11:33:31 +0800
Subject: Re: [song-md:md-next 9/14] ERROR: modpost: "__udivdi3" undefined!
To:     Song Liu <song@kernel.org>, kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, linux-raid <linux-raid@vger.kernel.org>,
        "Song Liu" <songliubraving@fb.com>
References: <202007230512.Ql0lYtJc%lkp@intel.com>
 <CAPhsuW66LPe0feQtgns=Tp2JYvUNT6vDnqg6j1inq+WT8uQrsQ@mail.gmail.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <056d7a5f-bc67-194e-4908-8677d82a4ac0@huawei.com>
Date:   Thu, 23 Jul 2020 11:33:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW66LPe0feQtgns=Tp2JYvUNT6vDnqg6j1inq+WT8uQrsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2020/7/23 5:31, Song Liu wrote:
> On Wed, Jul 22, 2020 at 2:21 PM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
>> head:   fe630de009d0729584d79c78f43121e07c745fdc
>> commit: e236858243d7a8e0ac60972d2f9522146088a736 [9/14] md/raid5: set default stripe_size as 4096
>> config: m68k-sun3_defconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout e236858243d7a8e0ac60972d2f9522146088a736
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "__udivdi3" [drivers/md/raid456.ko] undefined!
> 
> Yufen, could you please look into this one? I guess it is caused by ilog2().
> 

This compiler error is caused by 64bit division on on 32-bit architectures.
I have send the fix patch.

Thanks,
Yufen
