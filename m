Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41952792D
	for <lists+linux-raid@lfdr.de>; Sun, 15 May 2022 20:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiEOSkA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 15 May 2022 14:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiEOSj6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 15 May 2022 14:39:58 -0400
Received: from smtp-delay1.nerim.net (mailhost-f1-m0.nerim.net [78.40.49.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2E9313D03
        for <linux-raid@vger.kernel.org>; Sun, 15 May 2022 11:39:54 -0700 (PDT)
Received: from maiev.nerim.net (smtp-150-sunday.nerim.net [194.79.134.150])
        by smtp-delay1.nerim.net (Postfix) with ESMTP id BEF6FC65E8
        for <linux-raid@vger.kernel.org>; Sun, 15 May 2022 20:39:53 +0200 (CEST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by maiev.nerim.net (Postfix) with ESMTP id ABA642E007;
        Sun, 15 May 2022 20:39:42 +0200 (CEST)
Message-ID: <056cdd2b-e7c7-d9dc-8e33-cb0727e70d42@plouf.fr.eu.org>
Date:   Sun, 15 May 2022 20:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: failed sector detected but disk still active ?
Content-Language: en-US
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXh7cVHa+G1DaJwWSvgDaCOrYLP_Ppau8q6pk1V4dS3D_Q@mail.gmail.com>
 <Yn6BEym8s0kVLhD0@lazy.lzy>
 <994cb384-3782-dac2-898b-ea02816a904f@youngman.org.uk>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <994cb384-3782-dac2-898b-ea02816a904f@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Le 14/05/2022 à 15:46, Wols Lists a écrit :
> 
> Or the rewrite fails, raid assumes the drive is faulty and kicks it out. 
> That's why you should never use desktop drives unless you know EXACTLY 
> what you are doing!

What's wrong with desktop drives ?
