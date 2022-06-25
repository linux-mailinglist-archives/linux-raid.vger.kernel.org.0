Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7555ABCA
	for <lists+linux-raid@lfdr.de>; Sat, 25 Jun 2022 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiFYRnH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 25 Jun 2022 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYRnG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 25 Jun 2022 13:43:06 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F94BE23
        for <linux-raid@vger.kernel.org>; Sat, 25 Jun 2022 10:43:05 -0700 (PDT)
Received: from host86-158-155-35.range86-158.btcentralplus.com ([86.158.155.35] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1o59oF-0005R3-Fo;
        Sat, 25 Jun 2022 18:43:04 +0100
Message-ID: <cb10aa14-3a52-740c-4f6b-d7816cb31155@youngman.org.uk>
Date:   Sat, 25 Jun 2022 18:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Upgrading motherboard + CPU
Content-Language: en-GB
To:     Alexander Shenkin <al@shenkin.org>, Stephan <linux@psjt.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf59G6UjOe-80oqgwPmMY14t0_E=D20cbUwDwtOT8=AFcLQ@mail.gmail.com>
 <81c50899-7edb-e629-3bbc-16cfa8f17e34@youngman.org.uk>
 <b777865e-b265-1e83-dae0-f89654e86332@plouf.fr.eu.org>
 <5cbd9dd1-73fc-ce11-4a9d-8752f7bea979@youngman.org.uk>
 <1de4bf1f-242b-7d02-23dc-a6d05893db81@plouf.fr.eu.org>
 <20220624232049.502a541e@nvm>
 <dab2fe0a-c49e-5da7-5df3-4d01c86a65a7@shenkin.org>
 <20220624234453.43cf4c74@nvm>
 <22102e4b-4738-672d-0d00-bbeccb54fe84@shenkin.org>
 <d85093a4-be3e-d4f2-eca0-e20882584bab@youngman.org.uk>
 <b664e4ce-6ebe-86c6-78d9-d5606c0f6555@shenkin.org>
 <5cb8d159-be2a-aa6c-888a-fcb9ed4555c1@youngman.org.uk>
 <20220625030833.3398d8a4@nvm>
 <ae2288f4-ad06-65af-d30c-4aef6d478f27@plouf.fr.eu.org>
 <s6nh748amrs.fsf@blaulicht.dmz.brux>
 <1b6c6601-22a0-af2a-81a9-34599b1b0fa7@youngman.org.uk>
 <a16b44a7-ae37-7775-24c8-436dcbe69ae8@shenkin.org>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <a16b44a7-ae37-7775-24c8-436dcbe69ae8@shenkin.org>
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

On 25/06/2022 18:38, Alexander Shenkin wrote:
> 
> On 6/25/2022 10:10 AM, Wols Lists wrote:
>> On 25/06/2022 14:35, Stephan wrote:
>>>
>>> Pascal Hambourg <pascal@plouf.fr.eu.org> writes:
>>>
>>>> Why 0.90 ? It is obsolete. If you need RAID metadata at the end of
>>>> RAID members for whatever ugly reason, you can use metadata 1.0
>>>> instead.
>>>
>>> Does mdraid with metadata 1 work on the root filesystem w/o initramfs?
>>>
>> If you're using v1.0, then you could boot off of one of the mirror 
>> members no problem.
>>
>> You would point the kernel boot line at sda1 say (if that's part of 
>> your mirror). IFF that is mounted read-only for boot, then that's not 
>> a problem.
>>
>> Your fstab would then mount /dev/md0 as root read-write, and you're 
>> good to go ...
>>
>> Cheers,
>> Wol
> 
> My metadata is 1.2... I presume that won't cause problems...

Do you need an initramfs to assemble raid ... I thought you did ... in 
which case your system will not boot without one if your root is v1.2 ...

Cheers,
Wol
