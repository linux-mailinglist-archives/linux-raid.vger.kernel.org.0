Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB92139A66
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 20:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMT4P (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 14:56:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3462 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbgAMT4O (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 14:56:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DJqZjb021758;
        Mon, 13 Jan 2020 11:55:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lcRvcRlGIHgWJNbA7ASapF6Cw06762m9SnAiJsIwZzA=;
 b=C3Rb5SYzF/3RkJx+853OVDcs/OzA9HG+W+iV4QCGeFfa2t8kho8p88hAU9y+QadkSdt/
 3lbPdS0TTzQ5pLRJD1A/qqWcrkESGerjfFnqbIiZakvGLyKbUlhf9d81hXGAuM/V9jGM
 +xZSCFahSYpKAuRMBloyHPealRB40Fogzsw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xfcyushrv-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 11:55:18 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 13 Jan 2020 11:55:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 11:55:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuBxE0HLXMYUmFFUgV3sWRej/MP0lV62RSwyAVjgA2j15yCT4LwJUmNlNEFOmXyYN+hxwD8LQrpaICI8iXf+DaGgG4ksnnl7j5B2rJXm106xx03zitJtTFYmHy6alS0T1rCXiwWFL8KKbVknUB2ROAymiAc3Q6c7yHWtUCu9PuLkaurVnc5nVSIwHH+E4eLmBT0eR1LfMyGLGZPiMM9QR0tmFqq9W3is3f/vA88Z2SRj8m6bBUhashiLXzetI20K/o9WyGTbdM116OrpKj/mcnlOnUuumwdZLtVLt7ObjBtyAUasXDVKwKoB8qy4RThhaCn1TJpyNi5oEO11n9x6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcRvcRlGIHgWJNbA7ASapF6Cw06762m9SnAiJsIwZzA=;
 b=TPPJGY9MM9e2+3Esm8P2Op2hCZrcr+2rQd70Yy0Je9t+uIKeRLtzJfkGKlCB6F4n0kkJS2BxDWGCHSE+O+n+6vrZeHY6jFaZJcRsTO6kda+akd/b7wEdl+UTFUXxyBpjb6teTVQDrqPK1GKHpzKDIF/tmbUN3SM06B14ediwXMV2ckoYMqhAnfQwHzUCbj+PyTZYX2Cukh+dhBkoA7PlDIz/twYq9Tuitq/twKc7usqc29ncEJS1w4XfMmYGbk5a0R9+dvRMaiVMJaLzNhRnXN29hnXID/oOMrsjoy78afX4JrO0s4b/NgMMPL+eCpmdGxk+rUAZQpj6C/3MIUHojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcRvcRlGIHgWJNbA7ASapF6Cw06762m9SnAiJsIwZzA=;
 b=jQmz52xJS43R7UMB2XbqnxkzaiOCiln2vDTpf+QUzv10xfTqfOZgkSZhZhNL/2pfXV3/YGVUGoxMD78x3ceEkKcsgg5Hv+6LCYpvmzh90IfW/qmLa7lLJ7mgkQGm8I/xZ2by+dyR+W4lr68Q2L3L5fiueteSk3x3STR5sw34w1Q=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2344.namprd15.prod.outlook.com (52.135.200.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 19:55:14 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 19:55:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
        Kernel Team <Kernel-team@fb.com>
Subject: [GIT PULL] md-next 20200113
Thread-Topic: [GIT PULL] md-next 20200113
Thread-Index: AQHVykteuLVinyfojUu5puoCmnR94Q==
Date:   Mon, 13 Jan 2020 19:55:14 +0000
Message-ID: <153C0E51-CDFC-430C-8125-486CCC73406D@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::6df5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b733c871-17c8-4984-79b5-08d798628179
x-ms-traffictypediagnostic: BYAPR15MB2344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23442A2A4B8273CF974CBD84B3350@BYAPR15MB2344.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(76116006)(478600001)(5660300002)(6486002)(6512007)(4326008)(6506007)(2616005)(33656002)(8676002)(81156014)(81166006)(186003)(8936002)(64756008)(66476007)(66446008)(36756003)(71200400001)(66556008)(2906002)(110136005)(54906003)(316002)(86362001)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2344;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxe9Xg8lQr1OKn6jmW+FMiH6leRa2SgMV6bL2Wha4fPL+wxrT3L7euQYqU2EmL6Su1s175Ojovq8BSTz0Qd6nZ8D/D27O1d11gIfHA6g1vEvqWMBBp35km98/gNiBqmTsDxfl0RpulyAL0f39WSuR8mWBh0oFKHLioiPsHU5Bhk15u5LiI6gmRA0n4ldu/Bo0XMi/2D+eEp5pI4Q60s+4Rh3K0cxHF/rnm3OdH9JwpwKaRal8pM04ljhCUDnzghXXUS3uwxxOLystCmWPYaqeNvDYiOUaM31tpyKhOp7zw/lUZFG/hNsQrkuIgA/WOsZYeTwhLZcGUZ08vnxyyo+7l128wllSetywWR2mcLe55azDDAYi2D785fqfm/VOu6rsXENCoanMqra9CjSWh43xs16iSTYQ+tO+jXpAjNwXJiSfydW3wP2EbYaszrO1ZRn
Content-Type: text/plain; charset="us-ascii"
Content-ID: <174754EE23A24F40AF29649D288F0577@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b733c871-17c8-4984-79b5-08d798628179
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 19:55:14.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C48SQ4vrsITctpLSPTQGD1QZ+RWEF9TTe6spEviWaZMAXa7nlS/xfDG/uUchw0Um4VBS5KvEs42jMoWAXXfKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2344
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_06:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001130161
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pull the following changes for md-next on top of your for-5=
.6/block=20
branch (I didn't find for-5.6/drivers branch).=20

Thanks,
Song



The following changes since commit 8e42d239cb027143915cae13eb2ecf1360ee24de=
:

  block: mark zone-mgmt bios with REQ_SYNC (2020-01-09 07:59:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to d0d2d8ba0494655a01b97542c083e51b29cf8637:

  md/raid1: introduce wait_for_serialization (2020-01-13 11:44:10 -0800)

----------------------------------------------------------------
Guoqing Jiang (11):
      raid5: remove worker_cnt_per_group argument from alloc_thread_groups
      md: rename wb stuffs
      md: fix a typo s/creat/create
      md: prepare for enable raid1 io serialization
      md: add serialize_policy sysfs node for raid1
      md: reorgnize mddev_create/destroy_serial_pool
      raid1: serialize the overlap write
      md: don't destroy serial_info_pool if serialize_policy is true
      md: introduce a new struct for IO serialization
      md/raid1: use bucket based mechanism for IO serialization
      md/raid1: introduce wait_for_serialization

Zhengyuan Liu (3):
      raid6/test: fix a compilation error
      raid6/test: fix a compilation warning
      md/raid6: fix algorithm choice under larger PAGE_SIZE

Zhiqiang Liu (1):
      md-bitmap: small cleanups

 drivers/md/md-bitmap.c  |  25 ++++++++++----------
 drivers/md/md.c         | 254 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++--------------------------------------=
-----
 drivers/md/md.h         |  45 +++++++++++++++++++++---------------
 drivers/md/raid1.c      | 111 ++++++++++++++++++++++++++++++++++++++++++++=
++++---------------------------------------
 drivers/md/raid5.c      |  21 ++++++-----------
 include/linux/raid/pq.h |   7 +++++-
 lib/raid6/algos.c       |  63 ++++++++++++++++++++++++++++++++------------=
------
 lib/raid6/mktables.c    |   2 +-
 8 files changed, 353 insertions(+), 175 deletions(-)=
