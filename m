Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999055B2406
	for <lists+linux-raid@lfdr.de>; Thu,  8 Sep 2022 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiIHQ4M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 8 Sep 2022 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiIHQzi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 8 Sep 2022 12:55:38 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70395DF20
        for <linux-raid@vger.kernel.org>; Thu,  8 Sep 2022 09:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662655996; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=b70Ev+G389UBVtQrLwGO5JlcS5WEkVXihMv0ULHujJWDXDFSBycanhvtlg9Dig1qcJQr8qnalfQ4RHLkseZIjffuFIbhjPcjFKXTbys7JKJGGBjJQEwrDoXA1E/2ZX+m8aHXJiScEwE7Wlywb5n/ubHk+ijZ8bQvyQb4KYp5eYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1662655996; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Rm6SguLwSUmvAInaa22PfLrAR8N40ATTZ4XUCDkAXio=; 
        b=QekUbymhVx9drBktQsaN+RWtzc4QVZSitr/C3qvTzSa63FzNm5ATY7xrUWKOhAbgERexOQQn8hrbFsUlTK51CLNs+w8eoBACUA0nmU1ojOpbYFzGj4CwzqZ59Phnmu8HBe2DncRp3C9Kx4pvSS3H6c0Mglzc0f94auevBVE4l58=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.78] (pool-72-69-213-125.nycmny.fios.verizon.net [72.69.213.125]) by mx.zoho.eu
        with SMTPS id 1662655991213497.8812826804873; Thu, 8 Sep 2022 18:53:11 +0200 (CEST)
Message-ID: <a914b695-9b6d-fd45-97d4-ca5b98f1d1f3@trained-monkey.org>
Date:   Thu, 8 Sep 2022 12:53:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] Manage: Block unsafe member failing
Content-Language: en-US
To:     Mateusz Kusiak <mateusz.kusiak@intel.com>,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20220818094721.8969-1-mateusz.kusiak@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220818094721.8969-1-mateusz.kusiak@intel.com>
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

On 8/18/22 05:47, Mateusz Kusiak wrote:
> Kernel may or may not block mdadm from removing member device if it
> will cause arrays failed state. It depends on raid personality
> implementation in kernel.
> Add verification on requested removal path (#mdadm --set-faulty
> command).
> 
> Signed-off-by: Mateusz Kusiak <mateusz.kusiak@intel.com>
> ---
>  Manage.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)

Applied!

Thanks,
Jes


