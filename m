Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3523EE64
	for <lists+linux-raid@lfdr.de>; Fri,  7 Aug 2020 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHGNnX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Aug 2020 09:43:23 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17461 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgHGNl5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Aug 2020 09:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1596807703; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=i7z4iHobyQnvMpqA/mjCnRF57sa3M8bSPHN5W86j7MVwxKB7ftclE9L67EfxUYPZiu09AkQmH1W+hf95y2b9emw++ZOTdrckDfKLXwyliRv5svSYAS8dOajVtK1o9cAylUPBZRHWDuXLn7k/MaBGOkRamMlyBRwW+XIz3W2vjDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1596807703; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QHS4j8Td58ak9UGUnz/6h+/4dD8GXnzdtkSyPiJgJds=; 
        b=Y+cJ9bNEBZs/3vNVKLY5PkzrE2oDCXuxb+qQr9syd0o/xL0rK4eP+pWzxZTAavcTVx4N1CRFy3cY/24BPHaR4izXYeALulOQQl0GseseC620xJk2si/+qhSQvB5d2LIe9ofeP1Zr3Lpfw/PI3i+Dwtnogq8ehjWKJ2TPE9F+5ho=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-108-46-250-244.nycmny.fios.verizon.net [108.46.250.244]) by mx.zoho.eu
        with SMTPS id 1596807701966605.5691664843124; Fri, 7 Aug 2020 15:41:41 +0200 (CEST)
Subject: Re: [PATCH v3 mdadm 1/1] Specify nodes number when updating cluster
 nodes
To:     Xiao Ni <xni@redhat.com>, linux-raid@vger.kernel.org
Cc:     antlists@youngman.org.uk, ncroxon@redhat.com, heinzm@redhat.com
References: <1595812460-3929-1-git-send-email-xni@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <bfac39dd-d8cd-6cb1-2f57-9f1b1d847724@trained-monkey.org>
Date:   Fri, 7 Aug 2020 09:41:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595812460-3929-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/26/20 9:14 PM, Xiao Ni wrote:
> Now it allows updating cluster nodes without specify --nodes. It can write superblock
> with zero nodes. It can break the current cluster. Add this check to avoid this problem.
> 
> v2: It needs check c.update first to avoid NULL pointer reference
> v3: Wol points the typo error
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>  mdadm.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied!

Thanks,
Jes
