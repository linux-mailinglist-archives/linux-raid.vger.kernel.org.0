Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E945AA9CD
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbfIERPw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 13:15:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729945AbfIERPw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 13:15:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85HD2X6016474;
        Thu, 5 Sep 2019 10:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dI8y40bP3ns3bI+E8+CtVrKUks+T19j/lMDtHD7huQg=;
 b=AV4bKUfsvEwvHhvJyBqiKYotbVXhwG8YsSat8hnAif//caGp/zbxherQBsqF4DtMbI6i
 7UMG/WTrcXxamdVaXGbl1iGZb+M8V2tuRJ8byfZjHcoKYKHA9HbyVYyYS2tkTU/mEMSt
 qBcKriF0STVPqN5zb1sxQEvA5qHNxfSxCxg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2utkmmvts1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Sep 2019 10:15:47 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Sep 2019 10:15:46 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Sep 2019 10:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPs0ZkFY1RgvEhJuy2LO+u7QTgWvxRfZdzWjZVePnkhJ7SnkQr0qE23WpYIAvjZrorqmGsxmUO7mQlLxhlLh4iqRn6b7dZ8q85eNtOk3TkubCUqxpjdCObzjfe2uqiilFWCUkXwZlLHLBaAjW5wRN6oSBf4d0IcI75qnQdlBo8G3Hr1HSbWuRGf9fq7r0lwXK8ipa01o25hKNktDjKUWJ+/BRtOP4PcrlZqr7SR8husT3e74KjuAT/LidnBeP/VddhkaRbJz7HK45BD9FP+wBQf61ozQwj0CrMItEKqq8JKwXI5NDh0O4JENsSQ55t0v7mJw0juOoZg9otdrWBWstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI8y40bP3ns3bI+E8+CtVrKUks+T19j/lMDtHD7huQg=;
 b=QhndcgF6/suQ5MBh+79bfjXkUiaQn9TjNHCAuLqJcVufgOYfYeXtJW/mns1g857mBQ+8JFEJZMusWtGmDICugmqLDUk+3nLq+9c6D8DZPk/osIrmojXvNnlMN3XXlqxdIkJLyDdNhFTs0gHSzZgakWodKw5cJveHumlBjaoBOrkJZ3nbwFkTO/RnocMtMD86yw4HAEerm4s/kolFtKqieVNWECOWF3/hozPnS/aEJhI3JRLj8E8FEtt2SUHqCgG3jfZTA7rLvQhApsVhdknvnvmIyX0KfO8J8PuLoDkNekFmg2YvZPniiU4Tex5JxSMgD7JpOtdkxGSkI7OdRV83dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI8y40bP3ns3bI+E8+CtVrKUks+T19j/lMDtHD7huQg=;
 b=XYCV1Jf78n/MoZKt9sBMYsF1GIfqxFTIcEqdYyPPFSc3SdBGc0RDWOy0ZTNX+2ko3O2DLDqddvASBRE7cc1ADTH0U8oJULcFdq7ndKvidd7nooQp1a62rsigC3Vgcv0cVqC6Ms7daMzmDoOy2JG0IEwow2Aa9YX8xFzjfu49h5k=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1678.namprd15.prod.outlook.com (10.175.137.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Thu, 5 Sep 2019 17:15:45 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 17:15:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     NeilBrown <neilb@suse.com>, linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] raid5: don't warn with STRIPE_ACTIVE flag in
 break_stripe_batch_list
Thread-Topic: [PATCH] raid5: don't warn with STRIPE_ACTIVE flag in
 break_stripe_batch_list
Thread-Index: AQHVZARdl3NB1aZzkk6l5aokjSN886cdUxEA
Date:   Thu, 5 Sep 2019 17:15:45 +0000
Message-ID: <C3CDEAFF-4897-4AC9-9E37-FED5AC9DF738@fb.com>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
 <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
 <59821fd6-4dff-9871-7a48-dc9e877449f8@cloud.ionos.com>
 <a528b164-6f9a-3de1-df5e-105aaa71b4d4@cloud.ionos.com>
