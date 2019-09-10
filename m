Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6408AAEEC7
	for <lists+linux-raid@lfdr.de>; Tue, 10 Sep 2019 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436554AbfIJPpW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 11:45:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62254 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbfIJPpW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Sep 2019 11:45:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AFdYT5027036;
        Tue, 10 Sep 2019 08:44:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=j11f4/MemeTkPj3hlWj1qfjIXyE4psy2WDFrk/OgbeI=;
 b=Ose+ENGndAi6TJk0cdpblv6NRWOrZbgZeMhN2hETupnu/fdJ6vTxGqSCx/UftN0Or2WY
 2UIKGh6KQLlglwvYImrkVU7N0TWiMOEyWOL9B6ffX5L827D/3dS7wmvq9z5ONEFazwmI
 SL1cMiVcaNigwOmQ8IxocrrfzMkK1TkLsGc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uwxh2usmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 08:44:19 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 10 Sep 2019 08:44:18 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 10 Sep 2019 08:44:18 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Sep 2019 08:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LITOP8PZtZ6PxmSEZYYAxt2zBNsw3dRdVkOmd3X4t8kltMYBcxUrYttdH2EHbyLZL34n03CI6aj9KGA8i6U0qdZhPBIRNmEwotZJht9+OEhmPpjgruUmjfVGReMcpM20Q6Kk9xB3CSKAD6PfKW9HsoIIGgrxSS2RlZWlJMaDqk2OtC5eqmikD2XZEIfWnF5DK2fvhHTMbQck9ReXPGMaKuAo3YqnbVzdveQ6BLNpC7GamAYXcnmeGkLgQRxbwca/O8Vcjlpk9gAJjteowO43oXOqj0HpK49E5F85EubXHo8+zFK8HF9iKuYTcdhjLtvdcAcMKoY5Q5KB88bdH/Hxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j11f4/MemeTkPj3hlWj1qfjIXyE4psy2WDFrk/OgbeI=;
 b=U7J6MxRmPBzwf7y9bqeLztOLuqIoEbgj93ZyTuN3dqCSn/Ey7Nzn6pgRkvAunzn1Ng0QXhMkdL8svgZt5Ntj/ErBBaR2zkDw7RlQzBdZy1EeXBfVjv06vK8qS0ZyRe0I8SdyF0bTN1sqZ5jn9i39b96Q61/SHCCxtATGAzF6aQ2r4c+IoaaAa0GUFP8rpCGiyXeHHDxEYUfLQINtb/JrfM9TQkHpyNqoxs4wEFvDKoHZzeAMu06S+1gIEGrWgKgXUGcGssqKnoE+7jj10qAJx19ElaJ0OhP+Z2oOONpwOfUaI0p6LpfcY1lmJl9Qhnxk49/YNlWmQ2R4aKQNYWtm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j11f4/MemeTkPj3hlWj1qfjIXyE4psy2WDFrk/OgbeI=;
 b=TL9X1v9HAPBLhsAVPQ4ffCN2MOXlYBqVW5czE2GYoL1nZeEIgaa+yPTAsaW27+KuvLLYM9ZU1S/oVb9J5aGYR8lIalduCF8r8K8D6RhuhnsG0FnVhhp+Su0SE5CUkprCjStZh3Az0/Web77Q4Z/XqASygD6DJ5/kgmHPXlUtr/M=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1392.namprd15.prod.outlook.com (10.173.234.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 15:44:16 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 15:44:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yufen Yu <yuyufen@huawei.com>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH v2] md: don't let spare disk become the fresh disk in
 analyze_sbs()
Thread-Topic: [PATCH v2] md: don't let spare disk become the fresh disk in
 analyze_sbs()
