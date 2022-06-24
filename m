Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB955A0AA
	for <lists+linux-raid@lfdr.de>; Fri, 24 Jun 2022 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiFXSLj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Jun 2022 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFXSLj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Jun 2022 14:11:39 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8152E5D
        for <linux-raid@vger.kernel.org>; Fri, 24 Jun 2022 11:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656094287; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=E5oEig4faAnayh1YL4Tymu/jUdd3EtinaaNNn4d8otqeNtnQv7oHwJEPhpCVg5mNDrt0AwCFCmS/uyqJFKloOcI/C83zlmh7mrYc/4e8b74dhmKueuiv5Gja9oN42P9STQ+tzLDi9rliagyMtIz6BwOOHbHOuqJUbdKMfEoo8zk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1656094287; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4jekkjyMM5+4TbNU+XhI5Q4O3sf84ZLtGNSby8PxATU=; 
        b=HzEnfF3jgpXW990nue6CQH4e8/LsjMrL5T7gR/JwFwcbWvdP6mZKrI6D2Wt0w6DzXSvHHSt/X1DhY21JmuHQVasck4ZdDl81zWehoVWBo/g0rg8ZdiTA1KYcobZeVZLNyT6hHTOzpIWBIlvsnZi+NbWLADan0z7e5wNshZM2IME=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.80] (pool-72-69-213-125.nycmny.fios.verizon.net [72.69.213.125]) by mx.zoho.eu
        with SMTPS id 1656094285251322.1410911251437; Fri, 24 Jun 2022 20:11:25 +0200 (CEST)
Message-ID: <5aca22db-508d-15b4-d3fd-f3fe12cb8440@trained-monkey.org>
Date:   Fri, 24 Jun 2022 14:11:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mdadm: block update=ppl for non raid456 levels
Content-Language: en-US
To:     Lukasz Florczak <lukasz.florczak@linux.intel.com>,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de
References: <20220615122839.458384-1-lukasz.florczak@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220615122839.458384-1-lukasz.florczak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/15/22 08:28, Lukasz Florczak wrote:
> Option ppl should be used only for raid levels 4, 5 and 6. Cancel update
> for other levels.
> 
> Applied globally for imsm and ddf format.
> 
> Additionally introduce is_level456() helper function.
> 
> Signed-off-by: Lukasz Florczak <lukasz.florczak@linux.intel.com>
> ---
>  Assemble.c | 11 +++++------
>  Grow.c     |  2 +-
>  Manage.c   | 14 ++++++++++++--
>  mdadm.h    | 11 +++++++++++
>  super0.c   |  2 +-
>  super1.c   |  3 +--
>  6 files changed, 31 insertions(+), 12 deletions(-)

Hi Lukasz,

I like the level456 change, it really helps avoid trivial bugs. I would
have preferred this being two patches, one for the 456 change and one
for the functional change, but I still applied it.

Thanks,
Jes

