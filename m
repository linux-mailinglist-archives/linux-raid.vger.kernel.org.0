Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9222057A
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgGOGx1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 02:53:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbgGOGx1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 02:53:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06F6n7TS000407;
        Tue, 14 Jul 2020 23:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VW5R6P+b5A0+hCKISwAmaSkyGU4WiZDABNMg6Yx/LGc=;
 b=Hmzr75yhvbRB4ya8l7HUFn2xZ5yBdFFyGLn2diGY9Ja03C9c5HFD4mSPxvTkV1owhHn4
 wl9ttdiXRhIu6eRnW1I3/Ed1/RYH97Ab27/UDvdemkg6A0N+f+/um9Vy1fCq1u4iRQrs
 bWUblG2S81KVD8iR4oOMnErCHhOGwGEo/vs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 329nqv9fmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jul 2020 23:53:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 23:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhT3Kd11xN3Poo+KIQHZgKCJAoO8tIF+gtQFffog5LvEXljBsPmgJ7Ifgg02viDwuzfOv5c5UwX9FFiA9hah+qwsbFXMngv1csEjSVfIW+BML2VAUjpFm3buzSxc61/GFGdwigKZKJPQJPqQhFnRfnQAv+xK2Qe+WFBrLOoWuzQfhNq0/RIuExvCtQGVMCu1Y1rDgluXkFsudGOlQTbdxvJBwAdhcjsAL2+HLcDA8OdyKi9Y2ul1Bc6dmjOKoDMYs8USVQ9nwmWLcJ8QmspXu/P3vMeYa2u07oIqZjfgpWqK2F9xYIIlgUXPx3801CXAGwxK/kKUQoe+cHbA/MbJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW5R6P+b5A0+hCKISwAmaSkyGU4WiZDABNMg6Yx/LGc=;
 b=gi9TG/RGap7hcSVX/2fcJozwZcRafB1RAx9ugsPYk+eIxuP/IO+RvqaFJ4miRFLH/X3wAUa8jayivoJ/zYoMIRTH08Ucbknq+jsG/vQabDXt/AIHcfygeWBLnp3IGstbQTPRkudi+O737evSc+Npm0eqjRJ9cBjWsHbbHgKYPF4VN+ufqeXVpnrchKBC27H1d9m+CykJylCfWJV0J7FrlBoQrmhsXSMpmdgUvSxEoXg8edRW/bXgAatiye1vjYUGnl7dmCF7E4P82/WRJCndBvzTXZQSco5O1SyXl7vy/rCj2sZF83CZdB7OLt8GevLhdIazaxzxhEV65Wj3FOZZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW5R6P+b5A0+hCKISwAmaSkyGU4WiZDABNMg6Yx/LGc=;
 b=BmdfcpsEb3/MC2JTUdvKN04TKX7g1wIArrnc9Cw92aqZsNoyym8Ib9dGyEpPw5XJDLbl0bG445uKni72P3visjKT2FANVVEoLOhtp619WftWmbnrri+u42eAgoXR1Y2kSeY+tPHL4kDoKH+ptaTVmwPM51lk2EXLWIktpZloye8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2950.namprd15.prod.outlook.com (2603:10b6:a03:f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 06:53:15 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 06:53:15 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Junxiao Bi <junxiao.bi@oracle.com>,
        Zhao Heming <heming.zhao@suse.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [GIT PULL] md-next 20200714
Thread-Topic: [GIT PULL] md-next 20200714
Thread-Index: AQHWWnSdDyZ8RP+A3kOxt8UI4wEIww==
Date:   Wed, 15 Jul 2020 06:53:15 +0000
Message-ID: <FBE6B82B-E360-4EAF-999D-AFBC6BC5F058@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f0b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aca052b-90e1-4a48-1e2e-08d8288bbfe3
x-ms-traffictypediagnostic: BYAPR15MB2950:
x-microsoft-antispam-prvs: <BYAPR15MB295051BE0A04D4ACFA125265B37E0@BYAPR15MB2950.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: duwtY7viKzHqA45SFz3aaZRZdP83/mc/SMUuxZTRjIJfgx7FMTVOV4WPeCTL1689LhdAqE+DizCNA9qRJyqx7BX7CaklkAS05EcTO93smrdpp3O13l8SMfynFopCqlkeiok6lP3kjmsCs8s9plQOnrsbWjgdwPD4XvU9XPE8ACbJCuvT5KdcbyU+AfzgLoOA13iPwKRWdRyRsloIZIA28wJkJ/Bro9BJiQT00C7QkWgM+kkfKrtCMLSZJlUwJi546HIfMVFotr4wnrY6ISjerAOu2cz2kOCszAVHD9oK9GVOEQz98Chc5EWXO218Rm7VGw27uXiaDUVhUmTBwY5SOK0wijrHlQvMzPe4EjqoSWig4wkBBwyDFC+ck66vvoQIUFO+pWOHONZcCayT6r3NZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(316002)(6512007)(66556008)(478600001)(66446008)(64756008)(83380400001)(966005)(76116006)(36756003)(66946007)(5660300002)(66476007)(33656002)(186003)(71200400001)(2616005)(110136005)(4326008)(6486002)(6506007)(86362001)(54906003)(8936002)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DfkdrGLQQthx7qS0EyGO9cox8pm7J1yhpHfLBHobIr3dRgwp+BYRGn12gL6QH1ZakJpoJQYMY3UNJ0tr3Q3tY3BxOVemcteyX4TbdKhf6moflUyJKmVuETJAKf5yYEzufmj9alXe47I6dqaqQNFhjCE0JSr0LJVl2ja2/R6d5x1KXL9buS6tOuyA+gEhYLi0zAgz7oqTGi7jv6A1Qd7P6ikglKHmWQ7M+fZ4GODmC13jg07Z5daDO4mlw+lfZIJpTQtn2TVp7GwaI/OoJS5c1hPg4MOlC9jktkZNzUNpELgPXqnl74/2LLbKOq+FNuSsEju+s1zqsCRwY0xuSjZhStIiUEdk3jtNy0DEBv4pjzcgrLyZ/NPBoJ24qk0FvaouePGF8JnP4IEhhguUAUkl+2ahOXkFqolGxm87rooL8dDfdVM/l8aODqFA+UEhx6mhGDb/PQctfNWUrTs40+R2U78iQoIR/i+hjFKzdB353guoJTSjeFRy29GuQZj4d40AbvLTvkp2RbT61wI7a/ql7w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3C4813CA6067943BC1E18B5F8D96A5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aca052b-90e1-4a48-1e2e-08d8288bbfe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 06:53:15.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDu3T0sxGu/XwVmzktJZ/w90BlT6RicKkDuUeEwia3K92SAQG8kjNm5Xc3fK+t70V/FifAJW8I6cH4Fxg0bc/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_05:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150057
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your fo=
r-5.9/drivers=20
branch.=20

Thanks,
Song


The following changes since commit 2eaac320db515b2ec681f6a4bad4f67a7be84ce8=
:

  rsxx: switch from 'pci_free_consistent()' to 'dma_free_coherent()' (2020-=
07-11 09:27:09 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 60f80d6f2d07a6d8aee485a1d1252327eeee0c81:

  md-cluster: fix wild pointer of unlock_all_bitmaps() (2020-07-14 23:38:32=
 -0700)

----------------------------------------------------------------
Artur Paszkiewicz (1):
      md: improve io stats accounting

Colin Ian King (1):
      md: raid0/linear: fix dereference before null check on pointer mddev

Junxiao Bi (1):
      md: fix deadlock causing by sysfs_notify

Song Liu (1):
      md/raid5-cache: clear MD_SB_CHANGE_PENDING before flushing stripes

Zhao Heming (1):
      md-cluster: fix wild pointer of unlock_all_bitmaps()

 drivers/md/md-bitmap.c   |   2 +-
 drivers/md/md-cluster.c  |   1 +
 drivers/md/md.c          | 110 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++------------------------------
 drivers/md/md.h          |   9 ++++++++-
 drivers/md/raid10.c      |   2 +-
 drivers/md/raid5-cache.c |   7 +++++++
 drivers/md/raid5.c       |   6 +++---
 7 files changed, 101 insertions(+), 36 deletions(-)=
