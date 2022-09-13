Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF285B6C86
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiIMLsu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 07:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIMLsu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 07:48:50 -0400
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net [178.132.17.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307DE1DA5E
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 04:48:49 -0700 (PDT)
Received: from [192.168.0.247] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id 5D309DB18B;
        Tue, 13 Sep 2022 13:48:48 +0200 (CEST)
Message-ID: <97b66977-97c7-21aa-f1d9-f0d34a0fcf9b@plouf.fr.eu.org>
Date:   Tue, 13 Sep 2022 13:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: change UUID of RAID devcies
Content-Language: en-US
To:     Reindl Harald <h.reindl@thelounge.net>,
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
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <65ee1134-60e4-4577-74c7-0ba15ae39225@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13/09/2022 at 13:39, Reindl Harald wrote:
> Am 13.09.22 um 13:35 schrieb Pascal Hambourg:
>> On 13/09/2022 at 13:30, Reindl Harald wrote:
>>> Am 13.09.22 um 13:17 schrieb Pascal Hambourg:
>>
>> Why wouldn't your /boot work with GPT ? It works for me
> 
> because you said so?

No, I didn't say so.

> -------- Weitergeleitete Nachricht --------
> Betreff: Re: change UUID of RAID devcies
> Datum: Tue, 13 Sep 2022 12:39:50 +0200
> Von: Pascal Hambourg <pascal@plouf.fr.eu.org>
> An: Reindl Harald <h.reindl@thelounge.net>, Linux RAID Mailing List 
> <linux-raid@vger.kernel.org>
> 
> Yes, but it requires a "BIOS boot" partition for the core image (usually 
> less than 100 kB, so 1 MB is plenty enough). Also some flawed BIOS 
> require that a legacy partition entry in the protective MBR has the 
> "boot" flag set.

Legacy boot on GPT has some requirements, but it works.
