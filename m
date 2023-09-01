Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330979008B
	for <lists+linux-raid@lfdr.de>; Fri,  1 Sep 2023 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbjIAQLz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Fri, 1 Sep 2023 12:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjIAQLy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Sep 2023 12:11:54 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB442CDD
        for <linux-raid@vger.kernel.org>; Fri,  1 Sep 2023 09:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693584679; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=ajZtymcMnlV3xzJI4xwJzZZAs6PK8qHXF6ijEBsOy4RPs3fIgcWtP1Xrh5uZizoKrDNf6HfSYjSkxIXI4x51R6nzkDSaJxOcHktqwYQDOSbRj62kL6h+WVag5fYKVHIG8RunZQVYpYVsmLTSTHbdE++/U8T/1z3OHJtueBIaJFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1693584679; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=I/ZIoq1SP8u3Ekq7U/IxybdAtk7feJ3vTMAyJwojMIU=; 
        b=f0RZ+82g8Lb+ocELCibyukZtY8jW00HqQOiqj/StAt+8T2saaVCN+APS5Vaow31uwJtSteoTTOn/Cndu2H/5iSwAU+s5/tLVgfjpTlpY6Ef3ATZh6VmEsaV9p1iVWXCKX6gW2PZJBCPncgqcbSlT89ygujxkgym9Cdo0sZwtBbw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 1693584675659890.3929218738151; Fri, 1 Sep 2023 18:11:15 +0200 (CEST)
Date:   Fri, 1 Sep 2023 12:11:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix race of "mdadm --add" and "mdadm --incremental"
Content-Language: en-US
To:     Li Xiao Keng <lixiaokeng@huawei.com>,
        Martin Wilck <mwilck@suse.com>, pmenzel@molgen.mpg.de,
        colyli@suse.de, linux-raid@vger.kernel.org
Cc:     miaoguanqin@huawei.com, louhongxiang@huawei.com
References: <20230417140144.3013024-1-lixiaokeng@huawei.com>
 <ad5ba0f238f3919a125fb3ad18a2d228758a4ee0.camel@suse.com>
 <1af8c5cf-4c50-cbdd-d87e-6bb94470acfc@huawei.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <4fd15c81-d7a6-8594-9091-551e2ae567e1@trained-monkey.org>
In-Reply-To: <1af8c5cf-4c50-cbdd-d87e-6bb94470acfc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/11/23 10:37, Li Xiao Keng wrote:
> 
> 
> On 2023/5/8 21:35, Martin Wilck wrote:
>>> -       if (map_lock(&map))
>>> +       if (map_lock(&map)) {
>>>                 pr_err("failed to get exclusive lock on mapfile -
>>> continue anyway...\n");
>> As you added a "return 1" here, the "continue anyway" message is wrong.
>> You need to change it.
>>
> 
> After resolving doubts of Coly Li, I will change it to
> 
> pr_err("failed to get exclusive lock on mapfile when assemble raid.")
> 
> Regards,
> Li Xiao Keng

Hi Li,

Did you ever post an updated version?

Thanks,
Jes


