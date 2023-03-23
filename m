Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77546C6E08
	for <lists+linux-raid@lfdr.de>; Thu, 23 Mar 2023 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCWQpz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 Mar 2023 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjCWQpY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 23 Mar 2023 12:45:24 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509C6A60
        for <linux-raid@vger.kernel.org>; Thu, 23 Mar 2023 09:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679589880; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=JUhO8qVj+FoTE8+0HCbUzcPm31hinpa1TaIHzYrs59k1h6T+U89CTtPOYTr2F94TI8A0uivqyBpi5EjVydjI6jEGsyty7Se8Fw9c2v3fh5GB2+qxrk/BXOsPmG10Ok1xlaKs4StI5QFgs6us01nFJX5H3E4Z1NdikrmlP8rQB98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1679589880; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=FrcETDle667AL7jOZgZiWufw69voboU3fkQ4rEKQf2c=; 
        b=XPoP/niNJscebZ7KBW3HpQ6Et0kVI45Bp9rqrVDdX7XFiOThmE542XhoJ1B8hO4n609ypmde9nrqkMzlIfSYqg2wN64LWortzPp0U3JDD76VAwW7I4nYw0+s95w5LU3zCESazcEXzcJcUE5FCUAY4JVuGcd4jkUn3QNQ82/a4UY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1679589878945367.51907590252256; Thu, 23 Mar 2023 17:44:38 +0100 (CET)
Message-ID: <0073fd1a-d998-4ce8-83b4-bbf963afce58@trained-monkey.org>
Date:   Thu, 23 Mar 2023 12:44:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] Create: Fix checking for container in update_metadata
Content-Language: en-US
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>,
        linux-raid@vger.kernel.org
References: <20230323115000.25364-1-mateusz.grzonka@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230323115000.25364-1-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/23/23 07:50, Mateusz Grzonka wrote:
> The commit 8a4ce2c05386 ("Create: Factor out add_disks() helpers")
> introduced a regression that caused timeouts and udev failing to create
> links.
> 
> Steps to reproduce the issue were as following:
> $ mdadm -CR imsm -e imsm -n4 /dev/nvme[0-3]n1
> $ mdadm -CR vol -l5 -n4 /dev/nvme[0-3]n1 --assume-clean
> 
> I found the check for container was wrong because negation was missing.
> 
> Fixes: 8a4ce2c05386 ("Create: Factor out add_disks() helpers")
> Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
> ---
>  Create.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied!

Thanks,
Jes


