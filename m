Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4082B23E335
	for <lists+linux-raid@lfdr.de>; Thu,  6 Aug 2020 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHFUbc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Aug 2020 16:31:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgHFUbb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Aug 2020 16:31:31 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076KVQZ5027395;
        Thu, 6 Aug 2020 13:31:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZxEyboLw3ulMpkN4/3eXnCNkrHBevbB3VrWCB7sznNg=;
 b=cDcSL5v0YayNdtPv+gvAYS2IUslvYkrOM+07vNrrOLbCF+8PWDd3LemdSTp424Bm9DGH
 sxD66llV4WGOBnLnorjl15fUYUuSBPULeM5OWqV7EUdtrM4DQnFuwEi1+pjDkgKVfxMD
 E+74342sX/8ZIIbXtZ9Q7ybkR1aiUYXHs2o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32qy25f4vj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Aug 2020 13:31:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 6 Aug 2020 13:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK5jcDOQeTBj7gplL0TZEUxDaaV/8kfKdwzRWFyZ94xoo7994Q+w2nV1ujUtyM3D8lgSxICxJuYk6EfHrW14Nx2oDO64sfxVZwexHE9HnSrWuwZxtDlk3mXNwKsuxTxYkkRnB+MfuzCdOvGVMQOTTksqb/XN8Lvzfhxbx6RBwmhO73295B87ZsHnXzCMGhJ1lL9RNKvCZpadSisjY48tEe8Mf9XuwGCjxxEWn9LW3lH58+IFNyExwfQh/5LNz2XvE/zmPdd/S+0cwwowSkpSC5ktFydiN9M7I93PZ0FwJPTGO8mX3RTAvyCXNS/SbiEgkA9RdRgyBWSrrYdpazcZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxEyboLw3ulMpkN4/3eXnCNkrHBevbB3VrWCB7sznNg=;
 b=GTudBAHWuD6xn1Yx9Gk6lL9Sg2RU5YLVmTAFnL90mfYo8KhofGHQEazT6UM0GftzF/ndfBgj8vuEJ8tsiXn9Wt+XRrU4N7tnowmgzlGkPfIm0mTBMTITHxtjfs5Jwqky76sumXW+NTc0tHEWMZxLYmIc7USbTIe/TWcNxdflYDrKHe1Rl5FjFiIIVZAkJ/ne8bl9Dh9GXgDXrnDanwvY5QAKMIjewrPhDSrxG1wAlgNqR6rHac4JZrU0A3+wkX+QZKCt90zp2EuKdpyoAXggMgrfZTncV8QT7pjysffWBWVxC+0GdZzX1q7MKEfRu5ySY5INxqdjMMfPkZSn9jnkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxEyboLw3ulMpkN4/3eXnCNkrHBevbB3VrWCB7sznNg=;
 b=g5TNN8IPn7OFNruzPL0cqwyM5yJPhHqssBeTWHZVf3Mxp0W0ot8WwwQmzJhkQq+/ep1d5psWO7eei0t31+j0VV3Vv15nohHCvMqXhZNCacTJ6vcKhirxUTn3Exorllnxk9tFchzcyVUW7ry5pqDoY7e1Jrtgxrn4PjuE6WIq5sU=
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN8PR15MB2996.namprd15.prod.outlook.com (2603:10b6:408:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 20:31:05 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2%5]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 20:31:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Junxiao Bi <junxiao.bi@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [GIT PULL] md-next 20200806
Thread-Topic: [GIT PULL] md-next 20200806
Thread-Index: AQHWbDCCq4QqPylY80eph+h4IRm8VQ==
Date:   Thu, 6 Aug 2020 20:31:04 +0000
Message-ID: <DC5BBD6B-C93C-4376-8120-DF48249190F7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:8f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8229f57b-37e0-405b-9711-08d83a47a494
x-ms-traffictypediagnostic: BN8PR15MB2996:
x-microsoft-antispam-prvs: <BN8PR15MB299660543898405BA60661E0B3480@BN8PR15MB2996.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BizyubL/uHvKceYT8qPU/5U1SVmkpH9jvVWn+Zuxa+/V2CHH2NxA4fjGHNJoKfq2ePsdrU6RxZb64iCwkXJ0JnOYkFZ54uLoR+B02fd23cl032qVT3AJXfoogUxaPLRPcNV/6h+aRNcMBd6pWrPJjynjLXzmNyAzUZOna61YOdBIvCc5AIi9aZhpAehAlYgp0NZMvDnBlKaYnSIaljEEWeimtWnrLgPPLkGqxAYWwtvJhhyQ4cBG6rU6cp2CFmizpgI4+8tgYKhN2zCty+cTM+oAgGQjuE8nSqegE54QDx9b6cX80WusY8RGorjUkHxG6LiVEYf5yhLtJs6k9BFr/FP0RchUUOeUVkxU7vaXBZB9i8DemmeXSqWxQcuCzraPXgol21yFmnLrdvIIv2cr5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(86362001)(2906002)(64756008)(36756003)(76116006)(66446008)(66556008)(91956017)(6486002)(66476007)(6506007)(66946007)(6512007)(316002)(4744005)(8936002)(110136005)(8676002)(54906003)(186003)(4326008)(966005)(71200400001)(33656002)(5660300002)(83380400001)(2616005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8737SKokcg53k407p3PZUl4wYac1Tan/ZPVQwxEbBiCYzSiZJ98jNceL+ef0aBL/2I8/SkYA0QnWiiho07GJFkm34akgf26BZsdpGiepZ2sSZyJdpuesOYIGgUI6zn0hREv/1XYFeqEgwSMPEFpo2hJ58CD2CLnCdTO6NhWw9HAPNQKoN5DwJuK6wQbxlyuSh5NphbRwXUpdLYo+ecwmejO97gaq69Wk8KpCQQNC2kdipRZXd+S9x3IFBAJxw67NzaWis/olzIoMrCLmxypHJ3sGWmqYB6sImv/vtldy6IHjKtbVnS+jbMT9KMgdr/dejjazq8eb2DCvdY7SW5kkoyhYiaPrFT8WBoWCV6bC3ocCSD35I0M5r9hbgyFrg6fta0e3d1vs1qCbATlMpKmniQ/aMCbTLz3mcyj4yJxpxpRKTJ9wt3iL6y0OoqnT84IluetuyagiWqudCVunn7sPTVKNNa2dihj2LfV5pk8XVAZyyTo01XkdNnmaKXE1thZZqK7B+ngrEjYJhiw2qSH/LumNk09njYfT09jfTQf8n5WHcmLvbcTk8NNsbvcphLQJk5RnLbCSA/l0WHygxzYDx843kaVGhPoP0MBFWxj+Z4eKatgclli4oYLpNyeQwh8HvPCFhaCIUDjnEMT/SU3KQ/V82XAS0OB4VH01KhaD9rs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBE05FF448AFAF43A8B78D9630246A60@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2995.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8229f57b-37e0-405b-9711-08d83a47a494
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 20:31:05.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJJupiyR0mwy0DLyw036m54nqN+q8dlexY+a3eS68BXh3nWjoUWgIGUA2z26HT1mym+UYZPH3CTT4ZFMJ/bBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2996
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_15:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060134
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following fixes for md-next on top of your for-=
5.9/drivers
branch.=20

Thanks,
Song

The following changes since commit f59589fc89665102923725e80e12f782d5f74f67=
:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git=
/song/md into for-5.9/drivers (2020-08-03 06:38:44 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to e8abe1de43dac658dacbd04a4543e0c988a8d386:

  md-cluster: Fix potential error pointer dereference in resize_bitmaps() (=
2020-08-05 17:07:48 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      md-cluster: Fix potential error pointer dereference in resize_bitmaps=
()

Junxiao Bi (1):
      md: get sysfs entry after redundancy attr group create

 drivers/md/md-cluster.c |  1 +
 drivers/md/md.c         | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)=
