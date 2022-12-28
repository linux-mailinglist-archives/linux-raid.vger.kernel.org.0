Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515896579D9
	for <lists+linux-raid@lfdr.de>; Wed, 28 Dec 2022 16:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiL1PFY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 28 Dec 2022 10:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiL1PFX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 28 Dec 2022 10:05:23 -0500
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587E13D4B
        for <linux-raid@vger.kernel.org>; Wed, 28 Dec 2022 07:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672239914; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=ASMKwK4ZXV/HgUk8WDH/mQFbxoqFLxx3StIDBux7+9hU1SoRQm8r0vINm+CM4rSUqvs5aNMi0UMcrZaQf45ZPavNNSXU7EBn0DDf+8QJPp5Iqf+wkSIXXyd63Gzrp/38aE5XY3s1ItEQHc58/UoMYNDMtgDvPvBz0hvJpkJAUeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1672239914; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Jv4rPVpSgwAcHhCa5aUiuLZsPj8wLSjdfP/NtClArEg=; 
        b=Kq3t/w69zY90y8UI3Md7IDmPnBXd7hNdbIIFG8CKjM2hYYe2dgWxjJdsuo/pKX7AxfqhxZTuT47mfjcYUt39HP74Hd4NKKCALDlsQvsVBoAGfamjY/t4kJylzQnLdFGeeCTDGcywyePQUPosW1lGgcLb63SEyTGbjHTsITDQXDg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.78] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1672239911770656.8150144067741; Wed, 28 Dec 2022 16:05:11 +0100 (CET)
Message-ID: <764489a5-1344-0692-bb3b-29ed8299c04f@trained-monkey.org>
Date:   Wed, 28 Dec 2022 10:05:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] mdadm: create ident_init()
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, colyli@suse.de
Cc:     linux-raid@vger.kernel.org
References: <20221221115019.26276-1-mariusz.tkaczyk@linux.intel.com>
 <20221221115019.26276-2-mariusz.tkaczyk@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20221221115019.26276-2-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/21/22 06:50, Mariusz Tkaczyk wrote:
> Add a wrapper for repeated initializations in mdadm.c and config.c.
> Move includes up.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  config.c | 45 +++++++++++++++++++++++++++++----------------
>  mdadm.c  | 16 ++--------------
>  mdadm.h  |  7 +++++--
>  3 files changed, 36 insertions(+), 32 deletions(-)

Applied!

Thanks,
Jes


