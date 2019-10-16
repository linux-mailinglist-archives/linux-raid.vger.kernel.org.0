Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B724ED8877
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 08:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfJPGGe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 02:06:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36832 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfJPGGd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 02:06:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G630Ao031341;
        Tue, 15 Oct 2019 23:05:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vMMMU/xEtYpAexHwq7IZ4Rf9ay06ctMJ+93+p3DCdic=;
 b=QYYf4plMwFfzx1uVi4VH+6qb/9DDcfS2d3qTUKflOS6KLq80b/3DRppCy3SZg+t9ZJ7E
 bvRi3iGAx3R9Iy4pn6cjOY1EI+40Eb23jObzgoX3CNL3IrIfwrfqEUomi1VGKnbfJaAd
 5qz/L0EkPKOv4gJ76HYUhd7Ke9MWRImj9/8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnfbbv1u0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Oct 2019 23:05:37 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Oct 2019 23:05:35 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Oct 2019 23:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdI+uGlYUOhL69mGhrCbER3xRzbMegGxdXfgoXMghRo6PsgDkYhW0O71cu9yErpMoMJUxosPj7Qa7G3w+E0UT3W4yo5w2eltqI2ku8L5zLv8vR1gXpJoABmWXE80TcYWLUgi1ybH3vY5ysQi61HMF0v40g/mWSSVaqH3OaOEByM4bx18wFT/BhfCJkRlaiQ8FTbuqVvGiuwI+kr1eSugdcp4xnekhlV3hBjqjNAjg6piEWJl8CwaQ6i56cBejDjRUmvgGlRnhBxdVfW8C9ORK8az3Ghq4omoF13tvx2nWDxaweca+Rt/G3tvOHJNSfbq4/EpvbXUUyaw1JXRCDz/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMMMU/xEtYpAexHwq7IZ4Rf9ay06ctMJ+93+p3DCdic=;
 b=lzo4f9xbhwDRLzlYIXt+5N7IlDXzagBDFckS3PyHiUT545ot12lstYT9mVNdYdAfo8EuJ6yv4kNAo+vroNEG/hcn31CxLROvPw/2FLTD7ImDuNsEgEUXlPDJyAcM76Xwm4eX09Jc+KR5r9T1dlj6S7a6wSkD2XzV9rSQ+EOhBhoZXym5qs2a0zQ6AJxmLvSkcGAygZUWEF4a/oinVq+AIup2H1lGrx1vB3gUwysi/9+bB6n8i+KkZWbT5gQP6Jyw5XXfoObHUgsbrr1qYroR0xPlg085ayF/A2dD/Iwx0zB9zz+zto17lnE2EirncoplUjed5eJW+Fqe2OCm8abfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMMMU/xEtYpAexHwq7IZ4Rf9ay06ctMJ+93+p3DCdic=;
 b=RgIIKTC0Xtz3XE9U8fOGlg9aQLGVjZUl5DQLfgU1VbTrLd7rjE1xy5hYUDo36AFY5+9EVlDnJlxYlOZ0EUCDqdUpMYg8D9R1u9zItJOpMbmdXAv9ZLogMxkj+StSvfOKq1VxCY/ngchPPaheTXyiH+t9u3p9N4oFP4RKuUHr7/g=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1629.namprd15.prod.outlook.com (10.175.141.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 06:05:34 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 06:05:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yufen Yu <yuyufen@huawei.com>
CC:     Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH v3] md: no longer compare spare disk superblock events in
 super_load
Thread-Topic: [PATCH v3] md: no longer compare spare disk superblock events in
 super_load
Thread-Index: AQHVgwIFfxLI5l/TMkeuqdnFexxix6db4OoAgADCRgCAACY8gA==
Date:   Wed, 16 Oct 2019 06:05:34 +0000
Message-ID: <12BF33FB-A5D4-45C8-9D5D-030E2568C74C@fb.com>
References: <20191015030230.13642-1-yuyufen@huawei.com>
 <CAPhsuW5hF-SkCX4n7dJnZfEwFnTF=egjwCOJxt695Fuh6L8K3A@mail.gmail.com>
 <348e419c-5656-c8fa-5ec5-e39dda8a9b0d@huawei.com>
