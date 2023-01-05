Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3546F65F016
	for <lists+linux-raid@lfdr.de>; Thu,  5 Jan 2023 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAEPaW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Jan 2023 10:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjAEPaN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Jan 2023 10:30:13 -0500
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA25C914
        for <linux-raid@vger.kernel.org>; Thu,  5 Jan 2023 07:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672932602; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=WaGd0fHKQr1RIUldsaEofS5P7X2sSauIxT+1ntYIKAZTZXCE9rStZohLSd/rNOjyfqLwEXFAn5OwArlANw+HIDJJoTwTzoVCw7nDCre3IGtoRl6jM0APiYMvhh26TWG2cC2ISAGI1Tlg5W+btU9J7DoEN4AoB/HZs8A8QB+JzXs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1672932602; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=70NtL4zeii+gpS/0WNqaDStEXYKHmBjG3D+66IrPuTQ=; 
        b=f9flYbuykHEj7quR6T6qfz2lhlGg3piOfGXnvzj5N3pwXKDR1f81xXXFq/hc1L69zrgogIhlKSmLABVg8Wtrur5cdhg8SrzmQCIbVarGsS+DDr+4Kp8sxetxPlz9zF1nKxpYaUybgywFP0k121bVLly7XXTYzpUzx25/Dw6SVs4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1672932598941288.07981054174445; Thu, 5 Jan 2023 16:29:58 +0100 (CET)
Message-ID: <cbd3d749-f20d-7460-c506-172dd33444f9@trained-monkey.org>
Date:   Thu, 5 Jan 2023 10:29:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] manage: move comment with function description
Content-Language: en-US
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20230105053125.31388-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230105053125.31388-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/5/23 00:31, Kinga Tanska wrote:
> Move the function description from the function body to outside
> to obey kernel coding style.
> 
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
> ---
>  Manage.c | 72 ++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 28 deletions(-)
> 

Applied!

Thanks,
Jes


