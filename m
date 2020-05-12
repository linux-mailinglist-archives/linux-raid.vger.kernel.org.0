Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B433A1CFF14
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgELUNQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 16:13:16 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17140 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELUNQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 May 2020 16:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589314392; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=UixIjs1B5AXzcLqYxP8WwaWpILXItWgN3Phu/DynYnvFuAKxCeYB20QvNBhYKihWE+Z3T8J3SNWJ2+uTRus1ga2KYvB4VWMXR/feo+wXd0Kx/QftBxRBJS8Yxbec9Wl2GPf/PWSFyQ5ZBQx2laDJFTP9HnMBc7HG+3SgFb9vnss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589314392; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mWWj0sR9Slx//HTr9ZTYYnT6DCmo4IdQdaKp/PqUnXk=; 
        b=SLl/FWlP2+Q+GcLmBcTKQx+YxfiXFpStL4I4giCInVieJ4VhslQ1k3c6xWn7CRlo3b0QvXF5a3BT2JKViRO6xkLrA56Ba4v/pCFfqTwTvjOQZ6LCT8lsLByWuT6K/yhEN4XIkLS1yyjuOqYlALxysau762BRsIr3G/qFDhthNew=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.128.78] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1589314388160922.0594451304434; Tue, 12 May 2020 22:13:08 +0200 (CEST)
Subject: Re: Time to think about mdadm-4.2?
From:   Jes Sorensen <jes@trained-monkey.org>
To:     "Kernel.org-Linux-RAID" <linux-raid@vger.kernel.org>
Cc:     kernel-team@fb.com
References: <4b3d6f4f-2f80-f290-beff-e303075ef5d9@trained-monkey.org>
Message-ID: <d696b2f2-9182-eaaa-5e07-40fcab2207cf@trained-monkey.org>
Date:   Tue, 12 May 2020 16:13:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4b3d6f4f-2f80-f290-beff-e303075ef5d9@trained-monkey.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/17/20 5:15 PM, Jes Sorensen wrote:
> Hi,
> 
> We have had a lot of changes since 4.1 and I am thinking it's time to
> start thinking about a 4.2 release.
> 
> No hard date set, but probably in about a month?
> 
> If you have anything pending you would like to get in, now would be a
> good time to start posting those patches.

I received some patches for mdadm, anything else that needs to go in
before the next release?

Thanks,
Jes

