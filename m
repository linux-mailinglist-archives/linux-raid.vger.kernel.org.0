Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE926A85B7
	for <lists+linux-raid@lfdr.de>; Thu,  2 Mar 2023 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjCBQAn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Mar 2023 11:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBQAl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Mar 2023 11:00:41 -0500
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C454DE3E
        for <linux-raid@vger.kernel.org>; Thu,  2 Mar 2023 08:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677772835; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Up4jQYARID7/e2euIrfZ2fpgnp71kBeVdpcVFfNvN+63unPyF/BoyLGsPDgMaVns/rO3KhtYdQ70l2XEinQaVis8Tb2zha88xb7s4JRVG0ZUYb2fhD1jRZH5f+SmCf+MLsztF6+FTNUppigidCCuuMTrYnwF6VAjawUcFsnrG7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1677772835; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jB0OolznKkfosd7l7ZtnGMsds4K6aFyd5+IUYYzcwR8=; 
        b=DKb6Rk9OY6qX8fdSY0EuBbHsebo5bsavaR66fP3IXVYHGoNCoY1bybatDVHxxz4Xhod/uMmNs3UG6D6YxmOvGTm3v85ezUG1ZJ982TZ4aVlzg7XT2vZHivuz9g/Emp6gEHaNjRGwk0URe7pyXczv9yheCFwndpoUe9KnB+LSr4c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1677772833308566.430568647691; Thu, 2 Mar 2023 17:00:33 +0100 (CET)
Message-ID: <36ac759b-9505-aa7d-1efc-aaeb41dcb3eb@trained-monkey.org>
Date:   Thu, 2 Mar 2023 11:00:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/8] Mdmonitor refactor and udev event handling
 improvements
Content-Language: en-US
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>,
        linux-raid@vger.kernel.org
References: <20230202112706.14228-1-mateusz.grzonka@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230202112706.14228-1-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/2/23 06:26, Mateusz Grzonka wrote:
> Along the way we observed many problems with current approach to event handling in mdmonitor.
> It frequently doesn't report Fail and DeviceDisappeared events.
> It's due to time races with udev, and too long delay in some cases.
> While there was a patch intending to address time races with udev, it didn't remove them completely.
> This patch series presents alternative approach, where mdmonitor wakes up on udev events, so that
> there should be no more conflicts with udev we saw before.
> 
> Additionally some code quality improvements were done, to make the code more maintainable.
> 
> v2:
> Fixed mismatched comment style and rebased onto master.
> 
> v3:
> Resend to cleanup on patchwork.
> 
> Mateusz Grzonka (8):
>   Mdmonitor: Make alert_info global
>   Mdmonitor: Pass events to alert() using enums instead of strings
>   Mdmonitor: Add helper functions
>   Add helpers to determine whether directories or files are soft links
>   Mdmonitor: Refactor write_autorebuild_pid()
>   Mdmonitor: Refactor check_one_sharer() for better error handling
>   Mdmonitor: Improve udev event handling
>   udev: Move udev_block() and udev_unblock() into udev.c

Hi Mateusz,

1-6 applied, 7+8 don't build on Fedora 36.

Thanks,
Jes

