Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7046676A47
	for <lists+linux-raid@lfdr.de>; Sun, 22 Jan 2023 00:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjAUXEP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Jan 2023 18:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAUXEO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 21 Jan 2023 18:04:14 -0500
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB2727D59
        for <linux-raid@vger.kernel.org>; Sat, 21 Jan 2023 15:04:13 -0800 (PST)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4NzsPN0VJ3zXL7;
        Sun, 22 Jan 2023 00:04:08 +0100 (CET)
Message-ID: <3909da0c-aa2b-6e8d-4eb6-e36b4b424e5d@thelounge.net>
Date:   Sun, 22 Jan 2023 00:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Transferring an existing system from non-RAID disks to RAID1
 disks in the same computer
Content-Language: en-US
From:   Reindl Harald <h.reindl@thelounge.net>
To:     Pascal Hambourg <pascal@plouf.fr.eu.org>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <273d1fc9-853f-a8fa-bb47-2883ba217820@meddatainc.com>
 <963bb7eb-7ce2-c887-ca5c-d0359290841b@turmel.org>
 <4224103d-17b4-0635-9bb4-7f81b896ad07@plouf.fr.eu.org>
 <d1a78f14-843a-e6f1-b909-67e091c5fa3f@youngman.org.uk>
 <3a3d1de2-f02b-cd2a-7dd4-9d269bb0443e@plouf.fr.eu.org>
 <acc6add5-347b-7ecb-f6e9-056d21783984@thelounge.net>
 <23acc8a9-08c1-2e3c-0e98-2915f27d29ea@plouf.fr.eu.org>
 <c2d4ca04-6512-0d46-08f7-b11265e00e77@thelounge.net>
 <e8a44850-66d4-dbd3-ebf1-c1f584767aad@plouf.fr.eu.org>
 <f8078086-037d-cc54-b7c7-b9ad88255bfc@thelounge.net>
 <6b7f968b-813b-6405-cd71-c103b579012d@plouf.fr.eu.org>
 <d96d7d83-ecf8-50aa-1007-bd0a320d58f3@thelounge.net>
 <8a70562d-eadb-bb24-e549-5decc04984d1@plouf.fr.eu.org>
 <65ce1e60-ebeb-a9ac-b521-52b59a99abb1@thelounge.net>
 <cddb631b-04e6-6615-2299-d4a1a6492a17@plouf.fr.eu.org>
 <86343cc9-fff2-413a-dadc-c322fd2c96fa@thelounge.net>
 <ecae3a57-4034-75f4-0a9f-bb544f293854@plouf.fr.eu.org>
 <68c6a9ff-91c9-811a-b4eb-9981ae8ad0a6@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <68c6a9ff-91c9-811a-b4eb-9981ae8ad0a6@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 21.01.23 um 23:59 schrieb Reindl Harald:
> 
> 
> Am 21.01.23 um 23:56 schrieb Pascal Hambourg:
>> On 21/01/2023 at 21:44, Reindl Harald wrote:
>>> Am 21.01.23 um 21:04 schrieb Pascal Hambourg:
>>>> On 21/01/2023 at 19:57, Reindl Harald wrote:
>>>>> Am 21.01.23 um 19:52 schrieb Pascal Hambourg:
>>>>
>>>> No, EFI is not the root cause either. The root cause is carelessly 
>>>> storing stuff in the bootloader area as if it was part of the 
>>>> standard Linux filesystem. Guess what ? It is not. 
>>>
>>> LSB is dead
>>
>> LSB has nothing to do with this
> 
> fine, so nobody else but you knows what "part of standard Linux 
> filesystem" means - i can't read your mind
> 
> it's difficult wehn people mix different topics as well as questions 
> about "what is" and "what would be nice if it would"

and if i would mix different topics like you i would throw 
https://bugzilla.redhat.com/show_bug.cgi?id=2162871 into this therad - 
but it don't belong to the tpoic because it's about "why the f** a 
system don't reboot/poweroff" while this topic is about "how do i get a 
system to boot"
