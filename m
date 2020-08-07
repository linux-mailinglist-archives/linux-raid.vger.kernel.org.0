Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4623EE5E
	for <lists+linux-raid@lfdr.de>; Fri,  7 Aug 2020 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHGNjy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Aug 2020 09:39:54 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17437 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgHGNjv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Aug 2020 09:39:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1596807587; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Rn65sRV+/viqggayoHL1s6AZwhMOKSNHzdNrphm5mTZ9LVrFAPAk/vTmyhf0vYK75fcyZz8s7dK88R6pIfmIXcCW3rbv006kgYBNioK5uHTeogwch6or6/MVS7ygnN3lunbUOcb4l9HM/cRDBrFQRmmGzK9KefrlyhG3vGzULbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1596807587; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Udrliz21iLgFPuMZ9GovKdijg9DLE1tOj6TdajLwp0o=; 
        b=b7rIrG3KhXtUl5/vxB13oR+7Ic1GkUfNG5lLTi9Y4uW0i9c4yaZtaKZUJcrImb8Q595ZDcnRbEAw63UWokMRU7JA7i37KlgoYs5pIx7OsDKDhrIoJUTI2/rZrrwzrUsouRKwRZ6GEjBzP2EH5lcIAqwgzuNOn9oxcSuRIhxc5l0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-108-46-250-244.nycmny.fios.verizon.net [108.46.250.244]) by mx.zoho.eu
        with SMTPS id 1596807586677119.39776050894875; Fri, 7 Aug 2020 15:39:46 +0200 (CEST)
Subject: Re: [PATCH v3] mdadm/Detail: show correct state for cluster-md array
To:     Zhao Heming <heming.zhao@suse.com>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com
References: <1595994510-16161-1-git-send-email-heming.zhao@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <36a9bd05-fa7c-0fa8-feae-3c681bdc4db7@trained-monkey.org>
Date:   Fri, 7 Aug 2020 09:39:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595994510-16161-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/28/20 11:48 PM, Zhao Heming wrote:
> After kernel md module commit 480523feae581, in md-cluster env,
> mddev->in_sync always zero, it will make array.state never set
> up MD_SB_CLEAN. it causes "mdadm -D /dev/mdX" show state 'active'
> all the time.
> 
> bitmap.c: add a new API IsBitmapDirty() to support inquiry bitmap
> dirty or clean.
> 
> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
> ---
> v3:
> - Detail.c: fix error logic: v2 code didn't check bitmap when dv is null.
> v2:
> - Detail.c: change to read only one device.
> - bitmap.c: modify IsBitmapDirty() to check all bitmap on the selected device.
> 
> ---
>  Detail.c | 20 +++++++++++++++++++-
>  bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mdadm.h  |  1 +
>  3 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/Detail.c b/Detail.c
> index 24eeba0..a69e5ac 100644
> --- a/Detail.c
> +++ b/Detail.c
> @@ -495,8 +495,26 @@ int Detail(char *dev, struct context *c)
>  							  sra->array_state);
>  				else
>  					arrayst = "clean";
> -			} else
> +			} else {
>  				arrayst = "active";
> +				if (array.state & (1<<MD_SB_CLUSTERED)) {
> +					for (d = 0; d < max_disks * 2; d++) {
> +						char *dv;
> +						mdu_disk_info_t disk = disks[d];
> +
> +						if (d >= array.raid_disks * 2 &&
> +							disk.major == 0 && disk.minor == 0)
> +							continue;
> +						if ((d & 1) && disk.major == 0 && disk.minor == 0)
> +							continue;
> +						dv = map_dev_preferred(disk.major, disk.minor, 0,
> +												c->prefer);
> +						if (!dv) continue;

Minor nit here, never ever put if() < bleh on the same line.

Thanks,
Jes

