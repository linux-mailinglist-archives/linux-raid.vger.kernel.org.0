Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B378C5B62DA
	for <lists+linux-raid@lfdr.de>; Mon, 12 Sep 2022 23:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiILVhm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Sep 2022 17:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiILVhl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 12 Sep 2022 17:37:41 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62C3C15D
        for <linux-raid@vger.kernel.org>; Mon, 12 Sep 2022 14:37:39 -0700 (PDT)
Received: from host86-157-192-122.range86-157.btcentralplus.com ([86.157.192.122] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1oXr7Y-00025T-FM;
        Mon, 12 Sep 2022 22:37:37 +0100
Message-ID: <729bdc01-b0ae-887a-6d2a-5135d287636c@youngman.org.uk>
Date:   Mon, 12 Sep 2022 22:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: change UUID of RAID devcies
Content-Language: en-GB
To:     Reindl Harald <h.reindl@thelounge.net>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
From:   Wol <antlists@youngman.org.uk>
In-Reply-To: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/09/2022 16:04, Reindl Harald wrote:
> the reason for that game is that the machines are running for 10 years 
> now and all the new desktop hardware can't hold 4x3.5" disks and so just 
> put them in a new one isn't possible

How many SATA ports does the mobo have? Can you --replace onto the new 
drives (especially if it's raid-10!), then just fail the remaining two 
drives?

Iirc raid-10 doesn't require the drives to be the same size, so provided 
the two new drives are big enough, that should just work.

Then with just two drives you change the raid to raid-1.

Cheers,
Wol
