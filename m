Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7C57A4A3
	for <lists+linux-raid@lfdr.de>; Tue, 19 Jul 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiGSRKA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 Jul 2022 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiGSRKA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 Jul 2022 13:10:00 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCE04D4CF
        for <linux-raid@vger.kernel.org>; Tue, 19 Jul 2022 10:09:58 -0700 (PDT)
Received: from host86-158-105-35.range86-158.btcentralplus.com ([86.158.105.35] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1oDqjM-0009vI-A4;
        Tue, 19 Jul 2022 18:09:56 +0100
Message-ID: <0cbb4267-2b0d-5e34-97e0-5e4d13f3275b@youngman.org.uk>
Date:   Tue, 19 Jul 2022 18:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 5.18: likely useless very preliminary bug report: mdadm raid-6
 boot-time assembly failure
Content-Language: en-GB
To:     Jani Partanen <jiipee@sotapeli.fi>, Nix <nix@esperi.org.uk>,
        linux-raid@vger.kernel.org
References: <87o7xmsjcv.fsf@esperi.org.uk>
 <d28a695e-1958-d438-b43d-65470c1bbe7a@youngman.org.uk>
 <8ac1185f-1522-6343-c6c4-19bd307858f4@sotapeli.fi>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <8ac1185f-1522-6343-c6c4-19bd307858f4@sotapeli.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/07/2022 10:17, Jani Partanen wrote:
> Sorry to jump in but could you suggest something what is quite much 
> default programs, not something that works only debian or something..
> lsdrv on Fedora 36 spit this:
>   ./lsdrv
>    File "/root/lsdrv/./lsdrv", line 323
>      os.mkdir('/dev/block', 0755)
>                             ^
> SyntaxError: leading zeros in decimal integer literals are not 
> permitted; use an 0o prefix for octal integers
> 
Well, LAST I TRIED, it worked fine on gentoo, so it's certainly not 
Debian-specific.

I did have to tell it to use Python 2.7 because gentoo defaulted to 3. 
Apparently it's since been updated, but I haven't (tried to) use it for 
a while.

I've just googled your error, and it looks like a Python-2-ism, so it's 
nothing to do with the distro, and everything to do with the Python 
version change. (As I did warn about in my original post!)

Cheers,
Wol
