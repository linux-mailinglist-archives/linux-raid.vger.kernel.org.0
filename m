Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE97D1F1357
	for <lists+linux-raid@lfdr.de>; Mon,  8 Jun 2020 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgFHHNF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 8 Jun 2020 03:13:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:64441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgFHHNF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 8 Jun 2020 03:13:05 -0400
IronPort-SDR: V/84/H52MF124TaFB3Hx7CLY79STuxCKwsPubpC9LVLZbBkLSh0ryVtMAC6JR5q5TvW1SD/TeW
 igPYhpNa96UQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 00:13:05 -0700
IronPort-SDR: jBS8TMy4xANJqfTd3IVeWYSzhvAC2u/3AkhdR7aPUrxo6HqC7xk6CjpH639A03koatC8L7BX6g
 8L1SWb8T2Ehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="288379804"
Received: from dprugar-mobl1.ger.corp.intel.com (HELO apaszkie-desk.igk.intel.com) ([10.213.0.238])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2020 00:13:03 -0700
Subject: Re: [PATCH] mdraid: fix read/write bytes accounting
To:     jeffm@suse.com, linux-raid@vger.kernel.org, song@kernel.org
Cc:     nfbrown@suse.com, colyli@suse.com
References: <20200605201953.11098-1-jeffm@suse.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <ed552b4b-b19a-cc85-05f4-0a0dc0d6fac2@intel.com>
Date:   Mon, 8 Jun 2020 09:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605201953.11098-1-jeffm@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/5/20 10:19 PM, jeffm@suse.com wrote:
> The i/o accounting published in /proc/diskstats for mdraid is currently
> broken.  md_make_request does the accounting for every bio passed but
> when a bio needs to be split, all the split bios are also submitted
> through md_make_request, resulting in multiple accounting.

Hi Jeff,

I sent a patch a few days ago which should fix this issue. Can you check
it out?

https://marc.info/?l=linux-raid&m=159102814820539

Thanks,
Artur
