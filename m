Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33F065D73A
	for <lists+linux-raid@lfdr.de>; Wed,  4 Jan 2023 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjADP0a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Jan 2023 10:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjADP0a (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Jan 2023 10:26:30 -0500
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194128FED
        for <linux-raid@vger.kernel.org>; Wed,  4 Jan 2023 07:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672845982; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=PWr8X1WHaT3DI/lAStGgz86UQCvr9r4Af+Uff68sk3TUYN+dWDs7setQKd6Stg0s5wsTbWoDFM5hjF4+2gZ+7sh4YTwxrFK/tx7ELkrVMTLzb768UfSPIIRelBR4OOuT/DXzJ7iJaTGzSwrz4CXZ6DE0L84cAiNsBwzZcBABcPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1672845982; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=gfM3qzvlKCLj07qPmWwomleOLI2Pwugl3sc2dnRnJYg=; 
        b=Q5fP772UweNsS8aj7F3NoYV5patS2U1FlPhnK6KI6Z/qclyC1zC+pLFXqPc4xVezT87Gl1D6wXAA9gsQDXyWrhPYqp8NIXIOyZvN2UEBbiyOcGZzPqYCtbSmcxYzwbqPgRNUH9ffvTWhufpuKZn96s9Llt15xXHlsi9O1VZG33g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1672845980439581.0839126399422; Wed, 4 Jan 2023 16:26:20 +0100 (CET)
Message-ID: <e95bd797-06b9-7f73-19a2-fab0c76634bc@trained-monkey.org>
Date:   Wed, 4 Jan 2023 10:26:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] mdmon: fix segfault
Content-Language: en-US
To:     Mateusz Kusiak <mateusz.kusiak@intel.com>,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20230102084622.29154-1-mateusz.kusiak@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230102084622.29154-1-mateusz.kusiak@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/2/23 03:46, Mateusz Kusiak wrote:
> Mdmon crashes if stat2devnm returns null.
> Use open_mddev to check if device is mddevice and get name using
> fd2devnm.
> Refactor container name handling.
> 
> Signed-off-by: Mateusz Kusiak <mateusz.kusiak@intel.com>
> ---
>  Makefile |  2 +-
>  mdmon.c  | 26 ++++++++++++--------------
>  2 files changed, 13 insertions(+), 15 deletions(-)
> 

Applied!

Thanks,
Jes


