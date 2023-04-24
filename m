Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357AF6CF71E
	for <lists+linux-raid@lfdr.de>; Thu, 30 Mar 2023 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjC2Xah (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Mar 2023 19:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC2Xag (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 Mar 2023 19:30:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF71A8
        for <linux-raid@vger.kernel.org>; Wed, 29 Mar 2023 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132635; x=1711668635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcC/1POcjLEFAIcEMXu/G07oqNzLEW5v95BGotn97v8=;
  b=joQQ0iUilmvzDeaKoQpm8XiBAYvULdUKBMTZqFpEBaUv4ga/6RxmiwgQ
   usBk07kjooMljqbKzptvURIQZ+l7nBFQFpPpoI4eyk2pxSf51v+Z8kpfG
   z2Np94di53/y7NnXYDEWKAGwvqbvyq8tqHvgFpj9QAQH0GacC7Qam9h9x
   57yhyz7VPATaIkiDzUqrw6P9pbDpp38dEUZZw8VH9faStPPT275GCqiPb
   3UNQmAoJ69AUpKJXdbMAQwec+xE5sH4yBt7E59W/Xp3cILHSzK059R3M7
   k/trTTVWbS5IrUO7Q9vklrvzL5juc1a736YrQGDpjc/DEYyOZ34CA/8J2
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648023"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:30:34 +0800
IronPort-SDR: 1STf595/ms8CZWAuwiC/RhAiWEiKsn+RnSPVrFqKUZjEE2raJttr+38nDad5LXSzZc7ArqkhPq
 2+JWi3xbstVUfH2mDr2WG3rkeb71Iio7kwAvmFtebQQFN7PBOflzVey2cGNVXqtxdrzdRSGv0s
 Nafy1054u2zM+UCElf5VtDI5z+ErSIcrI5TcpUT293Y66GDrJ3RQ9HMGQ64QkVbDtzR2mE9xhd
 uhRXPGgwzW/6H+4Dxb2mB3MmhmiXKCQ64sPkyjQ0GnMsdR3aSUZhn8Uld83/8fQPdO1XQ1sBPf
 Uoo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:46:42 -0700
IronPort-SDR: YX3kKO8c+/dKGHWQZxrS8lTpzlmaOvSs5y6kVNOft5sQsbeVKKZA8rHNyCRYc0E5MVK1L7StSt
 dw/RZJEmic8kjEmK0hOSm3BomcPDliP2l6m4QpKkstgWIowjxlGuLbZCmDBHFQTTDt7WIF+rzx
 a1sDmfSb3lAP9eJ3P489cVOM88NP6EPJlRcvq6TU+LTd6nKasHd4a7cyDgr08ZHnl2WtWtWxLM
 NFRvIvsD+pPReMoq4PHBxP2aE57BiotcAi8K4hopKmmZjj3GLtv3ZeJTqVxBIqiILCRdMz14At
 pFs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:30:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2px4TGVz1RtVv
        for <linux-raid@vger.kernel.org>; Wed, 29 Mar 2023 16:30:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132632; x=1682724633; bh=gcC/1POcjLEFAIcEMXu/G07oqNzLEW5v95B
        Gotn97v8=; b=PoG50HzSd9Sqa3seuCovhxqh1ZZj1r8rRM7hqMVC1Pzrs/Mo8xn
        s2FvS3V47vL7XwXAfrvFNgGFN1/MXXWe6cQDyUrs+uLkmyMiu1ovYiEFYowQ7TUT
        wfa4tqt19MVPZuqNtDeGKyc7ne+kGMaZwH8cyCYGntsekO4jGotJoRJD6DLiPGwu
        os4aw6OxIJRE6l+V9kLg+RXaflepH+nb+xTPHi+u7Tkml5O8gOxvKnBM17WRQIbv
        mQdVhvyFEVMsEnqG8QNoHfx3vNLFW7ITiVKbEkKnZMEik4uxC9t7Y7t1oltQZe94
        VoGnC9Q9Nzo4gA9ee6x9ZTsaAiXIUcMppRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gxF9_YD9O2KR for <linux-raid@vger.kernel.org>;
        Wed, 29 Mar 2023 16:30:32 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2pt0C0hz1RtVm;
        Wed, 29 Mar 2023 16:30:29 -0700 (PDT)
Message-ID: <4e4aa0e7-f222-f269-1b5c-1abb3a7179e7@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:30:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/19] dm: dm-zoned: use __bio_add_page for adding single
 metadata page
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
 <4a2c46dc0e217a9fb6b9f32d460498a5feb8b67b.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4a2c46dc0e217a9fb6b9f32d460498a5feb8b67b.1680108414.git.johannes.thumshirn@wdc.com>
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
> dm-zoned uses bio_add_page() for adding a single page to a freshly created
> metadata bio.
> 
> Use __bio_add_page() instead as adding a single page to a new bio is
> always guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() __must_check
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

