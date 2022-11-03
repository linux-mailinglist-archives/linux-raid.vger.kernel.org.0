Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31461787C
	for <lists+linux-raid@lfdr.de>; Thu,  3 Nov 2022 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKCIOe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Nov 2022 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCIOc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 3 Nov 2022 04:14:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B54220B
        for <linux-raid@vger.kernel.org>; Thu,  3 Nov 2022 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667463270; x=1698999270;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SeCttNpTstnKQvKtWtVmBOOp0ND4bULXc7u7/CLzMnU=;
  b=BuaCooTlDP8ub9egMLMM3Xur8USqTbd07GXV2sq/N0MRS80VqdVbnOjj
   TQ2D3CmlorR6kMPzQsJRIrRUtmV2cCq7PPDAQz4MuigkVztFl38TqtyEE
   XDixvqeneo+daHrNdXB2dkA7WwMcjHEhWUzJqT/I3StelKY/+0NgQKoih
   KJAkAfiGQuEdszrYXVehuod/pbmtSRNdGrPpGSffbyW0hPOhXJ2di3zbN
   FbCoA2eJyRTg5RKTyhIROetP67L4X3PL1aINcr61GvJtP4k9PpUY7IDIc
   NkjzyloOajk+fSE6prYIY4mQwlD8rlG2NwCyShPbgb8e2P/DzPqu65Jgj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289330172"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289330172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 01:14:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="667881689"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="667881689"
Received: from ktanska-mobl1.ger.corp.intel.com (HELO intel.linux.com) ([10.237.140.83])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 01:14:17 -0700
Date:   Thu, 3 Nov 2022 09:14:15 +0100
From:   Kinga Tanska <kinga.tanska@linux.intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-raid@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Coly Li <colyli@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jonmichael Hands <jm@chia.net>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH mdadm v4 0/7] Write Zeroes option for Creating Arrays
Message-ID: <20221103091415.00000b8c@intel.linux.com>
In-Reply-To: <20221007201037.20263-1-logang@deltatee.com>
References: <20221007201037.20263-1-logang@deltatee.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri,  7 Oct 2022 14:10:30 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Hi,
> 
> This is the next iteration of the patchset that added the discard
> option to mdadm. Per feedback from Martin, it's more desirable
> to use the write-zeroes functionality than rely on devices to zero
> the data on a discard request. This is because standards typically
> only require the device to do the best effort to discard data and
> may not actually discard (and thus zero) it all in some circumstances.
> 
> This version of the patch set adds the --write-zeroes option which
> will imply --assume-clean and write zeros to the data region in
> each disk before starting the array. This can take some time so
> each disk is done in parallel in its own fork. To make the forking
> code easier to understand this patch set also starts with some
> cleanup of the existing Create code.
> 
> We tested write-zeroes requests on a number of modern nvme drives of
> various manufacturers and found most are not as optimized as the
> discard path. A couple drives that were tested did not support
> write-zeroes at all but still performed similarly with the kernel
> falling back to writing zero pages. Typically we see it take on the
> order of one minute per 100GB of data zeroed.
> 
> One reason write-zeroes is slower than discard is that today's NVMe
> devices only allow about 2MB to be zeroed in one command where as
> the entire drive can typically be discarded in one command. Partly,
> this is a limitation of the spec as there are only 16 bits avalaible
> in the write-zeros command size but drives still don't max this out.
> Hopefully, in the future this will all be optimized a bit more
> and this work will be able to take advantage of that.
> 
> Logan
> 
> --
> 
> Changes since v3:
>    * Store the pid in a local variable instead of the mdinfo struct
>     (per Mariusz and Xiao)
> 
> Changes since v2:
> 
>    * Use write-zeroes instead of discard to zero the disks (per
>      Martin)
>    * Due to the time required to zero the disks, each disk is
>      now done in parallel with separate forks of the process.
>    * In order to add the forking some refactoring was done on the
>      Create() function to make it easier to understand
>    * Added a pr_info() call so that some prints can be done
>      to stdout instead of stdour (per Mariusz)
>    * Added KIB_TO_BYTES and SEC_TO_BYTES helpers (per Mariusz)
>    * Added a test to the mdadm test suite to test the option
>      works.
>    * Fixed up how the size and offset are calculated with some
>      great information from Xiao.
> 
> Changes since v1:
> 
>    * Discard the data in the devices later in the create process
>      while they are already open. This requires treating the
>      s.discard option the same as the s.assume_clean option.
>      Per Mariusz.
>    * A couple other minor cleanup changes from Mariusz.
> 
> 
> *** BLURB HERE ***
> 
> Logan Gunthorpe (7):
>   Create: goto abort_locked instead of return 1 in error path
>   Create: remove safe_mode_delay local variable
>   Create: Factor out add_disks() helpers
>   mdadm: Introduce pr_info()
>   mdadm: Add --write-zeros option for Create
>   tests/00raid5-zero: Introduce test to exercise --write-zeros.
>   manpage: Add --write-zeroes option to manpage
> 
>  Create.c           | 479
> ++++++++++++++++++++++++++++----------------- ReadMe.c           |
> 2 + mdadm.8.in         |  16 ++
>  mdadm.c            |   9 +
>  mdadm.h            |   7 +
>  tests/00raid5-zero |  12 ++
>  6 files changed, 350 insertions(+), 175 deletions(-)
>  create mode 100644 tests/00raid5-zero
> 
> 
> base-commit: 8b668d4aa3305af5963162b7499b128bd71f8f29
> --
> 2.30.2

Acked-by: Kinga Tanska <kinga.tanska@linux.intel.com>
