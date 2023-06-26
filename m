Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB10B73E3EE
	for <lists+linux-raid@lfdr.de>; Mon, 26 Jun 2023 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjFZPvy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 26 Jun 2023 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFZPvv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 26 Jun 2023 11:51:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4611704
        for <linux-raid@vger.kernel.org>; Mon, 26 Jun 2023 08:51:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 465736732D; Mon, 26 Jun 2023 17:51:44 +0200 (CEST)
Date:   Mon, 26 Jun 2023 17:51:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <songliubraving@meta.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        Li Nan <linan122@huawei.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [GIT PULL] md-next 20230622
Message-ID: <20230626155143.GA4180@lst.de>
References: <BCD9738E-472D-4AA7-B4F9-CCF36B5DA0E1@fb.com> <83240030-681c-9ff5-6e2c-600e83b0cc71@kernel.dk> <392A5BF5-2961-4F2C-A1C6-D6532B5AAFC2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392A5BF5-2961-4F2C-A1C6-D6532B5AAFC2@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jun 23, 2023 at 03:08:52PM +0000, Song Liu wrote:
> Please let me know if you need set #1 (deprecate file bitmap) to 
> unblock other work. Otherwise, we will delay it until 6.6. 

It was intended so that we don't have to make all of md depend on
the new config option for buffers heads I plan to introduce.  So it's
a bit of a pity that we won't have it for 6.5, but not a deal breaker.
