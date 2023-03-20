Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379256C1ED9
	for <lists+linux-raid@lfdr.de>; Mon, 20 Mar 2023 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCTSBZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Mar 2023 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCTSAy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Mar 2023 14:00:54 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB7AAF23
        for <linux-raid@vger.kernel.org>; Mon, 20 Mar 2023 10:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679332152; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=aDG4YWiqxAp5Gwfm2d4Qj0zREJH4l/BHMObiETHotrU7ZX81Gh7pr7NyUVin2/DVdUt4AaKdexnEeZrxP809CX52oUUA0b0iz+HhXdHDpzIy9DA8DQIHHyDNcGVBFuLXYHXG+9miQyCI9mjZ9gxsyWUl6AXXfKl7PCbuiPFVsiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1679332152; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bJlLsX0nyFaYF7hIUH9bXTjaDDsycbDrUuCp6TXlzcA=; 
        b=iJpJS2IBY5a2mSgEDf2s9/zX+UfdV2dgnmokRRgbd/xH9UomSHRAbzV39POmk4PHAbHtCB1sD7gnXVYWn0RNgo74G9ViNSSy+RbthkHQyxzDoE9QJD0b/rmXQIQ9dwGvqFMyVVir8Sbrz39r7qp2iYTwcYEMfQaUJulhG1ekW8w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 167933215020965.08403524953167; Mon, 20 Mar 2023 18:09:10 +0100 (CET)
Message-ID: <a319db18-f56a-0b03-8eb3-64a10fe69e63@trained-monkey.org>
Date:   Mon, 20 Mar 2023 13:09:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] Improvements for IMSM_NO_PLATFORM testing.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <167928383495.8008.10987312807759367944@noble.neil.brown.name>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <167928383495.8008.10987312807759367944@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/19/23 23:43, NeilBrown wrote:
> 
> Factor out IMSM_NO_PLATFORM testing into a single function that caches
> the result.
> 
> Allow mdmon to explicitly set the result to "1" so that we don't need
> the ENV var in the unit file
> 
> Check if the kernel command line contains "mdadm.imsm.test=1" and in
> that case assert NO_PLATFORM.  This simplifies testing in a virtual
> machine.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mdadm.8.in             |  5 +++++
>  mdadm.h                |  2 ++
>  mdmon.c                |  6 ++++++
>  super-intel.c          | 45 +++++++++++++++++++++++++++++++++++++++---
>  systemd/mdmon@.service |  3 ---
>  5 files changed, 55 insertions(+), 6 deletions(-)

Applied!

Thanks,
Jes


