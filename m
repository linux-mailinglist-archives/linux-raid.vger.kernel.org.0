Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A46FB855
	for <lists+linux-raid@lfdr.de>; Mon,  8 May 2023 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjEHUbT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 8 May 2023 16:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHUbR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 8 May 2023 16:31:17 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD15B9E
        for <linux-raid@vger.kernel.org>; Mon,  8 May 2023 13:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683577868; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=e8QIlUtH5zMSpOltrfMnRXJzVRCZx3BKDGWZTns5zezzs6FemsJ1rh9F2RVQ+VM6yKbTZuQkFp2PQl2gcWeZw6/UKApSe5gDb+qkpXAJTZVYrggoTyjTziqxvkpPWm9YwRJApSCqINRqHvwEFlqRePYyMHedFJ8X87s2phzktxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1683577868; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aOtsPjudCXxTHYq3NI3YeX1UWPvSbwfm8bd40VYDmVg=; 
        b=WTpbodU5kUO6isMIH1JXUGRC0CLtmpaek+OBHmEJUrfxp9FnlC+gnz4x5P3fPt7kqzwP7zWJXkHSDFP8ipS7Vzu0Yag1EH4VKX2YB/+l5BrpBn2JKFHPvMxxfaU02yB4C1z3Ee+v3ZuBuhdVeOC1js0aX5dJ7KNX6Zxdb0mSKmg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1683577867451129.80581580359103; Mon, 8 May 2023 22:31:07 +0200 (CEST)
Message-ID: <e6c5d541-4352-4d8d-aea7-fce1035e1042@trained-monkey.org>
Date:   Mon, 8 May 2023 16:31:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] Fix unsafe string functions
Content-Language: en-US
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20230420234658.367-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230420234658.367-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/20/23 19:46, Kinga Tanska wrote:
> This series of patches contains fixes for unsafe string
> functions usings. Unsafe functions were replaced with
> new ones that limites the input length.
> 
> Kinga Tanska (2):
>   Fix unsafe string functions
>   platform-intel: limit guid length
> 
>  mdmon.c          | 6 +++---
>  mdopen.c         | 4 ++--
>  platform-intel.c | 5 +----
>  platform-intel.h | 5 ++++-
>  super-intel.c    | 6 +++---
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 

Hi Kinga,

This conflicts after applying Mariusz' changes.

Mind rebasing?

Thanks,
Jes

