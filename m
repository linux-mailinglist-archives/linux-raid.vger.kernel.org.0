Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93E0D8A25
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfJPHrO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 03:47:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726872AbfJPHrN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 03:47:13 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G7jANS026980;
        Wed, 16 Oct 2019 00:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=fDm8AdOgdno/PoDDgKbHOlRE+lWx9nQspktgoW0Y3Zg=;
 b=jzv5iPqCM0l/GLjBnPf5Kkg7KqR5fNYms9rTgibJdM8v7sB60TWkJ4bQobudkrGz6hqI
 PnrNyvrobbrq/NGqQCOjHNdYh7vVSFCeA+bzR+guYXHnZWJz6qbumyzESC0zpqEKFeVa
 QivMvkS0AaGLRKOrqT7+KqkIc9JzYazPm38= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vn8jv614b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 00:46:27 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 16 Oct 2019 00:46:27 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 16 Oct 2019 00:46:26 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Oct 2019 00:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOl+yEL4vzB3LfITd0HMaMK0cN4IHPqtY1Tf4ZZoRnZ/8mS2eD9/1/7B3G7V06ZWUoxhDJ73ffceWdDkRJfY/YKI/A+GOOnlRXR8wvaZ8MuCwi0zUi/oZOPIzhhWfRIL0UYX22SB7D/WbqrnPxXx6RBi0cZgWww3OG461+s5p4T6yKWZZbtbS9k/tdSA2OvHFuJrvC6p42J10LZEU30Sd1SInMFTliRQl4bxI4YKBqHmpWxQKC06CEKOJYDhyPOK3JYm3cYY01dQy0X2SGqdHroWi35+9wan5L5Fdr6Y1FhynP4HruxawmP1pSiOJDbIkXUGSzcbvkIGcpldv7lZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDm8AdOgdno/PoDDgKbHOlRE+lWx9nQspktgoW0Y3Zg=;
 b=EnasJsn85YFIhpmwBEMCfL7MOI+fPlhNoFw08ADsEtCY6qCAdjCFnIfctm5q5kS2bxAobdf8yDSNORL1c3jYOSiFcHM6JRPAjS7rF0/g9ElJoyAtKZjFgwfvzBg4xonsKLSvx0V7p+ntVQEcLJsh4Lx0Nk3y0h7qPCuKRDKUF2WLvorSJecBHj2VJv8TZFGp0xTLEsRhHvAFzts8JpqPdz7H+y4rgYWnr8SKjZd28VX8pMMiMcjkkgeN+UkzOTgBUVJSmPfSCy9ZJOKc9RssCauDfusmqjwy41d4mv7T9iz/Jx+Pj3ac7ye1/7L23+v7gYz/Be15rBPa1VUUEl41Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDm8AdOgdno/PoDDgKbHOlRE+lWx9nQspktgoW0Y3Zg=;
 b=b/WE7/OMsUOeiv0AXm5zhzZRgFGymE5CfNDg54bB+DD1l6YrJLenre9Mh7C0zTnpdkKvZaGFsG7kPobhnHhgqjVuCnmLKeRYy0STDdEsw86R9wYzDZaKu75FPDYC4PAprhyHgVax07K23ZMBOZpVqGGyNm/SqfHnOEYVK0ylwLE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1504.namprd15.prod.outlook.com (10.173.233.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 07:46:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 07:46:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yufen Yu <yuyufen@huawei.com>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH v4] md: no longer compare spare disk superblock events in
 super_load
Thread-Topic: [PATCH v4] md: no longer compare spare disk superblock events in
 super_load
