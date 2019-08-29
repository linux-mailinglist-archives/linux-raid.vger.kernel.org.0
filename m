Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48177A2AA6
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfH2X1V (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Aug 2019 19:27:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbfH2X1V (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 29 Aug 2019 19:27:21 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x7TNODs1015684;
        Thu, 29 Aug 2019 16:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FsBrCWwUVOuK/PdBNXNLatj1qXyfc8LBwqvPKU/jq+4=;
 b=bA6RSfKTvyasw5P35rYNNmlDqSG8UvtS60hijfdRfN5rFXIFckpJkjyh3Ma8f+PLnMWK
 mTGo2vBRKoU0sNKcGhNVQU8xkeDCPVFruMqmikWG7mNfrVqF3XeCljN7yZpRr+4CPtbO
 a0qZZg+FoZufjEsx4YjVy6YiFDcnett5hmc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2uphf425g2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Aug 2019 16:27:19 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 16:26:50 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 16:26:50 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Aug 2019 16:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1uzsHYWLzvIk6JOpQ1ErEvcH1P0WtoG931e83fvtNytFW6m3UyjD+3J4DtUi47IWzDPQYN87A4xldskhY7eeEYic9jbOJc0dtM2/WheWG2CLKElrn+M/YpwjQI49M4A0Zg2sREY8iXMAP+0+rvpUOKVdeIBZDNt5L9z8Ske11kM631xMDJFziEZZTNQZHvz0JOE6qx4ilExnHD54n8oCe4VZo0TDssSlHRb9Semi0SHXAXzIfkMbkBoE5yrxvMhxmwegKXhXMq1cDgW/qyb3G1mU2k9398w/kcyCiGPUGvDFJ6TTI2XzKy0kKzFki9npj27pLLY6myPziRJ9X2vWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsBrCWwUVOuK/PdBNXNLatj1qXyfc8LBwqvPKU/jq+4=;
 b=b+Sl97nuemsjWNXDnWYYWbhADHKt3JSm+KcE1fqqICSOKcTCumiuwoyuKIIm1CbF/rVaarZJK9d7yH4wjJwMJtGElV4cpZAgm9OuS2DrwkMM4N4CkRDzT4Kwe+h/RghY/hEODS2mDISGZUjLbHID+adlN60eRVcgqTtNSK1RhCNTgOTry4amVF3GCCbOmNDrRlOSY2EQYSWD7ECwxTHRcjc9tlxCK85sUbgL+r+LVv5kAVLs4eeHb5fmDcklc+oUmFDnlVZQXgmPAj/NSeRdgfQO/DN/YAWFpui1qCCqeSQg/7ReWe4NMnb2nZkrEniioT0/xwNCAkYcMZs6dsHyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsBrCWwUVOuK/PdBNXNLatj1qXyfc8LBwqvPKU/jq+4=;
 b=bQ9DLocW5sNiQLilG8ILm//GV9rDASmBE5mOEC+6JEKG/rs43r6OXwXGT+0aHDrWdDUh9fY2jk1WZyHtjllwjIMUP9hO1Q6NKEzQPFrNKPkqHd4ChZYOr17mV+QUluwVCuTITQUkQ53Y7RHLYnnFJuKNsYLvkX/rT/e6q6tSFBA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1790.namprd15.prod.outlook.com (10.174.97.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 23:26:48 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 23:26:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
Thread-Topic: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
Thread-Index: AQHVXXJ5FXpHdA2IaUmgjRFDKVxJWKcRniOAgACb0wCAAI2YgA==
Date:   Thu, 29 Aug 2019 23:26:48 +0000
Message-ID: <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
In-Reply-To: <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:3161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b245001-6cfe-4aaa-49c8-08d72cd85d37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1790;
x-ms-traffictypediagnostic: MWHPR15MB1790:
x-microsoft-antispam-prvs: <MWHPR15MB1790838BF86B36339AAD155DB3A20@MWHPR15MB1790.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(305945005)(81156014)(36756003)(186003)(53546011)(66446008)(6436002)(14444005)(54906003)(76116006)(8936002)(2616005)(256004)(5660300002)(486006)(6246003)(6506007)(86362001)(53936002)(476003)(64756008)(66556008)(6512007)(6486002)(2906002)(11346002)(71200400001)(71190400001)(446003)(66946007)(4744005)(25786009)(316002)(6116002)(46003)(102836004)(50226002)(57306001)(99286004)(6916009)(66476007)(478600001)(8676002)(76176011)(7736002)(14454004)(33656002)(229853002)(4326008)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1790;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lyip6PRHfBxhN/V3MpXcTzHMmaUmpCw8uws5AePysvfMyWwE4MA3W5llPlmGvxp+g2YAK9jd4W316gTamomTx+y/+JqbZag0+rH2l1GAZq/kK37DN3M7W33RU/Fb6L09tmSi0ntbZH8XjtDQVBDjrE1NTjtIR3PeTYZYiOlpeI1LmLY9yVVMyyAwhOQJ3AX6eSIPYMt5mhRytJZphab7dHPk5Fer7ZMqpxDmN2+tjBTxlbKGbz9lfC98RytbAyYEXU9ODddeO1XrmLdP76koCKK9cnYqyOWIOmgOph8UAridQe39SSMefVEj3ZONLgrgftvTtvN61oXzYxWMHI15Qc1ECn/WpNPZwz0NeATC1C2kPR8auUA/FtvK1ImLFmNOzRtjKZh9rqeFM47CdMk3YOOY3upjMYWr2ZdRaeosVww=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1A20A01D390AD4EA18D05270635B84C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b245001-6cfe-4aaa-49c8-08d72cd85d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 23:26:48.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ccmwo94RRtkM7V+xLzdrzIN3riTq78Xz8nqC1tTw+fHNaxBeD8ClQb00QEEk1nTZqQikmZ24GbPFUYW2TgcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1790
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_09:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908290234
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>=20
> Hi Song,
>=20
> On 8/29/19 7:42 AM, Song Liu wrote:
>> I read the code again, and now I am not sure whether we are fixing the i=
ssue.
>> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTI=
VE.
>> It only runs on other stripes in the batch, which should not have STRIPE=
_ACTIVE.
>=20
> From the original commit which introduced batch write, it has the descrip=
tion
> which I think is align with your above sentence.
>=20
> "With below patch, we will automatically batch adjacent full stripe write
> together. Such stripes will be added to the batch list. Only the first st=
ripe
> of the list will be put to handle_list and so run handle_stripe().".
>=20
> Could you point me related code which achieve the above purpose? Thanks.

Do you mean which code makes sure the batched stripe will not be handled?
This is done via properly maintain STRIPE_HANDLE bit.=20

Btw: do you have a solid repro of the WARNING message?

Thanks,
Song


