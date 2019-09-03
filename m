Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E704A76A8
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfICWB0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 18:01:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfICWB0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 18:01:26 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83Lxlg5029000;
        Tue, 3 Sep 2019 15:00:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CPNBPpvE37FZ2mAYnm5BADB286LguWQRxQ29FYJY+EM=;
 b=N1jqCk6Uv25hL5I4qjyzX764udgNY86bJ/QUgdgDjRUGQW12IV2UCFhF4xP3bu/on74+
 Bg/6xc80+Vvib/+XqzaqT0nztLAkxKDWMYiRJC+3KjJQuofru2JRpBw92FeCo/FsU+e7
 3ne48qrJW0byNpXg6tOkt4ncbhdOKV/g1z0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2usqs7amkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Sep 2019 15:00:36 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Sep 2019 15:00:34 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Sep 2019 15:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyJe6BMu+UinJ/Hb6HcohdbXKu/4ZZCKD9uCsadVA+8KXP3jzFoDSFphv0BF/JhLGrBnbxWngRw2C3R/RyouFqXhMHqjE2sKIufTAxjCRxL3ruyu2pzyDlPsquKtR4JIxgFuAGhHCR9TVUgzwc0z5MOtxX5o1gcXQhyCnCaKR5b0x2SbQvVPSW/xn+SdrVXCxRhQHRcK54U153Q6fQael4NLmglfQVkOXlT3/lvERhMnbsBvhg+R660LqCJbcOwqZ8644mla45NFg65ZSt095TY/B1nlDDmUkNK2NJEi5y74/IzQGcS4fYIF2GBPuwJxyXHGG8FKKbvLcOyFqL1uCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPNBPpvE37FZ2mAYnm5BADB286LguWQRxQ29FYJY+EM=;
 b=TG0tmfNCGCDFgSzDdia7PtMELC4ZheqktKZAsNL1E/nCMwWNFtq8cZeDFlsmUUS0bQjcIZHgJo+K/zJx4eELTcnHbIhYHLFcbdcpc2jGx6q+iVi71RkOwjnf0MxclSucdDzDnBMA4aqPdoceNIpXoPNIiq/5JV21O8+b6i/UJqVYf36zvGXE/dPxZqqCQvszHI13/A9t9E5vzRJvBtyLPCAbhPQdmAhfg22r0yyeIAREZtz9sJsBAhLiM0wXTgTyHp0ME0cuJtJWP8kIDYiVVPWatUJ6rQfrV38kK12RAB4Ewr3hs10YCe1vd361/7RetP4VWw6cvs8tnFPIzjnXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPNBPpvE37FZ2mAYnm5BADB286LguWQRxQ29FYJY+EM=;
 b=BUi6Nn8sswwwRWXa7nIsk5mU+M1JU7J2AaKFGDx5mru6qXYS2Ne46LSwkezGPYbxW/SJHHRPwadarERDLMR/SJEHjGO4Ya+0rlq8w/mfEA9jxgdBnVgdeWGi8v9HP8v9kryyy755uHZjXbRzmKPes5dFZcNoZwvzsErOXRy9+pM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1295.namprd15.prod.outlook.com (10.175.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 22:00:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 22:00:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: [GIT PULL] md-next 20190903
Thread-Topic: [GIT PULL] md-next 20190903
Thread-Index: AQHVYqMB+4QyohjHykyfQuvY11+Xqg==
Date:   Tue, 3 Sep 2019 22:00:32 +0000
Message-ID: <F9513FD6-D5AD-485C-9079-FD320F4325AC@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:c3ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdedfd17-ccd2-49bb-172c-08d730ba2457
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1295;
x-ms-traffictypediagnostic: MWHPR15MB1295:
x-microsoft-antispam-prvs: <MWHPR15MB12952BAA7758C2CA3F681899B3B90@MWHPR15MB1295.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(46003)(186003)(4326008)(99286004)(50226002)(14454004)(478600001)(8936002)(256004)(316002)(14444005)(305945005)(71190400001)(71200400001)(6512007)(7736002)(36756003)(86362001)(102836004)(2906002)(54906003)(33656002)(5660300002)(486006)(6506007)(76116006)(8676002)(81156014)(6436002)(476003)(2616005)(53936002)(81166006)(25786009)(6486002)(6916009)(66946007)(66446008)(64756008)(66556008)(66476007)(6116002)(57306001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1295;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wlre6YOTdfkhNzXeeb4rF2+pD2rfoZfg0V7B/8aERdYvxFziuRLy0bfmyEbI6arO7jkLuPlsjQ2lbSN2KwAF2loT7SOT+9GFLcOUoDzilEiMhbxotsA2rgwC3pbHTqhwdoPpj1kBIJO5L/+OzAx8vcPbmjm+64O3XBlnWx4bUsd1JQdyOqtdezxYbuMrlUiOXoTZgPMLqvQnT1EA+Ba9KsuELo+aJCMz8KQsv/jb4foT3t5LnoNzkpnlYIT5kgV3ubZM+BvIHVWl50Th5gQX7UJ358jacnYYOl0Zs/tKcWXwvP0XtqdLuhuIjpT42NCg5Y/NL39VOMqy7sQ3dXZkqI/fO6XoMBxo5Aj3nESx/KE4rg+mjljMUeGeVegOLDc6lwNOSnhF+wCSGaTTI/GHd+Vk5RFTbE99S9skRR7dPdw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C2B1588D4E7424F9A5959821ADEB710@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bdedfd17-ccd2-49bb-172c-08d730ba2457
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 22:00:32.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HsTLvFT9qECxK0pYiNSU0mSRedMiD5xCYlMSZy/SYsdFk7GhPaX+Ns5QW3S1K5Jh5/s5FYqUGmv+fq0lnPa2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_05:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909030218
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md on top of your=20
for-5.4/block branch.=20

Thanks,
Song



The following changes since commit a22a9602b88fabf10847f238ff81fde5f906fef7=
:

  closures: fix a race on wakeup from closure_sync (2019-09-03 08:08:31 -06=
00)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to b0f01ecf293c49d841abbf8b55c4b717936ab11e:

  md/raid5: use bio_end_sector to calculate last_sector (2019-09-03 14:52:3=
8 -0700)

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      md raid0/linear: Mark array as 'broken' and fail BIOs if a member is =
gone

Guoqing Jiang (1):
      md/raid5: use bio_end_sector to calculate last_sector

Yufen Yu (1):
      md/raid1: fail run raid1 array when active disk less than one

 drivers/md/md-linear.c |  5 +++++
 drivers/md/md.c        | 22 ++++++++++++++++++----
 drivers/md/md.h        | 16 ++++++++++++++++
 drivers/md/raid0.c     |  6 ++++++
 drivers/md/raid1.c     | 13 ++++++++++++-
 drivers/md/raid5.c     |  2 +-
 6 files changed, 58 insertions(+), 6 deletions(-)=
