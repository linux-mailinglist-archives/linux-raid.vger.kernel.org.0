Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42335571DE
	for <lists+linux-raid@lfdr.de>; Wed, 26 Jun 2019 21:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZTgl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 Jun 2019 15:36:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbfFZTgk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 26 Jun 2019 15:36:40 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5QJY6Fh019282;
        Wed, 26 Jun 2019 12:36:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=facebook;
 bh=1o/SsmjL6F26ZsgGUxFYNtOsnRBHSd2OTE29zxgLZZw=;
 b=BnmmOvftPKfAwgAF2FtXrXsXE95AXk5RjyPOcj78+20YEhNd0UOl4Jc3dhvbCInkq+Qq
 0lTFqHeE33x7BlgGjbJCGr9iL4KZgP70jmOBUBx6SVZ/tXlztReq7Uip+e4P6zsMaiOv
 CaLq8qW6/TtpZgGNwz6ZYZku4/cdWOeRqHo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2tceeh04c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Jun 2019 12:36:39 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 12:36:38 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 12:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=LLtt2IJrmcnVbmthfXRce7TWwYV93iS+lgI4aEqqI7p4fDqCAirichOR49x/i2YwrEVtJ1ZKz2m/OIEp/0mYDSaN0mcK/GYf7nhNVcrtIofkxZN9qaD+1dmrRxE9JAqOhYfuCOSEA+vRJQZKDN6A3O6tRbya8o0akAsdNgxp90U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o/SsmjL6F26ZsgGUxFYNtOsnRBHSd2OTE29zxgLZZw=;
 b=RJPR0pmsCEW+5GyUcGmggZHnXpR0AVLwoERf0BMqDScnpkZ5bq5K8+E+SLllXzRPXtt1lJzVYG1IF0I4MmSKuKIPmelr3hcb9dR9sQVag1RZsDOm1hyvGRpC6fW90/JUB654gm/+XpU4mG+jrdxSotXRWwsxrneQLLiSqmprZSc=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o/SsmjL6F26ZsgGUxFYNtOsnRBHSd2OTE29zxgLZZw=;
 b=dPiIkAQ8Sg+HSTQ7ZiKnZ2T1sIkQWAfmKomt14fo1A73EDuaWNZjXFRo2LG+P3E29iQCK6qkq6rvfVT/5ENG3o+U3rOwe0lL6Fy0Lzp0MwrAqXs4jSwck0EBuuREDZbHS9yUKMyBk8LUzDYI08sLuCRehB98tRDIPmom7Q+E9gQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1871.namprd15.prod.outlook.com (10.174.255.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Wed, 26 Jun 2019 19:36:37 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 19:36:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: [GIT PULL] fix for md-next 20190626
Thread-Topic: [GIT PULL] fix for md-next 20190626
Thread-Index: AQHVLFZ3KSyHl67JoEe255CJ6fpMgg==
Date:   Wed, 26 Jun 2019 19:36:36 +0000
Message-ID: <526C01BF-475E-42A2-A994-B6B9741D6749@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:6898]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4811914f-8611-40e1-d669-08d6fa6d9a85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1871;
x-ms-traffictypediagnostic: MWHPR15MB1871:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1871C692DD0CBEA1C132FBCFB3E20@MWHPR15MB1871.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(6306002)(6436002)(6116002)(305945005)(7736002)(76116006)(66476007)(66446008)(64756008)(66556008)(73956011)(66946007)(50226002)(8936002)(6512007)(6486002)(81166006)(81156014)(8676002)(966005)(316002)(14454004)(33656002)(57306001)(2906002)(4744005)(14444005)(486006)(46003)(256004)(2616005)(53936002)(476003)(110136005)(36756003)(68736007)(71190400001)(478600001)(71200400001)(86362001)(5660300002)(25786009)(186003)(102836004)(6506007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1871;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9D7mJVbYDqf05c2P+GhCui/oFuLqH1eWg1eRG5nbOIUC/A5GTxfdkmWYOhtgqE9MxJbrQ4u/vsRXjyRh2qSVfAiqRFUZ938VPxZXYKoSpYHvugbN1uPSTLZ6XJoqe9THYF+ALzgFSW2hwkeKBls/xMdcd47MuTuSdi0oA3FdnaafpXRNfocK0ghMEz/ccVI36AQpii916wkJ897Ri13y34t3uEyFIBNjzwjz4RMl/8ZraPpdBOEpo9u6l7p3vodvHiHTu+APyjZijQUpwYG2xuBbZWrKilevbes6P8Gb4WTmnshl6r7nu6j5GjTWA3AgprUk04BmuY4cJ6aquNzej9/7SNdHXezwLCRUtJTRcxN4nxrcnl/n/oGQUMUqTn0bercb1YMkgdPvhSdd169RnLTeu/1USCPxpnSTWJo4Ym4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4463D5FC22CE144CA495E4D07A26DCB4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4811914f-8611-40e1-d669-08d6fa6d9a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 19:36:36.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1871
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260227
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following fix on top of your for-5.3/block=20
branch.=20

Thanks,
Song


The following changes since commit 3726112ec7316068625a1adefa101b9522c588ba=
:

  block, bfq: re-schedule empty queues if they deserve I/O plugging (2019-0=
6-25 09:07:35 -0600)

are available in the Git repository at:

  https://github.com/liu-song-6/linux.git md-next

for you to fetch changes up to 16d4b74654ff7c3c5d0b6446278ef51b1de41484:

  md/raid1: Fix a warning message in remove_wb() (2019-06-26 12:18:48 -0700=
)

----------------------------------------------------------------
Dan Carpenter (1):
      md/raid1: Fix a warning message in remove_wb()

 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)=
