Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC95B676BC8
	for <lists+linux-raid@lfdr.de>; Sun, 22 Jan 2023 10:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjAVJEK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 22 Jan 2023 04:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjAVJEJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 22 Jan 2023 04:04:09 -0500
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [178.132.17.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C04F113F7
        for <linux-raid@vger.kernel.org>; Sun, 22 Jan 2023 01:04:07 -0800 (PST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id DAC2DDB180;
        Sun, 22 Jan 2023 10:04:05 +0100 (CET)
Message-ID: <88dd4c81-03fe-b4e0-182f-b232592c6068@plouf.fr.eu.org>
Date:   Sun, 22 Jan 2023 10:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Transferring an existing system from non-RAID disks to RAID1
 disks in the same computer
Content-Language: en-US
To:     Reindl Harald <h.reindl@thelounge.net>,
        Wols Lists <antlists@youngman.org.uk>,
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
 <ea1c9fda-32a2-e19c-5718-c164f0ae3b4f@plouf.fr.eu.org>
 <0a3e3d16-e73b-ce13-2cd4-4234e03af022@youngman.org.uk>
 <c48da91f-122f-b827-471b-4fcace5679c0@plouf.fr.eu.org>
 <19a04b8a-c314-becd-f272-1323160f346f@thelounge.net>
 <5dc67a57-1ebb-4ce5-80f3-bdc4f59a9510@plouf.fr.eu.org>
 <2240c8d8-0ad3-46b3-1166-31ce35f900d9@thelounge.net>
 <c2d7d60b-c21b-5e1b-5721-9362f459e37b@plouf.fr.eu.org>
 <85f4ef15-dab7-5eb4-520c-338c94c9c61d@thelounge.net>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <85f4ef15-dab7-5eb4-520c-338c94c9c61d@thelounge.net>
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

On 21/01/2023 at 23:56, Reindl Harald wrote:
> Am 21.01.23 um 23:43 schrieb Pascal Hambourg:
>>
>> RAID provides redundancy while the system is running 
> 
> RAID provides redundancy for devices - no matter if something is running

RAID alone does not provide boot redundancy.
If a drive fails, the system will continue to run until shutdown. But it 
won't boot if the boot area was only set up on the failed disk.

>> For boot redundancy, the boot loader must be installed on each disk
> 
> so what

So that the system can still boot after whichever drive failed.

>> With EFI boot, it means there must be an EFI partition on each disk. 
>> But EFI partitions do not need to be identical as long as any of them 
>> can boot the system
> 
> so what - the topic is "Transferring an existing system from non-RAID 
> disks to RAID1 disks in the same computer"

People who install the system on RAID usually expect boot redundancy.

(trim off-topic rant)
