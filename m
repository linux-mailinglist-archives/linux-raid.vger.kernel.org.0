Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A814BF8B1
	for <lists+linux-raid@lfdr.de>; Tue, 22 Feb 2022 14:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiBVNCm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Feb 2022 08:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiBVNCl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 22 Feb 2022 08:02:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FF580F7
        for <linux-raid@vger.kernel.org>; Tue, 22 Feb 2022 05:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645534936; x=1677070936;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8TSdf0fvYUrOgpjMcsRhzyXKyGJnArri5oV7ZrqM1to=;
  b=NNgE04fZS/TTUZcdkdDyELFzGAuikgn8YNRkPyrJN1Jinfm28HjCOkG0
   S0fK/ZKZew6aMKXHQaWGP0YyPuH/YyImrMJIdtIwS8+rxz2aTpF53ukJd
   /NnGvWrKuphU61kPcAJyHh2XNET731XSIabpdsF3QJwjKSJSHB+Mc1Hl8
   XY6JXhEgHfR3LrMgn19Wku37qAT0GNa601sWjVhTTHKC54X+dFoKk8+rn
   uJthhxb0Ccum/ciHZpSWLhU6oontdH8g0uDvKeaNDb2Wqx37JlrUZc9Kp
   Y6x6yzHJimQpC7gryidhI6AgBZOGplTmVlF/ubf+ucR0rBSkHVAj54Msw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251883441"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251883441"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:02:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706603364"
Received: from mtkaczyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.20.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:02:14 -0800
Date:   Tue, 22 Feb 2022 14:02:09 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 1/3] raid0, linear, md: add error_handlers for raid0 and
 linear
Message-ID: <20220222140209.00003ba1@linux.intel.com>
In-Reply-To: <CAPhsuW6xdntvmHZ6=NDVi7mO1H3B_8XjDDt9wDHrw-QC2cYx0A@mail.gmail.com>
References: <20220127153912.26856-1-mariusz.tkaczyk@linux.intel.com>
        <20220127153912.26856-2-mariusz.tkaczyk@linux.intel.com>
        <de8e69dc-4e44-de6f-d3d2-9d52935c9b35@linux.dev>
        <20220214103738.000017f8@linux.intel.com>
        <67429e77-f669-87f7-c2db-aaa4f545590b@linux.dev>
        <20220215150637.0000584f@linux.intel.com>
        <CAPhsuW6xdntvmHZ6=NDVi7mO1H3B_8XjDDt9wDHrw-QC2cYx0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,
On Mon, 21 Feb 2022 22:34:02 -0800
Song Liu <song@kernel.org> wrote:

> Could you please resend the patchset with feedback addressed? I can
> apply the newer version and force push to md-next.

Yes, I'm working on it. I cannot estimate when it will be ready, there
is ongoing discussion. If you prefer, you can take it off now.

Thanks,
Mariusz
