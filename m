Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5C4AE404
	for <lists+linux-raid@lfdr.de>; Tue,  8 Feb 2022 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiBHWZM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Feb 2022 17:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387250AbiBHWMz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 8 Feb 2022 17:12:55 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD236C0612B8
        for <linux-raid@vger.kernel.org>; Tue,  8 Feb 2022 14:12:52 -0800 (PST)
Received: from host81-132-12-162.range81-132.btcentralplus.com ([81.132.12.162] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nHYjC-0006Ve-Bl; Tue, 08 Feb 2022 22:12:50 +0000
Message-ID: <d07a9d41-5a8f-a1f3-59f7-d2a75d6df2e5@youngman.org.uk>
Date:   Tue, 8 Feb 2022 22:12:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] lib/raid6/test/Makefile: Use `$(pound)` instead of
 `\#` for Make 4.3
Content-Language: en-GB
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Matt Brown <matthew.brown.dev@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20220208152148.48534-1-pmenzel@molgen.mpg.de>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <20220208152148.48534-1-pmenzel@molgen.mpg.de>
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

On 08/02/2022 15:21, Paul Menzel wrote:
> So, do the same as commit 9564a8cf422d ("Kbuild: fix # escaping in .cmd
> files for future Make") and commit 929bef467771 ("bpf: Use $(pound) instead
> of \# in Makefiles") and define and use a `$(pound)` variable.

As commented elsewhere, for the sake of us ENGLISH speakers, *PLEASE* 
make that $(hash). A pound sign is £.

Cheers,
Wol
