Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0080E3F58
	for <lists+linux-raid@lfdr.de>; Fri, 25 Oct 2019 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfJXW2C (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 18:28:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727635AbfJXW2C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 24 Oct 2019 18:28:02 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OMNcQK009107;
        Thu, 24 Oct 2019 15:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MZtbg2cKp+h1aB9Qrr+qv2DGOlJaQWhuU6YK9DRHam8=;
 b=X9eIu2yP06qe9Pkdy7pPYcH5op3gCkSR0t0Rz/4Xc8anX8MxUez+KB7feKIKyUyAQI80
 11CIF1/Pmq4nbATL5yGVRS6GVhSwaGk5mHAAVzVqYqOJH+0IgBe7DDX61Gljn09c+XMa
 6m0kAhliDunq7RFiMzygE6NZOrIu8AWjzRc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vtyd6wy0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 15:27:04 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 24 Oct 2019 15:27:03 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 24 Oct 2019 15:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/TYUJQc9YdyaPd5Y3XJaCWpB1zK2XTekaVn5HzqFKex9dkJ9uho51h2E9mbULcQgOIxFddXIsbp1mWa+D/p1JWu9raMgmxKR0ThKwU+8iiy4l+Ohnq0yWv+Ju5KLZ5ga2VhzbeKqMp29fUbPYVHwHEe0vWrl//mEIutPTq/kft6JLO9QhdHqGIqeSxENNdul4EhtUEN60yzwkuLm2W6OmXhPpyVDodwhp7scOIyca2CwZrzU/qzjnh3jeCRSTXZgJWGsVgCgalLFQoH71QirxBWsFLdWvO06uwiPdDL7mRWX+muXNgJf6uZS4TB2og8VjLqqrd8X9zdk2WeGLzwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZtbg2cKp+h1aB9Qrr+qv2DGOlJaQWhuU6YK9DRHam8=;
 b=V49Q86Ap2oA1gCKPC2gyAayjjmIvD2aqaSDIv5GZMOybd/InhqL2T3WvwVIGGreEl76Ph+o2Q8PdQGAeaLFJJjdodUS4cCirwdSff1m+Bv8h5CnCoMH5gc6Zh/A1/ZXEZp+9HAhXcH081vAkVVuQVlW9awc8NtVo8Kq5R+0n4odNiOt46XhbhmGxUdC3wV1zyDHDiOSJBpIufd+KyWL+75CrX4Rq8/YGu3aD+3BIWA4ACfhhVh7RaUDUjDQ7tOcvSV/eJ1VCyIJOoj3R4wvJAjLhfwXF6g92VnSlrUwPFNkFUkQhX4/8qEelggSppOcW0w1nzRnxPrEkbgkRpO/EVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZtbg2cKp+h1aB9Qrr+qv2DGOlJaQWhuU6YK9DRHam8=;
 b=TTjrGERhuODIa6l4/spAD8iqFC2xSNF8xQVP15khArQ0tlhu8HfiQYPONHumxVXpyvv1nXXRXgPm1kNKYWLqHNMtN7i+tBe49J49vJA+j1Hkds7hRFft/Gk3E7vYZGSuQYuIPE5kt0B7fUFRSLW7wxY7eIG2TVsl5F1ovPTbE0s=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1854.namprd15.prod.outlook.com (10.174.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 24 Oct 2019 22:27:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 22:27:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Jeffery <djeffery@redhat.com>,
        "Guoqing Jiang" <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Yufen Yu <yuyufen@huawei.com>, Xiao Ni <xni@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [GIT PULL] md-next 20191024
Thread-Topic: [GIT PULL] md-next 20191024
Thread-Index: AQHViqRZgvVuDA4rlUOLrOyy66GYN6dqXQWAgAACAYA=
Date:   Thu, 24 Oct 2019 22:27:01 +0000
Message-ID: <F2681048-5B87-49A9-883D-FB892EF6831E@fb.com>
References: <ED0B162E-09AC-420D-9620-849EAB38C195@fb.com>
 <d452324f-ce01-2220-0ea2-19f23e46dba2@kernel.dk>
In-Reply-To: <d452324f-ce01-2220-0ea2-19f23e46dba2@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::3:e83f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de883df9-c71c-4257-06b9-08d758d14a94
x-ms-traffictypediagnostic: MWHPR15MB1854:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1854E3B647908AC93627C618B36A0@MWHPR15MB1854.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(8936002)(50226002)(2906002)(14454004)(6116002)(64756008)(36756003)(76176011)(446003)(66446008)(46003)(2616005)(53546011)(99286004)(6506007)(6436002)(66556008)(11346002)(486006)(102836004)(71190400001)(71200400001)(76116006)(186003)(5660300002)(6486002)(6246003)(6512007)(14444005)(256004)(305945005)(66946007)(966005)(6306002)(7736002)(8676002)(476003)(66476007)(81156014)(81166006)(86362001)(316002)(25786009)(33656002)(478600001)(4326008)(229853002)(6916009)(54906003)(4001150100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1854;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7DIT3axf1OyKfTPLXyyJfXjTr7/zNwbjgJpWAmJoCFwXQ/w+YvJWZjo92X+ndB7/9KLmDzPhK91eqpneR+26fAWNyFgFuhdcg8e92Mq/ItONeqIBSKEVHE/z/iUZ6YN4NaOQdAUWIBGzT1pBi4gQUJwxdNay4mlFaY4rexJYAHGoRmHcYifSXPjRJ7p6CgF3h8+fZVV48/SBBcCIaf3iEfvkPQhEjyzRGz3j6W8esgsR+rerPEU5cr+3618aohu8oRB+iycjPNSxCAnB1TaiWTTC+D0DCb6cEuoLH2uwWugIJEv0eIhBexRUxWwk9kElsvQbGPz+xhN57Q5IDy9Of2RXjmDZTkaAhiaCtM3M8vY4tx1w1FJUbipLXWFmiGfHCf9hXW69zt+1RwpCpAs6pQ+gUqS46UhtB/Rg1xPHE3FAM4zD/M4GtpL85QWiV+jJoOmUi9SKwde1OFACkgMMmyMZw3R4cnJKfDP/Q0N6H8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7C9A1DEF293BB4E84B13EE2AA7A7C82@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de883df9-c71c-4257-06b9-08d758d14a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 22:27:01.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNaE56DVAsYAcih3ehQvOT9+vJ+RKiXF3DtEHvi4g3fq1lA4M4/HWCA7TminM92vmMG98sHmdpYYb/WOUimpXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_12:2019-10-23,2019-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910240210
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Oct 24, 2019, at 3:19 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 10/24/19 1:50 PM, Song Liu wrote:
>> Hi Jens,
>>=20
>> Please consider pulling the following changes for md-next on top of your
>> for-5.5/block branch.
>=20
> Would you mind rebasing this on top of for-5.5/drivers? Linus wanted me
> to have stronger separation between the two, so...
>=20

Sure! Please find updated request below.=20

Thanks,
Song


The following changes since commit dd85b4922de1b70f0729d2a7856db619e210a8ec=
:

  null_blk: return fixed zoned reads > write pointer (2019-10-17 19:01:22 -=
0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 6a5cb53aaa4ef515ddeffa04ce18b771121127b4:

  md: no longer compare spare disk superblock events in super_load (2019-10=
-24 15:22:40 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      md/raid0: Fix an error message in raid0_make_request()

David Jeffery (1):
      md: improve handling of bio with REQ_PREFLUSH in md_flush_request()

Guoqing Jiang (1):
      md/bitmap: avoid race window between md_bitmap_resize and bitmap_file=
_clear_bit

Yufen Yu (1):
      md: no longer compare spare disk superblock events in super_load

 drivers/md/md-bitmap.c    |  2 +-
 drivers/md/md-linear.c    |  5 ++---
 drivers/md/md-multipath.c |  5 ++---
 drivers/md/md.c           | 68 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++--------
 drivers/md/md.h           |  4 ++--
 drivers/md/raid0.c        |  7 +++----
 drivers/md/raid1.c        |  5 ++---
 drivers/md/raid10.c       |  5 ++---
 drivers/md/raid5.c        |  4 ++--
 9 files changed, 76 insertions(+), 29 deletions(-)

