Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9502239FF2
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 09:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgHCG7z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Aug 2020 02:59:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgHCG7y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 3 Aug 2020 02:59:54 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0736xV9L004112;
        Sun, 2 Aug 2020 23:59:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GTBss58oNugYo07AXxWI6v9KvFEsbIZBnZt40es7/O0=;
 b=DXjEtYEZZmLHZZcMxP9fVjSrWbX0MoB6eHcj3VXfSpprM4rRpp66k6t+n/cjEo/QJADE
 dCYdTQwkmXMao0xtfAzwwoJuj/O6VTtzzxd/1vU4aKYuXWXe+xWjCVp/QZzwwKzI91bB
 FHSPUgJFle/vZK9Mlo0Eu0iXpIj1d+1aOmc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32n81fnmyk-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 02 Aug 2020 23:59:33 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 2 Aug 2020 23:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDXQ7b6LrudQl+4hmN4SUH2TAN8jgfxj71Y0LsM/S94f9p49wYIwmzYFwKqzKqEv/TU0WVP9id8YJ6PUi/sfBEZ7a/zB5ehxFTXWpDsA+47iQ/Zzptj5w/C5zUMXWS09V7Jrh76Iq+AJYEtgCkjRShhE/gQ31RXIJ6BsqeqU8/l852jLHabNoHBvUIktk9XcDLNYlkFu2n+zdAY8yVLOpuT72XaVB4WNCM7XPC7uTEtK+6jirZApqSqKdlQnib70bLOqv/IJDhFOiyP57nbJsdZWkYY3BZ4YOxVJOh/5T1SF724duHIGNWoEJjcNWKnXf+oTEfB/u/d6kwgcKPX0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTBss58oNugYo07AXxWI6v9KvFEsbIZBnZt40es7/O0=;
 b=M2++gqYxGBBq25S4rEV+gewEQBXuqcNCfTb7dcwchzTlRrg5AR9nTTyml8BlvNta7amABv8VH/8I1Cpj38G5HpHdBJpYNfV6GRKrydnLtEHYDfRAGK8lq4ceYPBxWWhs19UGtlRYO12CzCXq9Dn4py5A+ljUIzVmXIHaohJ8cdz0TC7WPp5WBVJ5KFpjICNH18I0VwS/rJ8lV0eAao03zmMjlqsF8sZaofPxtKZylNZ2RcASOqG30Yb3WfZvcoY3uNkQAWUiOLT500TQQJkU17eRWPdWsOnA01wQbhFpYMgf11TZUgi+iGNrTB5Gt8Y6T1rR4xJngzmwKsEwohKYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTBss58oNugYo07AXxWI6v9KvFEsbIZBnZt40es7/O0=;
 b=fwXBeKpuSlMyAq8VGXjFrpe+u+ZxuOGywynNCx/Viz7SNvDDnQmBrK4uKKG1b2c6oCPjukX9sA81Bdjw6P3vxnfuVTer3Ja6oJjUdExkbTEfaQDQzKhoR+T1IUf5YV5bxDtjMtjQW8GE8SjI35dTZ0jj5EI00BwtQSUnL37f1Is=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2645.namprd15.prod.outlook.com (2603:10b6:a03:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 06:59:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 06:59:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Xiao Ni <xni@redhat.com>,
        ChangSyun Peng <allenpeng@synology.com>,
        Sebastian Parschauer <s.parschauer@gmx.de>
Subject: [GIT PULL] md-next 20200802
Thread-Topic: [GIT PULL] md-next 20200802
Thread-Index: AQHWaWOSK9+WxaxUM0aodu6jiFM2yQ==
Date:   Mon, 3 Aug 2020 06:59:02 +0000
Message-ID: <1B094166-6B2F-4181-B389-8C5B564CD485@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:8f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2abece36-e64d-41fe-18d8-08d8377ab4ba
x-ms-traffictypediagnostic: BYAPR15MB2645:
x-microsoft-antispam-prvs: <BYAPR15MB264570B227EFFE277B099262B34D0@BYAPR15MB2645.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHS8aaigeirHVNzFo2OzLG1jnRmAUSGa2Sz4HwaqsXkwS0dkPNqdeA6n8QCkv0ukmomNiL0x1LgJ8mN/+i8k2S55chWOubfGB4sJwqHHaj57CCsxZTDUszi2RbrvyKF3v5Df7TeXHJxgn9gPz/wNQ3Hj6YfvYccROk2Gyq6phsq3/Ao8Y7jMvQdk9Lq9AnBEPaIg3/zPD9060536wVr5xJfufZ+wn1Zlpi86YzOXEJR6fyXW+kUYe6tlZ4YwX+XwDSPITFZ5xSK5zyeFK9iS/t7xlk4bXEn9wvwPJZJiH7paNy0anu/fSAbW5HmdJWCiczLUupZgdOghf4VMW3lSieVZhQgutWfXrb0yMfAMHluYlIK7SOBRWjyploakcWjHNKzQnBoLzV1/nZ3l94gh+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(6486002)(966005)(186003)(71200400001)(86362001)(33656002)(2906002)(54906003)(2616005)(66446008)(66556008)(8936002)(4326008)(64756008)(66476007)(5660300002)(8676002)(6506007)(316002)(110136005)(478600001)(66946007)(76116006)(36756003)(6512007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BxneNnLEKj4ZX5lrOEhmryOGR/z283p3ezJiu87EwgP+seCwwTCgMFE2LcaH9siQ/ju9/ZbOsd1w26dW4tkstQoGClhULeIh7PiAkQ6/079n1O2ghUiGC+FyviQ6f4ySxZF+rIPto31kV54GGfORNzHp0rywHjSag/FqwAvK6th5cgz9hRLG/9C/belhm3RdhNGBvJhxYaZwERs/aWJsq05OYAhDsyNwi+UMBNwFAMyoos+ZxY+77q5W4iYq0TYZaKv1VZ1p5QVuyryvjve/1MxEkaf9CdeiAOevzrTx9ysKL0EvNNSQP1cpXEM5EkgB6leYGcXO79prgRgsWqtoIjbXoGFWC7KBK+6n8KFNYjD1HEoWkQdQZ3W48zez9g8eMRfvf8gRLsbUpORDU811ki43jwx0Ed9puds5p52EMF60nlnx/m1j6s9XDWp6yzy5ky3zLKVmoWq0/dVMg4LH7sdDO40T0KXy+h/8EJuszo8NiU6aQvin9LZ0fSJM0Gw9fiQIcIMTkPoZ5iPYGZIHo1H6SIupVoW68mlGHtApv0kbA4XLGyyGEz0GfRWP+XGfvWBhVi6O7n1mwzL3veoO95NlIKFcWSPMY9tRWQ0+1XR1c0ZTG/ePo8i8uEbCv3EUrYqOPRkVCJdqpKI/nll+PQ8vF7HGSHTeX8oda8JxmbM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EB313009BBF0E4E93475456E604D083@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abece36-e64d-41fe-18d8-08d8377ab4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 06:59:02.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bb0iQAokp0ZR/VBCMrSl78VeBNJTWgvFoIkUz2O8Y3Fe3NP2701nhLb/URvJ7sVOnV+E0rM4rfaNfKrwK0CKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_04:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030050
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your
for-5.9/drivers branch.

The following changes since commit a9e8e18aaf914bf273ed63480c4c3d8dd626c95f=
:

  Merge branch 'nvme-5.9' of git://git.infradead.org/nvme into for-5.9/driv=
ers (2020-07-29 11:22:40 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 45a4d8fd6c7926e7991a1b29233d725fe12935da:

  md/raid5: Allow degraded raid6 to do rmw (2020-08-02 23:54:31 -0700)

----------------------------------------------------------------
ChangSyun Peng (2):
      md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
      md/raid5: Allow degraded raid6 to do rmw

Guoqing Jiang (4):
      md/raid5: remove the redundant setting of STRIPE_HANDLE
      md: print errno in super_written
      raid5-cache: hold spinlock instead of mutex in r5c_journal_mode_show
      raid5: don't duplicate code for different paths in handle_stripe

Sebastian Parschauer (1):
      md: register new md sysfs file 'uuid' read-only

Xiao Ni (1):
      md: fix max sectors calculation for super 1.0

 Documentation/admin-guide/md.rst |  4 ++++
 drivers/md/md.c                  | 47 ++++++++++++++++++++++++++++++++++++=
++++++-----
 drivers/md/raid5-cache.c         |  9 +++------
 drivers/md/raid5.c               | 40 ++++++++++++++++++++++--------------=
----
 4 files changed, 71 insertions(+), 29 deletions(-)=
