Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEB54B38E
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jun 2022 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiFNOin (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jun 2022 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356353AbiFNOii (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jun 2022 10:38:38 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282F1A811
        for <linux-raid@vger.kernel.org>; Tue, 14 Jun 2022 07:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655217461; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=NT4teXmd1y6M4btOaRV4s0SuoedWvl2578Skn9FOtFAmctB0H0mpoA/MOAsE4uaI2HH6IRa8GEuT92l8bAzvxIoixDz9esiV6tOxigD0pCczOAUb4kX2oxspBzCKuGohnLJ43lV8RUxO6x+f7DCHXl354p2siQE/1XrVNPBCeNw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1655217461; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UpUtaGykrcIJ5fd3kBPpr+ASymwZtz6kHIT3NpXalXE=; 
        b=S+H0E4nGpDZ05OgJ7kLeAEbd40GwSm/+B9wN4aViAId0ihcewzuXBRHJ/tyn8EWptaZGSRSLiAf8Fx+e0L+nhKAF2xL0+V2iFsdBO3f+CdfQni+ZPlsz2czNHSTFB0irgJjt6E1+XVR/ZJA+Ldh5W/puoE2JN/WCpTvZEo+rxwk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [IPV6:2620:10d:c0a8:1102::1844] (163.114.130.3 [163.114.130.3]) by mx.zoho.eu
        with SMTPS id 1655217459573663.3795431738586; Tue, 14 Jun 2022 16:37:39 +0200 (CEST)
Message-ID: <ab3ca493-4ef0-9117-2b9a-cceb9fd3aaff@trained-monkey.org>
Date:   Tue, 14 Jun 2022 10:37:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/2] Mdmonitor: Improve logging method
Content-Language: en-US
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, pmenzel@molgen.mpg.de
References: <20220606103213.12753-1-kinga.tanska@intel.com>
 <20220606103213.12753-3-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220606103213.12753-3-kinga.tanska@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/6/22 06:32, Kinga Tanska wrote:
> Change logging, and as a result, mdmonitor in verbose
> mode will report its configuration.
> 
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
> Signed-off-by: Oleksandr Shchirskyi <oleksandr.shchirskyi@intel.com>
> ---
>  Monitor.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 

Applied,

Thanks,
Jes


