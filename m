Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56D502398
	for <lists+linux-raid@lfdr.de>; Fri, 15 Apr 2022 07:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbiDOFNg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 Apr 2022 01:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbiDOFM5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 Apr 2022 01:12:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129C8566F
        for <linux-raid@vger.kernel.org>; Thu, 14 Apr 2022 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649999399; x=1681535399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y4PW6r0NI=;
  b=II5E1mJHriGuluqm5xuP/x9IMQhQaQSi70NXkaE/E269kJ+k6SJGDllV
   2boMvLU/NqnS6YcUfrbbCOh/eQdhXP6Hx6tXaUTP75PFKVPVXKughlQHW
   /60wfXOkml0hX0w0VRsV8AOqGlZdMWzQyasQaYNYADlRXHhTy35dO8grX
   OY6J4K4jD9Ih72Zoh0gq/nLlA3lOGLrFOPSJz9Ifgr3Nj/4WS8CA6eP82
   pyOa9VkYJH6cE3IlO1qkC2Ve8vTjhANzptbEama0E5UT16W55E8oK23Ck
   VkfPdSBjmaSCJikMl7Ba+FcaYDv1kbTeD/KnWK5SmYvO4XR/TQs1M50+l
   w==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; 
   d="scan'208";a="202830522"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 13:09:50 +0800
IronPort-SDR: evsY1uawE+QkmdvKczLg5VjvSLNjbQDIuP89uu2dq2FWnIrTHTAqMGkKde1LdDpY2FEfjI+Iba
 ra4lb55RhBU8+sU6BXubdKMIZRByzLaxGbYWVBt/QWpYMMr62+ko4pl+j+hgpyu4/8WmIW7d/2
 MOrNUXpZciZEkllgtkGl8N+nPnepAUb9O8ZIiKrTPN5X+XRNs+fIH++4Az5xu+H0VkN2bcJGl0
 3SaL5EEC6BdUHhWnGTal8AkMgFtJmrrd3ombbtphh0KQqMAOp6m4qD7dIuuSqUylzVZGGiy/LJ
 FHVbHCupheL5xxjUxs7ncFxb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 21:41:01 -0700
IronPort-SDR: CrXRR18vIjsLEoVZjByk89Mk5h7fUOypGt35ijMym0iWjOCoh0K2KFe9G6u7hSBBNE9Oy+rXfQ
 q4fzJvqqUrur15FYkf+OJfVN2Z4CS88RnUtA9z3GbWmz/EYtt58G6dzNx2BsAf9JCYuCkoDFjb
 TI5RThHIu5E80JfqyS7lXpgOR62HRimwkv7ZbbjUjNH5FxfTVNaIOzkSY2oZ7TCEn8cJ8ytxQ2
 vewWyjSVIp1ZmzZEHpTPCPr+N/gLK500RygMhgidncTg6rRm0fFbCR5l1wBqMPdhqbiWK+cj6Y
 Ji4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 22:09:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KfksT296jz1SVp6
        for <linux-raid@vger.kernel.org>; Thu, 14 Apr 2022 22:09:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649999388; x=1652591389; bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y
        4PW6r0NI=; b=D8kdC3rz3pjqnugRL+G3XHXL6Ng78iZSZCza4fEMQpTN/xdgY6D
        ndgbPRv8Ii6RTniwYP01qFwFHzH91r1LoAWx6xGwWEN+Qsp3Ex2YpjoRKlcblFjc
        7yjQF4oBeK9egOucgCIrr2m+tKTIlJA0mcKIvKIgWCVnz5iEJtEs0vxeju2wZT96
        jtBkpdSzig+EY3uiGMCOqAfDYf4ob5UMdfn63Y/7o6floZGBngeQCZ8K+n+vY3d5
        lYsSP/0Lz/G5amM7P4+yygELabSZDZHGZG/YfdQpCLMrO4FBxFoQbF9pdD3HvN17
        o1OWdE4/X82Vq8Fyie48I/oIcM5G/NLyIZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rREy_CShtthx for <linux-raid@vger.kernel.org>;
        Thu, 14 Apr 2022 22:09:48 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KfksM3c9Fz1Rvlx;
        Thu, 14 Apr 2022 22:09:43 -0700 (PDT)
Message-ID: <62ebc311-e5ef-cea5-5236-0c83d1a3eb64@opensource.wdc.com>
Date:   Fri, 15 Apr 2022 14:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/27] mm: use bdev_is_zoned in claim_swapfile
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-11-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220415045258.199825-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/15/22 13:52, Christoph Hellwig wrote:
> Use the bdev based helper instead of poking into the queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 63c61f8b26118..4c7537162af5e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2761,7 +2761,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  		 * write only restriction.  Hence zoned block devices are not
>  		 * suitable for swapping.  Disallow them here.
>  		 */
> -		if (blk_queue_is_zoned(p->bdev->bd_disk->queue))
> +		if (bdev_is_zoned(p->bdev))
>  			return -EINVAL;
>  		p->flags |= SWP_BLKDEV;
>  	} else if (S_ISREG(inode->i_mode)) {

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
