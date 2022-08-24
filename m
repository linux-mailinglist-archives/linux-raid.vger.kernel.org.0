Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E259F4D9
	for <lists+linux-raid@lfdr.de>; Wed, 24 Aug 2022 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiHXIPh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Aug 2022 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiHXIPX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 Aug 2022 04:15:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B70753A6
        for <linux-raid@vger.kernel.org>; Wed, 24 Aug 2022 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661328921; x=1692864921;
  h=message-id:date:from:to:cc:subject:mime-version:
   content-transfer-encoding;
  bh=Rey2aSedne+RRQyGPpzlVBC3ATzNxIiU1C0/KcTnS2A=;
  b=G78vlzrBcjoh9VQc0SH3d8xHcgEkrRfRNOPqpNu8BNHI0uHxQy0l0dA3
   Fz9AH1kf1q4U/nCFUjlQYyzzuXZQJGqwb8up3jmyxnAjz16A26QiWpO4A
   E09OMSCAioz7+E1BPe+ZJziPvkZtH9qo329yKO5nRVuZqvhg11RklyZtR
   QvjRMkDd4osHQS3D5ptZyCKPVPgH+SDlS0Kmdsf/pA0KCcaPls59BDJd0
   7VDt1Uh8VmZVaghoTUFy+4Lj3wQD30Wm7ARYtb337zolN+ag7OGWV58F9
   mKoKzhx9t0Jp6bq0GnWYtTeK52OTdNQHf9YScMDFxydA3PQdnLfMfJvfi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="292645856"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="292645856"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 01:15:21 -0700
Message-Id: <11ab82$jvatnj@fmsmga008-auth.fm.intel.com>
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670398195"
Received: from lflorcza-mobl.ger.corp.intel.com (HELO intel.linux.com) ([10.252.52.14])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 01:15:20 -0700
Date:   Wed, 24 Aug 2022 10:15:15 +0200
From:   Lukasz Florczak <lukasz.florczak@linux.intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-raid@vger.kernel.org
Subject: Python tests
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Coly,
I want to write some mdadm tests for assemblation and incremental
regarding duplicated array names in config and I'd like to do it in
python. I've seen that some time ago[1] you said that you could try to
integrate the python tests framework into the mdadm ci. I was wondering
how is it going? Do you need any help with this subject?

Thanks,
Lukasz

[1] https://marc.info/?l=linux-raid&m=165277539509464&w=2
