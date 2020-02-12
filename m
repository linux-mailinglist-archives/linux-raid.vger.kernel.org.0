Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DEB15B269
	for <lists+linux-raid@lfdr.de>; Wed, 12 Feb 2020 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLVAM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Feb 2020 16:00:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:15887 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBLVAM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 12 Feb 2020 16:00:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 13:00:11 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="256948918"
Received: from unknown (HELO localhost.localdomain) ([10.232.115.133])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Feb 2020 13:00:10 -0800
Subject: Re: [PATCH v2 2/2] md: enable io polling
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
 <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
Date:   Wed, 12 Feb 2020 14:00:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/11/20 2:13 PM, Keith Busch wrote:
> I must be missing something: md's make_request_fn always returns
> BLK_QC_T_NONE for the cookie, and that couldn't get past blk_poll's
> blk_qc_t_valid(cookie) check. How does the initial blk_poll() caller get
> a valid cookie for an md backing device's request_queue? And how is the
> same cookie valid for more than one request_queue?

That's true md_make_request() always returns BLK_QC_T_NONE. md_make_request()
recursively calls generic_make_request() for the underlying device (e.g. nvme).
That block io request directed to member disk is added into bio_list and is 
processed later by top level generic_make_request(). generic_make_request() 
returns cookie that is returned by blk_mq_make_request().
That cookie is later used to poll for completion. 
