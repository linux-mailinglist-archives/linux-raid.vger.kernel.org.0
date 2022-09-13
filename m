Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029ED5B6BC6
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiIMKkG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIMKkE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 06:40:04 -0400
Received: from smtp-delay1.nerim.net (mailhost-j0-m1.nerim-networks.com [78.40.49.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F046017E23
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 03:39:58 -0700 (PDT)
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net [178.132.17.102])
        by smtp-delay1.nerim.net (Postfix) with ESMTP id 6FF71C7AAD
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 12:39:57 +0200 (CEST)
Received: from [192.168.0.247] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id EE7E2DB189;
        Tue, 13 Sep 2022 12:39:51 +0200 (CEST)
Message-ID: <0023fefe-aad1-e692-48dd-e354497f6e41@plouf.fr.eu.org>
Date:   Tue, 13 Sep 2022 12:39:50 +0200
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
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <05a1161b-d798-c68f-d37c-a9fc373c6e73@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13/09/2022 at 12:28, Reindl Harald wrote:
> 
> BTW: currently the machines are BIOS-boot - am i right that the 2 TB 
> limitation only requires that the parts which are needed for booting are 
> on the first 2 TB and i can use 4 TB SSD's on the two bigger machines?

Which 2 TB limitation ? EDD BIOS calls use 64-bit LBA and should not 
have any practical limitation unless the BIOS implementation is flawed.

> in that case i think i would need GPT partitioning and does GRUB2 
> support booting from GPT-partitioned disks in BIOS-mode?

Yes, but it requires a "BIOS boot" partition for the core image (usually 
less than 100 kB, so 1 MB is plenty enough). Also some flawed BIOS 
require that a legacy partition entry in the protective MBR has the 
"boot" flag set.