Thread-Index: AQHVg/TJDL03ZbG/CUSIU+N+hJaPo6dc47WA
Date:   Wed, 16 Oct 2019 07:46:25 +0000
Message-ID: <E660B713-3623-4C8E-BF22-41ACC09F26DD@fb.com>
References: <20191016080003.38348-1-yuyufen@huawei.com>
In-Reply-To: <20191016080003.38348-1-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::fb00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34c701a4-bd31-4a59-87fc-08d7520cf274
x-ms-traffictypediagnostic: MWHPR15MB1504:
x-microsoft-antispam-prvs: <MWHPR15MB15046D2C004B8E4F7E352340B3920@MWHPR15MB1504.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(229853002)(46003)(6916009)(6512007)(50226002)(446003)(11346002)(5660300002)(6116002)(14454004)(71200400001)(71190400001)(478600001)(8936002)(66946007)(186003)(6436002)(36756003)(2906002)(81156014)(256004)(33656002)(14444005)(4326008)(76116006)(76176011)(8676002)(81166006)(6486002)(66476007)(66446008)(25786009)(86362001)(486006)(6246003)(7736002)(66556008)(2616005)(102836004)(64756008)(99286004)(316002)(53546011)(476003)(305945005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1504;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqgUrmzB8jST8TvKzC9G1eQIQXeID6Ds3kwUqTxiZBRHo2Bo/xFKvhDhCMg+mfvJmU4VE4l2WErCIBxoQJ1llYwlR+k+Dlbl29BOFTOHxOP4QbZn6cGh1pk1Z7uEzdzUIi7TX/3lY1DMyoDvWcZZgpvrmNLcgxuC70Hi5fZ18bbriaXcYi/yURLsuioIj+F4MPxqGhHoMVtpCFnwyET8ZhJlygoyGtwjXvhk3Sks+Tsv771o1e1Dj7XuLS81XSS/4bRef31+CE3FpU8LGQBhcWJ6OIUVf8ghpUpGXElDYTmZucD2eF4/3bWNDj5zYyquz0CCnGH4f0CKvy4jjAh05LTKetHKiXKyG1B7xFs8K3NU2KwIRJGINqXpQRYgt5KFJbviQFLCRfEx+u5XKejm1tSfTa1yu4O4H/R/gcILq8o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99E0AB5FE3DAC64AB38360F67F4ABF78@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c701a4-bd31-4a59-87fc-08d7520cf274
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 07:46:25.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92RTzLmPLjLky2ew05L36OF/Seqko5pDRErk1C5Y0IVPbLtD97tlC7XUjQ75vnwxv4eKvxYY8dAVTI720p/FXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160072
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Oct 16, 2019, at 1:00 AM, Yufen Yu <yuyufen@huawei.com> wrote:
>=20
> We have a test case as follow:
>=20
>  mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
> 	--assume-clean --bitmap=3Dinternal
>  mdadm -S /dev/md1
>  mdadm -A /dev/md1 /dev/sd[b-c] --run --force
>=20
>  mdadm --zero /dev/sda
>  mdadm /dev/md1 -a /dev/sda
>=20
>  echo offline > /sys/block/sdc/device/state
>  echo offline > /sys/block/sdb/device/state
>  sleep 5
>  mdadm -S /dev/md1
>=20
>  echo running > /sys/block/sdb/device/state
>  echo running > /sys/block/sdc/device/state
>  mdadm -A /dev/md1 /dev/sd[a-c] --run --force
>=20
> When we readd /dev/sda to the array, it started to do recovery.
> After offline the other two disks in md1, the recovery have
> been interrupted and superblock update info cannot be written
> to the offline disks. While the spare disk (/dev/sda) can continue
> to update superblock info.
>=20
> After stopping the array and assemble it, we found the array
> run fail, with the follow kernel message:
>=20
> [  172.986064] md: kicking non-fresh sdb from array!
> [  173.004210] md: kicking non-fresh sdc from array!
> [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
> [  173.022406] md1: failed to create bitmap (-5)
> [  173.023466] md: md1 stopped.
>=20
> Since both sdb and sdc have the value of 'sb->events' smaller than
> that in sda, they have been kicked from the array. However, the only
> remained disk sda is in 'spare' state before stop and it cannot be
> added to conf->mirrors[] array. In the end, raid array assemble
> and run fail.
>=20
> In fact, we can use the older disk sdb or sdc to assemble the array.
> That means we should not choose the 'spare' disk as the fresh disk in
> analyze_sbs().
>=20
> To fix the problem, we do not compare superblock events when it is
> a spare disk, as same as validate_super.
>=20
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Please add "---" before "v1->v2:". etc. This will hint git to not=20
include these change lists during git-am.=20

>=20
> v1->v2:
>  fix wrong return value in super_90_load
> v2->v3:
>  adjust the patch format to avoid scripts/checkpatch.pl warning
> v3->v4:
>  fix the bug pointed out by Song, when the spare disk is the first
>  device for load_super
> ---
> drivers/md/md.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 51 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1be7abeb24fd..fc6ae8276a92 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1149,7 +1149,15 @@ static int super_90_load(struct md_rdev *rdev, str=
uct md_rdev *refdev, int minor
> 		rdev->desc_nr =3D sb->this_disk.number;
>=20
> 	if (!refdev) {
> -		ret =3D 1;
> +		/*
> +		 * Insist on good event counter while assembling, except
> +		 * for spares (which don't need an event count)
> +		 */
> +		if (sb->disks[rdev->desc_nr].state & (
> +			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> +			ret =3D 1;
> +		else
> +			ret =3D 0;

Have you tried only passing a couple spare disks to mdadm -A? I guess
we will end up with freshest =3D=3D NULL in analyze_sbs(), which will
crash in validate_super().

Thanks,
Song

