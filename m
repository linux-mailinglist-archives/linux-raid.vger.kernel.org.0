Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0A5B7C48
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIMUq3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIMUq1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 16:46:27 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19CD101
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 13:46:25 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4MRwVR3fXxzXLb;
        Tue, 13 Sep 2022 22:46:23 +0200 (CEST)
Message-ID: <75a3c54a-c436-32a3-10c9-e9bc75d8a143@thelounge.net>
Date:   Tue, 13 Sep 2022 22:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: change UUID of RAID devcies
Content-Language: en-US
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Pascal Hambourg <pascal@plouf.fr.eu.org>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
 <729bdc01-b0ae-887a-6d2a-5135d287636c@youngman.org.uk>
 <05a1161b-d798-c68f-d37c-a9fc373c6e73@thelounge.net>
 <0023fefe-aad1-e692-48dd-e354497f6e41@plouf.fr.eu.org>
 <1fb05e0f-34b7-3ec4-bc00-ec540e592f19@thelounge.net>
 <3fc0b889-3ef9-652e-6452-2eeede918683@plouf.fr.eu.org>
 <9e537739-2fbd-2c99-8191-54faf0a69a8b@thelounge.net>
 <6b4a5399-5053-4a51-26d7-2f62c47c2981@plouf.fr.eu.org>
 <65ee1134-60e4-4577-74c7-0ba15ae39225@thelounge.net>
 <97b66977-97c7-21aa-f1d9-f0d34a0fcf9b@plouf.fr.eu.org>
 <b428f8c6-cf8b-218c-3cae-8f36327901f7@thelounge.net>
 <ec3b9673-688b-18c8-188b-246e9c63a2d0@plouf.fr.eu.org>
 <071b8b8a-7a50-3eec-22d4-5880ff3f80e9@thelounge.net>
 <8babedc5-a2e7-326f-3340-10e354aecb45@plouf.fr.eu.org>
 <15f573c4-0c96-885f-659f-bfa2cbd698a7@thelounge.net>
 <20220914003228.4377cc6a@nvm>
 <93ea4d09-d6f9-0c5f-1b8e-e610af592834@thelounge.net>
 <20220914012801.5b2dce25@nvm>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <20220914012801.5b2dce25@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 13.09.22 um 22:28 schrieb Roman Mamedov:
> On Tue, 13 Sep 2022 21:54:21 +0200
> Reindl Harald <h.reindl@thelounge.net> wrote:
> 
>>>> it's not funny when you are used to rsync your /etc/fstab over 11 years
>>>> that doing so would lead in a unbootbale system on the other side
>>>
>>> For this I'd suggest to use LABEL=rootfs (and so on) in fstab, instead of
>>> UUIDs.
>>>
>>> It's kind of the point of UUIDs that they are supposed to be (even globally)
>>> unique, and there should not be the same UUID on two different machines
>>
>> that's already the case for 15 years here
>>
>> but there is also mdadm.conf and sadly a copy in the intird
> 
> It has never occured to me to check, but you could also specify arrays by
> "name=" there, instead of UUID. See "man mdadm.conf".

and the name is *what*

ARRAY /dev/md1 UUID=b7475879:c95d9a47:c5043c02:0c5ae720
ARRAY /dev/md2 UUID=ea253255:cb915401:f32794ad:ce0fe396

> And it is possible to rename arrays:
> https://askubuntu.com/questions/63980/how-do-i-rename-an-mdadm-raid-array
> 
> Having same-name arrays on different hosts seems much more reasonable than
> same UUIDs

i get sick and tired after "Then with just two drives you change the 
raid to raid-1" and "mdadm: RAID10 can only be changed to RAID0" don't 
get me wrong but people coming with "i think" and "it may" shouldn't say 
nothing unless they did things in *reality*

i will find a way to get all this crap booting as RAID1 without 
reinstall the OS and nothing here is really helpful

