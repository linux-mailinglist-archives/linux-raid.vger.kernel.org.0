Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C359C417
	for <lists+linux-raid@lfdr.de>; Mon, 22 Aug 2022 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiHVQ2Q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Aug 2022 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHVQ2P (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Aug 2022 12:28:15 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F040E35
        for <linux-raid@vger.kernel.org>; Mon, 22 Aug 2022 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=Jr7dN9wQ/ig0lFC44sXi0K9sQQ6GWFeJw1WtZh9Mv0U=; b=sm4kSehe4QhxYLyrijw9/CK74W
        K6ubWqobfFMj9vuYKCT53RC3h38Clq/4avOuzRdC7V5z44xuxQdz68Mx32WBaj2/WOzGArCyx/tuN
        Qw2iTHYcE2NmkdnDXwOItEcdLXOBrCjToAILOSyVay8GYvJNk8HPh2jjKSUH1j4f6uUub8HjM3fDe
        yji0IpfrwMZRp/Gp+B11okVvOaQq2eS8Mr2Hcf6oQDcjv6aLK0TEGWFvsgVGgKxLwn5EzuYefTu30
        hQqk7Kn1ZVEOWBIb0gmvRjau78Rwmvhw0cZY/8JNIJXYR4csSwTNlDUS1N4fzEbjyMM/prgiImhcO
        8PCmFhAA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oQAHZ-005gpj-Ch; Mon, 22 Aug 2022 10:28:10 -0600
Message-ID: <b4e29397-3150-8580-86aa-f23cee893ee6@deltatee.com>
Date:   Mon, 22 Aug 2022 10:28:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-CA
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <e05c4239-41a9-d2f7-3cfa-4aa9d2cea8c1@deltatee.com>
 <CAPhsuW4=aa08-XGDtoQ3rLb8r-5t9Q7VwwFgGbTTt-xbkzEW8Q@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW4=aa08-XGDtoQ3rLb8r-5t9Q7VwwFgGbTTt-xbkzEW8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: song@kernel.org, linux-raid@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: raid5 Journal Recovery Bug
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 2022-08-22 01:04, Song Liu wrote:
> Could you please add some printk so that we know which condition triggered
> handle_stripe_fill() here:
> 
>         if (s.to_read || s.non_overwrite
>             || (s.to_write && s.failed)
>             || (s.syncing && (s.uptodate + s.compute < disks))
>             || s.replacing
>             || s.expanding)
>                 handle_stripe_fill(sh, &s, disks);
> 
> This would help us narrow down to the exact condition. I guess it is
> "(s.to_write && s.failed)", but I am not quite sure.

Ok, I hit this bug on a stripe and got these values for the call:

  to_read       = 0
  non_overwrite = 0
  to_write	= 0	
  failed	= 1
  syncing	= 1
  uptodate	= 2
  compute	= 0
  disks		= 3
  replacing	= 0
  expanding	= 0

So it's actually the "(s.syncing && (s.uptodate + s.compute < disks))"
condition that is getting hit.

Thanks,

Logan
