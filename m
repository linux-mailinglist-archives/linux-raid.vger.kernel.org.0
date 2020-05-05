Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7033E1C5F75
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgEER7l (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 13:59:41 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17062 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgEER7l (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 13:59:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588701575; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=eqTQ56XXmBVDJiZW29krs7r5LUlR3joWRRNFjudX4UsRGeqvGpOL7Nws7aJSShNKAG9a7OuM0p5f9dF1996pwI6K2eRiGZ5FrouPhsqzroegoRSx+tK5CnOsQIwNNn6CBf4PTBtfu9Im985mRAv7N5o/S1sb3HNO1Ik05QrMhAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1588701575; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1UN9RfUstO7/Hf2icNZFZSVdOSHU3q/JMltXuD6iXWE=; 
        b=aoc0822dJbtrGIcikOvOF+2X6T0bDy6FQMw69obGofOmp6HFRcy+FXkLchHMJm//CdSEEv/j2ChbmB5BVeYzDqVBkxAEXSjT3F0IUkQnqeuGr1nJlIwsH12Cp2SZW3Uo33rZgum5Pma+75AGyNem2iZ0MvHv0vFBQwAxnO+4Qbk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.124.22] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1588701573224704.3077802555482; Tue, 5 May 2020 19:59:33 +0200 (CEST)
Subject: Re: [PATCH] allow RAID5 to grow to RAID6 with a backup_file
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org
References: <20200504163138.22787-1-ncroxon@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <01d95357-ce4b-3cd8-2e33-e619c11ea325@trained-monkey.org>
Date:   Tue, 5 May 2020 13:59:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504163138.22787-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/4/20 12:31 PM, Nigel Croxon wrote:
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
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>  Grow.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Grow.c b/Grow.c
> index 764374f..6dce71c 100644
> --- a/Grow.c
> +++ b/Grow.c
> @@ -1135,6 +1135,16 @@ int reshape_open_backup_file(char *backup_file,
>  	unsigned int dev;
>  	int i;
>  
> +	if (lstat(backup_file, &stb) != -1) {
> +		switch (stb.st_mode & S_IFMT) {
> +		case S_IFLNK:
> +			return 1;
> +			break;

It doesn't make sense to have a break after a return here.

> +		default:
> +			break;
> +		}
> +	}
> +
>  	*fdlist = open(backup_file, O_RDWR|O_CREAT|(restart ? O_TRUNC : O_EXCL),
>  		       S_IRUSR | S_IWUSR);
>  	*offsets = 8 * 512;
> @@ -5236,8 +5246,17 @@ char *locate_backup(char *name)
>  	char *fl = make_backup(name);
>  	struct stat stb;
>  
> -	if (stat(fl, &stb) == 0 && S_ISREG(stb.st_mode))> +	lstat(fl, &stb);

You ditched the error check for lstat here. You cannot count on the
contents of stb being valid in this case.

> +	switch (stb.st_mode & S_IFMT) {
> +	case S_IFLNK:
>  		return fl;
> +		break;
> +	case S_IFREG:
> +		return fl;
> +		break;

Same with the break statements here.

Mind fixing this up and submitting a v2.

Thanks,
Jes

> +	default:
> +		break;
> +	}
>  
>  	free(fl);
>  	return NULL;
> 

