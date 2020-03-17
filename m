Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A8188E70
	for <lists+linux-raid@lfdr.de>; Tue, 17 Mar 2020 20:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQT5j (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Mar 2020 15:57:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQT5j (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Mar 2020 15:57:39 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HJcdlM029601;
        Tue, 17 Mar 2020 12:57:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C7QXgKZJKcizkoD1K0Md44pE3840ok+w20PCVqT5vhc=;
 b=Hx8x6E0qgBC6s/IrrGel3E/aDNNZv66uVLjcE3btTCw0yYrn3YRSObOi6hw+GKWFpobt
 xsuDKkGT/+bG6HDOEYGeEvhCouHzXB+hsXZqzFLF6x8iyF3Wvhk5DSs1zmGVRyp83HzA
 JE8Gw0+YiNrZTAoV55goVVaCgo94C+Ttrz0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yts6vkewx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Mar 2020 12:57:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 17 Mar 2020 12:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQLvlrEVpogCNsa8uZiA/FW1Ax1RhX39tYECnKZN0UrWkSbR0lzlNlY39pRB541aODzi3LUqRFqukbzgBlbu4XNrrpXIOIRXAUahAsPuXHmlNpSzNwWAVqEBAc4aJwmGnRDDGITFdW8tb5lBGt9UJB4bpSGIwwEvvxq/fN4LE2NBBgxGyN/o2exSI5Y7ayvAd0HgLMSZEUpn7rCTjdVFF74GvdV637K/91s3FMritgDFJrGC3ynY0NO1fmcNlfzEjBV2bQV4wglVZ9YoWYx9SnBhMvELGP6rqmIKfothZXkNMG1sDfELOj0t+OtXrjrkMn2KZi8z9iHZUELFLjDi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7QXgKZJKcizkoD1K0Md44pE3840ok+w20PCVqT5vhc=;
 b=mclRzz/tyU0EvoUfYBIQ4ArjWItg3Qj6MLc4NIPEQEvhgy0hLrBcFew0R7GyNkdE3gf6ZssXdcU1pGYx0t5edAF80uA6r0wDcOFdXgfAaO8J8aFXkSl0gaf3t2Qwf5r53jJMNbldlMsMZozJov3eVTDsoFrt8+FQRB7VD3iEEMEFav1dGFV/lQNPqL7Y5JtKE4nwVgtD/jk8tt2f6HDfpcn6hIG6FwUCHNQO6y0aJjb8cAJGOOlEFimXR8PliwvqaknYVR5qS3X6hDLAV8etqLrGF9Psk+6Rr4YKW/OUh7MMaAguWy7Cwq4q5c7WeLc4PlvQq9PMZXzYQnFscHOuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7QXgKZJKcizkoD1K0Md44pE3840ok+w20PCVqT5vhc=;
 b=ijjL62ZQlb3YqGirFM1B1MkyrhYVkY3NJZBwXP+au5rA10g6Skuojy8oOlSZgweoVHri8uqxkxaQ6l1ntMHiHfpLyNlj6XFMq6bs5LmGBirdHKNWqDkOH1sjppDvvJaPI9u9iMOBsoWRJ+jfyTEpcUjcWFFM9pqjSh4OME+A76Y=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3881.namprd15.prod.outlook.com (2603:10b6:303:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 17 Mar
 2020 19:57:34 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 19:57:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>, Guoqing Jiang <jgq516@gmail.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>
Subject: [GIT PULL] md-next 20200317
Thread-Topic: [GIT PULL] md-next 20200317
Thread-Index: AQHV/JZMCabDoLnGQECwXuKbec87RQ==
Date:   Tue, 17 Mar 2020 19:57:34 +0000
Message-ID: <7CD08FA9-5302-4885-98C5-CDF974CC225C@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:424]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af72e0f-1b89-4d0d-a246-08d7caad6f71
x-ms-traffictypediagnostic: MW3PR15MB3881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB3881EAA1391D56B32A148C5EB3F60@MW3PR15MB3881.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(346002)(136003)(199004)(6512007)(86362001)(6486002)(5660300002)(54906003)(110136005)(36756003)(8676002)(6506007)(186003)(81166006)(2616005)(33656002)(81156014)(8936002)(71200400001)(66476007)(4744005)(478600001)(66556008)(76116006)(66446008)(66946007)(316002)(64756008)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3881;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbygHFFTmX8VbVqbINrAZ0A4CUtonXsNC6Kh9mCWWGxcnKaV4Qt7KwM1L1OWPJA0DD6sSZNFVig3bJkUH6RYLXRfjg6WiAytCylGkLB4/6ZOmYNyk4TLc24X5HOBqpq+4sFc/GayuUTw6Wn18vd2pD/Brrrlxze5mglG+Aa/1Z1wWMjbNmOZ39uURnkgtBOQhS7PpbPluYXvug1vFKNePq/55eE/UGexjVbyHgu0HMG20P1fojq7m0JAnCPBWBGKHayslkPEalgOPK33HMeDbE7HlGJ80ZxSl6XVJQYpuWDMX3/RmUYayUhjsKoBqQ6u/dZONn1U6gLWbnTZNf+AzJ7QbTTTEJ8vAuew6KQ+SIluOPzgGSvIA8+dZvvAZSVrAZLaCdwBygd9CpyfJyl/OSmlHyVpvu0N3lviXlZspsg/EN6XypZhvbkpC+j+fr3g
x-ms-exchange-antispam-messagedata: 7waSFJuZDJpqhQ9XvQEauekA2jB8pzOGtGN1TYP9Ne7VfjbJHQheHGTqMqHpRwgalQ1kIvjdl/VLB8idSW/Q+gI9ygcohDZO/zQVk/yiDENkQAjFBLr/ABYLE8Sgqz2/3DZoT01KC6/MSLS8dZe2ZTjx2TdGtytWvqWUmxWOjhLA6S6Dpt4gbeSG4Me0Ys3i
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53FC40BA56C5BF479D69BA59CF5CC2BC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af72e0f-1b89-4d0d-a246-08d7caad6f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 19:57:34.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LdmzwOqzlgRIb3QmTNEkoTKG7oSl8UzmH7YrjgmX1D8A3qn/2P4VtY/5386+S98K7F+PL++WsZe/mOSn0hBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3881
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_08:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=702 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170075
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your=20
for-5.7/drivers branch.=20

Thanks,
Song


The following changes since commit e83995c9f84161900b80d337d6df358a7803870a=
:

  floppy: rename the global "fdc" variable to "current_fdc" (2020-03-16 08:=
26:58 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/song/md.git md-nex=
t

for you to fetch changes up to e74d93e96d721c4297f2a900ad0191890d2fc2b0:

  block: keep bdi->io_pages in sync with max_sectors_kb for stacked devices=
 (2020-03-17 10:53:07 -0700)

----------------------------------------------------------------
Guoqing Jiang (1):
      md: check arrays is suspended in mddev_detach before call quiesce ope=
rations

Konstantin Khlebnikov (1):
      block: keep bdi->io_pages in sync with max_sectors_kb for stacked dev=
ices

 block/blk-settings.c | 3 +++
 drivers/md/md.c      | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)=
