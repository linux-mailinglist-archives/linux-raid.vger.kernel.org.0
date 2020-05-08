Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3C1CB140
	for <lists+linux-raid@lfdr.de>; Fri,  8 May 2020 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgEHOB3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 May 2020 10:01:29 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17032 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEHOB3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 May 2020 10:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588946483; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=ZOfI/W1SAlhx5jNbiJZ4pyKVtP0jZvqoxm3du2RT8a1/22iHavwVTr8YOqL6eviqtgf7CttUSbiJyAn5gET9ojeO9KAWesGqBrdEJ4UfO0jkqwX8mZfKS09GwCRdSNjLFl8wAtEE93qdDMvFJixUJQ0yxoBmaIbFAcVSvJ0A+jc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1588946483; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6HfkFua4Dz/tzS4KaxpbDlxMcpz/FuakDAYD2y+MVgw=; 
        b=UtBJtLmUpKAN+OP/Dm1mY6vLycOuwDR19uFXAWw4QfnYC7l0FglAdgVNnIS9Q+IJucEklZmUhsk7pzxLYjvCLtBLv5djnbhMZRU+aUoICNwXpZiw84KLvFGEofNPxIi3YBULy+tDvdk9FEuTUX8BwYi7l2vX2zroqRa0+W9Wa2I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.124.22] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1588946479974273.6620856257755; Fri, 8 May 2020 16:01:19 +0200 (CEST)
Subject: Re: [PATCH V2] allow RAID5 to grow to RAID6 with a backup_file
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org
References: <20200505183545.26291-1-ncroxon@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <8a30b584-753c-abff-634a-7dda8a2e3e27@trained-monkey.org>
Date:   Fri, 8 May 2020 10:01:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505183545.26291-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/5/20 2:35 PM, Nigel Croxon wrote:
> This problem came in, as the user did not specify a full path with
> the backup_file option when growing an RAID5 array to RAID6.
> When the full path is specified, the symbolic link is created
> properly (/run/mdadm/backup_file-mdX). But the code did not support
> the symbolic link when looking for the backup_file. Added two
> checks for symlink.
> 
> This addresses https://www.spinics.net/lists/raid/msg48910.html
> and numerous customer reported problems.
> 
> V2:
> - Removed unneeded break; in both case-statements
> - Returned the error checking on call to lstat
> 
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>  Grow.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Grow.c b/Grow.c
> index 764374f..53245d7 100644
> --- a/Grow.c
> +++ b/Grow.c
> @@ -1135,6 +1135,15 @@ int reshape_open_backup_file(char *backup_file,
>  	unsigned int dev;
>  	int i;
>  
> +	if (lstat(backup_file, &stb) != -1) {
> +		switch (stb.st_mode & S_IFMT) {
> +		case S_IFLNK:
> +			return 1;
> +		default:
> +			break;
> +		}
> +	}
> +

Sorry for being a pita on this, but in this case you do the thing if the
lstat completes correctly, but what if it fails? In that case we should
error out rather than just continuing.

Jes
