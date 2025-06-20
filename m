Return-Path: <linux-raid+bounces-4468-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2461AE1D63
	for <lists+linux-raid@lfdr.de>; Fri, 20 Jun 2025 16:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E31BC33DA
	for <lists+linux-raid@lfdr.de>; Fri, 20 Jun 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F928AB0B;
	Fri, 20 Jun 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KcZwdbBy"
X-Original-To: linux-raid@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D028FD;
	Fri, 20 Jun 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429946; cv=none; b=eiN6p5Ku/eUmnuAtp0zmQ3j2A9V1LzgkTtGWa+xGAFa5fQGBr1jNOca0JJrpchRYySUrR29mbeEWln+TNRIu4xIKlY2HPE5TTnOhhNQV9LdZXUTs8Y7bs4Gr9UG7BUY9u9RRSfLO6FKIcwMpYp2Oh50V07E+dSH1BtADR1+Ehjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429946; c=relaxed/simple;
	bh=rP6AgbWUoh6aLE9OW7/00nce91UIipHy2acWVaqMBAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqkFmSpYFfEfBi8dZNO705nECDVmaJTDd3eZlQGDNhRhknvNSYStV8oWNNsTOA+D/dcTbKYvt1Ytw3XYgtW7gsItMhAfqVQyPKGI92SFlMJbOAYFyn1ItFLUFF/f9yhe3WCwB735ApjIelaS7BPnsYyLu6SZpKLRry6iG9w82XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KcZwdbBy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K5O9Al030929;
	Fri, 20 Jun 2025 14:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o+sjuU
	yjo7R/z8t+WjtpOIiUlMEYWSBYnfloL4tnnzs=; b=KcZwdbBylSd4Wfc0AoWxbe
	l7je7qQgmiU++ak3E86w8dz3Uhg7SWF+qFDcDLhFvjifXmwHlnk52tL9hmMy8l2z
	Z/+Gh+fWu1/l+4sClP0ZsIF4voZdqyZvJs6BSVeAtRZoMJiwyYHezTYYoX0X5cnB
	Eil7+O+lRkL1OZNS67B/8nNoo7+qbNZ3anUsFaA8GB65Myb8VjtCCvJdkpVQU903
	2DiRnXajZDxC8IqbWTj4SPujZGmD5LhoANJw7DIG3T9gh5KPwEXKr+/zva9V8RAa
	DSPNGH+NT7tBFNHubrQoEKQNLNBqUMyqHZ1eS8HQIktVP8cxEEPJlk9Y2P0/PGfw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r2kd1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 14:32:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KD6Tct000724;
	Fri, 20 Jun 2025 14:32:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdpkj5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 14:32:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KEW4WI26477208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:32:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D96958054;
	Fri, 20 Jun 2025 14:32:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 005EE5803F;
	Fri, 20 Jun 2025 14:31:59 +0000 (GMT)
Received: from [9.61.191.218] (unknown [9.61.191.218])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 14:31:58 +0000 (GMT)
Message-ID: <abb47ea9-f269-49db-9f39-604448699a77@linux.ibm.com>
Date: Fri, 20 Jun 2025 20:01:57 +0530
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] md/raid0: set chunk_sectors limit
To: John Garry <john.g.garry@oracle.com>, agk@redhat.com, snitzer@kernel.org,
        mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
        axboe@kernel.dk
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        ojaswin@linux.ibm.com, martin.petersen@oracle.com
References: <20250618083737.4084373-1-john.g.garry@oracle.com>
 <20250618083737.4084373-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250618083737.4084373-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PpHNFroRO1ODM37-SsdD3gIjOenXWlIT
X-Proofpoint-ORIG-GUID: PpHNFroRO1ODM37-SsdD3gIjOenXWlIT
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=685570e6 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=DTQqZlGBjZatJn8HPRAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwMiBTYWx0ZWRfX77madXOOq0Pk m13HsUoMx29XnkzBvfW/qxJsg071xIi+Qjszap6r98dRkFVH62kFAfQq87bkm+DdMmxWV6mByB0 AJ0LBFrn5EWGKa6WZF7RWZm9hhS2ZqcMCJwR9UD1j1IiZz8FkPfXaW51hi1WF424cz3WWffppxC
 dNc4wI8SAWBPDYjub3kcUaLxR/cCypcQyNW4+RQ8F0C1SaMNptwzOke8+58+m8Z5V1yVLvXzssy fkArjFkeKqHvyTt6zaytq3JeEGTvFuYrj8JaicH0HcK1apGogAfMbDkjSIPwZbrwc/R2zqxHu95 s1fsAhJNg0P3geNwxrQzJOeVc2w+460NI6ijNqMeyOrRjjZFyfZwL9YIjVAWsaMajW1l9REju4w
 Ls/Wa1xgADdQymN300BuQS6+d+DGqL1ovBwRngdMcAL5jWbm12opcaOdEEO3nZhz8TNwN+B6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200102



On 6/18/25 2:07 PM, John Garry wrote:
> Currently we use min io size as the chunk size when deciding on the
> atomic write size limits - see blk_stack_atomic_writes_head().
> 
> The limit min_io size is not a reliable value to store the chunk size, as
> this may be mutated by the block stacking code. Such an example would be
> for the min io size less than the physical block size, and the min io size
> is raised to the physical block size - see blk_stack_limits().
> 
> The block stacking limits will rely on chunk_sectors in future,
> so set this value (to the chunk size).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

