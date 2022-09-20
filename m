Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8625BDE03
	for <lists+linux-raid@lfdr.de>; Tue, 20 Sep 2022 09:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiITHT3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Sep 2022 03:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiITHTX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 20 Sep 2022 03:19:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3351CFC5
        for <linux-raid@vger.kernel.org>; Tue, 20 Sep 2022 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vd7RjFqQvQLKthaXWqLjMJ0u1nyKM68PHv4UnvuI/sg=; b=3X3MmA7BBNo/VqEDMCOScCJ5Ns
        7kUhyodnFv6dvFQ3VLjxViX7384XENtN7jUtCa3UD/cgBrgagdj8hZrgi0y8gLRimNqsICDL1WhI0
        no9+FCGEWD9kOQw3GZg+DLNmYElwWv/D7sjh8pyjVREbKFBGhzB2t9BAlbi597R9HTlTBvLG0IlSY
        rbKZK0K/c6AQ+FKgNqVSc+hlt+Q9vtVq80hfTPMrHoHbpktP3o1pvtgZOlaIwZmnHvLNCLgmPgegn
        FJya9+izlsVeby5vpFanYPcNlmFl3K5nnEL2aiUXuPmhswfCI3OacK+44apN/5TwEm5GwHj7KiUSI
        3ruI0S7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXXH-001JYL-Kg; Tue, 20 Sep 2022 07:19:15 +0000
Date:   Tue, 20 Sep 2022 00:19:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH -next 1/3] md: refactor md ioctl cmd check
Message-ID: <Yylpc/GVYLA0mC0k@infradead.org>
References: <20220920023938.3273598-1-yebin10@huawei.com>
 <20220920023938.3273598-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920023938.3273598-2-yebin10@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Sep 20, 2022 at 10:39:36AM +0800, Ye Bin wrote:
> Rename md_ioctl_valid to  md_ioctl_check, check whether the command is valid
> and whether the permission passes.

I think this going into entirely the wrong direction.  The right way
to go is to split each handler into a separate function, and move
those checks there.  I have a WIP series for that which I just need to
dust off.

