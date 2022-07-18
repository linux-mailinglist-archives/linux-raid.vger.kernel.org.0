Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13049578B76
	for <lists+linux-raid@lfdr.de>; Mon, 18 Jul 2022 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiGRUD1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 Jul 2022 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiGRUD1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 Jul 2022 16:03:27 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792AF1E3C0;
        Mon, 18 Jul 2022 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=uQvwC6sct1gvcQ+DITKFAZNqGFMlfd2+acinwvkcZio=; b=UUVp6yc8lAZRc0AA+bDpKNenh4
        2T0A2K0558UpiFRAsMJ1iMVcZgpfiFzDNxzNlMcIocBisDBokMbkLDFjH5f3N9ctHBeElwrr50LWw
        nuLpNU5TvzWtLWYKyX4oqOCs9ifF3NLMlmCA9N6QAe7oqi9f+wLB8L5Wi7rDVJNcNNZSBLn7Kb0R0
        U2T1xl/kf4iLXwlozkBVvPsBs+nPTcnlqxrwc3VNJ5XsGLmN0dnX4SlomaJPnc8Jb1PWvtzGsbYc5
        W75nT6EUKqLgvJjvFOBViYTve6kWcfemSPyRx45MIxmZsLe3OHZlVdD/0Owckgf6gKpAaPiC3PYYj
        dfFMuy1g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oDWxf-000iZd-4t; Mon, 18 Jul 2022 14:03:23 -0600
Message-ID: <7eb0436a-2f07-5777-7884-b5f606b2a6ff@deltatee.com>
Date:   Mon, 18 Jul 2022 14:03:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org
References: <20220718063410.338626-1-hch@lst.de>
 <20220718063410.338626-9-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220718063410.338626-9-hch@lst.de>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 08/10] md: stop using for_each_mddev in md_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2022-07-18 00:34, Christoph Hellwig wrote:
> Just do a simple list_for_each_entry_safe on all_mddevs, and only grab a
> reference when we drop the lock and delete the now unused for_each_mddev
> macro.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

