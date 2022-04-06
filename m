Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517264F6C44
	for <lists+linux-raid@lfdr.de>; Wed,  6 Apr 2022 23:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiDFVNu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Apr 2022 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiDFVMu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Apr 2022 17:12:50 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF317ABB0
        for <linux-raid@vger.kernel.org>; Wed,  6 Apr 2022 12:57:13 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ncBmB-0001MO-AO;
        Wed, 06 Apr 2022 20:57:11 +0100
Message-ID: <b9f58b50-3f79-4a81-2f47-0f23a6958e10@youngman.org.uk>
Date:   Wed, 6 Apr 2022 20:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RAID 1 to RAID 5 failure
Content-Language: en-GB
To:     Jorge Nunes <jorgebnunes@gmail.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
References: <CANDfL1au6kdEkR3bmLAHTdGV-Rb==8Jy1ZnwNFjvjNq7drC1XA@mail.gmail.com>
 <987997234.3307867.1649118543055.JavaMail.zimbra@karlsbakk.net>
 <336816279.3605676.1649150230084.JavaMail.zimbra@karlsbakk.net>
 <CANDfL1YiKq9aeUsrmdZyLb5Fy98Tifjcr_zZJY6a+LxyqKYKkA@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CANDfL1YiKq9aeUsrmdZyLb5Fy98Tifjcr_zZJY6a+LxyqKYKkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/04/2022 11:50, Jorge Nunes wrote:
> Hi roy.
> 
> Thank you for your time.
> 
> Now, I'm doing a photorec on /dev/sda and /dev/sdd and I get better
> results on (some) of the data recovered if I do it on top of /dev/md0.
> I don't care anymore about recovering the filesystem, I just want to
> maximize the quality of data recovered with photorec.

Once you've recovered everything you can, if no-one else has chimed in, 
do try shrinking it back to a 2-disk raid-5. It SHOULD restore your 
original filesystem. You've then just got to find out where it starts - 
what filesystem was it?

If it's an ext4 there's probably a signature which will tell you where 
it starts. Then somebody should be able to tell you how to mount it and 
back it up properly ...

I'm sure there will be clues to other file systems, ask on your distro 
list for more information - the more people who see a request for help, 
the more likely you are to get some.

Cheers,
Wol
