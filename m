Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2834E5B4DA9
	for <lists+linux-raid@lfdr.de>; Sun, 11 Sep 2022 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIKLLX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 11 Sep 2022 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiIKLLW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 11 Sep 2022 07:11:22 -0400
X-Greylist: delayed 1138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 04:11:21 PDT
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E432AA3
        for <linux-raid@vger.kernel.org>; Sun, 11 Sep 2022 04:11:21 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4MQRPw6p4xzXLX;
        Sun, 11 Sep 2022 12:52:20 +0200 (CEST)
Message-ID: <53f5754d-e3e2-a8ba-bedb-07eb2b594595@thelounge.net>
Date:   Sun, 11 Sep 2022 12:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: 3 way mirror
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXj0y_bfJ1q50S7xnTyz_4BSrgNboim9e+zK1nKZX9MR3g@mail.gmail.com>
Content-Language: en-US
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <CAJH6TXj0y_bfJ1q50S7xnTyz_4BSrgNboim9e+zK1nKZX9MR3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 11.09.22 um 11:08 schrieb Gandalf Corvotempesta:
> let's assume a 3 way mirror (raid1 with 3 disks)
> One disk got a bad sector detrcted by smartd
> what happens trying to read or write to that sector?
> 
> is md smart enough to read from the other 2 disks and serve consistant data?

that's the whole point of RAID

> in other words, can i delay the disk replacement for a couple of days

just throw it out of the array - on a RAID 1 with two disk you have 
still redundancy and i won't trust a disk which recognized that it has 
errors on it's own

> (i've ordered the disk today, will came tuesday)?

what's the point of "can i delay" when you have no other options? :-)
