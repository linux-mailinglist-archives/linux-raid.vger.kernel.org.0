Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66D61E5E
	for <lists+linux-raid@lfdr.de>; Mon,  8 Jul 2019 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfGHM0n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 8 Jul 2019 08:26:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:53824 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfGHM0n (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 8 Jul 2019 08:26:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 05:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="248802275"
Received: from unknown (HELO linux-spw6.localnet) ([10.102.102.170])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2019 05:26:41 -0700
From:   Mariusz Dabrowski <mariusz.dabrowski@intel.com>
To:     Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc:     linux-raid@vger.kernel.org, jsorensen@fb.com
Subject: Re: Regression in mdadm breaks assembling of array
Date:   Mon, 08 Jul 2019 14:24:52 +0200
Message-ID: <55824370.7nbRXrPP5B@linux-spw6>
In-Reply-To: <2504385.aUmv4P13uU@d-allen>
References: <2504385.aUmv4P13uU@d-allen>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Saturday, July 6, 2019 5:13:14 PM CEST Stephan Diestelhorst wrote:
> (Off list, please keep me in CC, thx!)
> Hi there,
> 
> TL;DR:
> https://github.com/neilbrown/mdadm/commit611d95290dd41d73bd8f9cc06f7ec293a40
> b819e regresses mdadm and does not let me assemble my main drive due to
> kernel error
> 
> md: invalid array_size 125035870 > default size 125035776
> 
> caused by changed reservation size in mdadm, and thus reduced "Usable
> Size" being reduced too much (smaller than 0.5 * Array Size).
> 
> Full write-up with logs etc here:
> https://forum.manjaro.org/t/mdadm-issues-live-cd-works-existing-install-bre
> aks-fakeraid-imsm/93613
> 
> I chased through both 4.0 mdadm (which works, e.g., from a Live image),
> and the new 4.1 version (from Manjaro update), and the same disk in the
> same machine works with the older, and refuses to work with the newer
> mdadm.
> 
> The kernel message suggests that the kernel refuses to assemble the
> array, and tracing the computation back through both versions (4.0 and
> GIT head 3c9b46cf9ae15a9be98fc47e2080bd9494496246 ) reveals that both
> versions end up using the default for reserved space, which is
> MPB_SECTOR_CNT + IMSM_RESERVED_SECTORS (the other difference between the
> versions is the size computed, but that is hopefully intentional due to
> 444909385fdaccf961308c4319d7029b82bf8bb1 ).
> 
> I understand too little to propose a fix or know why the defaults were
> changed, but this is clearly a regression, and the disk works in the
> same machine in Windows, and with older Live images.
> 
> More log output in the Manjaro forum thread, and I have some more log
> output with printf's sprinkled around if necessary.
> 
> Happy to help fix this, please have a look :)
> 
> Thanks,
>   Stephan

Hello Stephan,
I have failed to reproduce your issue. I would like to know how your array was 
created: in OS using mdadm or with RST PreOS? Which version of mdadm/RST have 
you used? Your notebook is booting in legacy or UEFI mode?

Regards,
Mariusz



