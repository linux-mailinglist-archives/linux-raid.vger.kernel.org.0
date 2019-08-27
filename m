Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48459F372
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfH0Tra (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 15:47:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42260 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726584AbfH0Tra (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 27 Aug 2019 15:47:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x7RJdbv4027838;
        Tue, 27 Aug 2019 12:47:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6+GibjHgzZMDseUrkbIbrW+JWXp4rntns3NJAaozdPI=;
 b=FSeL9sSTmvvqd3bV4qX9fTLbd6sNYsT1W+esnjJUiW0tpdsGeNSRdd+yUvsQkERmQvcN
 ttDwyGFte9zhkSRuIno+InMkRMZrvgivaz1CaY44kP8bXGOPrWNVrEmpVdvzbhkGuDPP
 fnLle2XY/jGz+HPs89SSx3FV8pDpDEhLmxM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2un62c9hfn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 12:47:23 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 27 Aug 2019 12:47:22 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Aug 2019 12:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcgXTa4Q/gD0C7U23FMlh2NWSNyAtZA/GJZhYpa6dnSoZUc3rx/1hqQRhlgD2CwCOhVQeYZW5GbgfwIQddvLimJIhb0OsjoZK+OBjLb6H1lQRZYLC0m1HQgPKSC/hMWekviz568jMzJc2sIcw3/T2NcJbtvuIUoJAksFrP0TDzOHAmF76IkAlnwVR2heb8STldEtbQrzDQI1ELKnMv/R4Ve25VBRVrqwXqIbiFTAnwfohZpdocd39vraEZMfuRUemFbw5Y1kDrSXpqzl8gCnXb8p1gkP7rLttiK/RcF2nyYYzQ8A9/0x5GLDQA/vYa4hhzal4Y3823xJAVxRZlP+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+GibjHgzZMDseUrkbIbrW+JWXp4rntns3NJAaozdPI=;
 b=hvUfXBec9bXbmUICqDgaARTZ/1vqKXQVXHhBZY1JpLimtPFciFgLK6imyP/X16vnpuu6of2y/fFULqJdiGOe9K7eTgYjJbRAeGVwT/b5OwZoyLgc5y2GjYGKKrOIb9bv33qCbIYcjKH1IeyWYuCJDb+sTbWUhWT/mEBb88AOLWHZOs+DHG8B4feo7IhS5bK4OdwYL3Q0/sfffj7NX2NRaltkpIlg/diwYgI84esqLEoSfrnSEnhdqJVsYQGtfWnvN4+mtXhGGgP2Y11jzhSf2BJztjgY7onnf5Cxe0Ef7aU2Cy71JYEAtL1IEpzqSYyCUiZz33z2CJv41HMbemQXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+GibjHgzZMDseUrkbIbrW+JWXp4rntns3NJAaozdPI=;
 b=lMALfNnAejrHJDfPVA3NrktfOrqk68Dokrj3RG18LlWYJSVSJWsRLS3NkoQUTrvfViUh2kZl24H7Uyz4aLnTepj8ARgRJ6lepRRQTEsN5QFcg7gxaZ5EwjfJXiTL0qoZBjOAjy6fhY5qtJWfGLlU0AEgXbSerW1a8UaoaNpbtek=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1549.namprd15.prod.outlook.com (10.173.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 19:47:21 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 19:47:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     NeilBrown <neilb@suse.com>, Nigel Croxon <ncroxon@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: [GIT PULL] md-next 20190827
Thread-Topic: [GIT PULL] md-next 20190827
Thread-Index: AQHVXRA9OEuhDRflr0GW/oWMWZI/lA==
Date:   Tue, 27 Aug 2019 19:47:21 +0000
Message-ID: <D4B2FC6B-6939-4EFB-A8A6-9105C04AFAFB@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:aca3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a86d4a20-e8d3-4124-8891-08d72b276035
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1549;
x-ms-traffictypediagnostic: MWHPR15MB1549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB154976C4B29755080F4FC955B3A00@MWHPR15MB1549.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(54906003)(71190400001)(71200400001)(36756003)(33656002)(486006)(50226002)(7736002)(316002)(25786009)(46003)(14454004)(81166006)(81156014)(2616005)(99286004)(5660300002)(476003)(2906002)(6512007)(305945005)(4326008)(478600001)(14444005)(256004)(186003)(8936002)(76116006)(8676002)(6116002)(6436002)(66946007)(64756008)(66476007)(66446008)(66556008)(57306001)(110136005)(4744005)(6506007)(86362001)(6486002)(102836004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1549;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8i9DiPL2xrCjHaxT+2W+9t71CIBrP4KxbzfibNp+c5jHZhUK4310mr9rlQQNOgz97kdx+7Fl9uiNtn/wYPpk9ze0UKA57RY1ghMjYXEid8uX96o6xakABa4Y6d4TuENFAJ4pdddMZMAQj/vYpFc9CIb7/lFmV+Q5uhH/OnywSG3urdv/Hb7qVPnSV8n6Qc0tKwfMEad4xh/FBtQSZBsaOtZa51W7EQpuYjiwPVlC2ynoElMyKQ3YRpy8TAtkvmnms2Yyj6AwMQh0xL9jW9hIgzX7xwSQ9Q5xUjuG6fdfVtxfVYvsfTYhTRMSL9ozoEtf0UQ5IEowUrThx8ED/5r6ePi0Iv5iPpMZGylTtMi1tnYDC4JH1H48+EggyQ2jvtK+DlzaCKU4n82O1HKY4OLkcJpA/Iw3t+vu6R/3+Ut96e4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <976CA2875895AD46903A792F7C5CE24E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a86d4a20-e8d3-4124-8891-08d72b276035
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 19:47:21.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCA2dPww9Ho33UnliPN4W/MdYxbuOlitycWEwwpCKzav1QBnuGZ+5kMF9rQ0pw/+ISgNKkqRE106ozPt3HCtew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1549
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 mlxlogscore=839 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270186
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,=20

Please consider pulling the following patches for md on top of your for-5.4=
/block
branch.=20

Thanks,
Song



The following changes since commit 97b27821b4854ca744946dae32a3f2fd55bcd5bc=
:

  writeback, memcg: Implement foreign dirty flushing (2019-08-27 09:22:38 -=
0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

for you to fetch changes up to 0009fad033370802de75e4cedab54f4d86450e22:

  raid5 improve too many read errors msg by adding limits (2019-08-27 12:36=
:37 -0700)

----------------------------------------------------------------
NeilBrown (2):
      md: only call set_in_sync() when it is expected to succeed.
      md: don't report active array_state until after revalidate_disk() com=
pletes.

Nigel Croxon (1):
      raid5 improve too many read errors msg by adding limits=
