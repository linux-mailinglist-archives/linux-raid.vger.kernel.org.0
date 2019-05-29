Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B012DAE0
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfE2KfR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 06:35:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42616 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfE2KfR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 May 2019 06:35:17 -0400
Received: from [86.177.149.27] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hVvvP-0007I7-Cm; Wed, 29 May 2019 11:35:16 +0100
Subject: Re: [RFC PATCH V2] mdadm/md.4: add the descriptions for bitmap sysfs
 nodes
To:     Guoqing Jiang <gqjiang@suse.com>, jes.sorensen@gmail.com
References: <20190527040523.24032-1-gqjiang@suse.com>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5CEE6062.1090604@youngman.org.uk>
Date:   Wed, 29 May 2019 11:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20190527040523.24032-1-gqjiang@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 27/05/19 05:05, Guoqing Jiang wrote:
> +This variable sets a limit on the number of concurrent background writes,
> +the valid values are 0 to 256, 0 means that write-behind is not allowed,
> +while any other number means it can happen.  If there are more write requests
> +than the number, new writes will by synchronous.

Is this a byte-wide or an integer field? 0 to 256 is an odd number -
surely it should be 255 (0xff)?

Cheers,
Wol
