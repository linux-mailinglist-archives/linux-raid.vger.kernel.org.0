Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A0229FB3
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgGVSzK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 14:55:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbgGVSzJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 14:55:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MIb8NG030511;
        Wed, 22 Jul 2020 11:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AqUSeXVqMQvpec17p8KmfSKElsxSUfFPa0rELCbU/fI=;
 b=b2aszm583S0bbxBpO3AAcsi0UiC9IYU+TASMMmNUiyn3fXIBv+4cRAPVGAcxUs4BpU5s
 fkt+BGT4477UjXkimMBWNm/g5re0jNfy7x8pmT9d6Tu8kZpcrLox25cFt/1ZXLYXbok9
 +xNd2Vlb1OYnFMJJJKEpMhleT/Kry85j2jI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32etbg09q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jul 2020 11:54:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 11:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiE6TwaFLi5KHLaKpBv5dr5udKjDRrZt8963zydGxJC82J8qI1RRa7csaLi0gOkdpRyk/yfLatNYVvW6huH7QlGOd/hAYDEvNKKgRo1vVL+3xxU3KlWCYyO6Xyyb/6MeE65NbyM/sUsElE7ZitHW+8qM0uME5Slm4H3+RY/HFmEx7W8Hxmm20ydQgRLLhDMouPaCwEBUC7n9EcIOhIjAKSLbF9f9n137qPLS3E2PkBDLZAMYvuNdfMBv/cOhPI3cg5Rbdm09daK54z4O7xlS2rMDHkbnZOrj9Qjv6Fxt47UpFIIIuMhvB1KFd34iAJ8qC8xf3dilBkVYO5dAFrTp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqUSeXVqMQvpec17p8KmfSKElsxSUfFPa0rELCbU/fI=;
 b=DAHjumC3I4Y0Vvbk6OLW9A+KwMxf8d2O6v0wjqnkWtr+Nglq7s6wRfUpOqtdGtVdrwp8helHqnQVTTBfBkky5XCQs89nWBwqkOTBHHz3AJgoNoEo+p4OnCsgv4hNSWJiqrGJcZnMIbza0S8cH7kJiI/JceupQd22ZUv6wJYDyoAFgxakujls7avIx/b+3JkeoRqClx0aNnoPeELYqFuH+kuy+K7cGbbxWPjs6XQoNblSf6LX8hjmdmAwCho1WDYSPi9I1OTQXJ6Ni9o6XqV6nqlFre2mOeEEkOm+WL1JCRHlJLEr1MUA3W5BPOCrOcvhFJU/QF1N8kT420GZqG75yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqUSeXVqMQvpec17p8KmfSKElsxSUfFPa0rELCbU/fI=;
 b=baTzFx+1pqjGDdtMKq0x39KnwUoSy0awkDtHrS9ONFHSvZHVZ+6/Odma5B85MWoA3Ka0/XH0bMU4/YBNBsx8lyzSZfejkVir7V++Ba4RZGKzg+PEZ/mjYkFQzPIgyxRK9rFCEkdYHSvYOlTMk9Gpo8G/MQjb//vA+z0gI4ZO6pQ=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2776.namprd15.prod.outlook.com (2603:10b6:a03:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 18:54:05 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 18:54:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Damien Le Moal <damien.lemoal@wdc.com>,
        Vitaly Mayatskikh <vmayatskikh@digitalocean.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Zhao Heming" <heming.zhao@suse.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [GIT PULL] md-next 20200722
