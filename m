Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30CF59E83A
	for <lists+linux-raid@lfdr.de>; Tue, 23 Aug 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiHWRB7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Aug 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344395AbiHWRBR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Aug 2022 13:01:17 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CFA8D3CA
        for <linux-raid@vger.kernel.org>; Tue, 23 Aug 2022 07:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661263814; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=XGdRhwuNDUcALWVCDPE+MHbQ8i1M505VV+bj2cuQGjSknK97SRd10jdzeZfAuko5WMofmd6QA5F5Igbe0BdmnbsNgVLRYB4ZDcc4wzeKD/ze94rQtn3VjyHJp9GoLQ9PjoPdPNGsmXOkPNK+sXYbPfW/PyNTgE8H05eBmxY+LC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1661263814; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0FBY+icpjMWIvZtEXB+i6HkSTjDhcYogxBwstvyneIk=; 
        b=MfmthR27H+fLUBO+81pEEFhm08BvePCGsfRjf2wHX8k433qWRUIJelckfOJPcazO41qFMXWwbeM56uWMJ+ONeTFgZXqjFgfyBGdnx8JN/s1VDv1n/+ulCT0LotTrZ5V/pTRNTAvMxOyjUAvDRS+P6Rk4K5kVTn+yWH+oJeVdW3Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.78] (pool-72-69-213-125.nycmny.fios.verizon.net [72.69.213.125]) by mx.zoho.eu
        with SMTPS id 1661263811500987.0104850973975; Tue, 23 Aug 2022 16:10:11 +0200 (CEST)
Message-ID: <3cec4466-1a13-d4f0-eac4-c62afecf9ddb@trained-monkey.org>
Date:   Tue, 23 Aug 2022 10:10:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mdadm] mdadm: Don't open md device for CREATE and ASSEMBLE
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        Jes Sorensen <jsorensen@fb.com>, Song Liu <song@kernel.org>,
        Coly Li <colyli@suse.de>
References: <20220714223749.17250-1-logang@deltatee.com>
 <150ffbb2-9881-9c1f-cc5e-331926b8e423@linux.dev>
 <20220719132739.00001b94@linux.intel.com>
 <dcaf3af0-95c5-bf9a-bd2c-9c6a60c67e97@deltatee.com>
 <20220720102015.00000bd0@linux.intel.com>
 <c3810d35-c918-e128-5184-52cef5710422@trained-monkey.org>
 <20220823160718.00004367@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220823160718.00004367@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/23/22 10:07, Mariusz Tkaczyk wrote:
> On Tue, 23 Aug 2022 09:49:11 -0400
> Jes Sorensen <jes@trained-monkey.org> wrote:

>> Hi Mariusz,
>>
>> Just to recap on this, do you support applying this patch as is, or
>> should we wait for the longer term fix you were mentioning?
>>
> Hi Jes,
> This patch looks good. Please apply next one version:
> https://lore.kernel.org/linux-raid/20220727215246.121365-3-logang@deltatee.com/

Great, thanks for the quick response.

Applied!

Thanks,
Jes

