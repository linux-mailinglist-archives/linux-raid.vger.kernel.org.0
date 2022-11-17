Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F26A62CF08
	for <lists+linux-raid@lfdr.de>; Thu, 17 Nov 2022 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiKPXqq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Nov 2022 18:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiKPXqj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Nov 2022 18:46:39 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB3C2F
        for <linux-raid@vger.kernel.org>; Wed, 16 Nov 2022 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=7VCp6WZMKDx2mnsoFVTvnsBz8uWUjVEx+lc63mF9pcA=; b=WNcNt/N/zSs1RKir5rBEIHtZYq
        4Jicf7A1p/4DG3mBj36Ou6gPWyTdExugd3LcIbNIue6MpYypt18j6MiQovUPuysVhXrokhO/8XV3u
        8KjVv/f5y0N08y5zUEQHiuO/xuWiCCO8BVoFGIBey0ueeAohMIRBinFQmoUnDQaSHRixeP1O1EYcO
        ok72TVUyqc6wlncPRDh9JQ+0J7V9/jQQXTXG4aCf5yBor0Fc2i08EEtTsal4hNrUQy+47TIL53ocp
        77E2556vSByitwlrWRhXcoSvu3JE+PJGJqlxWKMY6sE6hybKuSdxoQvhMKGaswAh/Io5ICiutR7Hx
        PLWQC/TA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ovS6y-0043vS-9m; Wed, 16 Nov 2022 16:46:34 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ovS6w-000KgH-GO; Wed, 16 Nov 2022 16:46:30 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-raid@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, Xiao Ni <xni@redhat.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Coly Li <colyli@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jonmichael Hands <jm@chia.net>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 16 Nov 2022 16:46:12 -0700
Message-Id: <20221116234617.79441-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116234617.79441-1-logang@deltatee.com>
References: <20221116234617.79441-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-raid@vger.kernel.org, jes@trained-monkey.org, guoqing.jiang@linux.dev, xni@redhat.com, mariusz.tkaczyk@linux.intel.com, colyli@suse.de, chaitanyak@nvidia.com, jm@chia.net, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH mdadm v5 0/7] Write Zeroes option for Creating Arrays
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

This is the next iteration of the patchset to add a zeroing option
which bypasses the inital sync for arrays. This version of the patch
set handles interrupts better by submitting smaller zero commands
to the kernel in the zeroing threads so they can be interrupted
and ensuring the main thread waits for the zeroing threads to
finish (with an appropriate message printed to inform the user).

This patch set adds the --write-zeroes option which will imply
--assume-clean and write zeros to the data region in each disk before
starting the array. This can take some time so each disk is done in
parallel in its own fork. To make the forking code easier to
understand this patch set also starts with some cleanup of the
existing Create code.

We tested write-zeroes requests on a number of modern nvme drives of
various manufacturers and found most are not as optimized as the
discard path. A couple drives that were tested did not support
write-zeroes at all but still performed similarly with the kernel
falling back to writing zero pages. Typically we see it take on the
order of one minute per 100GB of data zeroed.

One reason write-zeroes is slower than discard is that today's NVMe
devices only allow about 2MB to be zeroed in one command where as
the entire drive can typically be discarded in one command. Partly,
this is a limitation of the spec as there are only 16 bits avalaible
in the write-zeros command size but drives still don't max this out.
Hopefully, in the future this will all be optimized a bit more
and this work will be able to take advantage of that.

Logan

--

Changes since v4:
   * Handle SIGINT better. Previous versions would leave the zeroing
     processes behind after the main thread exitted which would
     continue zeroing in the background (possibly for some time).
     This version splits the zero fallocate commands up so they can be
     interrupted quicker, and intercepts SIGINT in the main thread
     to print an appropriate message and wait for the threads
     to finish up. (as noticed by Xiao)

Changes since v3:
   * Store the pid in a local variable instead of the mdinfo struct
    (per Mariusz and Xiao)

Changes since v2:

   * Use write-zeroes instead of discard to zero the disks (per
     Martin)
   * Due to the time required to zero the disks, each disk is
     now done in parallel with separate forks of the process.
   * In order to add the forking some refactoring was done on the
     Create() function to make it easier to understand
   * Added a pr_info() call so that some prints can be done
     to stdout instead of stdour (per Mariusz)
   * Added KIB_TO_BYTES and SEC_TO_BYTES helpers (per Mariusz)
   * Added a test to the mdadm test suite to test the option
     works.
   * Fixed up how the size and offset are calculated with some
     great information from Xiao.

Changes since v1:

   * Discard the data in the devices later in the create process
     while they are already open. This requires treating the
     s.discard option the same as the s.assume_clean option.
     Per Mariusz.
   * A couple other minor cleanup changes from Mariusz.

--

Logan Gunthorpe (7):
  Create: goto abort_locked instead of return 1 in error path
  Create: remove safe_mode_delay local variable
  Create: Factor out add_disks() helpers
  mdadm: Introduce pr_info()
  mdadm: Add --write-zeros option for Create
  tests/00raid5-zero: Introduce test to exercise --write-zeros.
  manpage: Add --write-zeroes option to manpage

 Create.c           | 562 +++++++++++++++++++++++++++++++--------------
 ReadMe.c           |   2 +
 mdadm.8.in         |  16 ++
 mdadm.c            |   9 +
 mdadm.h            |   7 +
 tests/00raid5-zero |  12 +
 6 files changed, 433 insertions(+), 175 deletions(-)
 create mode 100644 tests/00raid5-zero


base-commit: 8b668d4aa3305af5963162b7499b128bd71f8f29
--
2.30.2
