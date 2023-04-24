Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC936CF742
	for <lists+linux-raid@lfdr.de>; Thu, 30 Mar 2023 01:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC2XdH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Mar 2023 19:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjC2XdG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 Mar 2023 19:33:06 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA44C13
        for <linux-raid@vger.kernel.org>; Wed, 29 Mar 2023 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132784; x=1711668784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=APb6MZhJtx+BKA0st8ClsB22pp0y9Pqig7XgT6sLxmI=;
  b=ZdwYSlptuiiQ9m/XPcu72hjT1HkjkyJO6sAuXBEApjrKviKHBfgedsgK
   HaUq5j0oujVKNMlVFWcVDw1PqQqmqd3ZIvGAsrTLEN3U3G1F309ADcBrc
   vF9tk40fN7DQK0xck4VRVOlW1/OR4Fm5SL5udmNAQC4oW/wEyuCQ3GDCq
   oj55G6QyQhRoG5q83qQO8CTbfwOxhvW/NAwF3+LcVIANWs5iFMPQjCN98
   e4CxbLwhbIskb8u58cL68zpt6DnHvgSxLvNNLdpJQ7PJAz6T9btCAKxUe
   DR+BueXsW9o3343724cswkn84FnVkMHdziGXSOhFC3WRN6vsInoYk7Y3Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="331273896"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:33:00 +0800
IronPort-SDR: ueTj3XO/RxQNYx8pxUEWJUR6Wac8klGEn6tiVFLV3w1bnfRwJ4j5cEAxK8kk3QmhENM2Ro/Sj3
 /eVoTtRn0X2ptlPdn2g/EGdut+QGMIvHurXSiZhJ40pTbxhGcsii86AVxeEDK8KoGVYDVqRrJT
 2T8FXyz4suDVGGbleezz9QqmDs+d9hOXjPpz8zbzISy/uNxQ+1ZtWwUK0fGu9serGxZ6XKkYLX
 xl/ennIM0rmPLFoAJN3uZLVcIkyYNvR0RzpNxPyvTBQYRxVc35Ij6iphSdGVfUeUz9xKOSyBkV
 raI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:43:28 -0700
IronPort-SDR: zWZRmTE5kFcVyTvw7airUaizxhnejxpbhypYMA2WP1/2eCMrYn4I/2K8BIt5s7h6lCxSzEt+e2
 ImS4IcKj6EVV/sAmcsLr8gO1R7Wi4XjGzJDk09gfQ23M8j/GO26FM3kfJaKV9m4HxYpGbPYGdq
 CiXhbULyjy7lbJjAL333973rLycvypl88H3NhXeglXF5fktwbtWCIUQduA5VN33X1CKDOMSC4B
 UgmWngnmYsHFeEGXOhtT+TXFbH5ZmmPGtZvNkqKWoRRJ3qvEmR3j5twaHbtiVyk5u9HwUD7uq+
 CxQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:33:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2sl5d2Nz1RtVv
        for <linux-raid@vger.kernel.org>; Wed, 29 Mar 2023 16:32:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132779; x=1682724780; bh=APb6MZhJtx+BKA0st8ClsB22pp0y9Pqig7X
        gT6sLxmI=; b=EYPDnYeYBXvIPZU4yIKMtwumuioUV+FfuJ8fPXn7WoGbUKa7gK8
        7zyK1PX1ztxSUnflTcanHerZGll9o1DObBU+bLHw03SR356wtqMJKa09n0qcvgMS
        vZWj5aB/mrLRcKD+ZLaMWZavI1BMEp4d64WqsbKtIuhCcLZQRoyst2pdWD8Q3ya+
        ByQ8/RWystsxIVYmNeYNkH7soMStSvU7GBy5Z6O0BckSLdQn+7R88KD6YesLFa8q
        MYecYOCLxyWkIdz2hhL6x1SyTg5ktN5Fm733y5g6M9KOTaT0AtP36cbIMuLZhZ81
        iYFb15wzt+oKQjUeF0cNSTKYAFDWutLqRVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kIzlrgfcHGte for <linux-raid@vger.kernel.org>;
        Wed, 29 Mar 2023 16:32:59 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2sh28h9z1RtVm;
        Wed, 29 Mar 2023 16:32:56 -0700 (PDT)
Message-ID: <93331778-cc12-5d26-34a5-7cd8834a0309@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:32:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/19] md: raid5: use __bio_add_page to add single page to
 new bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The raid5-ppl submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked. For adding consecutive pages, the return is actually checked and
> a new bio is allocated if adding the page fails.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

