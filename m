Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C871321E3
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jan 2020 10:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAGJFn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Jan 2020 04:05:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJFn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Jan 2020 04:05:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so18441945wmi.5
        for <linux-raid@vger.kernel.org>; Tue, 07 Jan 2020 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4p4XHjIok74zQLNweYWbPwtj0wrNpVQiaSJeiLOIYvU=;
        b=Z47IJrpMX4PzCpX+nuzcvOynT6blhWVIWPtJ8cbs7REE6ZhV34aimrt8KbJbxBEoUm
         F9U8dt94TNKYUA27cuYQ9TTxGA9queHsIiLhiqujU6zuh1n8OO+nB5AgBPs2APFE5r74
         +edaLS5WXnig33Py2Z3kMdNoPtbRxL0kI9MJJpxPBbbtakvb44bMLFKl3ZFhfd/EOsHP
         UW2+IZSRtm1/O3Ws3Ee/J4rWxrvJbBYO9whS/p85TapnBk91wqxmFI2iOmpMVyqxvcLo
         V3xeyedFq6XSg+fUA58l0UZdRFpqX3vnYRCJb9ZGiv0ZXSgAyd5ZgGNsAk5dzjoBiXeY
         SMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4p4XHjIok74zQLNweYWbPwtj0wrNpVQiaSJeiLOIYvU=;
        b=MrrxoB0IxyJb4VPLGA5xebaNSpmCTgwzIRoWSarJ2LEnCbtI/4KqGjitCdPqftzwhi
         XYYRjU7Q5uUqubylAVWmyPfTLwCG+FRhlwqys6bIHNLznRuer7nsB4CiJW8nLIfWvRM2
         l02RJAh+2PPa39mFeGpZDkTvluk0YDRLDX+l+N03U1RnYpYbrwo47CwgExplR4GVgy3A
         i1MP7HBvOVXZvob1iqhUeJRTjP+vlociqP7AvXZ3/zZIDzf/GTiDGC4GsFqjJ08w8BPi
         A6N/Q7rPljDPLfobyk4uvgOh0iwlkJCrKVk6Qx4TtnojuV1IGVcAggYht6SvP0hyZZ7C
         fyLw==
X-Gm-Message-State: APjAAAXwqOKMCuEjag/4PCaljLev9l/NWRjkbkqaSi9cGcONkA/582AJ
        rezupSTZJZtCjnFlAiI0z5HQca1ScL0=
X-Google-Smtp-Source: APXvYqxMdhYO2+XNlUzvd9TS+/d/cYTdPJUN8uWzzA8FvqhBJF53KmoJCGY4Z+4hP7AkfU1BCySfIA==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr39493664wmh.164.1578387939962;
        Tue, 07 Jan 2020 01:05:39 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:e4f3:29f0:7223:b595? ([2001:1438:4010:2540:e4f3:29f0:7223:b595])
        by smtp.gmail.com with ESMTPSA id z4sm26003570wma.2.2020.01.07.01.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 01:05:39 -0800 (PST)
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Nick Desaulniers <ndesaulniers@google.com>, jgq516@gmail.com
Cc:     kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kbuild test robot <lkp@intel.com>,
        liu.song.a23@gmail.com, linux-raid@vger.kernel.org
References: <202001050333.SnzanhNo%lkp@intel.com>
 <CAKwvOdmkhS+jmu9erpnqr6+bvxjQD7yxQSvs3scokJ42tkF4mg@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <8cbfa385-d3c3-b1b9-9bce-1ae109072904@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 10:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmkhS+jmu9erpnqr6+bvxjQD7yxQSvs3scokJ42tkF4mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/6/20 11:29 PM, Nick Desaulniers wrote:
> Apologies if it was already reported (working backwards through emails
> missed during the holidays), but this warning looks legit. Can you
> please take a look?

Thanks for the report and will fix it, not sure why I didn't receive
the mail from lkp.

BR,
Guoqing

>
> On Sat, Jan 4, 2020 at 11:48 AM kbuild test robot <lkp@intel.com> wrote:
>> CC: kbuild-all@lists.01.org
>> In-Reply-To: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
>> References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
>> TO: jgq516@gmail.com
>> CC: liu.song.a23@gmail.com, linux-raid@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, linux-raid@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> CC: linux-raid@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Hi,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v5.5-rc4 next-20191220]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/jgq516-gmail-com/raid5-add-more-checks-before-add-sh-lru-to-plug-cb-list/20200104-172752
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3a562aee727a7bfbb3a37b1aa934118397dad701
>> config: x86_64-allyesconfig (attached as .config)
>> compiler: clang version 10.0.0 (git://gitmirror/llvm_project 320b43c39f0eb636c84815ce463893b21befdc8f)
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers//md/raid5.c:5484:6: warning: logical not is only applied to the left hand side of this comparison [-Wlogical-not-parentheses]
>>             if (!atomic_read(&sh->count) == 0 &&
>>                 ^                        ~~
>>     drivers//md/raid5.c:5484:6: note: add parentheses after the '!' to evaluate the comparison first
>>             if (!atomic_read(&sh->count) == 0 &&
>>                 ^
>>                  (                           )
>>     drivers//md/raid5.c:5484:6: note: add parentheses around left hand side expression to silence this warning
>>             if (!atomic_read(&sh->count) == 0 &&
>>                 ^
>>                 (                       )
>>     1 warning generated.
>>
>> vim +5484 drivers//md/raid5.c
>>
>>    5461
>>    5462  static void release_stripe_plug(struct mddev *mddev,
>>    5463                                  struct stripe_head *sh)
>>    5464  {
>>    5465          struct blk_plug_cb *blk_cb = blk_check_plugged(
>>    5466                  raid5_unplug, mddev,
>>    5467                  sizeof(struct raid5_plug_cb));
>>    5468          struct raid5_plug_cb *cb;
>>    5469
>>    5470          if (!blk_cb) {
>>    5471                  raid5_release_stripe(sh);
>>    5472                  return;
>>    5473          }
>>    5474
>>    5475          cb = container_of(blk_cb, struct raid5_plug_cb, cb);
>>    5476
>>    5477          if (cb->list.next == NULL) {
>>    5478                  int i;
>>    5479                  INIT_LIST_HEAD(&cb->list);
>>    5480                  for (i = 0; i < NR_STRIPE_HASH_LOCKS; i++)
>>    5481                          INIT_LIST_HEAD(cb->temp_inactive_list + i);
>>    5482          }
>>    5483
>>> 5484          if (!atomic_read(&sh->count) == 0 &&
>>    5485              !test_bit(STRIPE_ON_RELEASE_LIST, &sh->state) &&
>>    5486              !test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
>>    5487                  list_add_tail(&sh->lru, &cb->list);
>>    5488          else
>>    5489                  raid5_release_stripe(sh);
>>    5490  }
>>    5491
>>
>> ---
>> 0-DAY kernel test infrastructure                 Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
>>
>> --
>> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202001050333.SnzanhNo%25lkp%40intel.com.
>
>

