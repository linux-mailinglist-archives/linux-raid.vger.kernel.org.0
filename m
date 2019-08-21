Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD998687
	for <lists+linux-raid@lfdr.de>; Wed, 21 Aug 2019 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfHUVU5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 17:20:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58376 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfHUVU5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 21 Aug 2019 17:20:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LLDfZD032572;
        Wed, 21 Aug 2019 14:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=G6pK+3pNLuAo4k1zQ0yoUOWIumCHE45v9C6Gf0c1snQ=;
 b=ZYNPu0hRtCUdDNCHrr81RFny8caa/z/FBjHgbppX0rxRiVbWULtmSnw6TBpxrUSGUxgy
 XS2Z+K87fVEw5KYsz4I5nsjoCuchEoIX5+JzxafkIlsk9NoBd7sHK3Tq2UaMGOX1120M
 b+ZVmu2hQMe/LEnZdxpXri5RaNiJzLEf700= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uhac3s0yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 14:20:52 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 21 Aug 2019 14:20:51 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 21 Aug 2019 14:20:50 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Aug 2019 14:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoUDcwBp0k88tkw73HQ893LPCp9W1Bzaf/ri1seESCaDmFu9/OXw3KKodKKRGNXtqr4Q9BtxwqjubhCQhm6+K3B4osTOfWSuf0rzrvCfwH0OXbaXCyH298LPNZwnAbTwQsT/Wfzn/XktefGL5MVx3GlEGxzpwNV3H4D1y5EZ9vUlteaUSFB3rMnH/DYDDrkNrqWPNcKYUFnIBh5hW6+2uwgi+0iJb4T5S61Co0IP6SaRMO7tUcPKCuk1dKXZY9mRfvGL4vGj0ARw0+F7Wm1BlXiGLhorYbAONVQPaP0gGNJOp0LczXIE/q8DQx9siTEFG7KpIfS4w9n6d8eN7ii/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6pK+3pNLuAo4k1zQ0yoUOWIumCHE45v9C6Gf0c1snQ=;
 b=BL/rhJpH38TNADF7qSenK82CcLEUlTYWfINZ0WisR6Jo89pwpx5tcVG697/7KO3zbUnYsTfBRTrzf2FTbrO1xsUKX7hZYQbVnX7NLnW+JUYsJAUWg6iHDQporvsiEUIKpJJdnusOv3cLrKaupuTpGn+xcQ7k9hsHrJ83uMce5qe0oa7SyNdV+UfdIbTa6D/18edKT1+L0v8cEtZPij4UJVymIfx/qcn1qsLM4+dVmp36b8d+8T+8zs4/DHl1052P+QwsFNcP2Om9Jx3u+tIfeLkMJkblfLX8M5jsf8+nbv3xd4EFYPcauw1ZH1b3aAQpH0Mmraf5t31YtOnlIcM2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6pK+3pNLuAo4k1zQ0yoUOWIumCHE45v9C6Gf0c1snQ=;
 b=IJVOa+d7xWWv9kDKSkipVSWcKy7YZeoDcoLhnK/ZWAbd8k3NfZeh4o36MgPEWvF9vWDok08WrmZagWrnZOeJ5d4gAI6+6C9nJtCVsK5M1rXJ66fc4eARlF0GtbEB5dMYCFeQ5HYAQ4qYRi5WwzzFbcP7KsL0xCTDE5A8neWKVqU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1437.namprd15.prod.outlook.com (10.173.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 21:20:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 21:20:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] md: update MAINTAINERS info
Thread-Topic: [PATCH] md: update MAINTAINERS info
Thread-Index: AQHVWFChaxwpCS4RlUq7XVUhNN6MS6cGG2UAgAAAlYA=
Date:   Wed, 21 Aug 2019 21:20:49 +0000
Message-ID: <86023AE0-BCE3-439F-8F78-3E2ABA3BDD69@fb.com>
References: <20190821184525.1459041-1-songliubraving@fb.com>
 <51398ca1-44de-3b80-6381-54f594b6c251@kernel.dk>
In-Reply-To: <51398ca1-44de-3b80-6381-54f594b6c251@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::ede3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a1afc0c-defa-4de5-b0d7-08d7267d7084
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1437;
x-ms-traffictypediagnostic: MWHPR15MB1437:
x-microsoft-antispam-prvs: <MWHPR15MB14372FFED50FF54DE3BC8846B3AA0@MWHPR15MB1437.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(189003)(305945005)(8936002)(50226002)(86362001)(81156014)(81166006)(8676002)(7736002)(316002)(33656002)(99286004)(2906002)(486006)(66946007)(25786009)(66446008)(6916009)(64756008)(66476007)(66556008)(76116006)(6116002)(14454004)(53936002)(6246003)(6486002)(57306001)(54906003)(558084003)(2616005)(71200400001)(4326008)(46003)(6436002)(71190400001)(102836004)(186003)(5660300002)(53546011)(6506007)(476003)(36756003)(478600001)(6512007)(446003)(76176011)(256004)(11346002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1437;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AG0SisVt6bekIDyctlBXHWDrnoj6jONvNuJgbfdEHRj7b+dDdv45DrRNIPg6z8s/9hzDDr2LSn9BIsYdG8D7cQTLvs7iWa5Rpw8RqO9+n4RhzfzPJ7ICEZBUefM84PVWKi59rlsU2qr68TShH3jNc7FwGNIPuDC9MXtEttEzU5Yt2UWVUEf7r41vqbIbdb/9Q7JcqnLkKnMFsreuSEfcCCC1EehTD97PxJLEPbz7I3TZHErHJeq83LGxVxvj6jFrTX0LreuQs7jNNlz31SHHm3BxICLwDMQDMmErZY9q9X2s0Ym7Q+L1Lks5dWQJzpI0/49YVDSAzWuO82aenUpZtTaBqe8GFzpde+3U9ctrI4Ef5OCxPF0r1r44l6WQB0uV1AMduV0PiDcDyY10zLfgd0CJenOYl8JPhXD7BEjUitw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D3F1952F0477947BF78924DD69B9E8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1afc0c-defa-4de5-b0d7-08d7267d7084
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 21:20:49.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWn55B7qOlEtwq6FqwpJs25k8MMf58mXBBNhx/MZ9JtiSlsNhXwPsZXZjXLTeIbp10xdHWVfMhL316HxmWJoVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210208
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Aug 21, 2019, at 2:18 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 8/21/19 12:45 PM, Song Liu wrote:
>> I haven't been reviewing patches for md in the past few months. So I
>    ^^^^^^^
>=20
> have?

Ooops.. yeah, have...

Thanks,
Song
