Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503957A633
	for <lists+linux-raid@lfdr.de>; Tue, 19 Jul 2022 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiGSSL1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 Jul 2022 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbiGSSLO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 Jul 2022 14:11:14 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21935C368
        for <linux-raid@vger.kernel.org>; Tue, 19 Jul 2022 11:10:46 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4LnRhg4tw0zXLg;
        Tue, 19 Jul 2022 20:10:43 +0200 (CEST)
Message-ID: <4036832a-ee33-8da4-b1f6-739214c5cdad@thelounge.net>
Date:   Tue, 19 Jul 2022 20:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 5.18: likely useless very preliminary bug report: mdadm raid-6
 boot-time assembly failure
Content-Language: en-US
To:     Wols Lists <antlists@youngman.org.uk>,
        Jani Partanen <jiipee@sotapeli.fi>, Nix <nix@esperi.org.uk>,
        linux-raid@vger.kernel.org
References: <87o7xmsjcv.fsf@esperi.org.uk>
 <d28a695e-1958-d438-b43d-65470c1bbe7a@youngman.org.uk>
 <8ac1185f-1522-6343-c6c4-19bd307858f4@sotapeli.fi>
 <0cbb4267-2b0d-5e34-97e0-5e4d13f3275b@youngman.org.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <0cbb4267-2b0d-5e34-97e0-5e4d13f3275b@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 19.07.22 um 19:09 schrieb Wols Lists:
> Well, LAST I TRIED, it worked fine on gentoo, so it's certainly not 
> Debian-specific

i can't follow that logic
