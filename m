Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5323E5A3D09
	for <lists+linux-raid@lfdr.de>; Sun, 28 Aug 2022 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiH1Jyq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 28 Aug 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1Jyp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 28 Aug 2022 05:54:45 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D23D5B8
        for <linux-raid@vger.kernel.org>; Sun, 28 Aug 2022 02:54:43 -0700 (PDT)
Received: from host86-128-157-135.range86-128.btcentralplus.com ([86.128.157.135] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1oSF06-0003vI-3q;
        Sun, 28 Aug 2022 10:54:42 +0100
Message-ID: <dc24b476-2f0a-8406-f1c0-e33b5b0eb388@youngman.org.uk>
Date:   Sun, 28 Aug 2022 10:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: RAID 6, 6 device array - all devices lost superblock
Content-Language: en-GB
From:   Wols Lists <antlists@youngman.org.uk>
To:     Peter Sanders <plsander@gmail.com>, linux-raid@vger.kernel.org
Cc:     Phil Turmel <philip@turmel.org>, NeilBrown <neilb@suse.com>
References: <CAKAPSkJLd836Zp3xU=zSOHg3qcEmi29Y2qOwWzeAFaDp+dNTvg@mail.gmail.com>
 <70e2ae22-bbba-77a4-c9bc-4c02752f4cb7@youngman.org.uk>
In-Reply-To: <70e2ae22-bbba-77a4-c9bc-4c02752f4cb7@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 28/08/2022 10:14, Wols Lists wrote:
>> Currently I have no /dev/md* devices.
>> I have access to the old mdadm.conf file - have tried assembling with
>> it, with the default mdadm.conf, and with no mdadm.conf file in /etc
>> and /etc/mdadm.
> 
> It looks like the drives weren't partitioned :-( I think you're into 
> forensics.

Whoops - my system froze while I was originally writing my reply, and I 
forgot to put this into my rewrite ...

Look up overlays in the wiki. I've never done it myself, but a fair few 
people have said the instructions worked a treat.

You're basically making the drives read-only (all writes get dumped into 
the overlay file), and then re-creating the array over the top, so you 
can test whether you got it right. If you don't, you just ditch the 
overlays and start again, if you did get it right you can recreate the 
array for real.

Cheers,
Wol
