Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A805520CE
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jun 2022 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiFTP1L (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jun 2022 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiFTP07 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jun 2022 11:26:59 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133F1E3
        for <linux-raid@vger.kernel.org>; Mon, 20 Jun 2022 08:26:20 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3720B61EA1923;
        Mon, 20 Jun 2022 17:26:17 +0200 (CEST)
Message-ID: <1828d438-8584-d67b-f35b-631091dad39f@molgen.mpg.de>
Date:   Mon, 20 Jun 2022 17:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mdadm v1 06/14] mdadm: Fix mdadm -r remove option
 regresision
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-raid@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Coly Li <colyli@suse.de>, Bruce Dubbs <bruce.dubbs@gmail.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Wu Guanghao <wuguanghao3@huawei.com>
References: <20220609211130.5108-1-logang@deltatee.com>
 <20220609211130.5108-7-logang@deltatee.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220609211130.5108-7-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Logan,


Thank you for the patch. There is a small typo in *regression* in the 
commit message summary.


Kind regards,

Paul
