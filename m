Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CFAE3C83
	for <lists+linux-raid@lfdr.de>; Thu, 24 Oct 2019 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391753AbfJXTvy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 15:51:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390431AbfJXTvx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 24 Oct 2019 15:51:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9OJdLJr030060;
        Thu, 24 Oct 2019 12:50:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dqHFcMwGjwthqdNh3pDTgT16yl6Zc6wxi6NolbEwDUA=;
 b=Piob50Sjxja+qhlzmVPCoDjKuVn5FlK2JIu/bTfgLLoWpgWk9LyYpEiQZLYxLSCApZv7
 olwYb7qxZKqEPrDzRKegwqw+Iks9oe3iG2jszzV4NhpV+zymaihagrw7SjDR6c3Lj6qF
 Eh5UK8GLqtf2n91ofdB0JrNtEQGxVxO6Rfk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vuja7r1dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 12:50:58 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 24 Oct 2019 12:50:56 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 24 Oct 2019 12:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQHQkY3UgPP+2U4wdFcCnp/3+gyf2ziuWLvFnzREyQhLquYK581Lehx1CVbnEz5a/pjmjYM4q0qf6/6N2nkbnz61CWYe1ydpZ+BpIcVJCAX3+TCP5Nu2hBNvf0QknpmnLFwkh7/KFtxpeGTToBGyCEHV9bsHhrXnp7wgAySmTbesMo0wZmlF0yp2avKNCHxACdVcqmDUAXQxYUB7bj0viRLNpTCZQlq1CRPnddDod6erSld4yyHopmX2fsXMcRTRa5lPzXDc92hnF+aZ8qPkgzzBUdGFp1oDvjxOGzLSdJIdjAh6Pz7MDbF41XYZyXQh5yYaUi7Gr8+X4WTh7PQ7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqHFcMwGjwthqdNh3pDTgT16yl6Zc6wxi6NolbEwDUA=;
 b=bc7+1wVNR7SP1rN3DioWHP992W5vh6LWz/3U1MmP/CPbaApMHCYOcoHYFbkrY2LDvMd2hZsX26TOF5EvacOJw7ayTLu23Wra8ToOK53J7VUdOOEu4i9+7SXMFrvtQjN+BhrH3P+Ggmdo6yv77MBPwO5TuwEuxV7yxBFG4rgolNSeOcaCmQxVtrJrt4UODN/xOmKaJMyNMfSYZQmMFHUL6Gfn/MNYk9JysvYjj4a1bcBhJGf/wmTb3+HB+0XOaCpCNJo4hwGq56vllIc0Tjc1dgCmV8M+Jl9NoyRfWu7wn8Zd/HGYrT5csa4DzLaxW1hHLd0zcp1zlo+smzml17tVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqHFcMwGjwthqdNh3pDTgT16yl6Zc6wxi6NolbEwDUA=;
 b=LYaOf6WGvR5CrG7lihaDuOm6zQGb3ARkoc3qSMLXIS5HxV7KBGsSIDqxjDj9rLGeRkeqh9Wa50NvoNT4GyulY7qsZQGba++U7lhQ+G5JGdM89vNZvknwvfKTAkUxXWaR684OYwOXafsxhL5DVR3IhT3TFaYcPEtvL+tbi3KhpOg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1648.namprd15.prod.outlook.com (10.175.141.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 19:50:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 19:50:55 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Jeffery <djeffery@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "Guoqing Jiang" <jgq516@gmail.com>, Yufen Yu <yuyufen@huawei.com>,
        Xiao Ni <xni@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: [GIT PULL] md-next 20191024
Thread-Topic: [GIT PULL] md-next 20191024
Thread-Index: AQHViqRZGiILNO5uSUyVzyhNu9jE4w==
Date:   Thu, 24 Oct 2019 19:50:55 +0000
Message-ID: <ED0B162E-09AC-420D-9620-849EAB38C195@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::3:e83f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afd1ee6f-d487-4f56-d0f0-08d758bb7c10
x-ms-traffictypediagnostic: MWHPR15MB1648:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB16485267D01D9A648590B2F3B36A0@MWHPR15MB1648.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(8676002)(71190400001)(36756003)(966005)(316002)(6512007)(6306002)(50226002)(478600001)(486006)(46003)(4326008)(7736002)(476003)(5660300002)(6486002)(4001150100001)(186003)(66946007)(76116006)(66476007)(14454004)(102836004)(64756008)(6506007)(2616005)(6436002)(305945005)(66446008)(66556008)(2906002)(81156014)(81166006)(8936002)(25786009)(256004)(71200400001)(14444005)(110136005)(6116002)(33656002)(54906003)(99286004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1648;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5x059VOz7VUXkA0gqzUiNH+jr61KoMPjCr7htmOy1+vUPFxFA/qBeGSWAubh8W3MMHf3bxTBB4Tq0nh3gEwC3vYImQ95mwgPcjI2Shxt3H5LoqHsqNOsiQRz7neQlG3c9FvPnnXjat2ynNrBJpQsWZc6BlrkDQoy4e1daiyX++R3jwGzfDZvdDUuVb9CfpzgOdPzrd0eMULbjBANBarBQuwDsdJkT0UBBvJuF4EWMUaWZoqH4nVbLGfR3QJYHgopvzZ9XjWnd2BUedRVNpgb88OwZ822FD/2ujdyG2F6ca7D7oxhO6nmmm+21zIdq3jeOGUbcxtdu3khke4hvRAt3roDpm65/TuqkkNTC8Uc6Giv6a7YYuxukvNdIFK9mu34dHkPnCd0KNkQtXm4SMD6W+LItISjrWbJXPHrPcsOw5LdmSBLwHFoPVeii5fGkzSHK/B87/fAT9ZGJlJi5jCaIJWEyenN0WUMq/uQoA1jt4Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFEDF54308831042811628218B823672@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: afd1ee6f-d487-4f56-d0f0-08d758bb7c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 19:50:55.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqGUelNMlND/jg32NamaMvYlNKGM36kPj6gB4siO6E5rFi+YFc/OMYQ5DUR4zfLASmOqt8jvpritJaaK0Dnvlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_11:2019-10-23,2019-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910240184
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your=20
for-5.5/block branch.=20

Thanks,
Song


The following changes since commit 48d9b0d43105e0da2b7c135eedd24e51234fb5e4=
:

  block: account statistics for passthrough requests (2019-10-10 17:52:31 -=
0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 58075d924cf9fbdd4e96108a7bb973c8304ffcb4:

  md: no longer compare spare disk superblock events in super_load (2019-10=
-24 12:39:36 -0700)

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
 9 files changed, 76 insertions(+), 29 deletions(-)=
