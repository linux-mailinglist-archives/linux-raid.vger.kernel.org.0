Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CC5302A5
	for <lists+linux-raid@lfdr.de>; Sun, 22 May 2022 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiEVLZw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 22 May 2022 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiEVLZv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 22 May 2022 07:25:51 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33419C2F
        for <linux-raid@vger.kernel.org>; Sun, 22 May 2022 04:25:49 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4L5dSB02ltzXvP;
        Sun, 22 May 2022 13:25:40 +0200 (CEST)
Message-ID: <d8d15df1-28b6-1569-d13e-4cf411816fa0@thelounge.net>
Date:   Sun, 22 May 2022 13:25:40 +0200
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
 <04ed01d86c5c$2f632f50$8e298df0$@wmawater.com.au>
 <06995c9b-2dc5-3c0b-9ba1-59be171a7de8@thelounge.net>
 <054401d86d92$3c59cac0$b50d6040$@wmawater.com.au>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <054401d86d92$3c59cac0$b50d6040$@wmawater.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 22.05.22 um 06:13 schrieb Bob Brand:
> Is xfs_repair an option? 

unlikely in case the underlying device has all sort of damages - think 
of the RAID like a single disk and how the filesystem reacts if you 
shoot holes in it

> And, if it is, do I run it on md125 or the
> individual sd devices?

when you think two seconds it's obvious - is the filesystem on top of 
single disks or on top of the whole RAID - the filesystem don't even 
know about individual devices

> Unfortunately, restore from back up isn't an option - after all to where do
> you back up 200TB of data? 

on a second machine in a different building - the inital sync is done 
local and then no matter how large the data rsync is enough - the daily 
delta don't vary just because the whole dataset is huge

and don't get me wrong but who starts a reshape on a 200 TB storage when 
he knows that there is no backup?

> This storage was originally set up with the
> understanding that it wasn't backed up and so no valuable data was supposed
> to have been stored on it. 

well, then i won't store it at all

> Unfortunately, people being what they are,
> valuable data has been stored there and I'm the mug now trying to get it
> back - it's a system that I've inherited.

