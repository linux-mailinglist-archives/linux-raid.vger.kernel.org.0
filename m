Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947D2242A1
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQRzg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 13:55:36 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32047 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgGQRzf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jul 2020 13:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595008533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hphhuzx/ZEKOpJD9CuU/RIRgka+4gxuNuKAZpPFPJWc=;
        b=FAe1ERfBuc5+J+mnAGTCiLyZyBTxOWhxHJJvpfnukpG87yIiyy0DyoM4avnIdFDRQ+98SJ
        SMZVotvPiVGykmso9E2BjpY2c0cAHhjX4kukBONNA3KcQAwBeycl3YQqGqGh8B8sYkJA8+
        nLyayW/KX/7Q6LixSy5OeZJHWMRs0vc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-0B-0s_YOM4-0M9U30Gp0iw-1; Fri, 17 Jul 2020 19:55:31 +0200
X-MC-Unique: 0B-0s_YOM4-0M9U30Gp0iw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBFicp3n6f5vgutCm2h9Zh5n22tEM2jNBIOsGYFSpurK2ezkS1qUBYPp8oGTr2T2LpfPgb+ouQrOdqusFR4W1sgA8Ft6Midbt8ToGEBg9dFpVf2uVGEe8T3qNFqDvyjwffCOLAYu0QS4bZibuba6X6WfPdcmDwzPi3bp6rXkFUX0Kq8iuPZgi73aVq5OJ9agYwQD/7muYamh2kAi/F9M6QVJA72Itjh3X6YTIMbd/kZzpxp3oCPiJxcSR3+2SKMZscW/paddz4q6YJtqsY1Us/a3Twgi5u5qNVj9lQj7tCWamWNkiQYkg8g2TUSPwAc+2Rhxi1LrdNDK80ULt05c4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hphhuzx/ZEKOpJD9CuU/RIRgka+4gxuNuKAZpPFPJWc=;
 b=cDfWSxqi2QGQCK+xpMkTTFwQvWJ3YAyunPMo/zLSGfgoRmAEigS8GG/rHlPq15ZZD7Gx0g45icZgDmGD3/JjZqfpJO5AY8M0+605zMfUzk4C/hSOA50adBuETxuPtAowMGyHuvsL1xJREsPy6bp8vWjA7m4BDrrCWoN39DwjqGDCgrysd7DbgR3r2Z6jLbUg6BdiRQdzYTJB09weiaP7Dnrs4jaVmYrNT1C6Ldgxg7ybEl50A9y9R64WUxZhXlVjO/RwIanNrvY0Mdd+OUGx9L3eUFSnNArnONK1ivUlUib9SetnB2twWJkhmWvHf5TlvI+TH2QSf1hMh2ZUwvhd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: trained-monkey.org; dkim=none (message not signed)
 header.d=none;trained-monkey.org; dmarc=none action=none
 header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (52.135.133.14) by
 DB7PR04MB4265.eurprd04.prod.outlook.com (52.134.109.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Fri, 17 Jul 2020 17:55:30 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 17:55:30 +0000
Subject: Re: [PATCH] mdadm/Detail: show correct state for cluster-md array
To:     linux-raid@vger.kernel.org
Cc:     neilb@suse.com, jes@trained-monkey.org
References: <1595008271-3234-1-git-send-email-heming.zhao@suse.com>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <030cd214-f573-2942-353b-c0fac70905f2@suse.com>
Date:   Sat, 18 Jul 2020 01:55:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <1595008271-3234-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0157.apcprd02.prod.outlook.com
 (2603:1096:201:1f::17) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0157.apcprd02.prod.outlook.com (2603:1096:201:1f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 17:55:29 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e97c6a34-2c99-405e-e5af-08d82a7a9876
X-MS-TrafficTypeDiagnostic: DB7PR04MB4265:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB42655FBB1E4EBAA13B52D2AE977C0@DB7PR04MB4265.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6bL8btAMcX1mYe03u6m/gvJm1NrsWYWadfLubMefl3ZgowR7+hL8EnA0BI3rjOp9ZAt4xZ5LVEXCQGMyw7r+ImvZQ/0O/0CzBg1On180IaKVHpwgPPTtIzs960yKIe0FDoPgMuxmenBcPFx7JmhR6nfWyW6qZCvcqRtQRJLbe+ZopemydJ5C7GMr8J6Pyp94IAFs+4cDEWsVYYOn/hKHKk22U/afVdjecYdJKSPBgI/1t07+H2Xz+/U4pZ9tUTKDIlJixlfyJOpAcMVax8GJQuwuRbIrOI7Ixdwkn2tdF3Yqi0EiLbAnrX+hj4o66k4tDjjLYsZV4/Y9HSeWQa8WsKVpL7n2swXbXp0JRcWFRy27UXnYPQ8JYqACtAAjJYt8pnY8dvtz3SD3gMhtmT7Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(39860400002)(346002)(366004)(83380400001)(36756003)(4326008)(6666004)(5660300002)(956004)(2616005)(66946007)(8676002)(8936002)(31686004)(66476007)(6512007)(66556008)(6486002)(478600001)(86362001)(8886007)(16526019)(2906002)(31696002)(316002)(186003)(6916009)(26005)(52116002)(53546011)(6506007)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EKSqedRSIKWTkVXOtww2ySAYSm7BnaieXHxgPjQyQ45jJ79Q+iAwZQVhMoEGmqQumhMFg3g08ENxogaUYtJ4YqZYYylfGGxEboxdVSIoriAFCI0Ki1aCG3QAhiHbkgrZPD90b5SOe3d3I1JMQAWIoJWb4z0399xGtyswjAKSnbPeNS6s0uBNwtz5IjNiBUC/EcGmuSMiYA5cgd7DLX0Vn/f4nT0HgWePIQTF1afQCmAny/7eGqXDVXGHKXXCSI7f+qmt8wmWbgLivYrUDvNL/M7wjEUAzeIspY5Zpp3/H7ikjGWI6KZXHNM5YZPKfi4oPf2KvuWB88DSowRh2W+NRlHsf8YU7i8DrvhU10+DWDVr8EVGMdbAV8uTyiCOZAG8zv7z3l0CC1ftHHRupOgTVRevonUkdbM0U7zU0Nmsiu7FmRLLSqUmcyH8sWzsQQH6toVdynUMynXP85Sri6PLaFDOsuXcBPd6fm0Nt91ReaU=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97c6a34-2c99-405e-e5af-08d82a7a9876
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:55:30.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5d0ADC9H0XJq3O40rODW5EiiBNBSdnM9fJjWbgN/ZqFXsTI8aXKBhDRi9HCE619THzKLBBpSabHcmys4jakdyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4265
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I am very sorry, this patch contains bug.
please ignore this mail.
I will resend this patch very soon.

On 7/18/20 1:51 AM, Zhao Heming wrote:
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
>   Detail.c | 21 ++++++++++++++++++++-
>   bitmap.c | 22 ++++++++++++++++++++++
>   mdadm.h  |  1 +
>   3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/Detail.c b/Detail.c
> index 24eeba0..fd580a3 100644
> --- a/Detail.c
> +++ b/Detail.c
> @@ -495,8 +495,27 @@ int Detail(char *dev, struct context *c)
>   							  sra->array_state);
>   				else
>   					arrayst = "clean";
> -			} else
> +			} else {
>   				arrayst = "active";
> +				if (array.state & (1<<MD_SB_CLUSTERED)) {
> +					int dirty = 0;
> +					for (d = 0; d < max_disks * 2; d++) {
> +						char *dv;
> +						mdu_disk_info_t disk = disks[d];
> +
> +						if (d >= array.raid_disks * 2 &&
> +								disk.major == 0 && disk.minor == 0)
> +							continue;
> +						if ((d & 1) && disk.major == 0 && disk.minor == 0)
> +							continue;
> +						dv = map_dev_preferred(disk.major, disk.minor, 0, c->prefer);
> +						if (dv != NULL)
> +							if ((dirty = IsBitmapDirty(dv))) break;
> +					}
> +					if (dirty == 0)
> +						arrayst = "clean";
> +				}
> +			}
>   
>   			printf("             State : %s%s%s%s%s%s%s \n",
>   			       arrayst, st,
> diff --git a/bitmap.c b/bitmap.c
> index e38cb96..10c2045 100644
> --- a/bitmap.c
> +++ b/bitmap.c
> @@ -368,6 +368,28 @@ free_info:
>   	return rv;
>   }
>   
> +int IsBitmapDirty(char *filename)
> +{
> +	/*
> +	 * Read the bitmap file
> +	 * return: 1(dirty), 0 (clean), -1(error)
> +	 */
> +
> +	struct supertype *st = NULL;
> +	bitmap_info_t *info;
> +	int fd = -1, rv = -1;
> +
> +	fd = bitmap_file_open(filename, &st, 0);
> +	if (fd < 0)
> +		return rv;
> +
> +	info = bitmap_fd_read(fd, 0);
> +	if (!info)
> +		return rv;
> +	close(fd);
> +	return info->dirty_bits ? 1 : 0;
> +}
> +
>   int CreateBitmap(char *filename, int force, char uuid[16],
>   		 unsigned long chunksize, unsigned long daemon_sleep,
>   		 unsigned long write_behind,
> diff --git a/mdadm.h b/mdadm.h
> index 399478b..ba8ba91 100644
> --- a/mdadm.h
> +++ b/mdadm.h
> @@ -1447,6 +1447,7 @@ extern int CreateBitmap(char *filename, int force, char uuid[16],
>   			unsigned long long array_size,
>   			int major);
>   extern int ExamineBitmap(char *filename, int brief, struct supertype *st);
> +extern int IsBitmapDirty(char *filename);
>   extern int Write_rules(char *rule_name);
>   extern int bitmap_update_uuid(int fd, int *uuid, int swap);
>   
> 

