Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B286766C0
	for <lists+linux-raid@lfdr.de>; Sat, 21 Jan 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAUOdL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Jan 2023 09:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUOdK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 21 Jan 2023 09:33:10 -0500
Received: from mallaury.nerim.net (smtp-106-saturday.noc.nerim.net [178.132.17.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517BA21979
        for <linux-raid@vger.kernel.org>; Sat, 21 Jan 2023 06:33:08 -0800 (PST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id 8554CDB17D;
        Sat, 21 Jan 2023 15:33:06 +0100 (CET)
Message-ID: <ea1c9fda-32a2-e19c-5718-c164f0ae3b4f@plouf.fr.eu.org>
Date:   Sat, 21 Jan 2023 15:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Transferring an existing system from non-RAID disks to RAID1
 disks in the same computer
Content-Language: en-US
To:     Wols Lists <antlists@youngman.org.uk>, H <agents@meddatainc.com>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <273d1fc9-853f-a8fa-bb47-2883ba217820@meddatainc.com>
 <3c124633-6b69-c97c-30f2-02f70141ac1a@plouf.fr.eu.org>
 <963bb7eb-7ce2-c887-ca5c-d0359290841b@turmel.org>
 <4224103d-17b4-0635-9bb4-7f81b896ad07@plouf.fr.eu.org>
 <d1a78f14-843a-e6f1-b909-67e091c5fa3f@youngman.org.uk>
 <3a3d1de2-f02b-cd2a-7dd4-9d269bb0443e@plouf.fr.eu.org>
 <d4988c81-21f5-9b71-18ed-6ce489b28667@youngman.org.uk>
 <5030b2e0-b4af-c55f-b965-9e3aab6e5c39@plouf.fr.eu.org>
 <81f7f74f-259e-35e6-985d-3678e2b3c02e@youngman.org.uk>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <81f7f74f-259e-35e6-985d-3678e2b3c02e@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/01/2023 at 15:04, Wols Lists wrote:
> On 21/01/2023 13:32, Pascal Hambourg wrote:
>> Back on topic, if you mean Windows+Linux dual boot, it seems unlikely 
>> to me that this can be achieved with Linux software RAID, because 
>> Windows does not support it and Windows software RAID usually works on 
>> whole drives.
>> If you mean Linux dual-boot, you do not need multiple boot loaders, 
>> one single boot loader can boot all Linux systems.
> 
> Given that this all started with *MIRRORING* EFI partitions, I think 
> you've lost the thread ...
> 
> I'm fully in agreement that - if we want to keep our EFI partitions in 
> sync - then doing so when the partition is updated is the best TIME (not 
> place) to do it. (Which is why mirroring makes sense.)
> 
> It's just that - as soon as you bring multiple OSes (of any sort) into 
> it - this ceases to be a practical solution.

It depends if you mean "mirroring" with rsync or with RAID.
Also, it depends what the OS sorts are. With only Linux systems all 
using EFI partitions in RAID1, it might work.

> THERE'S TOO MANY WAYS TO SKIN THIS CAT and trying to automate it will in 
> almost all cases lead to tears :-(

This is why I claim that the only universal solution is that each OS 
supports multiple EFI partitions natively when writing any file in an 
EFI partition. Mirroring is a dead end.
