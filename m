Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD31D4F90
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEONwW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 09:52:22 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17170 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgEONwV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 May 2020 09:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589550737; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=GSqnxb3sg1J+9JSYzy3HUIZvrEpBWK1Oj+0qZoZkZ3gi9tNFhsw8I+qGQfj3hzk7ljO/zRMOE9VL1k/1/hnToDJeJvZfxnRyr+OUbiZw6tZ3WCeNuVnvL36W57XJWEliial9pm8NlJD/k2dGxr2+Ktzgj5hlFRyE58hveNqFHq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589550737; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=PuhsMqF8AhJST7hgmcVD4q6p55lwUCmPpSkXS0Wf9nQ=; 
        b=NclcZbi0chuakyYunZsctzDhm5FL/hKZ0F0xKwuPZ1JDh2lefPtIarENRFARQ2xD/4/Ir8sAmVWNOkG3ZpgfjhxHRJIelffcWuqp9WAHiwflyAO9L1Zqpp1/LO6fgAkAyvMPwcCVQiMWc1kmpyp0meSaR9tyWd+VHB/ZmTnyiMc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.129.242] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1589550735149130.06483827371926; Fri, 15 May 2020 15:52:15 +0200 (CEST)
Subject: Re: [PATCH, v2] Makefile: add EXTRAVERSION support
To:     Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200515092314.2711-1-mariusz.tkaczyk@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <90b6261f-f0dd-1a0c-f91b-21e47f1deef1@trained-monkey.org>
Date:   Fri, 15 May 2020 09:52:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515092314.2711-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/15/20 5:23 AM, Tkaczyk Mariusz wrote:
> Add optional EXTRAVERSION parameter to Makefile and allow to mark version
> by user friendly label. It might be useful when creating custom
> spins of mdadm, or labeling some instance in between major releases.
> 
> Signed-off-by: Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
> ---
> 
> V2: rename LABEL to EXTRAVERSION.

Applied!

Thanks,
Jes

