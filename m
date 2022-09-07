Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B705B050E
	for <lists+linux-raid@lfdr.de>; Wed,  7 Sep 2022 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIGNVS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Sep 2022 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGNVS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Sep 2022 09:21:18 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A871C935
        for <linux-raid@vger.kernel.org>; Wed,  7 Sep 2022 06:21:14 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B3BC61EA1929;
        Wed,  7 Sep 2022 15:21:11 +0200 (CEST)
Message-ID: <5dbbd5a0-808d-070d-5bbf-59be4a83e05f@molgen.mpg.de>
Date:   Wed, 7 Sep 2022 15:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 9/9] udev: Move udev_block() and udev_unblock() into
 udev.c
Content-Language: en-US
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>
Cc:     jes@trained-monkey.org, linux-raid@vger.kernel.org
References: <20220907125657.12192-1-mateusz.grzonka@intel.com>
 <20220907125657.12192-10-mateusz.grzonka@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220907125657.12192-10-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Mateusz,


Thank you for your patches.

Am 07.09.22 um 14:56 schrieb Mateusz Grzonka:
> Add kernel style comments and better error handling.

Please add a note, why the move is useful even if `lib.c` was just used 
for historic reasons.

> Change-Id: Ib6b8e7725d6739a2d7f7b8801e3403137c9cc402

The tag seems to be a leftover – or share the Gerrit URL.

[…]


Kind regards,

Paul
