Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D132199910
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2019 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbfHVQYT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 22 Aug 2019 12:24:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48636 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbfHVQYS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 22 Aug 2019 12:24:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MGInBi028872;
        Thu, 22 Aug 2019 09:24:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YPmKY4quyj2YEWS5ojFhgebk3v40hIU9jT4g6dC9G/0=;
 b=SxMmb1hYp4CdHK+loTisCCTGY101naotZboeJE8K81bzs4skp67Cuv46I3HbLObGg9Pn
 u2L+0o7YDUHxGdrPzkFVF1T+340z3S6XEYr+k2VOF92dhrK4KMAmhNpIXT4B8XsK1BqG
 Y+dvQtHDt/52Zw/McLejceyF99oPwRUvFAc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uhxbsr1rr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Aug 2019 09:24:14 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Aug 2019 09:24:13 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 22 Aug 2019 09:24:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9lFb/3zOlM/87dNZ8DsL5Ko5MZAlvEthojKGOBIJ6ElgG0LPGFbC7FwuDjstfCup3tEg0fRv+tt8pudhr9+fmrgFcsNk0F7qlnDiYG/5aTDnftr24WPAuINeMRhiCBv3tkOn2Q058GmQ1nolwrVNMOSzYk62Ri/uKSPGSjuz8chYpXVl4PGdCO/YGknv3USBGrcafjIH5lq/R1hqGgnykuSOxmb8mI0BApzcl3YksrX77lhDZkpJR5zouO4Xz+UkZprZUT9rfzODzJAMYq1TdlEdK+EkVsYN4BhFYwhrYxJVph0p7yXP50jZ9bV3Nf03Vlg62oCOKRXf1oCUK6ZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPmKY4quyj2YEWS5ojFhgebk3v40hIU9jT4g6dC9G/0=;
 b=LYgkGNn9QLVkGffRWnoMtPky/h52q68qN3z5X9vKm9XS+pgXdeN/f5YgPXlq7hPA8xODRqoBcszI5F/Pw/Co0JhMfRlS3TrEkF6sydWOv3b/+73AoXEyqOIHlR8FvZ1hPiu1tfgOkVba5Hpb7/oesIRIRXWlqEkkhnvde0B3Mup95PTNOV7jqhoiJ2DmQCTCDcCVDK29UG4gEHBeDKP9uR1TPXn4Y3e66N9a6eXz7RnGf9CXCe5CwlW9nqm6S8rVbTm2LM6ENdcIx06U16Bk9NTjh0RCZ+nSinqSYZRogYQsmUR0+NjxTOwPX3u/sYU2pwfabZWhyI0pw4FdJrXjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPmKY4quyj2YEWS5ojFhgebk3v40hIU9jT4g6dC9G/0=;
 b=WPXU91mBcDUIymNoi7g9J02P7ISRb8CECOUQfgudn+mckHzru2LYDMY9sEICIwXqDwxATZ4bvJeDcdZlp6uAMucGnJEPejoXt9CvoYgDvqdRQC4ED2NuyivwX3WXDQnXt6FTd+fzg44B8LoBKkyXE5yfpeiLHQOPquuWn7tMcrs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1134.namprd15.prod.outlook.com (10.175.8.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 16:24:13 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 16:24:13 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     NeilBrown <neilb@suse.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md: update MAINTAINERS info
Thread-Topic: [PATCH] md: update MAINTAINERS info
Thread-Index: AQHVWFChaxwpCS4RlUq7XVUhNN6MS6cGG2UAgAA3e4CAAAQwAIABBF8A
Date:   Thu, 22 Aug 2019 16:24:12 +0000
Message-ID: <012668B1-75A4-4666-A695-E82E11A191B5@fb.com>
References: <20190821184525.1459041-1-songliubraving@fb.com>
 <51398ca1-44de-3b80-6381-54f594b6c251@kernel.dk>
 <87h86aghmo.fsf@notabene.neil.brown.name>
 <e24cfc57-9855-c85d-b875-da8fa4c90a60@kernel.dk>
In-Reply-To: <e24cfc57-9855-c85d-b875-da8fa4c90a60@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::ca38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d013c871-c678-4177-2abb-08d7271d2b5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1134;
x-ms-traffictypediagnostic: MWHPR15MB1134:
x-microsoft-antispam-prvs: <MWHPR15MB113430ACE41F43452CD50EA7B3A50@MWHPR15MB1134.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(54906003)(99286004)(316002)(5660300002)(33656002)(76176011)(476003)(2616005)(446003)(11346002)(46003)(36756003)(53546011)(186003)(102836004)(81156014)(50226002)(478600001)(14454004)(81166006)(8676002)(8936002)(4744005)(486006)(57306001)(256004)(4326008)(53936002)(71190400001)(6916009)(6506007)(2906002)(229853002)(7736002)(6436002)(305945005)(71200400001)(25786009)(6512007)(76116006)(6116002)(66446008)(66476007)(64756008)(66556008)(6486002)(6246003)(86362001)(66946007)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1134;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NCpF2zrWX7U/wPSBfaAGZkYCWbqsycqF1vbYmzN0+e4lpEBm8h5p6A9xMmnwu/WfgilBJIhuuXtldFbTGoUIF1SpRiIcEfokuAjWe1JffjSUX9OQsZIgafuoNrN9+ooO28Ab2o9kzf+tUyi59Drjk29N/Y2WpzQKr1gSv10T8AdhM7iZr6J3K+BXrRs1fjwqqaMaKAINm4IuxgehJFYROFsb1pGUzVIJycgYknWOV+toxyJe055QsbqWcH2KI6wiqh6qk6o47k5Db6M2q8G266fmqgqjPYpyJ2MVV+UBtpTZfe4Fer+IvzRkEa/GnNisA1mSUpiIeeEq0cPIKl7uNzpPZRhMiZnGxbz+zEZAorKgSXNGjLEXi0K4BEvSArx291zOZ4ecQXwUkl9i6p22PbZev3i2qAwAWm7E9z3d/V0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6450C6C2D2F7E845A9B9F4C86776D953@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d013c871-c678-4177-2abb-08d7271d2b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 16:24:13.0051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTWOyrmZN1XNGOfFPTE7OmLy0wvZpwXf9+r2EioY1W89TpQHBkAEto6UVEBEzmMRbCdt031wjml2Ogj0wgUZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220154
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Aug 21, 2019, at 5:52 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 8/21/19 6:37 PM, NeilBrown wrote:
>> On Wed, Aug 21 2019, Jens Axboe wrote:
>>=20
>>> On 8/21/19 12:45 PM, Song Liu wrote:
>>>> I haven't been reviewing patches for md in the past few months. So I
>>>     ^^^^^^^
>>>=20
>>> have?
>>>=20
>>>> guess I should just be the maintainer.
>>>=20
>>> I'm fine with it. Neil?
>>=20
>> I'm very happy that Song has stepped up here.  He appears to be
>> appropriately responsive and competent at review - neither too accepting
>> or too dismissive.
>> I support his request to officially be maintainer.
>=20
> Thanks Neil, and I do agree. Song, I'll apply your patch with some of
> the verbiage changed.
>=20

Hi Neil and Jens,=20

Thanks for your support!=20

Song

