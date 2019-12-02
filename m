Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A026C10F1D3
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 22:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfLBVCB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 16:02:01 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17481 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBVCB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 16:02:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575320517; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=KtCEcNqird75UhamN5KUBoFUSIE6QaW9cBQTJGSmRedEVCDaTU+dgIdHwdPmKiNXKmViiBuAH2J5Qd7kEKzmVwh7c9fg58PmkpttQnTGPKp6xjprP2VWwUGQ+L5pYWBT0pfkl39aKCM0NhGAX3jQYM0R3X4lCRHiWsbP/3dVDyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1575320517; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3zMZirE6pnJgZvrcWYA0THaH54clV9TWnML7IAQcyrA=; 
        b=TWicWhn4j1EEG6af1anNfTMoDBq6e7OIULGeyKRF6B62bqaAobPkQ2stOugU1csy8sG+MAriGFPcM4QBq+FmnM2bGtKOrN1yRe8YO6Frln1A5Z+ddo2UO86lgThfszuVcFL7IOBumJud6efVyOEXb3jkxaSpCSUJCEWXT4hquGM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.221.108] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1575320516921932.4756766277326; Mon, 2 Dec 2019 22:01:56 +0100 (CET)
Subject: Re: [PATCH] imsm: return correct uuid for volume in detail
To:     Blazej Kucman <blazej.kucman@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20191129142108.10536-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <e676bad2-2747-e86d-73fd-f809922a2f83@trained-monkey.org>
Date:   Mon, 2 Dec 2019 16:01:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129142108.10536-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/29/19 9:21 AM, Blazej Kucman wrote:
> Fixes the side effect of the patch b6180160f ("imsm: save current_vol number")
> - wrong UUID is printed in detail for each volume.
> New parameter "subarray" is added to determine what info should be extracted
> from metadata (subarray or container).
> The parameter affects only IMSM metadata.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>   Detail.c      |  4 ++--
>   mdadm.h       |  5 +++--
>   super-ddf.c   |  5 +++--
>   super-intel.c | 20 ++++++++++++++++++--
>   super0.c      |  4 ++--
>   super1.c      |  4 ++--
>   6 files changed, 30 insertions(+), 12 deletions(-)

Applied!

Thanks,
Jes


