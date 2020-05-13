Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAB1D2058
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgEMUno (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 16:43:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgEMUnn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 16:43:43 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DKepK8022160;
        Wed, 13 May 2020 13:42:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=K9+OpXtR4K0Dx37pD9uCmvELZVgCj7jhtxfVu/t11GM=;
 b=iG04ZMPPtYG6pAdT2Gj/ciFrO/c7YjDCEJI4KwtooAJcb8fqPttolPlLHOXQP+5/y9X6
 /eMKiPp3+nreat8xi1fNkCwmXUB+6xHnL8N8RRsFZLZJZhfPIHQGWeaGzTcqzbUcqJlD
 GY3Rvelncep8yNWzTgI/oWTk1REsZrv4nrQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1q96k-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 13:42:23 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 13:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXfT7CYi8iyce4MqipU96eoObhyOr6bV9hp3JsIapY/Rnqb096oS5aId2okylSAVQy0J5gcazqMbSZRyAsO7AELIkzXmCXwB145QuQlH3h0wMdcnh1myu8oWGNXqwc8NuzGJJFhh0a+gWmZAKNrvQw+CewmkOioOnq0xTgL6CMyu5YnMtJoh0kHDoAZwnUxvAlKBWs3sfAJA6qn7leMbDWlFTHzLW8/8NLv67RKcXxwfj5XhRWXtAg7Msb/fr3e43ifPam6iXikbVdpcwIj9R5HzHJYAknsPD9mpzMiIvlluCOv3SBiU2VwRlPY/tpsHlX125RXpAlWQDd/V6Go99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9+OpXtR4K0Dx37pD9uCmvELZVgCj7jhtxfVu/t11GM=;
 b=arAFaiJIreoppna2fUbMHd7ooMlowymEXRLV6vhdRaoyiTOnTGSoiSf4/Z1jQIuow9RoE7bNnD5YdxbVAq+l8F3PpHdSuiLPTBTgO+xoGg9Ix0gvFYGfYMaAcDqbcSDHgepaE+XZDgO4GWoVXcXtAYSl+lP6gDGUR9pumU6XVXuvsjClkQxZmkIAgVpnk47UBD2cMzfvXQTsqNJKbqmibhdWszj6G5mDDTUeco0oGDvBwjHKZ5ghy0dY1268VFWchHXNVOjlfMS1+uoowOqdO9q7hkk1q0Dpn+zhWLYLMNqMtqSZ9H8UyqVewM1DkIRxhS8gzIyOsPWaT08pVaHV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9+OpXtR4K0Dx37pD9uCmvELZVgCj7jhtxfVu/t11GM=;
 b=MGUycWMsAl0FB5I/YTEZTTntpfXOCzMebINNOCtDUcwv4JVfLEXF7tapwsSvdCMtj8p8lKUBtB1QvhGdygGya8VO1rxOIIcjoNKUMwrzSHagA1WmumTyiGeiSkUnve5CGBZPpvBVvGRZ49BMpDGmmMp2SYskzxZIpLVT36EZOaM=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 20:42:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 20:42:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Coly Li <colyli@suse.de>, Christoph Hellwig <hch@infradead.org>,
        "David Jeffery" <djeffery@redhat.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
Subject: [GIT PULL] md-next 20200513
Thread-Topic: [GIT PULL] md-next 20200513
Thread-Index: AQHWKWb1qSjQXgJbuECtbyqeBqoW/Q==
Date:   Wed, 13 May 2020 20:42:03 +0000
Message-ID: <196CD868-7B35-4174-AFAF-9786943E4B0C@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:a644]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae9dd524-187f-4432-4412-08d7f77e182d
x-ms-traffictypediagnostic: BYAPR15MB3207:
x-microsoft-antispam-prvs: <BYAPR15MB32072EFCB7C575F0E468695CB3BF0@BYAPR15MB3207.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYkRJfeB4W1XjgQPdP12IycI+/G/RwK2t/c9l9awpDDx7S+M19yl9haDrBgM6TW0h4eBkQJBpadH1is4nUxlhycjvcLjHOMO0OY4HWtsw+v5p0BU+8nh76j2MVB62rN/XB0ei8XGkTr56EqdwhxsGFbz1j2vwtqq86xQ6F/GtWcQ2jHhNKpD8MHDQ384O6ByJkACcmXfzcCG9/fJgTHQHooPmJ6WthFSGoE8Z60Pz0LyauNYPzhVfzPghO4khmEYMFbw6EnkYBMGKE5CkOZObv435u3Dlq2kwXw36E8VYnoumJF9Fq1xAW/Xpk+Pzv103Ha0KLN7BbjE1WP0N+DBtn0988XqlLtxSIYtGrpTL2pXU7rkhXueOSxSG7ZFWG/54dFgBt5Q2+b4FjDzvB+obdYpIfyN7Fj9p9XHNtAdD4L+MwoIXd944bLOPxNt0eCdlFgjsG994hi7nKPUKYrdqDt2jzt7RH3gWbR6bs3h+Oc0EruQj7Wgam6KMpJUdDrXwwUodLGEuM1sadgw+TXS76ZVro69BNUN4EO1+ghcfurPgKTxsFwn+BBGiTjI2n7LHtOc+Ojtp4rYR6FMG/BH5fE21oID4anzxaxtJ9MGgzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(376002)(346002)(366004)(33430700001)(966005)(86362001)(6486002)(4326008)(478600001)(110136005)(8676002)(54906003)(316002)(6506007)(2906002)(8936002)(66446008)(36756003)(6512007)(5660300002)(186003)(76116006)(33656002)(2616005)(66476007)(71200400001)(66946007)(66556008)(33440700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t1cBIdXNtH4LgpBZ4q4gB3yW1a+uO6f0fsZ8tkA+HEE7E2LtkV/yfyuYa+e0yBVXULfkTyPf94XT5g3sbHbnDZLNZOc8/gQv+8wOiB0JHmDqwu6U2lGXFf2vOUFQmlXeGURQBCGYGDFw/JJX+xhOUJJpvUchddQG5t2IWMPrX+TraQnq5YEkO4k4tE+rUY1bfPIofh7GbWnFVRlagR1TSmZaQlE5gSTyHkZwNpn8hQ6lE3I0UmtaKjKApM7+lnUz5yWEF6WrUdNevmBvKrdijTEKRB4+7unD8gnaZoFcnBKxtfTgfm6AIZATwLFyVRDFKovzdalAOSJgNgFbLAEScGG+HMwnx7vl1EHSORKjx+qqH7DH6/q+WR/NKsOKsju0knV7SaDn7QdPXdCI6DKJFJaNytVFhuUi/gyKRRWOjToVSF+qPwk3KIU72twQSLi0FxpS0+dhNVN44eOjpAxKtgeQrRKLjYMviR99OITghe9AznlJtj03WlO9ybQCusEndchIe0CuvNShX9jSMEclYg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <439AA8606C84A04483693A5A748046C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9dd524-187f-4432-4412-08d7f77e182d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 20:42:03.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPoD2kSllM9exwsxFn3AYJ9y0XNOGznLOkPG7UcBWwAxqQoNkgijCMPRk5BcVEci4uoDJ1Ewo7pt7AxX5yUjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=661 clxscore=1011
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130175
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md-next on top of your
for-5.8/drivers branch.=20

Thanks,
Song


The following changes since commit 91bf5ec3421df5ec620e9abc9afa0ddacbbdefef=
:

 Merge tag 'floppy-for-5.8' of https://github.com/evdenis/linux-floppy into=
 for-5.8/drivers (2020-05-12 11:35:49 -0600)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 358369f03ac94637c9fd9d8f94a2dfde86b9f25f:

 md/raid1: Replace zero-length array with flexible-array (2020-05-13 12:02:=
23 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
     md: stop using ->queuedata

Coly Li (4):
     md: use memalloc scope APIs in mddev_suspend()/mddev_resume()
     raid5: remove gfp flags from scribble_alloc()
     raid5: update code comment of scribble_alloc()
     md: remove redundant memalloc scope API usage

David Jeffery (1):
     md/raid1: release pending accounting for an I/O only after write-behin=
d is also finished

Guoqing Jiang (5):
     md: add checkings before flush md_misc_wq
     md: add new workqueue for delete rdev
     md: don't flush workqueue unconditionally in md_open
     md: flush md_rdev_misc_wq for HOT_ADD_DISK case
     md: remove the extra line for ->hot_add_disk

Gustavo A. R. Silva (1):
     md/raid1: Replace zero-length array with flexible-array

Xiongfeng Wang (1):
     md: add a newline when printing parameter 'start_ro' by sysfs

drivers/md/md-linear.h |  2 +-
drivers/md/md.c        | 71 +++++++++++++++++++++++++++++++++++++++++++++++=
+-----------------------
drivers/md/md.h        |  1 +
drivers/md/raid1.c     | 13 +++++++------
drivers/md/raid1.h     |  2 +-
drivers/md/raid10.h    |  2 +-
drivers/md/raid5.c     | 22 ++++++++++++++--------
7 files changed, 73 insertions(+), 40 deletions(-)=
