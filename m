Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA611C037
	for <lists+linux-raid@lfdr.de>; Thu, 12 Dec 2019 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfLKXBW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 18:01:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbfLKXBW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Dec 2019 18:01:22 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBBMv2pe017150;
        Wed, 11 Dec 2019 15:01:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AFI4Ib1sm5SwrEcZ+M8ZPaalNq8M8CVKR3Lu2WVvXXY=;
 b=QI5C36unVdf+T2q3KV2k4F93qX8fWbTra4s8tQrEabIux9nMdqH03DYkrzgvV1DsXcZW
 bzU43FIk54QjpDOFbM0Pr3FwXhauNQ4yTqylsEbotsAer8NS2ExlEiu0qk3nCviBiKYA
 qLV3eNR03HbaYQONrQRdlwI9XtZXa98hZLE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wu5w912sg-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Dec 2019 15:01:19 -0800
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 15:00:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 15:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8eERycFLD6CvekCVnr1TkC8tR8+OXoMOvdbTH/2opELpA60B/9HxiBknuCkvH+XfD10s4Z8Bk4jT+AAVJ9hQhYU6IVr1HpZMoRMAEsJOfonj+0vTggGB389kWQr0h6LeBFWVz7zA3nW6WUAEFDW2NeR8fW5n8o+C1e/bn4sSUoKQt2430CC3Ixy9+T7LPtiJAewM8NirupHCiMH2PxaqWRvLcf6ymIhkJlnKmwfVzdBBHNCLZvl4EEkIAwpJ4NOpCU37wGvNzKx7ymXLZKPegqtoqKQVMi59Igm+RnYddGFWrdtN1BVTMQBN/ZbrfvYibk7Zl/2Wx9BkDgjlCQ3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFI4Ib1sm5SwrEcZ+M8ZPaalNq8M8CVKR3Lu2WVvXXY=;
 b=FbYmfEYqxIPbtNpmKu9qJA22OF7uDZMav/r1xfkUcYIr9/Sv2pUWbadMCtUFKrv8JCsX9sfUgFdZTzP0ANUMi3DEGSmU3ACFaUpHPfLFkcgUqzh6/dNfK4B7xwa7CgifP6kzlg2DhRIABEmDrRhYhPg4/EdDdpN8miAnGB7g5bk8/EODc3HOOqsgc8LFxeJnUaU7LnolhTZbfmh341wHtihEi5/YdB4A5X/uSp2qWf3p3XpDYT83Vp3R6Q8hd21Zk6QcUc+V9PBvl+qShKXqMHsA/RQkw6HiGAm9E/3GKElOxeZF+SmXS9oPzgoJN6uMggAYwr+Hx0gwmhSbp6m04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFI4Ib1sm5SwrEcZ+M8ZPaalNq8M8CVKR3Lu2WVvXXY=;
 b=bYVWKEgV3xyHdmV2kkpilZG6Zo1BbetRZ4sFTycnruxLKOgYMlqWZ/5wUQoDs+wbhSe+lnh8fbqnHhtw0+4sGegKgXXZ8gQoYHO939Iw38D5anSulAieiuakYbkIbbixQTjtWtftCS9Mz6Dea1PVaYmMDICxwLR3G9YMH9h75zg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Wed, 11 Dec 2019 23:00:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 23:00:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>
Subject: [GIT PULL] md-fixes 20191211
Thread-Topic: [GIT PULL] md-fixes 20191211
Thread-Index: AQHVsHbV6to3rpJGp0SD/eGQrSdA6w==
Date:   Wed, 11 Dec 2019 23:00:50 +0000
Message-ID: <D4EC2793-CDD7-44D7-9169-90129D7E8779@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::b6c5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbf83b5e-fe1a-4dfb-b429-08d77e8df799
x-ms-traffictypediagnostic: MWHPR15MB1216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB121698A7D6206BAC4B562DFFB35A0@MWHPR15MB1216.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(66446008)(6506007)(66476007)(110136005)(76116006)(66946007)(6512007)(4744005)(316002)(66556008)(64756008)(33656002)(2906002)(5660300002)(36756003)(186003)(2616005)(4326008)(8676002)(81166006)(86362001)(81156014)(71200400001)(4001150100001)(478600001)(8936002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1216;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AW690fM8+GbqkY7K9u4B/oL+t9wO2bl3lN4tvlptjHAxlOBPem84118GRgV/mKMjfh3hdbI26WY0EzeIFPErF/lI2b4DkTNHYwxRFR91Ojw/n2RYD5eI33T1QarIH5r2ObSF7cd9kXR3GkBuWAfIIoPkCLsSRHLUwUGl/skju3YmRZAWjGkH6p6sTfIXbsfBjBHMoZQuqPrTf5cMLWmlYaqKUU4S3hDwKTa/Iq8fywxLK4xehz6FYy8IGxjgeyZpPMXE888iq9FmCJDn7DqUO4JU7XFfoFF3avHin0X9P/j0zRZJ1tZ4GNXUECY5nsCwtWEjNa+uviZJjP1F0ySx0TE2qGocY3Idb35OnQhKNqkU2jSh+991mR7V3BpUnhIfNKrLItTtSoS0T7nU0GAUgv26qLXtQ40WHKDyVI1rXtzcdC4CSL9stzKtMno95qv9
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C1325661CA3464FAD380EC1BD7D56B3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf83b5e-fe1a-4dfb-b429-08d77e8df799
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 23:00:50.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmkrrSAW3lZuAw9t6v7acxpBf5WhEh0/BT5oP451zCPncJDaTNmHfQP2mQh7TPz9nS1Nl526soAJW1PsriooUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_07:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110180
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-fixes on top of your
for-linus branch.=20

Thanks,
Song


The following changes since commit cc90bc68422318eb8e75b15cd74bc8d538a7df29=
:

  block: fix "check bi_size overflow before merge" (2019-12-09 22:04:35 -07=
00)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-fixes

for you to fetch changes up to 3b7436cc9449d5ff7fa1c1fd5bc3edb6402ff5b8:

  md: make sure desc_nr less than MD_SB_DISKS (2019-12-11 10:38:08 -0800)

----------------------------------------------------------------
Guoqing Jiang (1):
      raid5: need to set STRIPE_HANDLE for batch head

Yufen Yu (1):
      md: make sure desc_nr less than MD_SB_DISKS

Zhiqiang Liu (1):
      md: raid1: check rdev before reference in raid1_sync_request func

 drivers/md/md.c    | 1 +
 drivers/md/raid1.c | 2 +-
 drivers/md/raid5.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)=
