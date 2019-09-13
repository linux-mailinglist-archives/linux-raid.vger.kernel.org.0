Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F81B268F
	for <lists+linux-raid@lfdr.de>; Fri, 13 Sep 2019 22:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfIMUU3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Sep 2019 16:20:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389255AbfIMUU2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 13 Sep 2019 16:20:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DKJAmr030766;
        Fri, 13 Sep 2019 13:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fJ0AbE4JkZpN03d+o40bbdBtyn++4XgO9bzjOIj0img=;
 b=iuxX3QhQYfZqr1dfLNG7ILQbWW6q+s7XzGjNXl0TB9Xchaq9J/x4MT+LvoXloUPP8nOj
 lbQLhHnGMCOKqSG0Ftln8FSt7BwTkfBb+WvRGC6O3Y6woc7q/4VgIVKyRMbweH99mar4
 KN+LKB7DEadPXCDLN/FZ+u0OqgiVg9LyDDM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uytd6nqk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Sep 2019 13:20:22 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Sep 2019 13:20:22 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Sep 2019 13:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1bhuG1ce5toFss22VxncdCqSNmOYKC1pf/6Tcadz9vaXo6/s+cXLt72Wp1+oXhFvMQpP/PuFWVJEYkET9fgbeEozjUJJNdL0AlANhXMp+ficQXb6fBF2BT1KGD/W3A4BX6VkYJKqgspXd3QdB7xtw9RIwyU90tjOcc+RqAPeHIEAmiICu5musRR941IvOuYFnTtMuAeOWpP+oBhUxtStcHDRxX9yC2nv8r45FBnrFoqmaRYMIU868FcRsi/NgpAAWGewlRQUDma0In9GCiskWq8wB83ODrzuCa9L0xMhEijm93+3st8LObdLDAeTcLZ38sJGZ/g/MYNgHzqdCGKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ0AbE4JkZpN03d+o40bbdBtyn++4XgO9bzjOIj0img=;
 b=ny5nbmvsc97NhEX2ro/r2djbWynQ2Katoo214Uug+YlGHYGcLxODMMqAApSkoQgZYoJoSGd0/QooK7bazAS0cTm/Ujcv3V15uI5vGhN4jdND590AiZJonHxgV344nVmp3Svfrlz25DXPOsSP129duHpMAaczkbn3f7t3IO3GrHxU4GEzW1VhoxwtWaggH3wmhWHUp6ot5vlQwZoeQetmxJvX8lyImkZTe11Ucswnw7XYUCIRCS7FkFdI7OA4CIe0UzPeeWwoSc7qsWAPpN9VgBqLUdffFY/J2AifapwaUTlA1SrurLAQptiQaXhK7DpZJRlideWgjoTYlXv/C/aLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ0AbE4JkZpN03d+o40bbdBtyn++4XgO9bzjOIj0img=;
 b=Kx4Kfz+ISF1KrktGdOZxhGjHlMecX681umlnj411OcyfJ1quUkosm6L2cUcSoA6w0WWDXxb+Q8gxsHWW9MkjldMyLdWVaR+ghBzg9ipSVKOSGjeJiU9m0EilxnZq+qhv0WhyLYzYfRkzRF6XmO9QcuT/fNBgWYruP0XZOYbWuqU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1214.namprd15.prod.outlook.com (10.175.2.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 20:20:20 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 20:20:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <jgq516@gmail.com>, NeilBrown <neilb@suse.de>,
        Nigel Croxon <ncroxon@redhat.com>
Subject: [GIT PULL] md-next 20190913
Thread-Topic: [GIT PULL] md-next 20190913
Thread-Index: AQHVanCqUi+x0XWuuk6fNofUvidw6A==
Date:   Fri, 13 Sep 2019 20:20:20 +0000
Message-ID: <B718A96B-0D25-46EB-815E-31ADD6007F17@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:4c3b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee35fcd2-a2a3-4857-8066-08d73887ccff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1214;
x-ms-traffictypediagnostic: MWHPR15MB1214:
x-microsoft-antispam-prvs: <MWHPR15MB1214DD953661B9C52A778C72B3B30@MWHPR15MB1214.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(66476007)(6486002)(53936002)(5660300002)(186003)(66556008)(64756008)(66446008)(476003)(6512007)(46003)(486006)(66946007)(6436002)(50226002)(76116006)(81166006)(81156014)(14454004)(86362001)(6506007)(8676002)(54906003)(478600001)(6116002)(110136005)(99286004)(14444005)(71190400001)(71200400001)(102836004)(305945005)(25786009)(7736002)(256004)(33656002)(36756003)(4326008)(2906002)(316002)(2616005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1214;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +vNk7cLCt32k8ZxiP00JcBnhOBFF6CfauGsr7MGZ2x8LWHgeV06iNnLQ53rnHAHbEzD9kRR3/sPBspsHGwOje36jPdhsCFys1m3RFlRLpFkOcy4e/O37N/cDgQPa3U7mScS2yQvhavgSXTaggwiGV3tvjyN43n2GFFiF4h6BqMnx0A5HJDqn+Etd+1dpnpDbLQ1RfqyK6aNIePKgodFrDTC3JX+5Tlr3l3OOQ3EaFCpHfFj/0WjUgx14Ty/lVXOnykAGvqJobP2Ha/l1KU4brFM1amN1WrdmT5ROwkpLGU1VBDrbIb3w7dRWCwvlCDSk4WJkY6/HksgPm4N0RhoF7h4rpdlJVNvMLiLIlAK6yYRPt3tL5vB7ksCB+ZzMBdRSCsr5bBBWlPYT4XlE+NviQfunS8Z+oeAJYtMiAACZ59I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B83218BFF21A344928E4EA53FF0A063@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee35fcd2-a2a3-4857-8066-08d73887ccff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 20:20:20.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3EAjA//nX76ztQUReynEuRFStpHDpeenM41fmVuATkdB4F6aHs2fKHeXLW2fIp96xI6WmmwIwby8Q2W0Wdgcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_09:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=853 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909130206
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your
for-5.4/block branch.=20

Thanks!
Song

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The following changes since commit 21fa1004ff5d749c90cef77525b73a49ef5583dc=
:

  Merge branch 'nvme-5.4' of git://git.infradead.org/nvme into for-5.4/bloc=
k (2019-09-12 11:19:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 067df25c83902e2950ef24fed713f0fa38282f34:

  raid5: use bio_end_sector in r5_next_bio (2019-09-13 13:14:43 -0700)

----------------------------------------------------------------
Guoqing Jiang (3):
      raid5: don't set STRIPE_HANDLE to stripe which is in batch list
      raid5: remove STRIPE_OPS_REQ_PENDING
      raid5: use bio_end_sector in r5_next_bio

NeilBrown (2):
      md/raid0: avoid RAID0 data corruption due to layout confusion.
      md: add feature flag MD_FEATURE_RAID0_LAYOUT

Nigel Croxon (1):
      raid5: don't increment read_errors on EILSEQ return

 drivers/md/md.c                | 13 +++++++++++++
 drivers/md/raid0.c             | 35 ++++++++++++++++++++++++++++++++++-
 drivers/md/raid0.h             | 14 ++++++++++++++
 drivers/md/raid5.c             |  7 ++++---
 drivers/md/raid5.h             |  5 +----
 include/uapi/linux/raid/md_p.h |  2 ++
 6 files changed, 68 insertions(+), 8 deletions(-)=
