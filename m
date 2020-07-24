Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6522D1A9
	for <lists+linux-raid@lfdr.de>; Sat, 25 Jul 2020 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXWNO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Jul 2020 18:13:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13570 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgGXWNO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 24 Jul 2020 18:13:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OMBOKp031168;
        Fri, 24 Jul 2020 15:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Wqcnqgwifmty/Pz1SMvwtf1Gc9oQUw5jwAhTQYuD8k0=;
 b=EVPWwgLvB5QpgJW9SYNcbKnTXhNfRtAfwu82NROXV2pF+d5RI4F7bt8oe17nevWBqKW5
 UTouxi8g/WpHGpnDJVgo4+HucMs8myLWOsYkSoJ1hNMrB4Xv6CzsCh8mgC4qtqiWqHYz
 ZA/ncfdsWn/ejE6PSW0RXayrM8A3nEw9OEg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32etbgbvp0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jul 2020 15:12:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 15:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMzDMBKzJkw+RP55mcwiNzggSj7f/nnhH1fqFWbnwzUNTPpnX7QA67HpT/t7VpSJeQyisZcXUDctpkZXbKPlpK36eP1zOYKqFHQ56Ftzon11UX/B+4DHx5ObVDuYbwz21dmfo44cBHjpKHcPtvnBEq0e8VB2wJQrleP2+3sRQ4cMXjbgyina7hG+0TLkoUrrETP5QfuYwognXvCPXiyqO1/uFiMTeZeNY0Ekw27dppxOMszzN6xmcJxgnKTuAB7nleoMqoiR5MB/reWC1xNG+QX19Ivu00k8GoSA5Csh5MzqXRch5Cqq1RCnBSoVZbEWnni1/OPpTGiWV3Ze1eUc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqcnqgwifmty/Pz1SMvwtf1Gc9oQUw5jwAhTQYuD8k0=;
 b=bRn+1IO+AA+ihp8bvkIGZTNj6OSt+vsMk07QsRrZGXto/Tuuu/NoUfZy0B8RLt3LEEfVTe0AHF2J3vxRNCKDEeqYlfmBMT/Z6t/jQpw84LoHIjxeQGIGbhHodPCU/XEOttMdyu8CAPAQCGJjoNzPHyW10WYqseAui+4kOx4tQFh2+clmBw+7NuJvRAxbpfNmZTqabqWNhfuyxI4ETxOnqytoTAiXT6tbTUpBwpMt84y4Ge8pvS0qdmUgaknY4rGMXF8Ns/zISKtSfXORaGMUrtBN8hdPUOTEJFBhD0Cwg+rUdPLDY/kM4Qir4pUcV+X4rN8Nfa55ZfdNmpn2j+LYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqcnqgwifmty/Pz1SMvwtf1Gc9oQUw5jwAhTQYuD8k0=;
 b=IpT28v1Acfq+PZVmPKL+PtfC/Rokl5EIS/NQ3DxjYcw+Z4xp5MUVPynpTbiKBFsM2UEMBOkrpTejSPib6OXkAH4Sn6su6bCrt3/PzqkqPC94GA/TIGrzht0GCxmmv47U60UMNeh9EIOhuDbECTAChPD/gz9u1GxEMgypdPVoWHw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2326.namprd15.prod.outlook.com (2603:10b6:a02:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 22:12:23 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 22:12:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Yufen Yu <yuyufen@huawei.com>
Subject: [GIT PULL] md-next 20200724
Thread-Topic: [GIT PULL] md-next 20200724
Thread-Index: AQHWYgeB1EfwKXZI/kyjr8qMMFMOjA==
Date:   Fri, 24 Jul 2020 22:12:23 +0000
Message-ID: <2C49144E-E8FF-4ECE-8897-F478AA1ED490@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:395d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d521900-e6a4-4bac-0608-08d8301ea462
x-ms-traffictypediagnostic: BYAPR15MB2326:
x-microsoft-antispam-prvs: <BYAPR15MB23269A2C6A4646782ABC03A2B3770@BYAPR15MB2326.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKmvvbuotXxLUqGt3PfujHnxRvdEH5kW/xsXMjzLM4SfwUKZt02iIAb7ARRdBiW2K+Zsp00P9yEC682DlXxJwt5U3IDsI/dlwHRSNMsKi0j6oa8R0v/UWWJW8Ur/m/+QRhaK2bd9ciAXfyPvgj8kKi+pBLdbEQE4D24UjWVzizxE/N9zXoohqSpRj6bxzzGKyyNYY0c/WZ6XuSlCSoHJVWzCZNI55rZge5NHEV6eWczR4xct3TNNIOnDMfNT3yyNFdp5DsXfi9X0pGeXHgMYXCfVHzUc9Rx/K1EmUNOET1U5ZrHxBHdtmsdVvfEdjQF3tHiwL7mN1sQvHmNirSSRHqxFnzPCfME8+ogotW4B8dTBLtFTGxnpUoxDxhQpt6+S3X44fHlKKbsiA59jySAlIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(36756003)(478600001)(86362001)(6506007)(4744005)(5660300002)(2616005)(6486002)(83380400001)(186003)(33656002)(6512007)(66946007)(66556008)(64756008)(76116006)(4326008)(966005)(8676002)(2906002)(110136005)(316002)(71200400001)(66446008)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lHgpjk9eRVYh8LI+HsP8CJn7aoikmknD8out1ZtaooSjgF2L+CC+nvf/IukbBfDh1nncMzf6KPC36HCbJN6POdye9k7VDofBKi2z/bLsPGkRSCsvPVKXmmuL7z3VXfzfXdZCc/P2La0vLH/FheXY1FTX/CrIDi+37Kh3fXlLIoJ60/xdOVSwJMgNJOujr5YOiYkeQFEakEpnMtZWgiPRcMeErMuCyq6nZ7AsmMl31mWrC6gkwPrNq/OMPnF1DplGD99lK5gSwL/YojeErGzFrV3RYjEourYN3gSWQG9mz2wnENibSvqnRnppm5PwnqLjUiqD24TSJVPqXyaeaYUF0aN1FTVN1BrctiG7ccIDtmYWZElDnCZEOwhBgdfjK8nTGJri6uD5XLWEnJYNgCrUwXbDN4Us3b+LeDC8pMoLA3tmmheRIcKJQyWzt/7mvHh70O2Mrtt/3yzSPi1Nlb2LWK2MHIIBA9M3iU8TSgEHJfkx1DUlezZ8Io1U9T+9sNE2TPVM2BYXr+2jkqQ+8N8nbw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54B3FA64F9DF444B9B5266911494B7D8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d521900-e6a4-4bac-0608-08d8301ea462
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 22:12:23.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTUBdBjjWaQvNvlpRZazzPvHDA27OkleqrzjVUnozKFIy7bHFJTGTqH5S50qrjW4cgVVA+xxcoRfPXJj7yI5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2326
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_10:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240149
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


The following changes since commit ef67744e7a4c82e246cd9831208d07249c519d22=
:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git=
/song/md into for-5.9/drivers (2020-07-22 14:11:38 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 83c3e5e17b5e3057ac304383a46e3c485d00ffed:

  md/raid5: use do_div() for 64 bit divisions in raid5_sync_request (2020-0=
7-22 22:49:46 -0700)

----------------------------------------------------------------
Yufen Yu (1):
      md/raid5: use do_div() for 64 bit divisions in raid5_sync_request

 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)=
