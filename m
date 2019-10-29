Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D166AE8CDF
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfJ2QkI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 12:40:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389940AbfJ2QkI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 12:40:08 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TGUWCI019335;
        Tue, 29 Oct 2019 09:39:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FWm0ma6Uv/Pz1Rn7x/eKs1RAtCbjKtCW6kaov2F5KWA=;
 b=lE926qNvLq0eNzfMxTXs3e3g7HBQy1bur6U27PLpKQoB/T+epL0ET+UlVifYA1jy/vWH
 zvezOGZbIXiDEeE+TFy9ZYFOnVq85HalrRFsql0vto2sZLKBUmdjqd+08yQzEm9lXEzq
 J8CHy/0833pi/CBDuflQbJZZrK72TyYuPsw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vxqx10f6h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Oct 2019 09:39:19 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 09:39:18 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 09:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBA2WseL4+agoqoz61f2uhMTvNhDAfAVvudsDG+E3KXbVy0pGym0QWoxfnK1pEGMLJHP54mBIQFp/Y97bTawtCOiiklmSv/dfIO2bh8qcCmSv9tIdohTq5bBf2SdEhNNEYemubxg4CxH8TYfgGbvjqqRedpW/qNqBNcaQeWrDyIVM7F8hOJkKpktekXCaepoDJzpSgeKGuOsoojhhWcaxq8D4r+IjBa0o5KmcSyYp8+ooBeDMTEv5ZQA4AAsbKUHVrYoZNLh5KEFeFP4vpwIbtHhQowqh8kZ1gd975cHeX9xLwDDZ9KNzETZz9CdQxUS77JTiMNaI1k6mz+r3X68Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWm0ma6Uv/Pz1Rn7x/eKs1RAtCbjKtCW6kaov2F5KWA=;
 b=NBZwKQVtQ1uwdDuzH47JzEwA0P8vSjiH84frABKJ4GxVoSO02qt1WC/QC03bjAJ6/RjjpzgEShg5dHlM41QGeIp1wIUbBToR4H9wS+CrbDfgdQNcRwQNSY+nTnJ8wBAf3VM3WsJisMidVfxE8FHSvzhJBlRn+3Nyt7Qf/W6CkHmnuZAyiyiGQwJzgpHmqlmzngu/e4iho4+1hnLMc4y7Kh+IG9DtLsBfKthA5ibEwlk6dByZ0g8wogWrVp7tP06j18CvjOX8gbIg1A3g/exgeqjYqgLraZqKJtrWDezLkSrSyPFwlQW9tHqhvMzcIxkDUuD0Tk4IgzEO5ibrIWyUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWm0ma6Uv/Pz1Rn7x/eKs1RAtCbjKtCW6kaov2F5KWA=;
 b=PHhAD2JvF4J/hYbbSnIpugQMLXxdhK4M93xndIhXJlSQAx+qvVSDL1aPIHKKgP77QJ8fEsesuE/R9ktZxkm2R+IaOQrZUBSSDsNtoeQq4JXV/4NKiEvXpVPYE+Urz1j93oEyPKRmFqdzjjJ5m8fsSl9bKcD2h5eFA8UrTEjIg7A=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1422.namprd15.prod.outlook.com (10.173.234.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 16:39:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 16:39:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yufen Yu <yuyufen@huawei.com>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md: avoid invalid memory access for array sb->dev_roles
Thread-Topic: [PATCH] md: avoid invalid memory access for array sb->dev_roles
Thread-Index: AQHVjgfT8ofWIgLsSky6l0dL0pNNPKdx0r4A
Date:   Tue, 29 Oct 2019 16:39:17 +0000
Message-ID: <0B3C835E-3CC8-4FC7-9DDF-2AF0A043E479@fb.com>
References: <20191029034143.47039-1-yuyufen@huawei.com>
In-Reply-To: <20191029034143.47039-1-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::3e14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 194ce96d-10dd-4bf1-ed16-08d75c8e8a63
x-ms-traffictypediagnostic: MWHPR15MB1422:
x-microsoft-antispam-prvs: <MWHPR15MB14224CA9E213B18B5386470AB3610@MWHPR15MB1422.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(66556008)(66446008)(66476007)(64756008)(486006)(76176011)(36756003)(476003)(25786009)(33656002)(6436002)(86362001)(8676002)(81166006)(14454004)(81156014)(6486002)(66946007)(50226002)(7736002)(229853002)(6512007)(76116006)(305945005)(5660300002)(8936002)(71190400001)(2616005)(14444005)(71200400001)(99286004)(186003)(46003)(102836004)(256004)(478600001)(316002)(446003)(6116002)(4326008)(2906002)(53546011)(6506007)(6246003)(6916009)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1422;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyGWwn0CoYO0g+2m1hzzYaKbdPVVQ57PNKGSN0+iI2P9adqORUVIN8P+bWoliA7rivATGI/uCO3F3LyBIf60PDqQzIvZ+zj3x6FVxrbh3gZ8pj241rU3e/tLzHlFITw20rewM3hf03/vJVDHAtS2midaLTJLg9GlopuMcTfw2eAt2aFOC7r4Qfn4WTfeba71kw94lJ3FuMOVyE1M/01GCa3+o0Iovm9KiSeMClN27XIsgQy0FzForLyvHfVziT8omPBnStbiAuUzYK1CScnkWg1/59sDrQhZT12sbb4IWEomN31uYgvNnD0IBqv3enxmh1pvTS07h1uXZE6FtRH2k3R6R/iptc1DpyKYfxbcwWoNaW43TFfwc1s3EzPRpF+ruKKdM3i/HJoK+ghN5V28p/XdsymwLQgD/ePXRy6RlHfqoHebPPtoZA3WqglQAXV3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B5D956A2DF25E4E814926E49B2346F5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 194ce96d-10dd-4bf1-ed16-08d75c8e8a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 16:39:17.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6yIefI2bZA8sb33sI3BaBPJTjsZkt+zjw45uRU/0WdWTLcA1lJGIdlILg7vqYIb1LnOWKJxUqkitTUJBVG+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1422
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290148
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Oct 28, 2019, at 8:41 PM, Yufen Yu <yuyufen@huawei.com> wrote:
>=20
> we need to gurantee 'desc_nr' valid before access array of sb->dev_roles.
>=20
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1487373 ("Memory - illegal accesses")
> Fixes: 6a5cb53aaa4e ("md: no longer compare spare disk superblock events =
in super_load")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
> drivers/md/md.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index fc6ae8276a92..8832ab70e34d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1153,7 +1153,8 @@ static int super_90_load(struct md_rdev *rdev, stru=
ct md_rdev *refdev, int minor
> 		 * Insist on good event counter while assembling, except
> 		 * for spares (which don't need an event count)
> 		 */
> -		if (sb->disks[rdev->desc_nr].state & (
> +		if (rdev->desc_nr >=3D 0 &&
> +			sb->disks[rdev->desc_nr].state & (
> 			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> 			ret =3D 1;
> 		else

So, we get ret =3D 0 for LEVEL_MULTIPATH. Then refdev would always=20
be NULL. This doesn't look right.=20

> @@ -1178,7 +1179,8 @@ static int super_90_load(struct md_rdev *rdev, stru=
ct md_rdev *refdev, int minor
> 		 * Insist on good event counter while assembling, except
> 		 * for spares (which don't need an event count)
> 		 */
> -		if (sb->disks[rdev->desc_nr].state & (
> +		if (rdev->desc_nr >=3D 0 &&
> +			sb->disks[rdev->desc_nr].state & (
> 			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)) &&
> 			(ev1 > ev2))
> 			ret =3D 1;
> @@ -1540,7 +1542,6 @@ static int super_1_load(struct md_rdev *rdev, struc=
t md_rdev *refdev, int minor_
> 	sector_t sectors;
> 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
> 	int bmask;
> -	__u64 role;

Hmm... why did we use __u64 in the first place...

>=20
> 	/*
> 	 * Calculate the position of the superblock in 512byte sectors.
> @@ -1674,8 +1675,6 @@ static int super_1_load(struct md_rdev *rdev, struc=
t md_rdev *refdev, int minor_
> 	    sb->level !=3D 0)
> 		return -EINVAL;
>=20
> -	role =3D le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
> -
> 	if (!refdev) {
> 		/*
> 		 * Insist of good event counter while assembling, except for
> @@ -1683,8 +1682,8 @@ static int super_1_load(struct md_rdev *rdev, struc=
t md_rdev *refdev, int minor_
> 		 */
> 		if (rdev->desc_nr >=3D 0 &&
> 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
> -			(role < MD_DISK_ROLE_MAX ||
> -			 role =3D=3D MD_DISK_ROLE_JOURNAL))
> +			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
> +			 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) =3D=3D MD_DISK_ROLE_JOURNA=
L))

Same concern for LEVEL_MULTIPATH applies here. And maybe we can make this=20
code simpler?

Thanks,
Song

> 			ret =3D 1;
> 		else
> 			ret =3D 0;
> @@ -1710,8 +1709,9 @@ static int super_1_load(struct md_rdev *rdev, struc=
t md_rdev *refdev, int minor_
> 		 */
> 		if (rdev->desc_nr >=3D 0 &&
> 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
> -			(role < MD_DISK_ROLE_MAX ||
> -			 role =3D=3D MD_DISK_ROLE_JOURNAL) && ev1 > ev2)
> +			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
> +			 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) =3D=3D MD_DISK_ROLE_JOURNA=
L)
> +			 && ev1 > ev2)
> 			ret =3D 1;
> 		else
> 			ret =3D 0;
> --=20
> 2.17.2
>=20

