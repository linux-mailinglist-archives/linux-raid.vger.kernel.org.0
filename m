Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD754693F
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jun 2022 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiFJPRQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jun 2022 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiFJPRP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 Jun 2022 11:17:15 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F436328
        for <linux-raid@vger.kernel.org>; Fri, 10 Jun 2022 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=F9Y3PvRbUNDbc1iZEfif52UhrZRYQGTV0jTtZ6jq7MI=; b=XuYxS6HpIXwB6bv92qpm/+qAyA
        x4ML+JtPLoDG+jIBcZwTlpByIZ8zfh+AwlQeIqIbVgTgXO8JTMul8w1frIltBrC5UWdAesP+AFM6R
        /PSFz8c8dytKGcIc9hGp/FLKPRvlMMBEjmJaP2F69soffU87YhD5U8tEfIMVlG+tem1CFv0T92YGB
        CMX135gK0VXfyfSUKtr3Lvs5TsnMLBmwlWNngKg+Si3SrMkmqwKeqJ8eJdTigZVOdIqoi+HCpn/td
        yW2QKpE3tn4p2vRATJOIDk98BTcmLUHgFJyJHb+YDSbr2oyU5mN/WOqkAdq3Dt90yV+MOwStJdMq0
        HdRlqmdA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nzgNs-003sIh-12; Fri, 10 Jun 2022 09:17:13 -0600
Message-ID: <db4f0f76-5d45-c5bb-bce3-88e252a33052@deltatee.com>
Date:   Fri, 10 Jun 2022 09:17:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-raid@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>
Cc:     Song Liu <song@kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>, Xiao Ni <xni@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Coly Li <colyli@suse.de>, Bruce Dubbs <bruce.dubbs@gmail.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220609211130.5108-1-logang@deltatee.com>
 <20220609211130.5108-15-logang@deltatee.com>
 <3b32656b-6d87-39df-625e-93bed6871022@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <3b32656b-6d87-39df-625e-93bed6871022@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, linux-raid@vger.kernel.org, jsorensen@fb.com, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, xni@redhat.com, himanshu.madhani@oracle.com, mariusz.tkaczyk@linux.intel.com, colyli@suse.de, bruce.dubbs@gmail.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH mdadm v1 14/14] tests: Add broken files for all broken
 tests
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org




On 2022-06-10 03:49, Guoqing Jiang wrote:
> Just to share some results from my  side, with 5.19-rc1 (revert my
> problematic patch of course), below tests failed.
> 
> /root/mdadm/tests/00raid0...
> /root/mdadm/tests/00readonly...
> /root/mdadm/tests/02lineargrow...
> /root/mdadm/tests/03r0assem...
> /root/mdadm/tests/03r5assem-failed...
> /root/mdadm/tests/04r0update...
> /root/mdadm/tests/04r5swap...
> /root/mdadm/tests/04update-metadata...
> /root/mdadm/tests/04update-uuid...
> /root/mdadm/tests/05r1-bitmapfile...
> /root/mdadm/tests/05r1-grow-external...
> /root/mdadm/tests/05r1-n3-bitmapfile...
> /root/mdadm/tests/05r1-re-add...
> /root/mdadm/tests/05r1-re-add-nosuper...
> /root/mdadm/tests/05r5-bitmapfile...
> /root/mdadm/tests/05r6-bitmapfile...
> /root/mdadm/tests/06wrmostly...
> /root/mdadm/tests/07autoassemble...
> /root/mdadm/tests/07changelevelintr...
> /root/mdadm/tests/07changelevels...
> /root/mdadm/tests/07layouts...
> /root/mdadm/tests/07revert-grow...
> /root/mdadm/tests/07revert-shrink...
> /root/mdadm/tests/07testreshape5...
> /root/mdadm/tests/09imsm-create-fail-rebuild...
> /root/mdadm/tests/09imsm-overlap...
> /root/mdadm/tests/10ddf-assemble-missing...
> /root/mdadm/tests/10ddf-create...
> /root/mdadm/tests/10ddf-fail-readd...
> /root/mdadm/tests/10ddf-fail-spare...
> /root/mdadm/tests/10ddf-fail-stop-readd...
> /root/mdadm/tests/10ddf-fail-twice...
> /root/mdadm/tests/10ddf-fail-two-spares...
> /root/mdadm/tests/10ddf-incremental-wrong-order...
> /root/mdadm/tests/19raid6auto-repair...
> /root/mdadm/tests/19raid6repair...
> 
> 05r1-bitmapfile failed which is probably because external bitmaps are only
> work on ext2 and ext3, I guess other 05*-bitmapfile failed due to the same
> reason.
Interesting, that would be good to document this failure some how.

> 01r5integ /01raid6integ  can't finish due to some reason.

I think that's addressed in patch 6 of this series. Though, I still see
random failures with those tests.

Logan
