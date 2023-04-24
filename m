Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148EF6EC718
	for <lists+linux-raid@lfdr.de>; Mon, 24 Apr 2023 09:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDXHah (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Apr 2023 03:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDXHae (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 Apr 2023 03:30:34 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056310D9
        for <linux-raid@vger.kernel.org>; Mon, 24 Apr 2023 00:30:30 -0700 (PDT)
Received: from host86-156-145-149.range86-156.btcentralplus.com ([86.156.145.149] helo=[192.168.1.99])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1pqqea-0002VZ-CF;
        Mon, 24 Apr 2023 08:30:28 +0100
Message-ID: <623fe346-9bb4-b81d-e3ed-525d7d7b22e8@youngman.org.uk>
Date:   Mon, 24 Apr 2023 08:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Raid5 to raid6 grow interrupted, mdadm hangs on assemble command
Content-Language: en-GB
To:     Jove <jovetoo@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <CAFig2csUV2QiomUhj_t3dPOgV300dbQ6XtM9ygKPdXJFSH__Nw@mail.gmail.com>
 <81f8ff93-28be-c520-f497-aeefa5a6f879@thelounge.net>
 <CAFig2cuCgNRZcm6q4=BQ8ikmCcoZiTJDtqwd5gs73qiHq19GVw@mail.gmail.com>
 <CAFig2cs1qtYxqMkCHRY+sFwY4E1rBC0KGS0RFWnjt67UF4wgwQ@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CAFig2cs1qtYxqMkCHRY+sFwY4E1rBC0KGS0RFWnjt67UF4wgwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 24/04/2023 08:02, Jove wrote:
>> I do doubt this is the cause of my problems though.
> Just to clarify, migrating an array from a 3 disk raid5 to a 4 disk
> raid6 should be fine?

Yup. This should not have been a problem.

I notice you have WD Reds ... are the new drives new Reds? Not a wise 
move...

At what percent is the conversion hung? If a status says 0% complete, 
then a data recovery should be fine. Snag is, this doesn't at first 
glance sound like that.

And you shouldn't have needed a backup file - again I'll have to dig 
deeper ...

Give me a chance, I'll dig deeper.

Cheers,
Wol
