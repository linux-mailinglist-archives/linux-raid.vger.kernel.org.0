Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46A8D97D3
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 18:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405823AbfJPQsX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 12:48:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404582AbfJPQsX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 12:48:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GGmBXc029478;
        Wed, 16 Oct 2019 09:48:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mOeSgzYcdAUo8G1qN/Pcn/jFT0UZ3RWwCbS/65IZsbo=;
 b=g7egOeZKWQB3WqO4kzQhLn4SUigJPRbSnZtMAPCuR5aJ6KNfksEGGFht/9FI7p/l4Nub
 NF02KepBbJQ8dJOYIeHgY9fwlwE3XL1o0MhpO/kYLJX7lSlZMl22dnmHdbQsIkrRAQ9V
 VyEZwizJpEy+gL2HMg9Qgfpp5OCyZcWy8bs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnmy2cfnu-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 09:48:21 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 16 Oct 2019 09:48:17 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 16 Oct 2019 09:48:17 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Oct 2019 09:48:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwGvx8vtSC3ImNVGsqwmgz2GpzTMsOknJygrvq9HQKG9AESO+bJ5PxbkkYtvILvHpl8HlvHeHxz3r2kn95i3Y0M9dxAcDlWzT6VWlCoAob4JH37+uboPHTxFrSm0d7zFyRGfQ1U91GNm0mWhBIhAxY0PzGSGqKz8v43oAIgBVxoS/ihB72drNND3FHbWuEDn2h/oKaKQih71L8Fh5c816gt3lQMlBloE5QEZlcDwYGJZCX2GSQOufTkfsoHOhOPocok2Ya6Gi4DXEU2ddUeuzHpkuWGmbDerdJCcnGdZ5OWiVI/GH+OsgntYn+ieKZQ/Uhn9YlWh/rODhE0kRezysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOeSgzYcdAUo8G1qN/Pcn/jFT0UZ3RWwCbS/65IZsbo=;
 b=gPQnp3WVSIbYXbGu0yma/ozhvTIYbOUr8TRahvRLiAidx4U8vFthJiIJzcC2+LUWpX1GWcHmrcgBWnl96jOX1LJBPXBKXp+EKEGOqbnS7Ida9EOl/aNiiKL46oj3YseTHA/bNKTDbIrlzW+u5RCMJoXJnX9RjNxAoedGfZEx1caaS4ugBNZbtEytV8dDW9ZE7Qq/t7DTaORmUI14fHAdAsDr+NrqtHxdheIB9R9ciPeP7nYrwfW/0yF4rgDhAMy0B89eZe4luGWC6vbwq4G1mHvz3Mm3VlLv3nqCBhZUPj65grd7QxbCxkMVi6HYKiZCutYMJjldi8/qt2aKQJO6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOeSgzYcdAUo8G1qN/Pcn/jFT0UZ3RWwCbS/65IZsbo=;
 b=Dl81Gha1WiaMLSI656/a56OySJPIbmAh1ojk0IqM5cxv/dk04aMiDSwe2rJa6oxt3UZCYnfSKa/S1JQKfn8othkTl2Y8A7KT68oJIRxb6wYpVbOZbceVnObOvCQhA7pi/GaFwUEH7KPbkJzw+73N0UEaEOSbCa69RqmLWPuwjSQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1902.namprd15.prod.outlook.com (10.174.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 16:48:15 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:48:15 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>
Subject: [GIT PULL] md-fixes 20191016
Thread-Topic: [GIT PULL] md-fixes 20191016
Thread-Index: AQHVhEGBKzR4OeDtNk+CURUO/AqgwQ==
Date:   Wed, 16 Oct 2019 16:48:15 +0000
Message-ID: <0EEBEA3E-141D-40E5-8E7E-DD1540124ED3@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::1:35f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46cde3ab-bd49-435b-7bb8-08d75258a3e6
x-ms-traffictypediagnostic: MWHPR15MB1902:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB190251A059044A30A4C092BAB3920@MWHPR15MB1902.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(4326008)(6512007)(8936002)(476003)(71200400001)(71190400001)(99286004)(81156014)(14454004)(2616005)(486006)(81166006)(316002)(14444005)(256004)(86362001)(110136005)(6306002)(50226002)(8676002)(46003)(25786009)(2906002)(478600001)(6116002)(102836004)(305945005)(76116006)(6506007)(5660300002)(33656002)(966005)(66476007)(186003)(4001150100001)(66946007)(4744005)(6486002)(36756003)(6436002)(66446008)(66556008)(7736002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1902;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prggZavwk/AwFUrt48QYPWEUwV6EOGiTT0B1SywXfbFJV1I2VOHessMigpXvTEcvWooVIop2ONDhvb/pT/7il6vYykb+inRpko5xc/8UcyrgieN5zrjZ/2AFi/JcvU6dAymO88TzcxsKA9A4rjd2YHcBdp8fomspQOaDl3ez2DM9A7h6j8w1Eoh2Ce4tlZFx/v/Wxy5ZzJ1f00YqZlz79K+wM2f55L7xHAByMzztWaKLetLqMY9VknLO5Z0MKWOsTWtjncQt8p8TN9cIQB5aGuWGrEYvZdU74W8U8tZhWRuBbcrRqDo28G2haXcAl2UDJEmArtGlveQNByN5r+tfSG8CrmIo7fcWO8Q7w1DglLJZ1nNbNyM2PkTEmQwM9odlDga2Hp374rs6JhrzAQ9KW8WUNE2K95OWt64v0W6/bT7KTXsDkG8fpp9J3+hRtCZHaRlkHTErIH+lk0u3teMJvQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E54FA411CF817468487D58708A5DAA1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cde3ab-bd49-435b-7bb8-08d75258a3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 16:48:15.4816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rKVJZogZ0CoLLyBRVjKxeHV9EnJIYT+7LKRj4lm9Pgi+OZQYlcfSzb38qwGATeIPRNq/Nn45V2dkXfHXpUE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1902
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_07:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160142
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,

Please consider pulling the following fix for md on top of your for-linus b=
ranch.

Thanks,
Song


The following changes since commit 09d6ac8dc51a033ae0043c1fe40b4d02563c2496=
:

  libata/ahci: Fix PCS quirk application (2019-10-15 14:10:19 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-fixes

for you to fetch changes up to 3874d73e06c9b9dc15de0b7382fc223986d75571:

  md/raid0: fix warning message for parameter default_layout (2019-10-16 09=
:43:02 -0700)

----------------------------------------------------------------
Song Liu (1):
      md/raid0: fix warning message for parameter default_layout

 drivers/md/raid0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)=
