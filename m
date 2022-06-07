Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB05388C5
	for <lists+linux-raid@lfdr.de>; Tue, 31 May 2022 00:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiE3WF4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 May 2022 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiE3WF4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 May 2022 18:05:56 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985A73543
        for <linux-raid@vger.kernel.org>; Mon, 30 May 2022 15:05:54 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4LBqH41ByyzXMH;
        Tue, 31 May 2022 00:05:52 +0200 (CEST)
Message-ID: <7373e0bf-f8cb-baf3-c1cd-502cc77185ce@thelounge.net>
Date:   Tue, 31 May 2022 00:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: raid array move
Content-Language: en-US
To:     o1bigtenor <o1bigtenor@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf5_QmoNvT+wsoy11S8cPCb2LepXNRHDAzcFGXTP9v9WWuw@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <CAPpdf5_QmoNvT+wsoy11S8cPCb2LepXNRHDAzcFGXTP9v9WWuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.05.22 um 23:55 schrieb o1bigtenor:
> I am investing in a new system.
> 
> The old system has a raid 10 array that I would like to put into the
> new system.
> 
> The new system is going to add 2 M2 drives that I want to set up as raid 1
> and this is for use for /EFI, /boot, /, /var, /usr and swap.
> There are 2 2.5" SDDs that are going to be set up as raid 1 for /home.
> 
> The idea is to transfer the previously used drives from the old system
> into the new system.
> 
> The question:
> is it better to load the system and then add the hard drives
> 
> or
> 
> do I move the drives into the system and then install the system with
> the drives at the same time

when your system isn't on the RAID for whatever reason first nstall the 
system and leave the drives out - common sense: the installer can't do 
anything wrong on drives which are not present

frankly i know companies which disconnect their data SAN-storages from 
virtualization hosts before ESXi updates beause 1 out of 1000 times 
years ago it ate the data
