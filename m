Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6A16B18F
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 22:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBXVIo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 16:08:44 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17353 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBXVIo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 Feb 2020 16:08:44 -0500
Received: from [172.30.220.169] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1582578521320322.0610918748499; Mon, 24 Feb 2020 22:08:41 +0100 (CET)
Subject: Re: [PATCH] imsm: pass subarray id to kill_subarray function
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20200219095449.29443-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <b3730e05-c8e6-78fc-e852-14042c0008c5@trained-monkey.org>
Date:   Mon, 24 Feb 2020 16:08:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219095449.29443-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/19/20 4:54 AM, Blazej Kucman wrote:
> After patch b6180160f ("imsm: save current_vol number")
> current_vol for imsm is not set and kill_subarray()
> cannot determine which volume has to be deleted.
> Volume has to be passed as "subarray_id".
> The parameter affects only IMSM metadata.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>  Kill.c        | 2 +-
>  mdadm.h       | 3 ++-
>  super-ddf.c   | 2 +-
>  super-intel.c | 9 ++++-----
>  4 files changed, 8 insertions(+), 8 deletions(-)

Applied!

Thanks,
Jes

