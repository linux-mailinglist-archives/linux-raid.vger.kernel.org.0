Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E428966B196
	for <lists+linux-raid@lfdr.de>; Sun, 15 Jan 2023 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAOOnY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 15 Jan 2023 09:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAOOnW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 15 Jan 2023 09:43:22 -0500
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [178.132.17.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F94F1259D
        for <linux-raid@vger.kernel.org>; Sun, 15 Jan 2023 06:43:20 -0800 (PST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id E37F6DB17D;
        Sun, 15 Jan 2023 15:43:12 +0100 (CET)
Message-ID: <2d0a1dad-1961-78df-4c89-e404537c1350@plouf.fr.eu.org>
Date:   Sun, 15 Jan 2023 15:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: What does TRIM/discard in RAID do ?
Content-Language: en-US
To:     Reindl Harald <h.reindl@thelounge.net>,
        linux-raid <linux-raid@vger.kernel.org>
References: <f8531fc8-6928-5300-b43e-1cad0a4ab03b@plouf.fr.eu.org>
 <dbca2904-1200-a81f-cc6d-300e8def6a96@thelounge.net>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <dbca2904-1200-a81f-cc6d-300e8def6a96@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/01/2023 at 13:13, Reindl Harald wrote:
> 
> Am 15.01.23 um 13:00 schrieb Pascal Hambourg:
>> Linux RAID supports TRIM/discard, but what does it do exactly ?
>> Does it only pass-through TRIM/discard information to the underlying 
>> devices or can it also store information about which blocks contain 
>> valid data in the superblock metadata?
> 
> pass-through TRIM/discard
> 
> it makes no sense to store that on the RAID layer

Wouldn't it make sense to:
- skip the initial sync at array creation
- only resync valid data areas during array resync
- reduce wear caused by useless writes on flash drives
- enable TRIM/discard with parity RAID levels by default without relying 
on the underlying device capability to return zeroes on read after TRIM
- ignore mismatches in invalid data areas when scrubbing
?