Thread-Index: AQHVZ8tCJThDYmGmJEiUKfbpNGDv46clDZyA
Date:   Tue, 10 Sep 2019 15:44:16 +0000
Message-ID: <F8E49799-63D1-4F2B-8E66-F9F1DD7B9ADD@fb.com>
References: <20190910115134.12328-1-yuyufen@huawei.com>
In-Reply-To: <20190910115134.12328-1-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c092:180::1:cd76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81b8b3ce-cf5b-4db9-8313-08d73605bcdf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1392;
x-ms-traffictypediagnostic: MWHPR15MB1392:
x-microsoft-antispam-prvs: <MWHPR15MB13925EF40857C359DB53F08BB3B60@MWHPR15MB1392.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(66446008)(99286004)(36756003)(11346002)(4326008)(2616005)(5660300002)(186003)(305945005)(91956017)(25786009)(86362001)(6486002)(7736002)(46003)(6916009)(229853002)(6512007)(14454004)(8676002)(76176011)(33656002)(54906003)(8936002)(446003)(14444005)(256004)(6436002)(81156014)(81166006)(76116006)(6246003)(2906002)(53546011)(478600001)(486006)(476003)(6506007)(102836004)(316002)(53936002)(66556008)(64756008)(66476007)(6116002)(50226002)(71200400001)(66946007)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1392;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RMbAjm7E5XWiSQ3nFUuIhkgf5NnetG7GTnUmoiRTxCgE/3rdTsY1sF13jSBcb2DxL+9QfXke0crRqzK3H6jTPCcSGVfCAHG+YSZIn2Hg9h4rjobyeAYWsc1TVqMiGoiJihH7+xlb6jmMGReEgYuRjFy+O1BjjaKfbWTvpgf3iWdnKc0prpxZ7frxLrjDH0byCC96lBgMhsMkJEwaeMd9oyCVXfQr8xF2knR+3dDLoLU424IhHBi13Br7o+pfBrxOgNI50iJ5lEoRnsrFCZJy5ANpa8J4m9mO3j426ILVdgeM2rqIfScfeptw4C4TkAsWWoBTKyZTzbtq4yY8GYXFW5qr4mnyegDb1x91vrue1bVps/Xi0CELre7g1UIQrUhGVwQjeysa/RPKkLrsEW+LgMsdrGVHfykRqAFwAtfDf9U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F27FF035259064A8BD1FB6487D03070@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b8b3ce-cf5b-4db9-8313-08d73605bcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 15:44:16.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLxVOtz2PCWgqE/AtfemchUY/BwnklGkpR9DFRnscvoxQxD/R7XebuatpuB8H2NXWUaHfspoQ4j5EpKeuOC3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1392
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_11:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100148
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Sep 10, 2019, at 12:51 PM, Yufen Yu <yuyufen@huawei.com> wrote:
>=20
> We have a test case as follow:
>=20
>  mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] --assume-clean --bitmap=3Dinte=
rnal
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
> added to conf->mirrors[] array. In the end, raid array assemble and run f=
ail.
>=20
> In fact, we can use the older disk sdb or sdc to assemble the array.
> That means we should not choose the 'spare' disk as the fresh disk in
> analyze_sbs().
>=20
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
> drivers/md/md.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 48 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 24638ccedce4..5a566750afc1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3571,18 +3571,56 @@ static struct md_rdev *md_import_device(dev_t new=
dev, int super_format, int supe
> 	return ERR_PTR(err);
> }
>=20
> +static int disk_is_spare(struct mddev *mddev, struct md_rdev *rdev)
> +{
> +	int err;
> +
> +	err =3D super_types[mddev->major_version].
> +			load_super(rdev, NULL, mddev->minor_version);
> +	if (err < 0)
> +		return err;
> +
> +	if (mddev->major_version =3D=3D 0) {
> +		mdp_super_t *sb;
> +		sb =3D page_address(rdev->sb_page);
> +
> +		if (sb->disks[rdev->desc_nr].state &
> +			((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> +			return 0;
> +
> +	} else if (mddev->major_version =3D=3D 1){
> +		struct mdp_superblock_1 *sb;
> +		sb =3D page_address(rdev->sb_page);
> +
> +		if (rdev->desc_nr >=3D 0 &&
> +			rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
> +			(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
> +			le16_to_cpu(sb->dev_roles[rdev->desc_nr]) =3D=3D MD_DISK_ROLE_JOURNAL=
))
> +			return 0;
> +	}
> +
> +	return 1;
> +}

We should add "disk_is_spare" to struct super_type.=20

Thanks,
Song=
