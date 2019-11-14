Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A52FD158
	for <lists+linux-raid@lfdr.de>; Fri, 15 Nov 2019 00:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKNXJe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 Nov 2019 18:09:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfKNXJe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 14 Nov 2019 18:09:34 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEN5Uql004824;
        Thu, 14 Nov 2019 15:09:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uczZPyKNNBm3v6syLVt4asE4D5050HOilxyrbotezkw=;
 b=PNlLgzmhMYXnslT2acjRs4SUVPBXlHhU7KOMrjWHPArIGLGoe/szxeOrOmjdi9mYY6fm
 UqgH+JcIp9lxPxJ/S0Mp++XNPpcua+UnrOUkOxzKbNkBdUk+Wn05I5iRSCvsDK9PIoKI
 WwXbjXs10XyMz9OAbjO5t6CP05nDiIaovbQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8w21qr6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Nov 2019 15:09:30 -0800
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 15:09:28 -0800
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 15:09:28 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Nov 2019 15:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhbJl+MxGjX0Sos6qNxw6lp+1Bj3tax3UqDq6v7+x1Af4pyX6PWKmepLrat/U17U1gGdzFJKAMsPRpV4CiOIyXXYOoOU6/SDYdJ/iGaeI+4wXfDetTwVg74Hys6MsB0RSMipo1qcxXySU5Bp3GwidnFELrYP5U0iMqawDd/IzG+oTNVhwqpdR9jmK6Yf9zXGtYYXbOn5KOgt1kOeFWNcVoxONEtA+2Vf2M+0m6eTiVAOs68EWEh541kT+LpCsQJu3Xqi+NlH12yx8upa5bhPuoJlY/HVXLzfkqzSi3cwaSYQcZqgIGPwLiKSVyD0so4Jb18PzL/KIouSGB1QiypPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uczZPyKNNBm3v6syLVt4asE4D5050HOilxyrbotezkw=;
 b=fAYQaN86Jr0jcClhYr8WBM5djn4I43CElEPsowAKMGre2BY1iPWBPQiHOqMzlvYr0tqdn/lsS6qQ3XzoshfnFfLXEg0kHBEayzaTljo2LGUD3MVH1gQ031zHhvb8NNUxOxpdo12PC26LCHogRxVl1A8ar7FKXDQmiyWBIejAEgQyZNKTcogEc3hosI8SnewzoZUGx2IkIvqWFSENGaHo0cCQj0ewSDLRXCk2flgMAFn87sgC5j7+DxfXI/LSC9mLPj/spU5bMpakH9BKC31urB1bOCCJ0E16136XMZ02n4svdGEGbgqWUanMumo9b92GXuURth6Gk+fJMkPToQnnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uczZPyKNNBm3v6syLVt4asE4D5050HOilxyrbotezkw=;
 b=LoN0QuuGjNMNrbZrBbagr7iG6Hjbkiz5xtQxyD9LWcLoqUiuP+97QMUc7TrYzAON9J52b9CPTHI2OQNPZg1OTQmVFP8KZVRr4HZjVBErkcuAerqQ20CrOXxsBjrVa33y25YVaYNHNMts4UGgFP33SV7Sq6jq2DgdfWfaKI2qQpk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1455.namprd15.prod.outlook.com (10.173.234.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 23:09:27 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2451.027; Thu, 14 Nov 2019
 23:09:27 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Eugene Syromiatnikov <esyr@redhat.com>
Subject: [GIT PULL] md-next 20191114
Thread-Topic: [GIT PULL] md-next 20191114
Thread-Index: AQHVm0CP5w6BUO39VES8JFR1s/pJLw==
Date:   Thu, 14 Nov 2019 23:09:27 +0000
Message-ID: <3B22CE6D-0244-41C8-81EA-2FA72505FDCE@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::3:e9ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6f2d87-fd65-4d0a-747b-08d76957b291
x-ms-traffictypediagnostic: MWHPR15MB1455:
x-microsoft-antispam-prvs: <MWHPR15MB1455598CEB108D046CC2990BB3710@MWHPR15MB1455.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(2906002)(5660300002)(316002)(6512007)(256004)(33656002)(305945005)(6116002)(478600001)(14454004)(110136005)(7736002)(81156014)(486006)(186003)(476003)(86362001)(6486002)(46003)(2616005)(25786009)(4744005)(50226002)(6506007)(64756008)(102836004)(6436002)(71190400001)(99286004)(66446008)(8936002)(66556008)(76116006)(66476007)(36756003)(8676002)(81166006)(66946007)(4326008)(71200400001)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1455;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPuw0QtufYNndU7GeT8vbwJWfbeE3JvqcyT/8yBl1GPORB8xWwFwDKfJbb7RHH/ty96uasZmwjEUT3kS/7guKIJWzZiT/NWn44i9u5QmVC1mRBcH+8Xi3XhurKhUoSWDVA/gWdPtXQMxwp9efrRM39sRQ52rFWUPZLxzfLcDBOFWd8nbYLE+3GFAXGb/hZAU/Bi7Vw8LSKAYmkf7UEUNQGU1hXYOic6xK031rkgD2mOH1ko8KZ8QXrKgq8nzBNgPcmYxetGsAuSMUrcgtSTLTf5HvSgmoIHtf6HW5ltiVMfpdES8Tn+DsEgnku3E2ZuRL4TWj2IMV1G1rw0xhdikVl6e6YjImjR0SNy9fR4mb4vOTVfqJXo80qTiLQ0n7N3cD7+1TdkdxBRLW1ajRj/a8q91uwOp7JwpytOXE71n1BTVybLe7ozdg4akj4jvPTHq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45BB4EF4914FD64AA4593AC3BA017081@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da6f2d87-fd65-4d0a-747b-08d76957b291
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 23:09:27.2493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7wc5NIXWZXuqFpF0jbhsmAAKWjeQuZqk5d6P4lR2GocfXrb5qB2jAPZlHd2xedhC1ATK6Lb24ZF6vy3MOB6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=924 clxscore=1011 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911140188
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your=20
for-5.5/drivers branch.

Thanks,
Song


The following changes since commit 15fbb2312f32cf99bd8e0247ac0240c9bce0ba47=
:

  bcache: don't export symbols (2019-11-13 15:42:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 0815ef3c019d280eb1b38e63ca7280f0f7db2bf8:

  drivers/md/raid5-ppl.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET (2=
019-11-14 14:59:15 -0800)

----------------------------------------------------------------
Eugene Syromiatnikov (2):
      drivers/md/raid5.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET
      drivers/md/raid5-ppl.c: use the new spelling of RWH_WRITE_LIFE_NOT_SE=
T

 drivers/md/raid5-ppl.c | 2 +-
 drivers/md/raid5.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)=
