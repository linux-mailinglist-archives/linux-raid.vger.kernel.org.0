Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9125189025
	for <lists+linux-raid@lfdr.de>; Tue, 17 Mar 2020 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQVMy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Mar 2020 17:12:54 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17519 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVMx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Mar 2020 17:12:53 -0400
Received: from [100.109.44.175] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1584479570528286.56832337375874; Tue, 17 Mar 2020 22:12:50 +0100 (CET)
Subject: Re: [PATCH] imsm: show Subarray and Volume ID in --examine output
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200317092103.7200-1-artur.paszkiewicz@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <6bf91263-04a7-b517-92df-640f94518ad2@trained-monkey.org>
Date:   Tue, 17 Mar 2020 17:12:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317092103.7200-1-artur.paszkiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/17/20 5:21 AM, Artur Paszkiewicz wrote:
> Show the index of the subarray as 'Subarray' and the value of the
> my_vol_raid_dev_num field as 'Volume ID'.
> 
> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> ---
>  super-intel.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied!

Thanks,
Jes

