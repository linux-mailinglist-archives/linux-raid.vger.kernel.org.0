Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16651EEAA
	for <lists+linux-raid@lfdr.de>; Sun,  8 May 2022 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiEHPgJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 8 May 2022 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiEHPgI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 8 May 2022 11:36:08 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7810FEF
        for <linux-raid@vger.kernel.org>; Sun,  8 May 2022 08:32:16 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nnitK-0002Nb-6s;
        Sun, 08 May 2022 16:32:14 +0100
Message-ID: <f4e9c9f8-590d-49a4-39da-e31d81258ff3@youngman.org.uk>
Date:   Sun, 8 May 2022 16:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Failed adadm RAID array after aborted Grown operation
Content-Language: en-GB
To:     Bob Brand <brand@wmawater.com.au>, linux-raid@vger.kernel.org
References: <00ae01d862de$1d336980$579a3c80$@wmawater.com.au>
From:   Wols Lists <antlists@youngman.org.uk>
Cc:     Phil Turmel <philip@turmel.org>
In-Reply-To: <00ae01d862de$1d336980$579a3c80$@wmawater.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 08/05/2022 14:18, Bob Brand wrote:
> If you’ve stuck with me and read all this way, thank you and I hope you
> can help me.

https://raid.wiki.kernel.org/index.php/Linux_Raid

Especially 
https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

What you need to do is revert the reshape. I know what may have 
happened, and what bothers me is your kernel version, 3.10.

The first thing to try is to boot from up-to-date rescue media and see 
if an mdadm --revert works from there. If it does, your Centos should 
then bring everything back no problem.

(You've currently got what I call a Frankensetup, a very old kernel, a 
pretty new mdadm, and a whole bunch of patches that does who knows what. 
You really need a matching kernel and mdadm, and your frankenkernel 
won't match anything ...)

Let us know how that goes ...

Cheers,
Wol
