Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300DC1EB5D4
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jun 2020 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFBGb4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jun 2020 02:31:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:31910 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBGbz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jun 2020 02:31:55 -0400
IronPort-SDR: etxslvlcm3J6/0wpzCPpy9yog38U2vT80CQYBMXyzMHme/RWOeMIHToTC+SYiFIwdGcTo0yanY
 DsHVPbMzUPBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 23:31:55 -0700
IronPort-SDR: hqaMttDdVTApFEe39Jmzv+kXUFh8IiRKH88KA9krA6+0CnUC/vmuEHVPqE9AM0HzZiFWrphDlD
 0czauzZqDA+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="470558952"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2020 23:31:53 -0700
Subject: Re: [kbuild-all] Re: [PATCH] md: improve io stats accounting
To:     Song Liu <song@kernel.org>, kbuild test robot <lkp@intel.com>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        kbuild-all@lists.01.org, linux-raid <linux-raid@vger.kernel.org>
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
 <202006020549.F4anhkPI%lkp@intel.com>
 <CAPhsuW5AKgHQaAOhqxd+4BEXL+Dc8SDiR+N27Y9AHnLXnjSQgw@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <46c406a2-0586-1291-a9c2-5a2e6bf328f6@intel.com>
Date:   Tue, 2 Jun 2020 14:31:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5AKgHQaAOhqxd+4BEXL+Dc8SDiR+N27Y9AHnLXnjSQgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/2/20 2:22 PM, Song Liu wrote:
> Hi kbuild test robot,
>
> On Mon, Jun 1, 2020 at 3:03 PM kbuild test robot <lkp@intel.com> wrote:
>> Hi Artur,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on next-20200529]
>> [cannot apply to linus/master md/for-next v5.7 v5.7-rc7 v5.7-rc6 v5.7]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
> I am able to apply this to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
>
> Please use that branch for testing.
>
> Thanks,
> Song

Hi Song,

Thanks for your advice, we'll try.

Best Regards,
Rong Chen