In-Reply-To: <a528b164-6f9a-3de1-df5e-105aaa71b4d4@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:b3a5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f3fb66a-424e-4e06-cca1-08d73224b041
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1678;
x-ms-traffictypediagnostic: MWHPR15MB1678:
x-microsoft-antispam-prvs: <MWHPR15MB16780B5B230C79EC92762A08B3BB0@MWHPR15MB1678.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(6436002)(33656002)(25786009)(6916009)(46003)(14454004)(186003)(36756003)(229853002)(50226002)(14444005)(6116002)(54906003)(2906002)(256004)(66446008)(99286004)(6246003)(66946007)(66476007)(66556008)(76116006)(64756008)(81156014)(71190400001)(316002)(486006)(6506007)(6512007)(8676002)(4326008)(71200400001)(5660300002)(11346002)(102836004)(6486002)(53546011)(478600001)(2616005)(446003)(476003)(53936002)(7736002)(8936002)(76176011)(86362001)(305945005)(81166006)(57306001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1678;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OTCsRKLLsB+YsVChfnWg05T4+gxszb+sMsbTXJbrlNaZG+RRHiMF7aO+JNs0plfVC9KKlh8j8qZEDSRc+24/OQM+xD5yDx+d/UAgwJx9pAj19DbzbVE3VA/ssx0a6CrKLF3kbD+fModArtM24zL1Ny+7e8SGsDAcl6YUk6Z5GRYnYZSBUDQkkD2W7LG07C7GxfZZpQnc+5iZ10UUoJRtQRPTgrtWYWhchQcHOApFlCCzusT7eUqvVcbtsiX+3bFqvmj3M9RFk9YxnOyRcyL8FIm7s6f5TK9DGgMhC0K4Xxr/TdBOktjB4AUN8P7Wthyz/HI67eW4IXhZGE3RXvMQtr1JLHBCpURWsH4rzYDgpc0adOaVVzjfQHsBjL2vDZ+OVR5a8dduAO/7xU9erjh1VFqYf+GPpXZNr5lAR6sjV70=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A20ADEFF95254840B6EB70E2C549E0D7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3fb66a-424e-4e06-cca1-08d73224b041
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 17:15:45.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6Lyhp9Jw3BkTaPK/qoapzg6jAoTQei8C56nqn4RehcAxjfMV2q4QoYVVQS0xZhyB8oRp9PF799bfnb7R4Y42Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1678
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_05:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050165
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Sep 5, 2019, at 9:09 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>=
 wrote:
>=20
> Replace STRIPE_SYNCING with STRIPE_ACTIVE in the subject ...
>=20
> On 8/30/19 4:07 PM, Guoqing Jiang wrote:
>>=20
>>=20
>> On 8/30/19 1:26 AM, Song Liu wrote:
>>>=20
>>>> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.=
com> wrote:
>>>>=20
>>>> Hi Song,
>>>>=20
>>>> On 8/29/19 7:42 AM, Song Liu wrote:
>>>>> I read the code again, and now I am not sure whether we are fixing th=
e issue.
>>>>> This WARN_ONCE() does not run for head_sh, which should have STRIPE_A=
CTIVE.
>>>>> It only runs on other stripes in the batch, which should not have STR=
IPE_ACTIVE.
>>>>  From the original commit which introduced batch write, it has the des=
cription
>>>> which I think is align with your above sentence.
>>>>=20
>>>> "With below patch, we will automatically batch adjacent full stripe wr=
ite
>>>> together. Such stripes will be added to the batch list. Only the first=
 stripe
>>>> of the list will be put to handle_list and so run handle_stripe().".
>>>>=20
>>>> Could you point me related code which achieve the above purpose? Thank=
s.
>>> Do you mean which code makes sure the batched stripe will not be handle=
d?
>>> This is done via properly maintain STRIPE_HANDLE bit.
>>=20
>=20
> The raid5_make_request always set STRIPE_HANDLE for stripe which is retur=
ned from
> raid5_get_active_stripe, so seems the batched stripe could also set with =
STRIPE_HANDLE
> too, am I miss something?
>=20
> I checked the STRIPE_IO_STARTED flag, it is set in the path: handle_strip=
e -> ops_run_io.
> Since both STRIPE_IO_STARTED and STRIPE_ACTIVE are valid, which means the=
 stripe
> should be handling in the middle of handle_stripe.
>=20
> Maybe the scenario is that raid5_make_request get a lone stripe, then it =
is added to handle_list
> since STRIPE_HANDLE is valid, then handle_stripe sets STRIPE_ACTIVE flag =
to the stripe.
>=20
> Meantime, another full write writes to the same stripe, and added stripe =
to batch_list by:
>      raid5_make_request -> add_stripe_bio -> stripe_add_to_batch_list.
>=20
> Then the warning is triggered when err happens in the batch head stripe. =
There are two
> ways to address the warning I think.
>=20
> 1. remove the checking of STRIPE_ACTIVE flag since it is possible that a =
batched stripe
> could have the flag.
> 2. if STRIPE_ACTIVE flag is valid, then don't add stripe to batch list.

I think we should not set STRIPE_HANDLE if the stripe is added to a batch, =
so something=20
like:

diff --git i/drivers/md/raid5.c w/drivers/md/raid5.c
index 3de4e13bde98..af19f08627ce 100644
--- i/drivers/md/raid5.c
+++ w/drivers/md/raid5.c
@@ -3308,8 +3308,11 @@ static int add_stripe_bio(struct stripe_head *sh, st=
ruct bio *bi, int dd_idx,
        }
        spin_unlock_irq(&sh->stripe_lock);

-       if (stripe_can_batch(sh))
+       if (stripe_can_batch(sh)) {
                stripe_add_to_batch_list(conf, sh);
+               if (sh->batch_head)
+                       return 0;
+       }
        return 1;

  overlap:


I haven't tested this yet. It could be totally wrong.

>=20
> Also, there is short window between set STRIPE_ACTIVE and clear the flag =
in handle_stripe,
> does it make sense to make rough change like this?
>=20
>  static void handle_stripe(struct stripe_head *sh)
>  {
>         struct stripe_head_state s;
> @@ -4675,7 +4682,7 @@ static void handle_stripe(struct stripe_head *sh)
>         struct r5dev *pdev, *qdev;
>=20
>         clear_bit(STRIPE_HANDLE, &sh->state);
> -       if (test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)) {
> +       if (test_bit(STRIPE_ACTIVE, &sh->state)) {
>                 /* already being handled, ensure it gets handled
>                  * again when current action finishes */
>                 set_bit(STRIPE_HANDLE, &sh->state);
> @@ -4683,9 +4690,9 @@ static void handle_stripe(struct stripe_head *sh)
>         }
>=20
>         if (clear_batch_ready(sh) ) {
> -               clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
>                 return;
>         }
> +       set_bit(STRIPE_ACTIVE, &sh->state);

I don't think we can do this. We need atomic test_and_set for the stripe.=20

Thanks,
Song=
