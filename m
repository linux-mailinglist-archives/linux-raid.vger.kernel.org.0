Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE581EFC64
	for <lists+linux-raid@lfdr.de>; Fri,  5 Jun 2020 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFEPVn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Jun 2020 11:21:43 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17139 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgFEPVn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 5 Jun 2020 11:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591370496; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Tu4vqxV4EAOSi6GLl5UP2W3wgb6QqhAMstZKs7izVC6DZKaJZcvU0QGGvTIG35ZgIcLpKv2n+awefRqwUvhFWi0YKIRfZRP17ZoaJ1Zs5fmOnErvda0VJOlFr1zeK6ffgzeer3psdq1gkjsDocbkJmezZypQb38qo6h4xqolWIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1591370496; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5+LVCvdjSo/6tcPs7Qe4RYgTTbx5BIUPHs03vTfFhNQ=; 
        b=KNRlj6e2ZgTRtUXUIZ57vz/X2uyA37CBKsTlu5+6bHyHgxEsjdXgncUxPbzZxNPyWsxjUQXJKF5VWYVVjWioyVeNcgJi9TCxkNBZvyLr3frUeBt7qbZmmtogUscv4DYLiHUyuDBPU+SMe5DrDLvqZ1yUnOZLE4zbF2qTzFXk/X8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.108.78.247] (163.114.132.6 [163.114.132.6]) by mx.zoho.eu
        with SMTPS id 1591370494699628.5858159217174; Fri, 5 Jun 2020 17:21:34 +0200 (CEST)
Subject: Re: [PATCH] Detect too-small device: error rather than
 underflow/crash
To:     dfavro@meta-dynamic.com
Cc:     linux-raid@vger.kernel.org
References: <20200523122459.1151100-1-dfavro@meta-dynamic.com>
 <20200523122459.1151100-2-dfavro@meta-dynamic.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <d4aa93ea-8810-db0b-15d2-2d68d8c7f3e1@trained-monkey.org>
Date:   Fri, 5 Jun 2020 11:21:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523122459.1151100-2-dfavro@meta-dynamic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/23/20 8:24 AM, dfavro@meta-dynamic.com wrote:
> From: David Favro <dfavro@meta-dynamic.com>
> 
> For 1.x metadata, when the user requested creation of an array on
> component devices that were too small even to hold the superblock,
> an undetected integer wraparound (underflow) resulted in an enormous
> computed size which resulted in various follow-on errors such as
> floating-point exception.
> 
> This patch detects this condition, prints a reasonable diagnostic
> message, and refuses to continue.
> 
> Signed-off-by: David Favro <dfavro@meta-dynamic.com>
> ---
>  super1.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Applied!

Thanks,
Jes

