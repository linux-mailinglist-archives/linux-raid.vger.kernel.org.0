Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74786C2E6C
	for <lists+linux-raid@lfdr.de>; Tue, 21 Mar 2023 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCUKJ0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Mar 2023 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUKJZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 Mar 2023 06:09:25 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE01CAF6
        for <linux-raid@vger.kernel.org>; Tue, 21 Mar 2023 03:09:24 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8042461CC457B;
        Tue, 21 Mar 2023 11:09:22 +0100 (CET)
Message-ID: <92e83784-48d9-1081-180a-858e1d4fd040@molgen.mpg.de>
Date:   Tue, 21 Mar 2023 11:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix race of "mdadm --add" and "mdadm --incremental"
To:     Li Xiaokeng <lixiaokeng@huawei.com>
Cc:     jes@trained-monkey.org, mwilck@suse.com, colyli@suse.de,
        linux-raid@vger.kernel.org, miaoguanqin@huawei.com,
        louhongxiang@huawei.com
References: <20230321085500.867948-1-lixiaokeng@huawei.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230321085500.867948-1-lixiaokeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Li,


Am 21.03.23 um 09:55 schrieb Li Xiaokeng:
> From: lixiaokeng <lixiaokeng@huawei.com>

Just a note, that your name is not correctly configured on the system 
you created the patch on.

[…]


Kind regards,

Paul
