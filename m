Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF66051AF
	for <lists+linux-raid@lfdr.de>; Wed, 19 Oct 2022 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiJSVBB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Oct 2022 17:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiJSVBA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 19 Oct 2022 17:01:00 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1517253B
        for <linux-raid@vger.kernel.org>; Wed, 19 Oct 2022 14:00:55 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4Mt36X4ngczXSt;
        Wed, 19 Oct 2022 23:00:52 +0200 (CEST)
Message-ID: <e9feaefd-9ddb-c07a-86b8-3640ca4201af@thelounge.net>
Date:   Wed, 19 Oct 2022 23:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Performance Testing MD-RAID10 with 1 failed drive
Content-Language: en-US
To:     Umang Agarwalla <umangagarwalla111@gmail.com>,
        linux-raid@vger.kernel.org
References: <CAEQ-dADdRd91GBkTzVU0AQiXQ4tLitYsU2uLziWOi=hLtaBK0w@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <CAEQ-dADdRd91GBkTzVU0AQiXQ4tLitYsU2uLziWOi=hLtaBK0w@mail.gmail.com>
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



Am 19.10.22 um 21:30 schrieb Umang Agarwalla:
> Hello all,
> 
> We run Linux RAID 10 in our production with 8 SAS HDDs 7200RPM.
> We recently got to know from the application owners that the writes on
> these machines get affected when there is one failed drive in this
> RAID10 setup, but unfortunately we do not have much data around to
> prove this and exactly replicate this in production.
> 
> Wanted to know from the people of this mailing list if they have ever
> come across any such issues.
> Theoretically as per my understanding a RAID10 with even a failed
> drive should be able to handle all the production traffic without any
> issues. Please let me know if my understanding of this is correct or
> not.

"without any issue" is nonsense by common sense
