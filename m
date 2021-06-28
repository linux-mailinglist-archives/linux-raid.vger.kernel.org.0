Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D673B5F59
	for <lists+linux-raid@lfdr.de>; Mon, 28 Jun 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhF1NvT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Jun 2021 09:51:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:29944 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231944AbhF1NvS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 28 Jun 2021 09:51:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="271812479"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="271812479"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 06:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="425131550"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2021 06:48:52 -0700
Received: from [10.213.21.163] (mtkaczyk-MOBL1.ger.corp.intel.com [10.213.21.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0BA595808A1;
        Mon, 28 Jun 2021 06:48:50 -0700 (PDT)
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     Xiao Ni <xni@redhat.com>,
        Oleksandr Shchirskyi <oleksandr.shchirskyi@linux.intel.com>,
        blazej.kucman@intel.com, linux-raid <linux-raid@vger.kernel.org>
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
Subject: mdadm 4.2-rc2
Message-ID: <614b0f39-0a1d-5c86-be88-42f65a72911b@linux.intel.com>
Date:   Mon, 28 Jun 2021 15:48:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Jes,
A lot of mdadm patches are waiting, could you look into them?

IMO it is good time to mark rc2. Do you agree?

Thanks,
Mariusz
