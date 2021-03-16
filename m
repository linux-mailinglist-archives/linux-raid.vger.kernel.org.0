Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5727A33DE8A
	for <lists+linux-raid@lfdr.de>; Tue, 16 Mar 2021 21:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCPUWW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 16 Mar 2021 16:22:22 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17226 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCPUVq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 16 Mar 2021 16:21:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1615926098; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=d1gLADQhyIrvF05rWUAKhscNoOKq5CsJqVVBSFoCGqhhzDLUgmk1dUItG9MTdGmV4zjQNPm0sLp0Q8S0c0/cKB/EoRSDEt87w8nUA603b0sKq08FvcCNhvplP6emaazPDKEiWy9qsdLs+InnXjQuIs2HQDC4eWwnbvmZFQQrsDI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1615926098; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ay6r/K8y9l6rvCC91EIdcjAbvgvHXVcX8Th/hRX2UM4=; 
        b=NNDBHRMmffyYezxC141mWpVFi0d6Dypx1ZXt1pYIecsGRQTUHYxtzLjNMB07h1ElRU8+huC39lLLQY/Lx0d1vRaUkFSarSc5pbnYhZc1k0JMEoswhncvnUjROVM5vD0y0sS0FgEEWExkMiy44EqH61305ek3FrHC+qSL+0oO8/c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1615926096512190.09502821782246; Tue, 16 Mar 2021 21:21:36 +0100 (CET)
Subject: Re: [PATCH] imsm: extend curr_migr_unit to u64
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20210311125245.9615-1-mariusz.tkaczyk@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <db82f169-1c27-b483-2a03-717bb2205fa1@trained-monkey.org>
Date:   Tue, 16 Mar 2021 16:21:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210311125245.9615-1-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/11/21 7:52 AM, Mariusz Tkaczyk wrote:
> Make it u64 to align it with curr_migr_init field from migration_area.
> 
> Name helpers as vol_curr_migr_unit for differentiation between those
> fields. Add ommited fillers in struct migr_record.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  super-intel.c | 92 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 51 insertions(+), 41 deletions(-)
> 

Applied!

Thanks,
Jes


