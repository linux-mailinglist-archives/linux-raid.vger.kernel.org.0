Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08D8523D
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2019 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbfHGRkU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Aug 2019 13:40:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388369AbfHGRkU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Aug 2019 13:40:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77HKx54014088;
        Wed, 7 Aug 2019 10:39:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HXsXggZKPS5kwtQkAftQoQBakDqoo+ySMlxNJAmmLcM=;
 b=hfIOAHPTwGzVmbbSyfQ5L9kcRF8hxWQh8jt3OPBkNUhrZlR3eFr+k/CzP93WoHQc9zos
 m8btznD7Ldj9gskGQpCOJHXkCGqMAhRki5Zx8U7ApqOJt8o+OPZ2yTLEKoR+B8yt8Us6
 PkqlhDgwJLXwVRGwhbpPPR5ySIrGIXuhz34= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u811frj4x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Aug 2019 10:39:22 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Aug 2019 10:39:20 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Aug 2019 10:39:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Aug 2019 10:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8qPJ8qa9NpzNzKI3MuzRUY54aiJCDwCDfPpNIDFvgsNOp7LqVnYRD9jzYAC6dw9iZGlkBLEAq0mTd4rkLKom0b0Vp+Vfpf+lhAq6vcvN3wdPVJZ3vBpNSA8TMY2fe2/SuBMy01vDj+u8ssTx7CVkbZ/heGNuuJv6ThKvlOAV9bHJaw7vmIk7/ekpee+r/p+9+WffBTg9E2e/TKvwvYakDkwR1Iwn/xtmT596NV34UHIYtNEK5iuTXqH2U/BzNaAQ0pXh+k4zNus9wMIk8ovXBt6j//dEh2dTmkv+6GdABlf1CEbNtQNaG+BghrdgLLPMagkxLY8AzAuGZks1GSlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXsXggZKPS5kwtQkAftQoQBakDqoo+ySMlxNJAmmLcM=;
 b=KJL0Al0YNtxtHInTd03niUnh4F1M3JvbgnjB5x3c5Ljm/tyNyKj9B9g1fqtxT0Td8O5KprPqc5dhftLlpGh+DyWxnhSUU2UxdjKveG/HnmNntG0TLRuhJuSriILh9SVqKe8DCv7Fe395gkQv6lt8ir5kTiv6RI/x6LKLhwyrRQ8HjlCd/D6RjbUXeMmfuBolfFOzFZTyvdqNWnyQ+7YIj9/r/EKyDyTt8A3ct5WAt+5xqsfL13utBDt54iEUeUe5DwwNrL6sPWBQyogqEmXLYguXuRvf4FAOALDGyakryAnNy/lbd5UEEe9gR4wO7uSjgblNGfqMYkUy56SukPdGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXsXggZKPS5kwtQkAftQoQBakDqoo+ySMlxNJAmmLcM=;
 b=EHAI73iG1rJajATniFK4mQPg06JqPp1d1WWvU4xfSsUXN/G8N8pPcnc2al2Ni0c2HfWiQmX6wdzbH45i5g/Si0lbyEGuRaCPcuIK3qB+47pAXirHs781HaPWPk/Zs914T6qQLTQJlzr0MOVzd7eLCLs/tcjNZRyf7odCAMiFFVA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1360.namprd15.prod.outlook.com (10.173.228.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Wed, 7 Aug 2019 17:39:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d%9]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 17:39:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        Xiao Ni <xni@redhat.com>, Yufen Yu <yuyufen@huawei.com>
Subject: [GIT PULL] md-next 20190807
Thread-Topic: [GIT PULL] md-next 20190807
Thread-Index: AQHVTUcKK3Jimkz8cEyXhkWM/x5dlw==
Date:   Wed, 7 Aug 2019 17:39:18 +0000
Message-ID: <5EF8F057-3ADB-41D5-855B-0FBAE7A43E6D@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:1a00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158c5725-a8fe-41f7-61c1-08d71b5e2ce9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1360;
x-ms-traffictypediagnostic: MWHPR15MB1360:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1360CF2EC371F993C8323F9FB3D40@MWHPR15MB1360.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(36756003)(54906003)(6486002)(316002)(6116002)(2906002)(25786009)(33656002)(110136005)(57306001)(102836004)(6506007)(256004)(14444005)(186003)(486006)(476003)(2616005)(71190400001)(71200400001)(50226002)(46003)(99286004)(68736007)(4326008)(86362001)(7736002)(305945005)(966005)(6512007)(478600001)(8676002)(81156014)(81166006)(8936002)(6306002)(53936002)(14454004)(6436002)(64756008)(66946007)(5660300002)(66476007)(66556008)(66446008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1360;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y9fiEOTnoz8SX55HZSLztiq1xu50FWQXndjzyPDZ4eTjY+e4EXd7+/SXV1OfEGP1HnexetKF3zfkUq8rka3tnzo+PapVicbnYqXdRr37sFPa5QE/dC6Lc9wig7A2fq3iEr7lCHBRLxe2S1Ve1k34gMQcsd2PI9gdwFrCh42ogqHhc9Fgw3l/tWUrlpFWJik2AFTBAk5Npm6qgJmN/ytK8OL+8kTnD5BSNpZBrsQuOE4NfEn8LjqkfdibobfJtoxWm/Fu3QDyKPc59sdKLkKqtIgIITGV+J7shF6DMUM27fFALX2b4Gi3NGprxtf6JBggDFq0roWF3OtIM0N43UaSL4bRY5iD87s4GFBZFzPsH0pVoMwPl8dK445OzMHrmrz0mmLm9/tCg0is71ZIf4m/1ATeCKZY3+C+gvCvU2G+jyQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4818110A262244A99148AF7DA9BC777@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c5725-a8fe-41f7-61c1-08d71b5e2ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 17:39:18.9213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070167
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following changes for md on top of your=20
for-5.4/block branch.=20

Thanks,
Song


The following changes since commit 00ec4f3039a9e36cbccd1aea82d06c77c440a51c=
:

  block: stop exporting bio_map_kern (2019-08-06 08:20:10 -0600)

are available in the Git repository at:

  https://github.com/liu-song-6/linux.git md-next

for you to fetch changes up to 449808a254fd567d3dbeb11595a0af238c687c82:

  raid1: factor out a common routine to handle the completion of sync write=
 (2019-08-07 10:25:02 -0700)

----------------------------------------------------------------
Andy Shevchenko (1):
      md: Convert to use int_pow()

Guoqing Jiang (3):
      md: allow last device to be forcibly removed from RAID1/RAID10.
      md: don't set In_sync if array is frozen
      md: don't call spare_active in md_reap_sync_thread if all member devi=
ces can't work

Hou Tao (2):
      raid1: use an int as the return value of raise_barrier()
      raid1: factor out a common routine to handle the completion of sync w=
rite

Xiao Ni (1):
      md/raid6: Set R5_ReadError when there is read failure on parity disk

Yufen Yu (2):
      md/raid1: end bio when the device faulty
      md/raid10: end bio when the device faulty

 drivers/md/md.c     | 49 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/md/md.h     |  1 +
 drivers/md/raid1.c  | 76 +++++++++++++++++++++++++++++++++++++++----------=
---------------------------
 drivers/md/raid10.c | 32 +++++++++++++++++---------------
 drivers/md/raid5.c  |  4 +++-
 5 files changed, 101 insertions(+), 61 deletions(-)=
