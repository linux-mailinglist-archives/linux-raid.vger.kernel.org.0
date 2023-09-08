Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED88798799
	for <lists+linux-raid@lfdr.de>; Fri,  8 Sep 2023 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbjIHNIO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Sep 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIHNIO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 Sep 2023 09:08:14 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 06:08:09 PDT
Received: from vps.thesusis.net (unknown [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26291BF0
        for <linux-raid@vger.kernel.org>; Fri,  8 Sep 2023 06:08:09 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 8BC66138141; Fri,  8 Sep 2023 09:00:05 -0400 (EDT)
References: <CAGqmV7ojxmsMVStS2LWzfeN+A565z4U=d9kUBUnAfCGq5TGtsw@mail.gmail.com>
 <c22e4c16-ad15-b358-ac42-778675aeb5ad@huaweicloud.com>
 <CAGqmV7obHLD5FOT_jL05gw5-kMLXsWJpvv6VfoHce9-Pz6i74Q@mail.gmail.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     CoolCold <coolthecold@gmail.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: RADI10 slower than SINGLE drive - tests with fio for block
 device (no filesystem in use) - 18.5k vs 26k iops
Date:   Fri, 08 Sep 2023 08:54:30 -0400
In-reply-to: <CAGqmV7obHLD5FOT_jL05gw5-kMLXsWJpvv6VfoHce9-Pz6i74Q@mail.gmail.com>
Message-ID: <878r9gddm2.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


CoolCold <coolthecold@gmail.com> writes:

>> Write will be slower is normal, because each write to the array must
>> write to all the rdev and wait for these write be be done.
>
> This contradicts with common wisdom and basically eliminates one of
> the points of having striped setups - having N stripes, excepted to
> give up to N/2 improvement in iops.

Striping is raid0.  Radi10 is striping, AND mirroring.  In the case of
only two drives in the default near layout, it is identical to raid1, so
you only have a single stripe.
