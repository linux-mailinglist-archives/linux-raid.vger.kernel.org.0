Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A762EEB97D
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJaWDQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 31 Oct 2019 18:03:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38471 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJaWDQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 31 Oct 2019 18:03:16 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iQIXC-0002Do-Og
        for linux-raid@vger.kernel.org; Thu, 31 Oct 2019 22:03:14 +0000
Received: by mail-il1-f198.google.com with SMTP id u68so6555810ilc.4
        for <linux-raid@vger.kernel.org>; Thu, 31 Oct 2019 15:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UQSbHWM5yXgFy8tQ69g05SRv7ccu0CjFVTwPh3Cg/Q=;
        b=Rmn8oktuylGGVIFPC/s8EFWlwbq85Y6cnABRay2VL51ZrF5VWsGCul1k5r7BCjKM8i
         RkQ5GCMzMKkVaFI+14WURrs6dOdeWoAeCeCoYJCmCX/wQvk+5RduKMt/scGPF8VHkytu
         /Ixcv+39iuz1NEtioJ3mpurMSWgMa1/YEY/jOTktFIBLWPl/0VFH1mo9yMIVKo8QhUIf
         X0a8cb6aNf6EASgPk8mFgDHOg1hRPD7+W9aU1LLeaOOuXsgMxzCH3q9Wq9iZFcuPfJwa
         pw0U78I5saFiffxtAFjRJiBpIKw4AezqJSglKAFiv40YoNzWXsoR24P4fUPywD8sl1Gd
         VxDw==
X-Gm-Message-State: APjAAAVUo91pC8jGY8TV9nEeOIr7Fssh4Wwqykl45L72YR4v+Da2ZeVU
        0YGY6MCm2jqSNIwj6EImkVMqOGQ/bg+B9VsceQwM12aluPf+L7L5nsd1BdLrgzZDwd/cB9os86f
        u6KqAVCCMltipMslZleybIF/8AxXaBTB9lOS1olU=
X-Received: by 2002:a92:9957:: with SMTP id p84mr9091532ili.290.1572559393512;
        Thu, 31 Oct 2019 15:03:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztOC6JzrmsN1Le88bT4gdQwmYjJtUNHkkKDSR0RQbi83ZEYHVnDDlVh7krbp46Vz2YNhfcnQ==
X-Received: by 2002:a92:9957:: with SMTP id p84mr9091503ili.290.1572559393177;
        Thu, 31 Oct 2019 15:03:13 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id r23sm491448ioj.7.2019.10.31.15.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:03:12 -0700 (PDT)
Date:   Thu, 31 Oct 2019 16:03:11 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 2/2] Assemble: add support for RAID0 layouts.
Message-ID: <20191031220311.GC24512@xps13.dannf>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown>
 <157247976452.8013.2396485247609220571.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157247976452.8013.2396485247609220571.stgit@noble.brown>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Oct 31, 2019 at 10:56:04AM +1100, NeilBrown wrote:
> If you have a RAID0 array with varying sized devices
> on a kernel before 5.4, you cannot assembling it on
> 5.4 or later without explicitly setting the layout.
> This is now possible with
>   --update=layout-original (For 3.13 and earlier kernels)
> or
>   --update=layout-alternate (for 3.15 and later kernels)

