Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169693FE9BC
	for <lists+linux-raid@lfdr.de>; Thu,  2 Sep 2021 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhIBHJ0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Sep 2021 03:09:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:9486 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240424AbhIBHJ0 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Sep 2021 03:09:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215863138"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="215863138"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 00:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="532744376"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2021 00:08:28 -0700
Received: from [10.213.25.121] (mtkaczyk-MOBL1.ger.corp.intel.com [10.213.25.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 406085802B1;
        Thu,  2 Sep 2021 00:08:27 -0700 (PDT)
Subject: Re: [PATCH v2] Monitor: print message before quit for no array to
 monitor
To:     Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org
Cc:     George Gkioulis <ggkioulis@suse.com>,
        Jes Sorensen <jsorensen@fb.com>
References: <20210902023644.509-1-colyli@suse.de>
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
Message-ID: <59b40b04-399a-a0cd-f8be-ebdebe9a458c@linux.intel.com>
Date:   Thu, 2 Sep 2021 09:08:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902023644.509-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Coly,
On 02.09.2021 04:36, Coly Li wrote:
> @@ -258,6 +258,7 @@ int Monitor(struct mddev_dev *devlist,
>   			if (oneshot)
>   				break;
>   			else if (!anyredundant) {
> +				pr_err("Stop for no array to monitor\n");
>   				break;

IMO the message is not precise enough. See that if there is only raid0
then it also stops. Something like:
"No array with redundancy detected, stopping" is more detailed.

Thanks,
Mariusz

