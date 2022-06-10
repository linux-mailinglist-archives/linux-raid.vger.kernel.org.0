Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75112546350
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jun 2022 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbiFJKOu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jun 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbiFJKOu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 Jun 2022 06:14:50 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2B1AD
        for <linux-raid@vger.kernel.org>; Fri, 10 Jun 2022 03:14:48 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb3f.dynamic.kabel-deutschland.de [95.90.235.63])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7F23561EA1923;
        Fri, 10 Jun 2022 12:14:45 +0200 (CEST)
Message-ID: <fdcc3343-9aca-b8df-8960-0ea8ba8f13b0@molgen.mpg.de>
Date:   Fri, 10 Jun 2022 12:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mdadm v1 00/14] Bug fixes and testing improvments
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
        David Sloan <David.Sloan@eideticom.com>
References: <20220609211130.5108-1-logang@deltatee.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220609211130.5108-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Logan,


Am 09.06.22 um 23:11 schrieb Logan Gunthorpe:

[…]

> There are still a number of broken tests which need more work, and there
> may be other issues on other people's systems (kernel configurations,
> etc) but that will have to be left to other developers.

Thank you for all your work. Can you list the broken tests, you 
encountered, in the cover letter?


Kind regards,

Paul
