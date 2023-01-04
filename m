Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2365E0FD
	for <lists+linux-raid@lfdr.de>; Thu,  5 Jan 2023 00:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjADXjJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Jan 2023 18:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjADXjI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Jan 2023 18:39:08 -0500
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC2F42E0B
        for <linux-raid@vger.kernel.org>; Wed,  4 Jan 2023 15:39:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672875530; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=fBtI5iMbTXdIpVyQGTJTCuyFkxdM4mnYCk+jamaDuMce5ZDGb9jWctGjrvp/ah7X8FOS5Dktl5B8N4HhmLc4sWt32C1Y/mrafutcUdOHzr9T8DhtwNmVRcvcE2l0LjLECbk7TLoTG4bo/+iFYPe9gmO1yY+LhltN2gkKM0bickI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1672875530; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=raFaAdK0whXkw/kHcwmRbB4l0DFR17Hl+Befc7hXl2o=; 
        b=BM/P4OHvDo1FORSLjWbgX2pOPZSWIxdKopt/5LKv0CnSVv9VxAZtx+er8t55lc5MsllEYRdZ47Ogvjv/JPbHKKsdI903LrlNDOleg7hyEhnlJE1hsLIL5z/XHrHVapzWDzET1TMHrGrlcK/T1FMZw12LrPlxJog/AZc8BeCUGfY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1672875527802549.9313216156378; Thu, 5 Jan 2023 00:38:47 +0100 (CET)
Message-ID: <a61b4f7e-aded-c40f-c6ee-966e64142c8b@trained-monkey.org>
Date:   Wed, 4 Jan 2023 18:38:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/1] mdadm/udev: Don't handle change event on raw
 devices
Content-Language: en-US
To:     Xiao Ni <xni@redhat.com>
Cc:     pmenzel@molgen.mpg.de, ncroxon@redhat.com,
        linux-raid@vger.kernel.org
References: <20230104162920.18172-1-xni@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230104162920.18172-1-xni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/4/23 11:29, Xiao Ni wrote:
> The raw devices are ready when add event happpens and the raid
> can be assembled. So there is no need to handle change events.
> And it can cause some inconvenient problems.
> 
> For example, the OS is installed on md0(/root) and md1(/home).
> md0 and md1 are created on partitions. When it wants to re-install
> OS, anaconda can't clear the storage configure. It deletes one
> partition and does some jobs. The change event happens. Now
> the raid device is assembled again. It can't delete the other
> partitions.
> 
> So in this patch, we don't handle change event on raw devices
> anymore.
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>  udev-md-raid-assembly.rules | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied!

Thanks,
Jes


