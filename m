Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332A57A72B
	for <lists+linux-raid@lfdr.de>; Tue, 19 Jul 2022 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiGSTWk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 Jul 2022 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiGSTWj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 Jul 2022 15:22:39 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D60545D0
        for <linux-raid@vger.kernel.org>; Tue, 19 Jul 2022 12:22:37 -0700 (PDT)
Received: from host86-158-105-35.range86-158.btcentralplus.com ([86.158.105.35] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1oDsnj-0001mL-B8;
        Tue, 19 Jul 2022 20:22:35 +0100
Message-ID: <130972ea-1d6c-8b60-10fc-b536e1b8db0d@youngman.org.uk>
Date:   Tue, 19 Jul 2022 20:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 5.18: likely useless very preliminary bug report: mdadm raid-6
 boot-time assembly failure
Content-Language: en-GB
To:     Reindl Harald <h.reindl@thelounge.net>,
        Jani Partanen <jiipee@sotapeli.fi>, Nix <nix@esperi.org.uk>,
        linux-raid@vger.kernel.org
References: <87o7xmsjcv.fsf@esperi.org.uk>
 <d28a695e-1958-d438-b43d-65470c1bbe7a@youngman.org.uk>
 <8ac1185f-1522-6343-c6c4-19bd307858f4@sotapeli.fi>
 <0cbb4267-2b0d-5e34-97e0-5e4d13f3275b@youngman.org.uk>
 <4036832a-ee33-8da4-b1f6-739214c5cdad@thelounge.net>
From:   Wol <antlists@youngman.org.uk>
In-Reply-To: <4036832a-ee33-8da4-b1f6-739214c5cdad@thelounge.net>
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

On 19/07/2022 19:10, Reindl Harald wrote:
> 
> 
> Am 19.07.22 um 19:09 schrieb Wols Lists:
>> Well, LAST I TRIED, it worked fine on gentoo, so it's certainly not 
>> Debian-specific
> 
> i can't follow that logic

Gentoo is a rolling release. I strongly suspect that 2.7 is deceased. It 
is no more. It has shuffled off this mortal coil.

Cheers,
Wol
