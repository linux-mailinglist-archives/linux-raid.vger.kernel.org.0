Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF223B953
	for <lists+linux-raid@lfdr.de>; Tue,  4 Aug 2020 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgHDLQV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 4 Aug 2020 07:16:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgHDLQK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 4 Aug 2020 07:16:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074BDAtO113189;
        Tue, 4 Aug 2020 11:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=yhVa+sGWPiCrSxzTLW7WJK6Btb/mhOSlf4PA+TeSbTo=;
 b=U1V4ekWOIV/mohp5085VfaTTzGZtw0WwasDhgSK91c9ksRRgAJzHutEa6KvntgceD/MO
 MFn/SKBTCNTjVwhG+zDivR4bB4PNp/eE4ruOCdpS/Y9titrJWwDcV1FLC9IwIPb5orW4
 rZh+89AfiI0uwqQRVYzPaQoq4mXkEGm5rEonZtc6jOwDlRulLOXSH+IwTws5BcvvbZ6u
 5eDHGi4OeHViQG3FHlhApQZ5e1ruuEDZ0IM/J7GXoMjEjhnyiuC4lEFpQ0Hu/mhqz+UP
 OmN+3Vq7ReOwh9xqbRMu+8/ghB54A0BGA8771R2M1GwRTHCzDcMOpFCYJG2RaEZgDBMm Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32pdnq6xsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 11:16:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074B7iFO079768;
        Tue, 4 Aug 2020 11:16:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32njawcjet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 11:16:01 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074BFxZC020752;
        Tue, 4 Aug 2020 11:15:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 04:15:58 -0700
Date:   Tue, 4 Aug 2020 14:15:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Song Liu <song@kernel.org>, Shaohua Li <shli@fb.com>,
        NeilBrown <neilb@suse.com>, linux-raid@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] md-cluster: Fix potential error pointer dereference in
 resize_bitmaps()
Message-ID: <20200804111549.GN5493@kadam>
References: <20200804101645.GB392148@mwanda>
 <824849e0-c98d-1f22-817c-7a76d3ee22b1@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <824849e0-c98d-1f22-817c-7a76d3ee22b1@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=2 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040084
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Aug 04, 2020 at 12:40:18PM +0200, Guoqing Jiang wrote:
> 
> 
> On 8/4/20 12:16 PM, Dan Carpenter wrote:
> > The error handling calls md_bitmap_free(bitmap) which checks for NULL
> > but will Oops if we pass an error pointer.  Let's set "bitmap" to NULL
> > on this error path.
> > 
> > Fixes: afd756286083 ("md-cluster/raid10: resize all the bitmaps before start reshape")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/md/md-cluster.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> > index 73fd50e77975..d50737ec4039 100644
> > --- a/drivers/md/md-cluster.c
> > +++ b/drivers/md/md-cluster.c
> > @@ -1139,6 +1139,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
> >   		bitmap = get_bitmap_from_slot(mddev, i);
> >   		if (IS_ERR(bitmap)) {
> >   			pr_err("can't get bitmap from slot %d\n", i);
> > +			bitmap = NULL;
> >   			goto out;
> >   		}
> >   		counts = &bitmap->counts;
> 
> Thanks for the catch, Reviewed-by: Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com>
> 
> BTW, seems there could be memory leak in the function since it keeps
> allocate bitmap
> in the loop ..., will send a format patch.
> 
> 
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 73fd50e77975..89d7b32489d8 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -1165,6 +1165,8 @@ static int resize_bitmaps(struct mddev *mddev,
> sector_t newsize, sector_t oldsiz
>                          * can't resize bitmap
>                          */
>                         goto out;
> +
> +               md_bitmap_free(bitmap);

Hm...  I'm now not at all certain my patch is correct.  Although it's
obviously harmless and fixes an Oops.  I had thought that that the call
to update_bitmap_size(mddev, oldsize) would free the rest of the loop.

I really suspect adding a free like you're suggesting will break the
success path.

I'm not familiar with this code at all.

regards,
dan carpenter