s/3.15/3.14/

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  Assemble.c |    8 ++++++++
>  md.4       |    7 +++++++
>  mdadm.8.in |   17 +++++++++++++++++
>  mdadm.c    |    4 ++++
>  super1.c   |   12 +++++++++++-
>  5 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/Assemble.c b/Assemble.c
> index b2e69144f1a2..4066f93e977f 100644
> --- a/Assemble.c
> +++ b/Assemble.c
> @@ -1031,6 +1031,11 @@ static int start_array(int mdfd,
>  				pr_err("failed to add %s to %s: %s\n",
>  				       devices[j].devname, mddev,
>  				       strerror(errno));
> +				if (errno == EINVAL && content->array.level == 0 &&
> +				    content->array.layout != 0) {
> +					cont_err("Possibly your kernel doesn't support RAID0 layouts.\n");

Why possibly?

> +					cont_err("Please upgrade.\n");
> +				}
>  				if (i < content->array.raid_disks * 2 ||
>  				    i == bestcnt)
>  					okcnt--;
> @@ -1220,6 +1225,9 @@ static int start_array(int mdfd,
>  			return 0;
>  		}
>  		pr_err("failed to RUN_ARRAY %s: %s\n", mddev, strerror(errno));
> +		if (errno == 524 /* ENOTSUP */ &&
> +		    content->array.level == 0 && content->array.layout == 0)
> +			cont_err("Pleasse use --update=layout-original or --update=layout=alternate\n");

s/Pleasse/Please/
s/layout=alternate/layout-alternate/

>  
>  		if (!enough(content->array.level, content->array.raid_disks,
>  			    content->array.layout, 1, avail))
> diff --git a/md.4 b/md.4
> index 6fe275541abd..0712af255dd5 100644
> --- a/md.4
> +++ b/md.4
> @@ -208,6 +208,13 @@ array,
>  will record the chosen layout in the metadata in a way that allows newer
>  kernels to assemble the array without needing a module parameter.
>  
> +To assemble an old array on a new kernel without using the module parameter,
> +use either the
> +.B "--update=layout-original"
> +option or the
> +.B "--update=layout-alternate"
> +option.
> +
>  .SS RAID1
>  
>  A RAID1 array is also known as a mirrored set (though mirrors tend to
> diff --git a/mdadm.8.in b/mdadm.8.in
> index ea07c429e668..7240d461bdc9 100644
> --- a/mdadm.8.in
> +++ b/mdadm.8.in
> @@ -1213,6 +1213,8 @@ argument given to this flag can be one of
>  .BR no\-bbl ,
>  .BR ppl ,
>  .BR no\-ppl ,
> +.BR layout\-original ,
> +.BR layout\-alternate ,
>  .BR metadata ,
>  or
>  .BR super\-minor .
> @@ -1364,6 +1366,21 @@ The
>  .B no\-ppl
>  option will disable PPL in the superblock.
>  
> +The
> +.B layout\-original
> +and
> +.B layout\-alternate
> +options are for RAID0 arrays is use before Linux 5.4.  If the array was being

s/is use/in use/

> +used with Linux 3.13 or earlier, then the assemble the array on a new kernel,

s/then the/then to/

> +.B \-\-update=layout\-original
> +must be given.  If the array was created and used with a kernel from Linux 3.14 to
> +Linux 5.3, then
> +.B \-\-update=layout\-alternate
> +must be given.  This only needs to be given once.  Subsequent assembly of the array
> +will happen normally.
> +For more information, so

see?

> +.IR md (4).
> +

Cheers!

  -dann

>  .TP
>  .BR \-\-freeze\-reshape
>  Option is intended to be used in start-up scripts during initrd boot phase.
> diff --git a/mdadm.c b/mdadm.c
> index e438f9c864da..256a97ef07f5 100644
> --- a/mdadm.c
> +++ b/mdadm.c
> @@ -795,6 +795,9 @@ int main(int argc, char *argv[])
>  				continue;
>  			if (strcmp(c.update, "revert-reshape") == 0)
>  				continue;
> +			if (strcmp(c.update, "layout-original") == 0 ||
> +			    strcmp(c.update, "layout-alternate") == 0)
> +				continue;
>  			if (strcmp(c.update, "byteorder") == 0) {
>  				if (ss) {
>  					pr_err("must not set metadata type with --update=byteorder.\n");
> @@ -825,6 +828,7 @@ int main(int argc, char *argv[])
>  		"     'summaries', 'homehost', 'home-cluster', 'byteorder', 'devicesize',\n"
>  		"     'no-bitmap', 'metadata', 'revert-reshape'\n"
>  		"     'bbl', 'no-bbl', 'force-no-bbl', 'ppl', 'no-ppl'\n"
> +		"     'layout-original', 'layout-alternate'\n"
>  				);
>  			exit(outf == stdout ? 0 : 2);
>  
> diff --git a/super1.c b/super1.c
> index 312303fecbe1..d8f4403f0388 100644
> --- a/super1.c
> +++ b/super1.c
> @@ -1550,7 +1550,17 @@ static int update_super1(struct supertype *st, struct mdinfo *info,
>  		sb->devflags |= FailFast1;
>  	else if (strcmp(update, "nofailfast") == 0)
>  		sb->devflags &= ~FailFast1;
> -	else
> +	else if (strcmp(update, "layout-original") == 0 ||
> +		 strcmp(update, "layout-alternate") == 0) {
> +		if (__le32_to_cpu(sb->level) != 0) {
> +			pr_err("%s: %s only supported for RAID0\n",
> +			       devname?:"", update);
> +			rv = -1;
> +		} else {
> +			sb->feature_map |= __cpu_to_le32(MD_FEATURE_RAID0_LAYOUT);
> +			sb->layout = __cpu_to_le32(update[7] == 'o' ? 1 : 2);
> +		}
> +	} else
>  		rv = -1;
>  
>  	sb->sb_csum = calc_sb_1_csum(sb);
> 
> 
