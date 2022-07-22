Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F209A57E0CA
	for <lists+linux-raid@lfdr.de>; Fri, 22 Jul 2022 13:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiGVLaY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 22 Jul 2022 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGVLaX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 22 Jul 2022 07:30:23 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A613E0FF
        for <linux-raid@vger.kernel.org>; Fri, 22 Jul 2022 04:30:21 -0700 (PDT)
Received: from host86-158-105-35.range86-158.btcentralplus.com ([86.158.105.35] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1oEqrM-0008Z7-3N;
        Fri, 22 Jul 2022 12:30:20 +0100
Message-ID: <ed27e3f8-0d54-3e1e-bae8-d90c259e430a@youngman.org.uk>
Date:   Fri, 22 Jul 2022 12:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 5.18: likely useless very preliminary bug report: mdadm raid-6
 boot-time assembly failure
Content-Language: en-GB
To:     Nix <nix@esperi.org.uk>, Roger Heflin <rogerheflin@gmail.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <87o7xmsjcv.fsf@esperi.org.uk>
 <fed30ed9-68e3-ce8b-ec27-45c48cf6a7a1@linux.dev>
 <8735evpwrf.fsf@esperi.org.uk>
 <CAAMCDeenbs5R6e_kuQR_zsv50eh49O2w4h-+BAg1xU9y0_BZ1Q@mail.gmail.com>
 <871qudo4g0.fsf@esperi.org.uk>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <871qudo4g0.fsf@esperi.org.uk>
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

On 22/07/2022 10:57, Nix wrote:
> I thought all the work done to assemble raid arrays was done by mdadm?
> Because that didn't change. Does the kernel md layer also get to say
> "type wrong, go away"? EW. I'd hope nothing is looking at partition
> types these days...

As far as I know (which is probably the same as you :-) the kernel knows 
nothing about the v1 superblock format, so raid assembly *must* be done 
by mdadm.

That's why, despite it being obsolete, people get upset when there's any 
mention of 0.9 going away, because the kernel DOES recognise it and can 
assemble those arrays.

Cheers,
Wol
