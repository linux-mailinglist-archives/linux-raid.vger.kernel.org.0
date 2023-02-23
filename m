Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA96A0DDB
	for <lists+linux-raid@lfdr.de>; Thu, 23 Feb 2023 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjBWQYi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 Feb 2023 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjBWQYh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 23 Feb 2023 11:24:37 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C64521E9
        for <linux-raid@vger.kernel.org>; Thu, 23 Feb 2023 08:24:36 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CCB5A60027FE6;
        Thu, 23 Feb 2023 17:24:33 +0100 (CET)
Message-ID: <d10f5df9-0f3d-3a5d-4adb-8ced8e4d67fb@molgen.mpg.de>
Date:   Thu, 23 Feb 2023 17:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Grow: fix can't change bitmap type from none to
 clustered.
Content-Language: en-US
To:     Heming Zhao <heming.zhao@suse.com>
Cc:     linux-raid@vger.kernel.org, jes@trained-monkey.org,
        ncroxon@redhat.com, colyli@suse.de
References: <20230223143939.3817-1-heming.zhao@suse.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230223143939.3817-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Heming,


Thank you for your patch.

It’d be great, if you removed the dot/period from the end of the commit 
message summary.


Kind regards,

Paul
