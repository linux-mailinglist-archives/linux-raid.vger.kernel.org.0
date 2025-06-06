Return-Path: <linux-raid+bounces-4376-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14BAD04FE
	for <lists+linux-raid@lfdr.de>; Fri,  6 Jun 2025 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E783A943F
	for <lists+linux-raid@lfdr.de>; Fri,  6 Jun 2025 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86381D63C6;
	Fri,  6 Jun 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y6GTTxAI"
X-Original-To: linux-raid@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62513D52F;
	Fri,  6 Jun 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223014; cv=none; b=UIb6fucQLXooTEcpS+3yDXciBaEXw3OphYlZjkMHz2c734y7841L7LNVfRinjAZR/DZbgm/6WvJ5Pizh9gFh5GeoAjkLXhMLSV0eLggpvjGWfoaEje6wKVP4FbUpNx3ae74YUxuow4VwUo3gfngzvnYpFMHnowbF9BMstdwJDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223014; c=relaxed/simple;
	bh=bMcoQZ8/56NkiSi6ldpCU2xHO/U+BegQxxASRAkiQqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9qtYqX7lnhRNRvyjxkJsTdZZADK6pKol2gIzow49IHDmW+qX1ShCrkRFMTX7WfESV7XpfHlbuuUvGI8/tMpR5wQ+JOnyISYLLliG0xZE1/3t6MMqVPwz2sLVcc6AH/ydyABO4v3CFeShI627IQgImLpEWATmE1DZcvCbxtr/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y6GTTxAI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556DRAn9032703;
	Fri, 6 Jun 2025 15:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SznduB
	7uZbB2TupeB0XlulVyY8Rgk+W8Ehae2oY7ceE=; b=Y6GTTxAIFQWQlF31NbTc5E
	T0ZUbm+qQx39BmBDGD1J+qVov1GCE2WXdnG7URSUetlJ1S2/LXCvwWcP3NXZS0xZ
	nwSuj1iXhNfBq9uJJUZEE8C0gMio+1KEAhlM5QtU/frwOtwypW/ps77Dw53FZ6Cw
	bVa6Tj5KujgvWkSRKLEJLqmO+VkQM60HU1heFx32saFcYlo66J0sm3b/gAkD4hWH
	bzhuvrAWHmZKpD9E/6UatVpHV1tJXm181X7NoHS+dNEddYL+48e+qH9tzARQ+eLK
	nK7lb/8fiXt8+MYEG2iyqxw9YAbNUgoG8oB42qVbLU1jhYz6dh5+6fuNHgwKERZg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47332yru34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 15:16:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556BdQkI024914;
	Fri, 6 Jun 2025 15:16:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmsxsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 15:16:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 556FGUL421234430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Jun 2025 15:16:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D7158059;
	Fri,  6 Jun 2025 15:16:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA04958058;
	Fri,  6 Jun 2025 15:16:24 +0000 (GMT)
Received: from [9.67.149.38] (unknown [9.67.149.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Jun 2025 15:16:24 +0000 (GMT)
Message-ID: <041186c7-a249-4564-979c-3e480aadaa23@linux.ibm.com>
Date: Fri, 6 Jun 2025 20:46:22 +0530
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] dm-stripe: limit chunk_sectors to the stripe size
To: John Garry <john.g.garry@oracle.com>, agk@redhat.com, snitzer@kernel.org,
        mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
        axboe@kernel.dk
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        ojaswin@linux.ibm.com, martin.petersen@oracle.com
References: <20250605150857.4061971-1-john.g.garry@oracle.com>
 <20250605150857.4061971-4-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250605150857.4061971-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zfauzWNZU7Fhnw5fbhqBnJ3WZz4ZokBJ
X-Proofpoint-ORIG-GUID: zfauzWNZU7Fhnw5fbhqBnJ3WZz4ZokBJ
X-Authority-Analysis: v=2.4 cv=SO9CVPvH c=1 sm=1 tr=0 ts=68430650 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=H49iAnPEzUvt3JwDqx0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzMiBTYWx0ZWRfXzHp/c9A8vlDS ayOHWFRgdS0HJWnzKg+fvUE3XNFE5d8qw35o3/l8GuKe9CFK7YTWYq6ljJk2VBoraFptL4IEVse itmjoeBC9QZ0SXvcY3YuFwXz1GniImC2TewbiPzjf0mA6KrSHdfuMU7T4INGzTkVEO1UlL7mgIi
 iHcpkPgrqzDIIKbM/sZFXiZbQbmhV/BYbK36gJ4TL7tqVwIiHsBErpSJobu+H3aGm0dPH3DDG9o HcmjLM9PMa7PNEtLSWzBfP8dyiyCmg2GVYyWsyJXP2ERYnbQCLnOt2awPIVfjMDDjFooQgNsrXg xrYC+aCMYl46wrDarZEHCCl25LPx4KQtWgKwk7ZpNcTGBtBjY7F7mdraAj+Kz7/DUhTpmXi/YLz
 z1/BOl1I1fEee4heF5fqJ9pzrXJmjjg+Nc9sX8mUs5A47wQjRBnM4w0UZbHN6Y0kO+CL5yMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060132



On 6/5/25 8:38 PM, John Garry wrote:
> Currently we use min io size as the chunk size when deciding on the limit
> of atomic write size.
> 
> Using min io size is not reliable, as this may be mutated when stacking
> the bottom device limits.
> 
> The block stacking limits will rely on chunk_sectors in future, so set
> this value (to the chunk size).
> 
> Introduce a flag - DM_TARGET_STRIPED - and check this in
> dm_set_device_limits() when setting this limit.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/md/dm-stripe.c        | 3 ++-
>  drivers/md/dm-table.c         | 4 ++++
>  include/linux/device-mapper.h | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index a7dc04bd55e5..c30df6715149 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -466,7 +466,8 @@ static struct target_type stripe_target = {
>  	.name   = "striped",
>  	.version = {1, 7, 0},
>  	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
> -		    DM_TARGET_ATOMIC_WRITES | DM_TARGET_PASSES_CRYPTO,
> +		    DM_TARGET_ATOMIC_WRITES | DM_TARGET_PASSES_CRYPTO |
> +		    DM_TARGET_STRIPED,
>  	.module = THIS_MODULE,
>  	.ctr    = stripe_ctr,
>  	.dtr    = stripe_dtr,
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 24a857ff6d0b..4f1f7173740c 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -430,6 +430,10 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
>  		return 0;
>  	}
>  
> +	/* For striped types, limit the chunk_sectors to the chunk size */
> +	if (dm_target_supports_striped(ti->type))
> +		limits->chunk_sectors = len >> SECTOR_SHIFT;
> +
I think here "len" refers to the total size of dm target and not the 
chunk sectors. So we need to modify this and take into account chunk sectors..
We can get chunk sectors, for example, like this:

	struct stripe_c *sc = ti->private;
	limits->chunk_sectors = sc->chunk_size;

But again struct stripe_c is private to dm-stripe.c and so we can't access it
here directly in dm-table.c Better we add a new callback function for dm target
type under struct target_type and then use that callback to get chunk sector. 

struct target_type stripe_target = {
        ...
        .chunk_sectors = stripe_chunk_sectors,
        ...
}

Thanks,
--Nilay


