Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FC2125F2
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGBOR2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 10:17:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:8863 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgGBOR1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 10:17:27 -0400
IronPort-SDR: BrNAg4XKl6FkRUmGRj/PoWGVooHDModr1Gw1MGeHcwW6IS1igtnc0wqDmsUqAdi2gW5uhxhFa2
 i38ai5COUxQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="211953429"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="211953429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 07:17:27 -0700
IronPort-SDR: KZqbp1MKMuiJ9ZrfYeNfPaTq+SllS8bDfX26AuNIM9zMcl/rFRDH5eOnAT42RsZpReA3WCC3q8
 HJFUZ6qkSgtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="425962045"
Received: from apaszkie-desk.igk.intel.com ([10.102.102.225])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2020 07:17:26 -0700
Subject: Re: [PATCH v2] md: improve io stats accounting
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20200702105440.17097-1-artur.paszkiewicz@intel.com>
 <c2579e84-dc89-68fe-f6fc-81ad80d3f3ee@cloud.ionos.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <63851623-9546-637f-446b-b84cdec61a38@intel.com>
Date:   Thu, 2 Jul 2020 16:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c2579e84-dc89-68fe-f6fc-81ad80d3f3ee@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/2/20 3:55 PM, Guoqing Jiang wrote:
> It can just be "md_io->start_time = bio_start_io_acct(bio)", with that

Oh, nice. I haven't noticed that. I'll resend.

Thanks,
Artur
