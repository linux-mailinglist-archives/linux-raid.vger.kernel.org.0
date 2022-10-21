Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FA60721B
	for <lists+linux-raid@lfdr.de>; Fri, 21 Oct 2022 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJUIZT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 21 Oct 2022 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJUIZJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 21 Oct 2022 04:25:09 -0400
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 01:25:04 PDT
Received: from smtp-delay1.nerim.net (mailhost-x5-m4.nerim-networks.com [78.40.49.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D7EF12275A
        for <linux-raid@vger.kernel.org>; Fri, 21 Oct 2022 01:25:02 -0700 (PDT)
Received: from maiev.nerim.net (smtp-155-friday.nerim.net [194.79.134.155])
        by smtp-delay1.nerim.net (Postfix) with ESMTP id 4FA95C7AD8
        for <linux-raid@vger.kernel.org>; Fri, 21 Oct 2022 10:15:49 +0200 (CEST)
Received: from [192.168.0.247] (plouf.fr.eu.org [213.41.155.166])
        by maiev.nerim.net (Postfix) with ESMTP id 82B9D2E008
        for <linux-raid@vger.kernel.org>; Fri, 21 Oct 2022 10:15:43 +0200 (CEST)
Message-ID: <6c31fc94-b70e-88c5-205a-efff32baf594@plouf.fr.eu.org>
Date:   Fri, 21 Oct 2022 10:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Performance Testing MD-RAID10 with 1 failed drive
Content-Language: en-US
To:     linux-raid@vger.kernel.org
References: <CAEQ-dADdRd91GBkTzVU0AQiXQ4tLitYsU2uLziWOi=hLtaBK0w@mail.gmail.com>
 <e9feaefd-9ddb-c07a-86b8-3640ca4201af@thelounge.net>
 <7ca2b272-4920-076f-ecaf-5109db0aae46@youngman.org.uk>
 <CAAMCDef4bGs_LnbxEie=2FkxD6YJ_A4WFzW8c647k9MNLGoY3A@mail.gmail.com>
 <CAEQ-dAAYRAg-t3ve9RJV-vJhzqMSe7YOw2bwJVJ_vk0BDp7NZw@mail.gmail.com>
 <20221021001405.2uapizqtsj3wxptb@bitfolk.com>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <20221021001405.2uapizqtsj3wxptb@bitfolk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Le 21/10/2022 à 02:14, Andy Smith a écrit :
> 
> On Thu, Oct 20, 2022 at 12:13:19PM +0530, Umang Agarwalla wrote:
>> But what I am trying to understand is, how to benchmark the
>> performance hit in such a condition.
> 
> Perhaps you could use dm-dust to make an unreliable block device
> from a real device?

That seems uselessly complicated to me. What about this ?

- benchmark the array in the clean state
- fail and remove a drive
- benchmark the array in the degraded state
- add a new drive and start the resync
- benchmark the array in the resync state
