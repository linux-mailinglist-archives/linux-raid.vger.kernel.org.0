Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5058478F
	for <lists+linux-raid@lfdr.de>; Thu, 28 Jul 2022 23:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiG1VKv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 Jul 2022 17:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiG1VKu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 28 Jul 2022 17:10:50 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A24F695
        for <linux-raid@vger.kernel.org>; Thu, 28 Jul 2022 14:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659042642; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Oo/k50LdHPz+Bq0bhodmPaBGUhrHV+KxQeb2OzrO1gmma7oh7QikpPagv/lR7NxQ/41mg3MERDnGk2R5Dw0TuIYpaHkhvolKbSSrLpmrgfXZd3CNweC0ICdEan5EKLdReISlvsQ6INWt/qj5xCnpUWjjRUqjMpE7CrEbwwyCnBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1659042642; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=lpzV/Anrdjo0HUi6IL7kTk1xtrjUwBw+cxwE4/HtWbs=; 
        b=Orkp5oVuFC2LTJXFbrQqk+H9G3MUmaq50X97eB0nrm2jV3T9FhamdIXimdI6Jca04ktnyUX4o66PsuoX9XqM7qsbh/lcu5XQrvGCspANemVamY1F2CqvlfZZN+pbiZqC1vzInLq7AUZ3S2DBOCm5aVlT3y5O3wmjnlrYVnx+C6w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.78] (pool-72-69-213-125.nycmny.fios.verizon.net [72.69.213.125]) by mx.zoho.eu
        with SMTPS id 165904264178832.33194605049778; Thu, 28 Jul 2022 23:10:41 +0200 (CEST)
Message-ID: <d3d9ded4-903a-3adf-0463-dea0a44b5e55@trained-monkey.org>
Date:   Thu, 28 Jul 2022 17:10:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] String functions fixes in Monitor
Content-Language: en-US
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20220714070211.9941-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220714070211.9941-1-kinga.tanska@intel.com>
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

On 7/14/22 03:02, Kinga Tanska wrote:
> Series of patches which fixes unsafe string functions
> used to fill devnames in Monitor.c.
> 
> Kinga Tanska (2):
>   Monitor: use devname as char array instead of pointer
>   Monitor: use snprintf to fill device name
> 
>  Monitor.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 

I have applied both of these!

Thanks,
Jes

