Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C4AE147
	for <lists+linux-raid@lfdr.de>; Tue,  8 Feb 2022 19:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385262AbiBHSpC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Feb 2022 13:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385312AbiBHSpA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 8 Feb 2022 13:45:00 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0DC0612AA
        for <linux-raid@vger.kernel.org>; Tue,  8 Feb 2022 10:44:45 -0800 (PST)
Received: from host81-132-12-162.range81-132.btcentralplus.com ([81.132.12.162] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nHVTm-000AKN-99; Tue, 08 Feb 2022 18:44:43 +0000
Message-ID: <0c20be6e-87f2-b9dc-4c9a-85680ba10417@youngman.org.uk>
Date:   Tue, 8 Feb 2022 18:44:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] lib/raid6/test/Makefile: Use `$(pound)` instead of
 `\#` for Make 4.3
Content-Language: en-GB
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Song Liu <song@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-raid@vger.kernel.org,
        Matt Brown <matthew.brown.dev@gmail.com>
References: <20220126114144.370517-1-pmenzel@molgen.mpg.de>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <20220126114144.370517-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/01/2022 11:41, Paul Menzel wrote:
> So, do the same as commit 9564a8cf422d (Kbuild: fix # escaping in .cmd
> files for future Make) and commit 929bef467771 (bpf: Use $(pound) instead
> of \# in Makefiles) and define and use a `$(pound)` variable.

Ouch!

In the English (as opposed to American) speaking world this will be very 
confusing! The pound sign is £ not #.

If this is not dictated by some sort of upstream PLEASE can we make it 
$(hash) not $(pound)

Cheers,
Wol
