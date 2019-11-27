Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6910B255
	for <lists+linux-raid@lfdr.de>; Wed, 27 Nov 2019 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfK0PWE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 Nov 2019 10:22:04 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17459 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PWE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 27 Nov 2019 10:22:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574868104; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Cg8QLsu60864lnUeGXqzXscp8A6tuDsm6dKNcCIkyXP0cjoVDr9BLwkWm7O/WKx2MwrpUalmtaTDCowNO7wDZ58hRXziHZ/aodVGBcA4Wa4Im0sYOZuye7nru3cUQp+aomyJZGfqbQov6WjnSUc3xqLSgGZdfPUlYCQxXCcT7Nk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1574868104; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QJSlsJa065ELoGO12ZlVMPN1YSHNyM0hvWvxy0ebiQE=; 
        b=keRfKsrSn13M0b0bN4R+PqoniZqWTaWYUXzhn+bsa2P6Y9T8ZYVGITRyGOpnHqy42Jz+TypHUGTFtg/wWhCxIFWo7aqwFMu6I1IJpdMUtlmXieTrMdtFbvbtFMvva7Bk6g9g8Hx2c4ZtAEITIX6upk+wBdmuK+eSlrp8aQprr6M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.74.102] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1574868102093664.5643127385395; Wed, 27 Nov 2019 16:21:42 +0100 (CET)
Subject: Re: [PATCH] Manage: Remove the legacy code for md driver prior to
 0.90.03
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     neilb@suse.de, gqjiang@suse.com, linux-raid@vger.kernel.org
References: <20191127035924.12734-1-ice_yangxiao@163.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <2f440de5-5c27-0765-0e23-4664d2141801@trained-monkey.org>
Date:   Wed, 27 Nov 2019 10:21:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127035924.12734-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/26/19 10:59 PM, Xiao Yang wrote:
> Previous re-add operation only calls ioctl(HOT_ADD_DISK) for array without
> metadata(e.g. mdadm -B/--build) when md driver is less than 0.90.02, but
> commit 091e8e6 breaks the logic and current re-add operation can call
> ioctl(HOT_ADD_DISK) even if md driver is 0.90.03.
> 
> This issue is reproduced by 05r1-re-add-nosuper:
> ------------------------------------------------
> ++ die 'resync or recovery is happening!'
> ++ echo -e '\n\tERROR: resync or recovery is happening! \n'
> ERROR: resync or recovery is happening!
> ------------------------------------------------
> 
> Fixes: 091e8e6("Manage: Remove all references to md_get_version()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> ---
>   Manage.c | 12 ------------
>   1 file changed, 12 deletions(-)

Applied!

I also went in and removed the last references to HOT_ADD_DISK in a 
follow-on patch.

Thanks,
Jes


