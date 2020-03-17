Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E47189024
	for <lists+linux-raid@lfdr.de>; Tue, 17 Mar 2020 22:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQVMh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Mar 2020 17:12:37 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17515 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVMh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Mar 2020 17:12:37 -0400
Received: from [100.109.44.175] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1584479552154823.8926865177608; Tue, 17 Mar 2020 22:12:32 +0100 (CET)
Subject: Re: [PATCH] imsm: support the Array Creation Time field in metadata
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200317092012.7093-1-artur.paszkiewicz@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <9df05f7e-72ef-788e-9770-18d1041136b7@trained-monkey.org>
Date:   Tue, 17 Mar 2020 17:12:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317092012.7093-1-artur.paszkiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/17/20 5:20 AM, Artur Paszkiewicz wrote:
> Also present its value in --examine and --examine --export.
> 
> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> ---
>  super-intel.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Applied!

Thanks,
Jes

