Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CD13F575
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 19:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgAPS4d (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 13:56:33 -0500
Received: from sender21-op-o12.zoho.eu ([185.172.199.226]:17341 "EHLO
        sender21-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389154AbgAPS4c (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jan 2020 13:56:32 -0500
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579200988689556.0273684842718; Thu, 16 Jan 2020 19:56:28 +0100 (CET)
Subject: Re: [PATCH] imsm: Update grow manual.
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20200116083444.4971-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <ef347d98-1572-018f-7674-4a5933513f9c@trained-monkey.org>
Date:   Thu, 16 Jan 2020 13:56:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116083444.4971-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/16/20 3:34 AM, Blazej Kucman wrote:
> Update --grow option description in manual, according to
> the supported grow operations by IMSM.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>  mdadm.8.in | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied!

Thanks,
Jes



