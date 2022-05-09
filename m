Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09EE51F891
	for <lists+linux-raid@lfdr.de>; Mon,  9 May 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiEIJxG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 May 2022 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiEIJgv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 May 2022 05:36:51 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A81E029A
        for <linux-raid@vger.kernel.org>; Mon,  9 May 2022 02:32:49 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nnzkt-0007Am-9w;
        Mon, 09 May 2022 10:32:39 +0100
Message-ID: <c2917c23-c218-e600-7e10-31a504c844e2@youngman.org.uk>
Date:   Mon, 9 May 2022 10:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Update PATCH V3] md: don't unregister sync_thread with
 reconfig_mutex held
Content-Language: en-GB
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, Song Liu <song@kernel.org>
Cc:     Donald Buczek <buczek@molgen.mpg.de>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20220505081641.21500-1-guoqing.jiang@linux.dev>
 <20220506113656.25010-1-guoqing.jiang@linux.dev>
 <CAPhsuW6mGnkg4x5xm6x5n06JXxF-7PNubpQiZNmX0BH9Zo1ncA@mail.gmail.com>
 <141b4110-767e-7670-21d5-6a5f636d1207@linux.dev>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <141b4110-767e-7670-21d5-6a5f636d1207@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 09/05/2022 09:09, Guoqing Jiang wrote:
> I can switch back to V2 if you think that is the correct way to do 
> though no
> one comment about the change in dm-raid.

DON'T QUOTE ME ON THIS

but it is very confusing, as I believe dm-raid is part of Device 
Managment, which is actually nothing to do with md-raid (apart from, 
like many block layer drivers, md-raid uses dm to manage the device 
beneath it.)

Cheers,
Wol
