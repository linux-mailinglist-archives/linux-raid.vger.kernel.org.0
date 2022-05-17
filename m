Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6149452AB63
	for <lists+linux-raid@lfdr.de>; Tue, 17 May 2022 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351225AbiEQTBL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 May 2022 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352442AbiEQTAz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 May 2022 15:00:55 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD520198
        for <linux-raid@vger.kernel.org>; Tue, 17 May 2022 12:00:53 -0700 (PDT)
Received: from host86-156-102-78.range86-156.btcentralplus.com ([86.156.102.78] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nr2R9-0001Ph-4W;
        Tue, 17 May 2022 20:00:51 +0100
Message-ID: <d95061c0-8332-7e70-9c53-282ecddda226@youngman.org.uk>
Date:   Tue, 17 May 2022 20:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: failed sector detected but disk still active ?
Content-Language: en-GB
To:     Pascal Hambourg <pascal@plouf.fr.eu.org>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXh7cVHa+G1DaJwWSvgDaCOrYLP_Ppau8q6pk1V4dS3D_Q@mail.gmail.com>
 <Yn6BEym8s0kVLhD0@lazy.lzy>
 <994cb384-3782-dac2-898b-ea02816a904f@youngman.org.uk>
 <056cdd2b-e7c7-d9dc-8e33-cb0727e70d42@plouf.fr.eu.org>
 <169db918-cdc1-e461-f484-058f41cbab87@youngman.org.uk>
 <5e0aea05-0159-a184-d5ea-dee176939b1c@plouf.fr.eu.org>
 <a58016bf-5bc2-4272-7250-33ef9b11b6b2@youngman.org.uk>
 <26b37f8d-7f6b-dc43-c494-6d4370365b27@plouf.fr.eu.org>
From:   Wol <antlists@youngman.org.uk>
In-Reply-To: <26b37f8d-7f6b-dc43-c494-6d4370365b27@plouf.fr.eu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 17/05/2022 15:57, Pascal Hambourg wrote:
> On the other hand, I have seen faulty drives report success on write to 
> an unreadable block then failing immediate read at the same location.

That's exactly what I'd expect from a write (as opposed to a 
write-and-verify, they're not the same thing ... :-(

Cheers,
Wol
