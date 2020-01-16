Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1B13F550
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 19:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbgAPSza (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 13:55:30 -0500
Received: from sender21-op-o12.zoho.eu ([185.172.199.226]:17337 "EHLO
        sender21-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbgAPSz3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jan 2020 13:55:29 -0500
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579200665386615.8527397930729; Thu, 16 Jan 2020 19:51:05 +0100 (CET)
Subject: Re: [PATCH] imsm: Disable --dump/--restore options
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20200110105927.5965-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <95c22f71-e85b-cdfd-8b07-6bddf135d8cc@trained-monkey.org>
Date:   Thu, 16 Jan 2020 13:51:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110105927.5965-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/10/20 5:59 AM, Blazej Kucman wrote:
> Currently --dump/--restore are not working correctly.
> Temporarily disable this functionally for IMSM
> to avoid unexpected behaviors and side effects.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>

I dislike leaving the code in there dead, especially as it's not clear
when this will get fixed.

Should we just remove it, or do you have plans to fix this in the near
future?

Thanks,
Jes


