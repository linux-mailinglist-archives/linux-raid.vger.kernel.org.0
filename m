Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6355B22E6
	for <lists+linux-raid@lfdr.de>; Thu,  8 Sep 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIHP5R (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 8 Sep 2022 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIHP5R (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 8 Sep 2022 11:57:17 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F87D740B
        for <linux-raid@vger.kernel.org>; Thu,  8 Sep 2022 08:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662652625; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=jUOfy2DBdH1Jc+8PlpvshDtMwto/uECYk7vIwzGPRvs7oOWys1xsNfpUuLTeyAF96rh1ksah8xsiDgHsE/etKjOs5UQz13J/JQ8urVSXE4WFEbPbgr/jRhRe5WoQMWMBD/zhSNbU8JgeGX5KxMLAP/WORKJXEGmWOSpXavo1pFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1662652625; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xf8nusNxM8H7Ea99S83GEndZ/n6igAC+ltk1QQHu+CU=; 
        b=GWzs2j+NKqx0c4arCvVfj2VHLCKtwIk6rYveO/VmDFYd6+KV0f6PDSSC9i7QWc0YWeMUqT3Z5sLs3x2bq/sQZ85d1cyYEPc4BSaGAFvpenEv7Vi9MTZKNoER3JvTow6TTw65FkkTLvTA6Zh06R11IoL5JOh86YcXJ37xOSYcg4I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [100.109.63.17] (163.114.130.7 [163.114.130.7]) by mx.zoho.eu
        with SMTPS id 1662652620963608.021443150562; Thu, 8 Sep 2022 17:57:00 +0200 (CEST)
Message-ID: <f3ddb157-0479-fc9c-54f7-def2d620cb1e@trained-monkey.org>
Date:   Thu, 8 Sep 2022 11:56:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] mdadm: Correct typos, punctuation and grammar in man
Content-Language: en-US
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>,
        linux-raid@vger.kernel.org, Wols Lists <antlists@youngman.org.uk>
References: <20220812145212.16138-1-mateusz.grzonka@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220812145212.16138-1-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/12/22 10:52, Mateusz Grzonka wrote:
> Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
> Reviewed-by: Wol <anthony@youngman.org.uk>
> ---
>  mdadm.8.in | 178 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 88 insertions(+), 90 deletions(-)
> 

Applied!

Thanks,
Jes


