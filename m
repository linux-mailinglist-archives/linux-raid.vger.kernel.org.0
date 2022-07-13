Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D045729D0
	for <lists+linux-raid@lfdr.de>; Wed, 13 Jul 2022 01:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiGLXVZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 Jul 2022 19:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiGLXVZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 Jul 2022 19:21:25 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD2CAF77E;
        Tue, 12 Jul 2022 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=GcSnsmTSArOCBkWqx5BnP3VtK1UGANiObmnZI2DrZCI=; b=quQkmn7Ru3FY1R4vebW5OaTrE6
        VK03ZuqBx4mcVXXvB60q861itmQX3w71PSXDCUAdGlD6Bt+RRyXCn7QthO4VyKrnkBrzpJKIgNTiP
        Nug3bOBneWoc7ypHfFvx8dKixR385/DLju6VAcFRtmJl13fpmy38+o9fXGlkydhxO+kg+nLtFIx8y
        4bwZ0co290AaGxkr+wFF67QVme0e8osYkIf6Eg/A5Fq/gL0GMB/IpvKSBUtPsmX9pmznTUIaosCi8
        OoSXah5k63KpMAnKN+9HFhYkgRHz2qLCvPZwPKDjXSSK1OcUyxUznWB5ki5pNZ1BUvUd0LQAUEEpy
        E13znKnQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oBPBv-00DQUR-Om; Tue, 12 Jul 2022 17:21:20 -0600
Message-ID: <a083fad9-c844-b4bd-b68d-0515803427c1@deltatee.com>
Date:   Tue, 12 Jul 2022 17:21:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org
References: <20220712070331.1390700-1-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220712070331.1390700-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, song@kernel.org, linux-raid@vger.kernel.org, linux-block@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: fix md disk_name lifetime problems
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2022-07-12 01:03, Christoph Hellwig wrote:
> Hi all,
> 
> this series tries to fix a problem repored by Logan where we see
> duplicate sysfs file name in md.  It is due to the fact that the
> md driver only checks for duplicates on currently live mddevs,
> while the sysfs name can live on longer.  It is an old problem,
> but the race window got longer due to waiting for the device freeze
> earlier in del_gendisk.
> 
> Note that I still can't reproduce this problem so this was based
> on code inspection.  Also note that I occasionally run into a hang
> in the 07layouts tests with or without this series.

Yes, there should be a fix for 07layouts in md-next already 
(92a2748dc3c5).

Your branch wasn't based off md-next and does have some conflicts. 

I've rebased your patches onto md-next, replaced patch 2 with 
my suggestion and ran my battery of tests on it and have found that 
it fixes the bug I identified and looks good to me.

https://github.com/sbates130272/linux-p2pmem   md-lifetime-fixes

This branch will still conflict (easily) with the patch
8b9ab62662 ("block: remove blk_cleanup_disk") in your branch.

How do you want to proceed with getting these merged?

Logan


