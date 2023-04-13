Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C036E0891
	for <lists+linux-raid@lfdr.de>; Thu, 13 Apr 2023 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDMIFU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Apr 2023 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjDMIFT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 13 Apr 2023 04:05:19 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0393D0
        for <linux-raid@vger.kernel.org>; Thu, 13 Apr 2023 01:05:16 -0700 (PDT)
Received: from host86-156-145-149.range86-156.btcentralplus.com ([86.156.145.149] helo=[192.168.1.99])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1pmrxC-0001EI-EO;
        Thu, 13 Apr 2023 09:05:14 +0100
Message-ID: <2d471704-bf1c-453f-1c46-469c4d88b98c@youngman.org.uk>
Date:   Thu, 13 Apr 2023 09:05:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Recover data from accidentally created raid5 over raid1
To:     Mark Wagner <carnildo@gmail.com>, linux-raid@vger.kernel.org
References: <c0a9e08b91e86c86038be889907f0796@itrosinen.de>
 <25653.47458.489415.933722@quad.stoffel.home>
 <21b0a1ef-6389-8851-f6f9-17f3ca6d96c0@youngman.org.uk>
 <14ccbf12-0254-b0b8-4c9a-8949c947a63c@thelounge.net>
 <da9f8739-f923-de3f-2a4e-320c757f3139@turmel.org>
 <CAA04aRTJ4RreJtOnZcvvTqcc5ZGU5T5WbBt0X0str210CcMo8g@mail.gmail.com>
Content-Language: en-GB
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CAA04aRTJ4RreJtOnZcvvTqcc5ZGU5T5WbBt0X0str210CcMo8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/04/2023 21:22, Mark Wagner wrote:
> On Wed, Apr 12, 2023 at 5:45 AM Phil Turmel <philip@turmel.org> wrote:
>>
>> What is nonsense?  A two-disk raid5 does have exactly the same content
>> on both disks, just like a mirror.  The parity for any given single byte
>> is that same byte.
> 
> Only if it's using even parity.  If it's using odd parity, the second
> disk is the inverse of the first.
> 
It's documented on the raid wiki (because I think it was documented 
there before I started editing it), that the way raid switches between 
different raid types is through the fact (accidental or on purpose I 
don't know) that most of the two-disk raid types just happen to have an 
"identical in practice" disk layout.

So converting between raid-1 and raid-5 is as simple as changing the 
config of a raid-1 to a degraded raid-5 and vice versa.

Cheers,
Wol

