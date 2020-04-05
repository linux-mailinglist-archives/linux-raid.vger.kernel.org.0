Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E019ED13
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgDERn7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 Apr 2020 13:43:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35064 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbgDERn7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 Apr 2020 13:43:59 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 035HZWt4008282;
        Sun, 5 Apr 2020 10:43:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wHKG5c2PhvVHxelQIUxOYDX39ShIA7bqc+4cgyjZChI=;
 b=bW4x7C3D1Kq5Ik2eL53QRlY32s04DGIr1CZBoVZRUQj6aUJNYFhDpKRzfGsUKOsyn3e9
 k4uuxH4M7ACN710NxeX7t6R7OEPw1leDLiuYoNBw7Lv9Be+iFjVCqbWxHsOOf8aW64pe
 r1ERggA/YVUqB0nsv205DxYqEqta7rJ0gFc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3072c4tqpr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 05 Apr 2020 10:43:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sun, 5 Apr 2020 10:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAQBz/VpbIOFwwKEHjFkYKx4js/AGDBeZZakF/OPyAAeOpEozhcrBG/qJShDqo80WHOSIz4FKr+DA01MNlz/ZALzsBml1XmajReWm1VhZupJirlxV+Xa8c7RAoKszGMUojsTuKImCo8iC0z4jYFqM7bXQ68N04Bhwqj6NdBFFR1fl1p1W9Le13RaO6WDQTqbURQDJAkMqxsiuQBaQHW7h6vsCbF2eRhAmby0idr1+5qCTNpgDSp2cceeD01dw+2RhHSUFmP0VVoQTPVDIYXWlrHgHDuW5WPJXZ0BKJg0SBahABg3SdtfW3WPo8AZJADsWKfwHGJxGwk8NwbHq+d99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHKG5c2PhvVHxelQIUxOYDX39ShIA7bqc+4cgyjZChI=;
 b=Xi0xz0fJoLsCvmSWdpdaB+6ZDCmi8owrNRidaEFZGkJ7sTvFhE887XFMF5yMD44adv8l9mGTRC9hexxqrWcS58XWJNn5vIBPciK3fCnXIAufF1pAi47scBGYW4yZfy/Lkt0eHQARGPOLRpI67BcyLPef64TYCaHwgnhpfI+djbSbxly854gFcOAPa2Sd/9WnAkB99fYaaPqbyJ3PEk4UfZ12ZvG82FVr1fu9Zfltqu8K0tS+NrJNEoOsHLPujLfZYburxXPFJ7PPDSCXs1UiMzGwzdiWEz2qRhd13+KoAaRyuXd8yQHC4QSOH44HEnmPyl7TuQ8gWWZDJtumv7+irQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHKG5c2PhvVHxelQIUxOYDX39ShIA7bqc+4cgyjZChI=;
 b=DZji6WRGvZOjHXRcIdfnKJXdAbUDXEMonSjhQT6YIIoA8YzYF3n/iDByqd5aDYCogZJ81Dh7k/tkgSy02KKaxqUZmPazcKmtq0O/GN3TNctMR0iC7j/pe97wcvdLPeBLaIJIqaO2huEBFZMAzPdUHZ4zEhmFBFjmlPIPTZ4rH8U=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3963.namprd15.prod.outlook.com (2603:10b6:303:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Sun, 5 Apr
 2020 17:43:33 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 17:43:33 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Coly Li <colyli@suse.de>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
Thread-Topic: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
Thread-Index: AQHWCMaZPtL1EAJCIkGgkby2AYbB9qhq0eaA
Date:   Sun, 5 Apr 2020 17:43:33 +0000
Message-ID: <8A145C50-D9E8-4874-A365-576FC4578486@fb.com>
References: <20200402081312.32709-1-colyli@suse.de>
In-Reply-To: <20200402081312.32709-1-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:dd03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53767a44-db8f-4052-d240-08d7d988dcd2
x-ms-traffictypediagnostic: MW3PR15MB3963:
x-microsoft-antispam-prvs: <MW3PR15MB39636BDC2B789454C45CCE79B3C50@MW3PR15MB3963.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03648EFF89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3882.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(81156014)(53546011)(71200400001)(66476007)(64756008)(66556008)(6506007)(66446008)(5660300002)(66946007)(76116006)(8936002)(6916009)(478600001)(8676002)(186003)(36756003)(33656002)(2616005)(86362001)(54906003)(2906002)(316002)(6512007)(6486002)(4326008)(81166006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSL1EjUZxG+X5k6S8rt4c5Vpgwb8FC5STbeDSwtA383raZB7seqch8Tj/B+qcO7OS1IQcGCd+8evByRJ1wXP9N9MpSa2HCtDfm4FHXxz4HXX2LBtQKK4yNKE2UTX+E26VCvjwF/2euC6LqlO46XAzJ8/DCdS++OA1uFLXh6XITHmeeUTtLCekehl6jHBQryy9TfgA9C8jH9Pkyi1oPazzOEiyI2zp8+cQSOuOzw/lMfreNCcV3OzEZQOro0/EEPay0VtSs8oXdWzM3+ZPdxsY8ehDk5a1seVaEjYd13pVe+QyetpMUk4z5vhjfziRQSzdSvdB3W9guGDK1/8LuNjmTLLGxAxwgxiEfh+VufNAb3u3lF77tQTP0u5MoicVIMkJFOLLU+lnzj9usLNcZjCgQRkGbefqY+5S9puGrMfcOgaP4tpPYKvmIGSJlJzW9p1
x-ms-exchange-antispam-messagedata: YwIPy/OM7t0gr2YLd6IIdDbRnyMRHuOFO9A09GGwLoAKBKRh2TDEJ8wwPUNT4LzhALnUc4Sx3zxQWdEqNTWK3uPrOxvRGG7PKX727ufp2Lf4fBKyelJIN3IImXvpSzWjN/COiFd/iUtXIA1iOdVBSti81weXQRxIZRUDBivKskWxtG/HaA2SXM7UaiWIs0qt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF8B29F5D0E4A941A6A40FF3E1A4B5F3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53767a44-db8f-4052-d240-08d7d988dcd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2020 17:43:33.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InnC/FkpeYVUp81o/5XzVbHM9P5WT1bIf6i6QbyrI8JqEFMeR3aRDBqjlcPvtjoaQB8UylFLUx4KLwq8O0fWIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3963
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-05_08:2020-04-03,2020-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004050165
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Coly,

Thanks for the patch!

> On Apr 2, 2020, at 1:13 AM, Coly Li <colyli@suse.de> wrote:
>=20
> Commit b330e6a49dc3 ("md: convert to kvmalloc") uses kvmalloc_array()
> to allocate memory with GFP_NOIO flag in resize_chunks() via function
> scribble_alloc(),
> 2269	err =3D scribble_alloc(percpu, new_disks,
> 2270			     new_sectors / STRIPE_SECTORS,
> 2271			     GFP_NOIO);
>=20
> The purpose of GFP_NOIO flag to kvmalloc_array() is to allocate
> non-physically continuous pages and avoid extra I/Os of page reclaim
> which triggered by memory allocation. When system memory is under
> heavy pressure, non-physically continuous pages allocation is more
> probably to success than allocating physically continuous pages.
>=20
> But as a non GFP_KERNEL compatible flag, GFP_NOIO is not acceptible
> by kvmalloc_node() and the memory allocation indeed is handled with
> kmalloc_node() to allocate physically continuous pages. This is not
> the expected behavior of the original purpose when mistakenly using
> GFP_NOIO flag.
>=20
> In this patch, the memalloc scope APIs memalloc_noio_save() and
> memalloc_noio_restore() are used when calling scribble_alloc(). Then
> when calling kvmalloc_array() with GFP_KERNEL mask, the scope APIs
> may indicatet the allocating context to avoid memory reclaim related
> I/Os, to avoid recursive I/O deadlock on the md raid array itself
> which is calling scribble_alloc() to allocate non-physically continuous
> pages.
>=20
> This patch also removes gfp_t flags from scribble_alloc() parameters
> list, because the invalid GFP_NOIO is replaced by memalloc scope APIs.
>=20
> Fixes: b330e6a49dc3 ("md: convert to kvmalloc")
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> ---
> drivers/md/raid5.c | 22 ++++++++++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index ba00e9877f02..6b23f8aba169 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2228,14 +2228,15 @@ static int grow_stripes(struct r5conf *conf, int =
num)
>  * of the P and Q blocks.
>  */

I noticed the comment before scribble_alloc() is outdated. Maybe
fix also that as we are on it?=20

> static int scribble_alloc(struct raid5_percpu *percpu,
> -			  int num, int cnt, gfp_t flags)
> +			  int num, int cnt)
> {
> 	size_t obj_size =3D
> 		sizeof(struct page *) * (num+2) +
> 		sizeof(addr_conv_t) * (num+2);
> 	void *scribble;
> +	unsigned int noio_flag;
I think we don't use noio_flag in scribble_alloc()?=20

Thanks,
Song

