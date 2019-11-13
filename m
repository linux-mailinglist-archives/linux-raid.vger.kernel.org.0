Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51E5FBBC1
	for <lists+linux-raid@lfdr.de>; Wed, 13 Nov 2019 23:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKMWkU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 Nov 2019 17:40:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61102 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfKMWkU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 Nov 2019 17:40:20 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADMdFrV028216;
        Wed, 13 Nov 2019 14:39:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gBTgAETqw+n6TTw23nFdPmmw6JhKcmk5rsvC22guaDU=;
 b=lIQVTo6cx9dH3Gf9lV3MN7wBoTn/pwlBIYespT1pklBPKDCfEHRKaNo55BkIoy/qR6n7
 GQ5K7no3IvC16lIq2t6Wsz13PC0In6AQkyTbAFGbMzkXP5+O0Yk3incuZjlyx4mSkBMp
 lDz5xrpsh86ihFDOAFFa8xhlbjBy8FQrKFU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8qbvs3tx-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 14:39:24 -0800
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 14:39:22 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 14:39:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLNOEceaeC5zt8p2GDHLWCf7uWZkq0ihIxxxj3m91tbQ+VB5DQOT7DB1e0LV85WEPMa6arvlm0FNCMAF4UzAup+cV7CfFspWgI0wAHoFEeU1TV2yX8jr7vYdsabxon7D7OgYAX6/6izXlGsYNt5DXi2+ndm1Kvio2O/luerAjIPuArXNDWmUjJ5wKiabNrFZXjD51m4Ml5eiPrRG5RgXV5+hTUzmAMNE9NhpanXDUvShlOESsDxh6hvWt3xk+Z450LfeQOrsZtPiCw+g4gmkjLtccCFEfUp5EdYJuI69QH/SOEdbBrVmVdGiqgwP8FQAdDMRtmj2VEDbxQ8+F+VeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBTgAETqw+n6TTw23nFdPmmw6JhKcmk5rsvC22guaDU=;
 b=Z8wBTKGftpwabB73i1Fop7ArHeo7WpCOQgruiyBK1nFxqudhRcCj2wluzCgqv/IGf3E73FOPF+yuKnsZrYy6XlSLLps+CjUHjtxRg+bx60yTDy2+MzoKYr+f/bM0Vc5q4BHvnt/MSG7d0wC2WhKD1Li6fOI3BKnbFibGcWU+u/jKfa18r7U6Qb/WHFFWaJ9rLsyl3tGiJdJ8V5JyCka9IfQ8IRcDJ6l2Ki4O6y/DgoBqD3+/JorVkiLwyoogkb/czIsfkrxpeDwcwTdv1UkopeYMmc42oipMkGDtkfKA2tHN1/1shXa/1vSidtPsMktQA1iSateD4j+ihx12r8dVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBTgAETqw+n6TTw23nFdPmmw6JhKcmk5rsvC22guaDU=;
 b=bvbZyYmdbaZ+kw8wjO/eEs45YtjGmkuRZVYTuq9X9rF6YkeFUs8A+hxjasLWnHL8hdHeNfcRDEElQ4G9MfGcMNmo8Yx8gFBiBk2R5KbeHrtDPEmODrsbEhpIUKgHoKo5GRabjDYGEhFFUoAQO83ZAmaOTxobwAn2Q78CRPRaVp0=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.215.141) by
 DM5PR15MB1385.namprd15.prod.outlook.com (10.173.223.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:39:21 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::8536:d72f:3b96:42d2]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::8536:d72f:3b96:42d2%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:39:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, Yufen Yu <yuyufen@huawei.com>,
        "John Pittman" <jpittman@redhat.com>
Subject: [GIT PULL] md-next 20191113
Thread-Topic: [GIT PULL] md-next 20191113
Thread-Index: AQHVmnMxQZYU43uMn0WhCoYpWfS6VA==
Date:   Wed, 13 Nov 2019 22:39:21 +0000
Message-ID: <FE2DE0EF-F9F9-4970-8B73-CEC074391DD7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::1:1ab7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d89fad96-199f-41cf-57c4-08d7688a53ae
x-ms-traffictypediagnostic: DM5PR15MB1385:
x-microsoft-antispam-prvs: <DM5PR15MB138533B6A3C75321D0535F53B3760@DM5PR15MB1385.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(5660300002)(99286004)(305945005)(7736002)(33656002)(86362001)(46003)(36756003)(478600001)(6116002)(71200400001)(71190400001)(14454004)(4326008)(25786009)(2906002)(2616005)(476003)(186003)(486006)(8936002)(6486002)(64756008)(256004)(14444005)(50226002)(66556008)(81166006)(66476007)(81156014)(6436002)(66446008)(102836004)(8676002)(4001150100001)(76116006)(91956017)(66946007)(6512007)(4744005)(316002)(6506007)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1385;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +V1dZbEZhCRwO6FYVXFgB4GzpgwxzeHieCB60+RMVomeb7te1hdlCf9uGX0leGFU/oysnALZ7s1C9oLJHFONRZFqtAJk8ja0FIVpdGKzIFLlgrvgIMNb0yYl1X9oXUVgIrifWd/8cZZfvEr/tjoiq1A367sgeA3eIMQUVb8815waWELw5eV2U0RVN4AkbTQDD+k9kQ8Ia6sRe6nBy61Z7d9e8EbsIdwf0kE0tuiPcKMF4h3fQgoS+/uFFj7t4SpzEv9ofCGwwV6N/tiBsLLujM40iyz/xWVQqwKyfUBxgIkMLx/RTay+AA47FJROlKrIg+Dv/YbaXZOLCqBtwhGYXbsG5dfVqsAQ18oBNTW7rAda23B7ndnGU/qbRnzxe5p6wHPzX0plEMCEMLKjwXGhnPlv26SKeW3BFJ3yDtbz6mwk2DIMY3XqiM2V94GOA7p2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <309B06A4BB1E2848BEBCED373DD64A76@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d89fad96-199f-41cf-57c4-08d7688a53ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:39:21.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZjUrxpjOAy08PveJ1eiuDQHKEHXeiAJyx04Lg1ljl7dWkE1pAb+jQXT4Gzj/tuffc7f+R6KAnLyyCHO/JiiQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1385
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_05:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=668 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130188
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your
for-5.5/drivers branch.=20

Thanks,
Song


The following changes since commit da644b2cc1a4664ff7f75d3ae50e3fcf638580d9=
:

  null_blk: add zone open, close, and finish support (2019-11-07 06:37:40 -=
0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 45422b704db392a6d79d07ee3e3670b11048bd53:

  md/raid10: prevent access of uninitialized resync_pages offset (2019-11-1=
1 16:47:39 -0800)

----------------------------------------------------------------
Hannes Reinecke (1):
      md/raid1: avoid soft lockup under high load

John Pittman (1):
      md/raid10: prevent access of uninitialized resync_pages offset

Yufen Yu (1):
      md: avoid invalid memory access for array sb->dev_roles

 drivers/md/md.c     | 51 ++++++++++++++++++++-----------------------------=
--
 drivers/md/raid1.c  |  1 +
 drivers/md/raid10.c |  2 +-
 3 files changed, 22 insertions(+), 32 deletions(-)=
