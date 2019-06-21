Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEABD4DE03
	for <lists+linux-raid@lfdr.de>; Fri, 21 Jun 2019 02:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFUAIg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Jun 2019 20:08:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725905AbfFUAIg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 20 Jun 2019 20:08:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5L07hG3012138;
        Thu, 20 Jun 2019 17:08:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rYsMsDwWXXj1TdQKdZPaNVq+w4TOAteRz//7PtAilD8=;
 b=XnS7lvF+LhaNM0Dr1fj5MjDAQjhmbiidhC+nR+wzOTcOYNZmWQYmW1Kfmfh5rtlbYEph
 4EvLIziiCLL7KJfE+IPN6YYQqQcRgyFvGpJPGusYrvW65iI2hj3wFci9NHCC+B5tstj6
 v7s0tkbna0lgZZSkKcvXqrtKoL9dPA9uRlA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2t7rtddky8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:08:07 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 17:08:05 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Jun 2019 17:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYsMsDwWXXj1TdQKdZPaNVq+w4TOAteRz//7PtAilD8=;
 b=lyDIZpofKID2xi6eqEpv+N0L4k7xsqbe6KWCVkbMPYAHpzIDO3vEOO+gHOiLJdnBDsBxIOiHDGfjDgTQltRwOIjHcVB1PwAew52kWPo/+CKPBA8kfn9mxN17sbOTLQHu+pAZd+iNYzpIziTP5bjWGw8MboHx3pnZH2yeH8h6O4A=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1246.namprd15.prod.outlook.com (10.175.3.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Fri, 21 Jun 2019 00:08:04 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 00:08:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>, Guoqing Jiang <gqjiang@suse.com>
Subject: [GIT PULL] md-next 20190620
Thread-Topic: [GIT PULL] md-next 20190620
Thread-Index: AQHVJ8Vl/BKfd23O8k2+yx7be50cLw==
Date:   Fri, 21 Jun 2019 00:08:04 +0000
Message-ID: <FBC7C647-6761-4DDE-AC4D-A7E0DDA5E9E2@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:35e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd542fe1-1d79-4fa5-2efa-08d6f5dc8828
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1246;
x-ms-traffictypediagnostic: MWHPR15MB1246:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1246451AFAF0C3798C5CB4C9B3E70@MWHPR15MB1246.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(25786009)(6436002)(6512007)(186003)(53936002)(6306002)(46003)(476003)(2616005)(14454004)(256004)(68736007)(50226002)(86362001)(6506007)(99286004)(6486002)(478600001)(7736002)(102836004)(305945005)(81166006)(66556008)(71200400001)(76116006)(57306001)(4326008)(486006)(8936002)(81156014)(8676002)(64756008)(71190400001)(66476007)(2906002)(66446008)(966005)(36756003)(6116002)(33656002)(110136005)(316002)(54906003)(5660300002)(73956011)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1246;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4oT1roS1qvEaqn6G0UsmUZDoHMKGrgmtokEJTr5qyj2sbgg77026uaqxsCz7mokZNcbBBgMG09PgERDuIW5/33G7AylLHfRvF5H3qsPSMoIcgnreQO4r9VlfJOaqUmUHHuzgzZ3nQeHp6ieCzoD6gPjlrZNlwR+PKbNDQsvYon1i420wylc1+168m7YDzecOvNCRq/j4hDq5pge6d1TjDtyT1oaKwZ7gXVUwQn5lG32KqNvwP5brxwLSmXMX0pVwJDNNJgzUSr0CFTc79CnJSXnja/DVzzgChR1gme1LYjOyA5yLJHO8oj/9HY9Gf5kxINNdzeWfuu7joCxrMhAN8GQvR/XeeIgT+fFsceJky3d9KNJe7c1Nh8QKy0buti6OkMztJw8CcvBJnE3toQX4KTiL5JPiY+rh2ezd5jf/rVw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D7A55DE8465B5458113063382C65912@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd542fe1-1d79-4fa5-2efa-08d6f5dc8828
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 00:08:04.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200172
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md on top of your=20
for-5.3/block branch.=20

Thanks,
Song


The following changes since commit 0ce353794b6c4dc88592b942e94b33cd1bf2ef54=
:

  f2fs: use block layer helper for show_bio_op macro (2019-06-20 13:03:52 -=
0600)

are available in the Git repository at:

  https://github.com/liu-song-6/linux.git md-next

for you to fetch changes up to d494549ac8852ec42854d1491dd17bb9350a0abc:

  md: add bitmap_abort label in md_run (2019-06-20 16:36:00 -0700)

----------------------------------------------------------------
Guoqing Jiang (5):
      md/raid1: fix potential data inconsistency issue with write behind de=
vice
      md: introduce mddev_create/destroy_wb_pool for the change of member d=
evice
      md-bitmap: create and destroy wb_info_pool with the change of backlog
      md-bitmap: create and destroy wb_info_pool with the change of bitmap
      md: add bitmap_abort label in md_run

 drivers/md/md-bitmap.c |  20 ++++++++++++++++++++
 drivers/md/md.c        | 116 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/md/md.h        |  23 +++++++++++++++++++++++
 drivers/md/raid1.c     |  68 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++-
 4 files changed, 218 insertions(+), 9 deletions(-)=
