Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F194F2143
	for <lists+linux-raid@lfdr.de>; Tue,  5 Apr 2022 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiDEChU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 Apr 2022 22:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiDEChP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 Apr 2022 22:37:15 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7F28CF58
        for <linux-raid@vger.kernel.org>; Mon,  4 Apr 2022 18:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649121330; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=BR+cKTkRxb/yUOZ85YHDWoUCOFxM9dGtiII5g2ZOds4DDX/dX46xGwba5aofbmxwh1RegF6+2f+CSOW66FB8zvPbo/C8dw4OZeP10MLvog9fmRdp3djbKaDEFexvVAtfTJ4ZXLbt3EESElkLS4QEx5cHXc6mBcyOKiIEaXLrlDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1649121330; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Xj0wAp2vvvjsyzLOme3b88Z9nZHbtDrkC0h8aSEEzYQ=; 
        b=iTBnCSPEkv5hCxnKoOf6bgBKQkKbJnCno3ht9PcvkZiPKXquVWZDYuu2Xfj6VrGg71ljPUCtTiBI5brbxABi9UJSZoxRlpce2HETWYMsOy6egyGR2tfqKRWKSM5lPhPNbAePkAibJgQAuHI/ZUVO+BLTqlSTuawOvJ1l838CS9E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [172.30.27.237] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1649121329512473.8448161727657; Tue, 5 Apr 2022 03:15:29 +0200 (CEST)
Message-ID: <2f06f5ba-1a0d-0f91-5f52-20caaa7cbdf8@trained-monkey.org>
Date:   Mon, 4 Apr 2022 21:15:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] mdadm: Update ReadMe
Content-Language: en-US
To:     Lukasz Florczak <lukasz.florczak@linux.intel.com>,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de, pmenzel@molgen.mpg.de
References: <20220318082607.675665-1-lukasz.florczak@linux.intel.com>
 <20220318082607.675665-3-lukasz.florczak@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220318082607.675665-3-lukasz.florczak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/18/22 04:26, Lukasz Florczak wrote:
> Instead of hardcoded config file path give reference to config manual.
> 
> Add missing monitordelay and homecluster parameters.
> 
> Signed-off-by: Lukasz Florczak <lukasz.florczak@linux.intel.com>
> ---

Applied!

Thanks,
Jes

