Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8658C18331E
	for <lists+linux-raid@lfdr.de>; Thu, 12 Mar 2020 15:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCLObE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Mar 2020 10:31:04 -0400
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17367 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgCLObE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Mar 2020 10:31:04 -0400
Received: from [100.109.80.229] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1584023458128352.92232910569646; Thu, 12 Mar 2020 15:30:58 +0100 (CET)
Subject: Re: [PATCH] imsm: Correct minimal device size.
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20200311144013.24424-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7a4fdbc6-a3a3-2bda-e3dd-46fb214bc82b@trained-monkey.org>
Date:   Thu, 12 Mar 2020 10:30:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311144013.24424-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/11/20 10:40 AM, Blazej Kucman wrote:
> Check if given size of member drive is not less than 1 MibiByte.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>  super-intel.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied!

Thanks,
Jes

