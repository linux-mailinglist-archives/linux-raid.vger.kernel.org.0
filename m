Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0971544B500
	for <lists+linux-raid@lfdr.de>; Tue,  9 Nov 2021 22:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhKIV6W (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Nov 2021 16:58:22 -0500
Received: from sender12-1.zoho.eu ([185.20.211.225]:17224 "EHLO
        sender12-1.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhKIV6W (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Nov 2021 16:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1636494933; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=HCLLHaLONtnkxAJRzQl1Bxl3aStgN3nTA/d4qyM9WlrQBoKZnspjk9d+afn76AkOjSmCk/XzqDwGFK2xJWJfzsBUHVpnHC1x08fB5xx2Rj1rMc2AlE4sJoHM1ODEn6MuBxymhlvHVhQPgjiFf6yY1S06rbhgnsVFj9loWw6L9Wo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1636494933; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0NFMun5t1WautdAEBfBY6XnDEyKpvly6IewdujFa3qk=; 
        b=VFUADOP4NrRsOWqFiClEmwBHVbVWsx4nioklbQJmpX9YxJxfJHMPc0FkiBMj2cT8qhj9cl8HIYDNhKIZITYRqgcgqR/zlZq/QsdeRjqA0oWW2gjgPStFU78PzyjzKKnIazSCRE9T/+r8Iyq4nuJ4dxQi6RAfEeT5lxCMwg1FiJ8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1636494931922672.9790471680146; Tue, 9 Nov 2021 22:55:31 +0100 (CET)
Subject: Re: [PATCH] imsm: free allocated memory in imsm_fix_size_mismatch
To:     Pawel Piatkowski <pawel.piatkowski@intel.com>,
        linux-raid@vger.kernel.org
References: <20211104131622.3563-1-pawel.piatkowski@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <d270d0df-e1ee-c656-d562-b1ed32a5145c@trained-monkey.org>
Date:   Tue, 9 Nov 2021 16:55:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20211104131622.3563-1-pawel.piatkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/4/21 9:16 AM, Pawel Piatkowski wrote:
> Free allocated memory stored in variable named update
> 
> Signed-off-by: Pawel Piatkowski <pawel.piatkowski@intel.com>
> ---
>  super-intel.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied!

Thanks,
Jes

