Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A673EB1DB
	for <lists+linux-raid@lfdr.de>; Fri, 13 Aug 2021 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhHMHp5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Aug 2021 03:45:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:15267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239456AbhHMHp4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 13 Aug 2021 03:45:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="276551679"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="276551679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 00:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="528271004"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2021 00:45:29 -0700
Received: from [10.213.30.238] (mtkaczyk-MOBL1.ger.corp.intel.com [10.213.30.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0003D5806C8;
        Fri, 13 Aug 2021 00:45:27 -0700 (PDT)
Subject: Re: [PATCH V2] Fix return value from fstat calls
To:     NeilBrown <neilb@suse.de>
Cc:     Nigel Croxon <ncroxon@redhat.com>, jes@trained-monkey.org,
        xni@redhat.com, linux-raid@vger.kernel.org
References: <20210810151507.1667518-1-ncroxon@redhat.com>
 <20210811190930.1822317-1-ncroxon@redhat.com>
 <162872237888.31578.18083659195262526588@noble.neil.brown.name>
 <346e8651-d861-45c7-9058-68008e691b93@Canary>
 <162881060124.15074.6150940509008984778@noble.neil.brown.name>
 <5b71689a-6d07-0dfd-a4b6-26322ee3136e@linux.intel.com>
 <162883915010.1695.14187049458830945568@noble.neil.brown.name>
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
Message-ID: <fe98561f-7f8f-45fa-bafa-e7f553a0f162@linux.intel.com>
Date:   Fri, 13 Aug 2021 09:45:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162883915010.1695.14187049458830945568@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13.08.2021 09:19, NeilBrown wrote:
> On Fri, 13 Aug 2021, Tkaczyk, Mariusz wrote:
>>

> Error handling that is buggy, or that is hard to maintain is not better
> than nothing.  If I can't guarantee that we never pass a bad file
> descriptor, then you cannot guarantee that the error handling has no
> bugs.   Less code generally means less bugs.
> 
> Any attempt to try to handle an error that should not be able to happen
> other than crashing is fairly pointless - you cannot guess the real
> cause, so you cannot know how to repair.  Just printing a message and
> continuing could be as bad as not checking the error.
> As error handling, I meant any error verification. It doesn't indicate
that we should return status and end gracefully. exit() is elegant
solution in this case, totally agree.

Thanks,
Mariusz

