Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27A69FFC5
	for <lists+linux-raid@lfdr.de>; Thu, 23 Feb 2023 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBVXtM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Feb 2023 18:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBVXtK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Feb 2023 18:49:10 -0500
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7586303D7
        for <linux-raid@vger.kernel.org>; Wed, 22 Feb 2023 15:49:09 -0800 (PST)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4PMXtL28X1zXKn;
        Thu, 23 Feb 2023 00:48:58 +0100 (CET)
Message-ID: <cf7d2f0e-a49b-66a9-a2ad-4726f98e1704@thelounge.net>
Date:   Thu, 23 Feb 2023 00:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/3] md: Use optimal I/O size for last bitmap page
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Xiao Ni <xni@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Sushma Kalakota <sushma.kalakota@intel.com>
References: <20230222215828.225-1-jonathan.derrick@linux.dev>
 <20230222215828.225-4-jonathan.derrick@linux.dev>
 <Y/aoYGITuKUHBkoC@infradead.org>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <Y/aoYGITuKUHBkoC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 23.02.23 um 00:42 schrieb Christoph Hellwig:
> On Wed, Feb 22, 2023 at 02:58:28PM -0700, Jonathan Derrick wrote:
>> +	if (io_size != opt_size &&
>> +	    start + opt_size / SECTOR_SIZE <= boundary)
>> +		return opt_size;
>> +	else if (start + io_size / SECTOR_SIZE <= boundary)
> 
> No need for an else after a return.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

the "return" is within the if-condition and has nothing to do with the 
else - with {} it would be clearly visible