In-Reply-To: <348e419c-5656-c8fa-5ec5-e39dda8a9b0d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::fb00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb170707-31a1-4d53-6bdc-08d751fedb8a
x-ms-traffictypediagnostic: MWHPR15MB1629:
x-microsoft-antispam-prvs: <MWHPR15MB1629EC6421DF496E9B8A1A25B3920@MWHPR15MB1629.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(6246003)(71200400001)(4326008)(71190400001)(14454004)(14444005)(99286004)(256004)(2906002)(25786009)(36756003)(316002)(6512007)(2616005)(8936002)(229853002)(6486002)(478600001)(486006)(33656002)(6506007)(54906003)(50226002)(81166006)(81156014)(8676002)(6436002)(5660300002)(53546011)(305945005)(446003)(7736002)(76176011)(11346002)(46003)(186003)(66446008)(102836004)(6916009)(66946007)(86362001)(66556008)(64756008)(76116006)(66476007)(476003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1629;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IckoJA6SsKubYwT4B3wVSC9j0rO8rsbD3/lq9DmMAcFJ5Nm2zjvQiISuymH1cUS71ftuECnXmQgDNrjDVZF8IBGiGXSjV5PxL5qAvwgEU2P6jChZauXOkMEBBvRalR4OiybatLqWlu8e5MyWAb0K+ivqATqGf2HC53tZU7bopjYZ3X+zbpSQPsYnRogGRNYUaPN/CS0u1stqBrhMTY3oGpLq7QDAa971XxTYeYzhkNC0K4hI/vR6YMUBwJv2oYn2aIHQHuThEi0WqNngRZ4FB+31t1kyQQAMZ5W3VNj0fcW7ZcXgwAcww6i51iOSZokVpMzLe105+4xLQx1+Mo0hAD2xKckTNgqdfPYT1DMq4ARE9S0q2skg5Rgke0GqdUgRbXtGtazoCUp/zwl/oaMTH4615Yb/szYSS/LgXu4QGk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8A23A52E2B1B745B8F3335DEBD4C3B3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb170707-31a1-4d53-6bdc-08d751fedb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 06:05:34.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3g1XrbySFurQ/wV5CrJY2uM8lJeLS+MmNXsovSSNo5JrrrjDupmySP4hGWO4PiYHscqgzpo0kATvR01ee7Q3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_02:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160057
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Oct 15, 2019, at 8:48 PM, Yufen Yu <yuyufen@huawei.com> wrote:
>=20
>>>  drivers/md/md.c | 51 +++++++++++++++++++++++++++++--------------------
>>>  1 file changed, 30 insertions(+), 21 deletions(-)
>>>=20
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 1be7abeb24fd..1be1deca3e3a 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -1097,7 +1097,7 @@ static int super_90_load(struct md_rdev *rdev, st=
ruct md_rdev *refdev, int minor
>>>  {
>>>         char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>>>         mdp_super_t *sb;
>>> -       int ret;
>>> +       int ret =3D 0;
>>>=20
>>>         /*
>>>          * Calculate the position of the superblock (512byte sectors),
>>> @@ -1111,14 +1111,12 @@ static int super_90_load(struct md_rdev *rdev, =
struct md_rdev *refdev, int minor
>>>         if (ret)
>>>                 return ret;
>>>=20
>>> -       ret =3D -EINVAL;
>>> -
>> I think ret is handled correctly in existing code. I would not recommend=
 this
>> type of refactoring.
>=20
> Yes, there is no problem for existing code. But, after adding follow test=
:
>=20
> +               if (sb->disks[rdev->desc_nr].state & (
> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> +                       if (ev1 > ev2)
> +                               ret =3D 1;
>=20
>=20
> If the current disk is spare or events is smaller, then ret will be set a=
s default '-EINVAL',
> which is not expected. Just as super_1_load(), I refactor the return.
>=20
> If you don't like it, I can modify the test as following without refactor=
ing:
>=20
> +               if (sb->disks[rdev->desc_nr].state & (
> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)) &&
> +                       (ev1 > ev2))
>                        ret =3D 1;
>                else
>                        ret =3D 0;

I like this better.=20

>=20
>>=20
>>>         bdevname(rdev->bdev, b);
>>>         sb =3D page_address(rdev->sb_page);
>>>=20
>>>         if (sb->md_magic !=3D MD_SB_MAGIC) {
>>>                 pr_warn("md: invalid raid superblock magic on %s\n", b)=
;
>>> -               goto abort;
>>> +               return -EINVAL;
>>>         }
>>>=20
>>>         if (sb->major_version !=3D 0 ||
>>> @@ -1126,15 +1124,15 @@ static int super_90_load(struct md_rdev *rdev, =
struct md_rdev *refdev, int minor
>>>             sb->minor_version > 91) {
>>>                 pr_warn("Bad version number %d.%d on %s\n",
>>>                         sb->major_version, sb->minor_version, b);
>>> -               goto abort;
>>> +               return -EINVAL;
>>>         }
>>>=20
>>>         if (sb->raid_disks <=3D 0)
>>> -               goto abort;
>>> +               return -EINVAL;
>>>=20
>>>         if (md_csum_fold(calc_sb_csum(sb)) !=3D md_csum_fold(sb->sb_csu=
m)) {
>>>                 pr_warn("md: invalid superblock checksum on %s\n", b);
>>> -               goto abort;
>>> +               return -EINVAL;
>>>         }
>>>=20
>>>         rdev->preferred_minor =3D sb->md_minor;
>>> @@ -1156,19 +1154,24 @@ static int super_90_load(struct md_rdev *rdev, =
struct md_rdev *refdev, int minor
>>>                 if (!md_uuid_equal(refsb, sb)) {
>>>                         pr_warn("md: %s has different UUID to %s\n",
>>>                                 b, bdevname(refdev->bdev,b2));
>>> -                       goto abort;
>>> +                       return -EINVAL;
>>>                 }
>>>                 if (!md_sb_equal(refsb, sb)) {
>>>                         pr_warn("md: %s has same UUID but different sup=
erblock to %s\n",
>>>                                 b, bdevname(refdev->bdev, b2));
>>> -                       goto abort;
>>> +                       return -EINVAL;
>>>                 }
>>>                 ev1 =3D md_event(sb);
>>>                 ev2 =3D md_event(refsb);
>>> -               if (ev1 > ev2)
>>> -                       ret =3D 1;
>>> -               else
>>> -                       ret =3D 0;
>>> +
>>> +               /*
>>> +                * Insist on good event counter while assembling, excep=
t
>>> +                * for spares (which don't need an event count)
>>> +                */
>>> +               if (sb->disks[rdev->desc_nr].state & (
>>> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
>>> +                       if (ev1 > ev2)
>>> +                               ret =3D 1;
>> Just realized this:
>>=20
>> If the first device being passed to load_super is a spare device, we sti=
ll
>> have the same problem, no?
>=20
> Good catch!
>=20
> My local test with one spare disk and one normal disk shows that,
> no matter what order of two disks in 'mdadm -A', spare disk cannot
> be the first device in mddev->disks list. I think mdadm tool have
> ordered all disks by events. So, test case will be OK.
>=20
> But, I think we need to resolve the problem completely.

Yes, let's resolve this in kernel.=20

Thanks,
Song=
