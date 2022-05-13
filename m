Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDDE525D45
	for <lists+linux-raid@lfdr.de>; Fri, 13 May 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiEMISk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 May 2022 04:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiEMISj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 May 2022 04:18:39 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5A3AA51
        for <linux-raid@vger.kernel.org>; Fri, 13 May 2022 01:18:36 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4L01kL10D5zXvM;
        Fri, 13 May 2022 10:18:34 +0200 (CEST)
Message-ID: <6c2f10d3-44be-f3f2-d329-2a0f267c5d58@thelounge.net>
Date:   Fri, 13 May 2022 10:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Failed adadm RAID array after aborted Grown operation
Content-Language: en-US
To:     Bob Brand <brand@wmawater.com.au>,
        Roger Heflin <rogerheflin@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     Linux RAID <linux-raid@vger.kernel.org>,
        Phil Turmel <philip@turmel.org>, NeilBrown <neilb@suse.com>
References: <00ae01d862de$1d336980$579a3c80$@wmawater.com.au>
 <f4e9c9f8-590d-49a4-39da-e31d81258ff3@youngman.org.uk>
 <00cf01d86327$9c5dd8a0$d51989e0$@wmawater.com.au>
 <3f84648b-29db-0819-e3ba-af52435a2aab@youngman.org.uk>
 <00d101d86329$a2a57130$e7f05390$@wmawater.com.au>
 <00d601d8632f$ac1f1300$045d3900$@wmawater.com.au>
 <00e401d86333$e75d8f60$b618ae20$@wmawater.com.au>
 <00eb01d86339$18cc0860$4a641920$@wmawater.com.au>
 <5931f716-008d-399b-2ea8-acbbc9c8d239@youngman.org.uk>
 <CAAMCDecTb69YY+jGzq9HVqx4xZmdVGiRa54BD55Amcz5yaZo1Q@mail.gmail.com>
 <019701d864f9$7c87ab90$759702b0$@wmawater.com.au>
 <4fc8c8b4-cfc2-81b2-40d6-13c9d8c940bb@thelounge.net>
 <01f501d8653a$1ccf8420$566e8c60$@wmawater.com.au>
 <84b97e58-9884-ca0f-8186-2e046e900334@thelounge.net>
 <b2a3c4ec-2f86-7775-c84f-2f360ab9cfd0@thelounge.net>
 <00b801d8668a$da017c00$8e047400$@wmawater.com.au>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <00b801d8668a$da017c00$8e047400$@wmawater.com.au>
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



Am 13.05.22 um 07:32 schrieb Bob Brand:
> This may not be the forum to ask 

it is because you can type that sort of questions also into google and 
there isn't a good reason to build your own kernel in 2022 for most usecases

> this but what exactly is "compiling the
> kernel". From what I've been reading, it sounds like a somewhat involved and
> complex process - is it? Is compiling a new kernel the same as upgrading the
> OS? I'm getting the impression that it sort of is but sort of isn't. Is it
> possible to compile a kernel for a rescue CD (from the comments I've read,
> it is possible)? If I were to compile a new kernel, would I expect the
> version number for the kernel and mdadm to be the same? Sorry for all the
> question but, as I said at the outset, a lot of this is all very new to me.

don't get me wrong but "Is compiling a new kernel the same as upgrading 
the OS" and "what exactly is "compiling the kernel" implies just use a 
binary distribution when it sounds that you even don't know what compile 
software from source means

> -----Original Message-----
> From: Reindl Harald <h.reindl@thelounge.net>
> Sent: Thursday, 12 May 2022 12:59 AM
> To: Bob Brand <brand@wmawater.com.au>; Roger Heflin <rogerheflin@gmail.com>;
> Wols Lists <antlists@youngman.org.uk>
> Cc: Linux RAID <linux-raid@vger.kernel.org>; Phil Turmel
> <philip@turmel.org>; NeilBrown <neilb@suse.com>
> Subject: Re: Failed adadm RAID array after aborted Grown operation
> 
> 
> 
> Am 11.05.22 um 16:56 schrieb Reindl Harald:
>>
>>
>> Am 11.05.22 um 15:22 schrieb Bob Brand:
>>> Sorry Reindl.  I'm not sure I understand. Are you saying I did or
>>> didn't do the right thing in booting from a CentOS rescue disk? At
>>> the moment it's running from the rescue disk and, be it the best
>>> distro to have used (or not), I would imagine that I need to keep
>>> running from the rescue disk until the reshape is complete as
>>> rebooting in the middle of a reshape is what got me in this mess.
> 
> and nowhere did i say reboot now
> 
> and i only responded to your "Do I understand that you would recommend
> upgrading our installation of Linux once the repair is complete or are
> advising downloading and compiling a new kernel as part of the repair?"
> 
> nobody said that - the only point was use a as recent kernel as possible
> with all rgow/reshape operations
> 
>> and i don't understand what you did not understand in the clear
>> response below you got days ago!
>>
>> due reshape you where advised use whatever rescue/live system with a
>> recent kernel and mdadm, not more and not less
>>
>> just to avoid probaly long fixed bugs in your old kernel
>>
>> ---------------------
>>
>> Try and get a CentOS 8.5 disk. At the end of the day, the version of
>> linux doesn't matter. What you need is an up-to-date rescue disk.
>> Distro/whatever is unimportant - what IS important is that you are
>> using the latest mdadm, and a kernel that matches.
>>
>> The problem you have sounds like a long-standing but now-fixed bug. An
>> original CentOS disk might be okay (with matched kernel and mdadm),
>> but almost certainly has what I consider to be a "dodgy" version of mdadm.
>>
>> If you can afford the downtime, after you've reverted the reshape, I'd
>> try starting it again with the rescue disk. It'll probably run fine.
>> Let it complete and then your old CentOS 7 will be fine with it
> 
> 
> 
> CAUTION!!! This E-mail originated from outside of WMA Water. Do not click
> links or open attachments unless you recognize the sender and know the
> content is safe.
