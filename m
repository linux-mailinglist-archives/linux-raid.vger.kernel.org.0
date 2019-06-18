Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004D14A531
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfFRPUv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 11:20:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729701AbfFRPUv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 18 Jun 2019 11:20:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IF4HOp020496;
        Tue, 18 Jun 2019 08:20:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MZV+qDGnSyF5sZcMQ5/mqKZHsMbfpdprMO27/DmvVl0=;
 b=rmVzM9BYKQaQoJQR62UcofwImz/A0qK8nQ6NjuHu6n4uqmbxoOaSzK/q+IMdNiVlrFiO
 lHiO1FijvXk67NtT1aUrFTaUBtPNpDr2GLQkmMcb06bXKSMJdN7mdIEpLstu0GcbOh/P
 +J6nHdM0zm/qL+UfKZOqodKjkrmnPDxGXvA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t6xxn0rk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jun 2019 08:20:48 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Jun 2019 08:20:47 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Jun 2019 08:20:47 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Jun 2019 08:20:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZV+qDGnSyF5sZcMQ5/mqKZHsMbfpdprMO27/DmvVl0=;
 b=KpDh2xv2H0eLpa74SUStVRnC0p+AwG3udB7TKO4sYzlM6Xxw9/tDsUi387kddmAoIO3wSeaCisaxdBj7i+9/F3aVcD7pvXX+9yuGPnvk1vckbUVarzdDQP0dKp+GnVC3SuRvuIbVB2EEyTW0JFdKc2TPUS1fW4fjByVfackIIcg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1598.namprd15.prod.outlook.com (10.173.234.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 15:20:45 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 15:20:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Subject: [GIT PULL] md fixes 20190618
Thread-Topic: [GIT PULL] md fixes 20190618
Thread-Index: AQHVJelmNDUTD/inyUS9wzPVyFHixQ==
Date:   Tue, 18 Jun 2019 15:20:45 +0000
Message-ID: <D941D6D8-65E9-42F8-91D4-78129823F742@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:2b1d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b288b31-e9d5-4295-0835-08d6f4008939
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1598;
x-ms-traffictypediagnostic: MWHPR15MB1598:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB15984B3944175CE03B5BC6B2B3EA0@MWHPR15MB1598.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(199004)(8676002)(71200400001)(4326008)(86362001)(46003)(7736002)(81166006)(2906002)(305945005)(54906003)(66946007)(66556008)(66476007)(66446008)(6116002)(73956011)(53936002)(76116006)(14454004)(966005)(57306001)(64756008)(6436002)(478600001)(6512007)(102836004)(36756003)(256004)(6486002)(6306002)(486006)(476003)(6506007)(25786009)(316002)(2616005)(68736007)(8936002)(4744005)(5660300002)(186003)(33656002)(50226002)(99286004)(71190400001)(110136005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1598;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VQ5Geb4oUHG/TFkSc4v8HtRgAmsHYum/42eRTjvL0N8W6vjGmRxYGYE2l+dniw3pj3sh9vLd5gcpF/Qtx6zCTLzxCKFvECWyCfA/Yvns/c/OGRn9L7lI+pPawIDhYGfvfKFqxYbYu1epwZ1mfoHNv7brySfGem5gfy9FjYchTpwIpvJrakgoIiWY7aWERwDH5Ikkpi4qT5Fq50iFeWY1O7RBsZkB0sNt1HD7nXCkbg2OopllDENGv+o1nqESwdqyjJ5ElmzeTT8pU5fkhI1Hyu9d8eo2gjibQ/2nesHxc7/qIsc571Ksl5ZzeMDKEWqN5K2/rFgILbGSXhmUtkFjwgQ8oKmG4OXu4ZsO7hS2ez40OKsXz4D4yDoYsu3MUIIenQ7EN1dXXvAsIMqP5BwWSIkLrAvZQ0MCljlBERo9ZJE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EF04240D097E64BA2E1FA23DD12E5D2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b288b31-e9d5-4295-0835-08d6f4008939
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 15:20:45.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180122
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following fix for md on top of your for-linus
branch.=20

Thanks,
Song


The following changes since commit 4569180495600ac59f5cd27f67242a6cb51254f3=
:

  block: fix page leak when merging to same page (2019-06-17 09:33:04 -0600=
)

are available in the Git repository at:

  https://github.com/liu-song-6/linux.git md-fixes

for you to fetch changes up to 9642fa73d073527b0cbc337cc17a47d545d82cd2:

  md: fix for divide error in status_resync (2019-06-18 08:02:25 -0700)

----------------------------------------------------------------
Mariusz Tkaczyk (1):
      md: fix for divide error in status_resync

 drivers/md/md.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)
