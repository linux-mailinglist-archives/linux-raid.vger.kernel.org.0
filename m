Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8510109729
	for <lists+linux-raid@lfdr.de>; Tue, 26 Nov 2019 01:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKZACc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Nov 2019 19:02:32 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17494 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKZACc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 Nov 2019 19:02:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574726548; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Ef8pAbUujpOfzLOfSOXepQnoR10BkrrYk6OwBxNBNHuueyyW5nwpx2myVy0BRudBW3xjRONL2rZSeow6BWzh0gchyU8W7EJoaXVra7iu3ouzSJuJ+2QPQsDWcILNUXM+8ZPoiTlFp68SLqVv3zLiXoVhmWX0EoPFGpCk7p2Q0k4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1574726548; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ph0ouagL9oB/3EZJacSXxwbANSLthDhYWPnBI4JZd+Y=; 
        b=OOzw2m37HyzT6sByxIEfZFeO/4/NcQD/R0pXnUpmdwbuc+FDBfyRfqeXtyPxlevV7RkapetIOdxOqHHotVN6XLX7axACKh3woYQOkzeZQ79ZFaFIyRn03K1E0qkWGg1+1+9HTcsp+SO6x19X2hQI2emqtZ079WFR9XYW+nbHBsg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.98.102] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1574726547566419.9640616104408; Tue, 26 Nov 2019 01:02:27 +0100 (CET)
Subject: Re: [PATCH] Change warning message
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
References: <20191120104948.9461-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <172dbb61-50db-efde-c967-4aa3d08a682d@trained-monkey.org>
Date:   Mon, 25 Nov 2019 19:02:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120104948.9461-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/20/19 5:49 AM, Kinga Tanska wrote:
> In commit 039b7225e6 ("md: allow creation of mdNNN arrays via
> md_mod/parameters/new_array") support for name like mdNNN
> was added. Special warning, when kernel is unable to handle
> request, was added in commit 7105228e19
> ("mdadm/mdopen: create new function create_named_array for
> writing to new_array"), but it was not adequate enough,
> because in this situation mdadm tries to do it in old way.
> This commit changes warning to be more relevant when
> creating RAID container with "/dev/mdNNN" name and mdadm
> back to old approach.
> 
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
> ---
>   mdopen.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mdopen.c b/mdopen.c
> index 98c54e4..905a770 100644
> --- a/mdopen.c
> +++ b/mdopen.c
> @@ -120,7 +120,8 @@ int create_named_array(char *devnm)
>   		close(fd);
>   	}
>   	if (fd < 0 || n != (int)strlen(devnm)) {
> -		pr_err("Fail create %s when using %s\n", devnm, new_array_file);
> +		pr_err("Fail to create %s when using %s, fallback to old approach\n",

I don't think "fallback to old approach" is a good description, it may 
not mean anything to the user. Maybe you can make it more elaborate.

Thanks,
Jes