Thread-Topic: [GIT PULL] md-next 20200722
Thread-Index: AQHWYFl5dYULwxAjQkaKV9czYRUQ3w==
Date:   Wed, 22 Jul 2020 18:54:05 +0000
Message-ID: <62A334F9-B486-4101-9803-AD72B4D5F66F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:974f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a59a89f-7fdc-4447-9b76-08d82e709be7
x-ms-traffictypediagnostic: BYAPR15MB2776:
x-microsoft-antispam-prvs: <BYAPR15MB27762F005BD18BB4EEB935A0B3790@BYAPR15MB2776.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:82;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aw3ZgxV2pDt/XylXi6jMWkh8MTaPIC23UVSwCCVP1DMKmqO66Yu/D5ilKg8TGBl+5IraVXEaFjpRXB1FyZYBis2uOnKzQouQ6xdCZcisfuTM58uFgJ3ASpeApqXFLD8zyyuHOHlw+QO3rYMYFPswRCT6ADk6g7M57W3D1CGEO23s8N3k0w9qJi/SFpj+KFKrUpRb0YiLvLRuFk5DdQ02H2lfF6G9rIBu9vXlqeR6Ht/bPGE2iJk9gf3RsN5jERM8JeZ1D7OZkhMKgvzgBi4vrdhMs9hoJHcpWy3ttMO/Uz+XoWfc/q//Yb0CWwDiYtPutPuXIWWHQa/ygzb7MxZjj/37AWB2zA96j+UhMjt+vW31Y8YoN/1+WfaMAjAkg3g9Unyyd5WY1XmgplYAMiVMNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39860400002)(346002)(366004)(396003)(36756003)(33656002)(5660300002)(316002)(6486002)(110136005)(54906003)(6512007)(66946007)(66476007)(64756008)(66446008)(76116006)(66556008)(71200400001)(186003)(6506007)(966005)(8676002)(478600001)(8936002)(4326008)(86362001)(2906002)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bSIbrg6Wg4IoLYoeRuRfsh5UykvfN9R0IiFxJDpJvHpnK6s6m53x7RUbSeGFT8K0jf7w0HsuAegTZ2EN19ibFXz1i0yi8iHSNQq8sIbtSKB+d/YR9nHr0VaK0o6GfQkeKsImqxTDpVqxZmP3waGX/ANf/B5YMdS9Wt2ES8cQ3UScMhfAQURB6S1dwD7ayLvPlCfziIQoI1DLCcqRT11Msfm4HotodrIrj1mShwtcMbWO1fWHKe+0FTCPGZyTIcL5rE/sAcXz/Z5/T2PwiWntLdZOT7hpNr89OzrLKjfVX3ptxmGxXPXwwctusucHCbtRrYXsJJ6frAR0+vHfzSAynHtU3ZX9pVlid+u0WM5cmEQtOkjgEiirTjXStJkOdGSqxjkERJMvweVlIusCak7d+jN8Bx1IM/fG/gzMMp0m37W1bPs1CtNNR0YX4+auosNGNwxdXmOj01Sd4Z7y5WMACPypt2c/zgayV7JCnoZQz9gDQ7P6hqTdtsa9CaA8OWDCh5JX6P8VaSbWs0Uor24/4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD5EB86FF2A9C6468BEE81E1FF0B56AE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a59a89f-7fdc-4447-9b76-08d82e709be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 18:54:05.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BD/Kfcw2l1zLvSzNJbn4gEAghsDbYKWk740yX4G+qvAjkHWqtupaXIytdUJ0/wm7IJPkZaywmaj3yJulZnoTvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2776
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_10:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220119
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your=20
for-5.9/drivers branch.=20

Thanks,
Song


The following changes since commit 659bf827ba8f1183b714341d8a1d4b1e446178d9=
:

  block: add max_active_zones to blk-sysfs (2020-07-15 14:26:11 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to fe630de009d0729584d79c78f43121e07c745fdc:

  md/raid10: avoid deadlock on recovery. (2020-07-22 11:44:54 -0700)

----------------------------------------------------------------
Damien Le Moal (4):
      md: Fix compilation warning
      md: raid5-cache: Remove set but unused variable
      md: raid5: Fix compilation warning
      md: raid10: Fix compilation warning

Guoqing Jiang (3):
      raid5: call clear_batch_ready before set STRIPE_ACTIVE
      raid5: put the comment of clear_batch_ready to the right place
      raid5: remove the meaningless check in raid5_make_request

Randy Dunlap (1):
      raid: md_p.h: drop duplicated word in a comment

Vitaly Mayatskikh (1):
      md/raid10: avoid deadlock on recovery.

Yufen Yu (3):
      md/raid456: convert macro STRIPE_* to RAID5_STRIPE_*
      md/raid5: set default stripe_size as 4096
      md/raid5: support config stripe_size by sysfs entry

Zhao Heming (2):
      md-cluster: fix safemode_delay value when converting to clustered bit=
map
      md-cluster: fix rmmod issue when md_cluster convert bitmap to none

 drivers/md/md.c                |  24 +++++++++-----
 drivers/md/raid10.c            |  18 ++++++++---
 drivers/md/raid5-cache.c       |  12 +++----
 drivers/md/raid5-ppl.c         |  11 ++++---
 drivers/md/raid5.c             | 340 +++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++----------------------------------------------------------=
------------
 drivers/md/raid5.h             |  53 +++++++++++++++++++++----------
 include/uapi/linux/raid/md_p.h |   2 +-
 7 files changed, 298 insertions(+), 162 deletions(-)=
