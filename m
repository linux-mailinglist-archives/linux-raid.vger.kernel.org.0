Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67914447A
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jan 2020 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAUSmc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jan 2020 13:42:32 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17362 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSmc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 Jan 2020 13:42:32 -0500
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579632147481590.6186886612982; Tue, 21 Jan 2020 19:42:27 +0100 (CET)
Subject: Re: [PATCH] imsm: fill working_disks according to metadata.
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20200117142404.25035-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <2d196b56-cd44-dcea-8175-4fb257ba3ce4@trained-monkey.org>
Date:   Tue, 21 Jan 2020 13:42:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117142404.25035-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/17/20 9:24 AM, Blazej Kucman wrote:
> Imsm tracts as "working_disk" each visible drive.
> Assemble routine expects that the value will return count
> of active member drives recorded in metadata.
> As a side effect "--no-degraded" doesn't work correctly for imsm.
> Align this field to others.
> Added check, if the option --no-degraded is called with --scan.

I assume you meant tracks rather than tracts? I corrected this in the
description and applied this. If I was wrong, my apologies.

Thanks,
Jes


> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>  mdadm.c       | 9 ++++++---
>  super-intel.c | 5 ++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mdadm.c b/mdadm.c
> index 256a97ef..13dc24e4 100644
> --- a/mdadm.c
> +++ b/mdadm.c
> @@ -1485,9 +1485,12 @@ int main(int argc, char *argv[])
>  			rv = Manage_stop(devlist->devname, mdfd, c.verbose, 0);
>  		break;
>  	case ASSEMBLE:
> -		if (devs_found == 1 && ident.uuid_set == 0 &&
> -		    ident.super_minor == UnSet && ident.name[0] == 0 &&
> -		    !c.scan ) {
> +		if (!c.scan && c.runstop == -1) {
> +			pr_err("--no-degraded not meaningful without a --scan assembly.\n");
> +			exit(1);
> +		} else if (devs_found == 1 && ident.uuid_set == 0 &&
> +			   ident.super_minor == UnSet && ident.name[0] == 0 &&
> +			   !c.scan) {
>  			/* Only a device has been given, so get details from config file */
>  			struct mddev_ident *array_ident = conf_get_ident(devlist->devname);
>  			if (array_ident == NULL) {
> diff --git a/super-intel.c b/super-intel.c
> index 5c1f759f..47809bc2 100644
> --- a/super-intel.c
> +++ b/super-intel.c
> @@ -7946,7 +7946,8 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
>  				skip = 1;
>  			if (!skip && (ord & IMSM_ORD_REBUILD))
>  				recovery_start = 0;
> -
> +			if (!(ord & IMSM_ORD_REBUILD))
> +				this->array.working_disks++;
>  			/*
>  			 * if we skip some disks the array will be assmebled degraded;
>  			 * reset resync start to avoid a dirty-degraded
> @@ -7988,8 +7989,6 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
>  				else
>  					this->array.spare_disks++;
>  			}
> -			if (info_d->recovery_start == MaxSector)
> -				this->array.working_disks++;
>  
>  			info_d->events = __le32_to_cpu(mpb->generation_num);
>  			info_d->data_offset = pba_of_lba0(map);
> 


