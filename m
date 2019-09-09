Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612D4ADBDD
	for <lists+linux-raid@lfdr.de>; Mon,  9 Sep 2019 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfIIPLY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Sep 2019 11:11:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbfIIPLX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Sep 2019 11:11:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89FBFxa031776;
        Mon, 9 Sep 2019 08:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=21CIQSKr1R0UGgqWM7/soaMi7yzEbXJckSiPabf5B/Q=;
 b=q8mnNlLOJwJUhXAOfaKce8urreT174c20hnoGPXUKTao9zcIt/1CXrDk+Qg2627U5jGI
 cn2FfvFjRUvbnSdm+2mStW39mYOI/3Xe23z74dsucpGuvdNS0eh9EdGTw305giTHd+yc
 YWpde8boEDkELf5ZHJ1RtEM/IpG7FuTf4KI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uvv8d50yt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Sep 2019 08:11:19 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 08:10:52 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Sep 2019 08:10:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXFiAnWZVirPIdYZRCv+nlCDrWRCox4wilI5ZvUmFplrB2HgF4y+7fqYTH20qn4Z40b6Bw/262XpgkzFCufGdlDQjgIZelyGq2FOd9N57NAtQAl/qff4N0yUGD4RGMJMYTDtY/gbndVsB0uaCXKtH+DXjn8WEhKf5ETmAUJdczn58FJhAfQmF3qAdUR1h39mDRLULjKovEaC9RK2wwnDp9BoJqYJReg513zSbrHTOH+D/teywBFLeudBcKVvNa+vxdEawf4R82Fv6YnByZNCQLHvqZ4ImmNPY7aNOIOQsJEP4JcbXrG1ifOCf2dsdRBAEDp3NDVTcd3PiUag7+zp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21CIQSKr1R0UGgqWM7/soaMi7yzEbXJckSiPabf5B/Q=;
 b=mR8j7wxsiWVZNKHhabIEDrpiws5DAbiMw8dBHy7aXDpodI1MYmJos+1Xa6yObZUco/3pSWEiY1TjxedZ6Y7w4erCDIiSibTOim2GCEvcJzjJ1L00mClGi2wmGURLDuDMCh1n4kOGGtVLiKGyJuwqdnL3jZo8Ptq86VAqq7Uc7ZKO89vaZp0T0ka23UQF1RRt844C/BfXfMeAlmO344GrKzrp/lcLdlI5TFoDdNMFJK+QI7dEEtMzYh1T3D64ANEgNMqqzSK59SUNKSqieg+XcAktv3im/HmBfsGJ16CS/2ZMU+crFVDwFP+Zwii2zYyzSi0Qgzu2f9zI2i/nSZ9VtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21CIQSKr1R0UGgqWM7/soaMi7yzEbXJckSiPabf5B/Q=;
 b=UvtoNpFseu34n6myDGbo7QKomhC4vRZDBhzKL029/YL9IurCencwMp/MAlldqPJbcSxQfs0J4nbfIkLhdRDONQrHkBgoP/A9Qj/t6GRs/sZjrFnixFln76jK3HDQ4jgHnUwrmZsHF82o9J5ba2wduq/JgrXlBRqMLYGhY2wC0sg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1663.namprd15.prod.outlook.com (10.175.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 15:10:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 15:10:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     NeilBrown <neilb@suse.com>, linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] raid5: don't warn with STRIPE_ACTIVE flag in
 break_stripe_batch_list
Thread-Topic: [PATCH] raid5: don't warn with STRIPE_ACTIVE flag in
 break_stripe_batch_list
Thread-Index: AQHVZARdl3NB1aZzkk6l5aokjSN886cdUxEAgAEceoCABQnygA==
Date:   Mon, 9 Sep 2019 15:10:49 +0000
Message-ID: <BC73D2C7-782A-40D7-9B85-0D7AA6E40A5F@fb.com>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
 <167E280B-5D21-4A31-A772-E913E2252298@fb.com>
 <59821fd6-4dff-9871-7a48-dc9e877449f8@cloud.ionos.com>
 <a528b164-6f9a-3de1-df5e-105aaa71b4d4@cloud.ionos.com>
 <C3CDEAFF-4897-4AC9-9E37-FED5AC9DF738@fb.com>
 <79bd85f3-d88f-b0d9-deda-7b5e2958de7b@cloud.ionos.com>
In-Reply-To: <79bd85f3-d88f-b0d9-deda-7b5e2958de7b@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::7d10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3b76d65-7108-4170-abe5-08d73537e66b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1663;
x-ms-traffictypediagnostic: MWHPR15MB1663:
x-microsoft-antispam-prvs: <MWHPR15MB166376DE142656C7FC38CD34B3B70@MWHPR15MB1663.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(50226002)(102836004)(66946007)(64756008)(66556008)(66476007)(5660300002)(76176011)(6916009)(186003)(478600001)(99286004)(14444005)(54906003)(6436002)(6512007)(4326008)(256004)(229853002)(8676002)(316002)(81166006)(81156014)(86362001)(53936002)(8936002)(6246003)(36756003)(91956017)(7736002)(53546011)(6486002)(6506007)(25786009)(476003)(11346002)(2906002)(46003)(14454004)(71200400001)(76116006)(71190400001)(446003)(33656002)(305945005)(486006)(2616005)(6116002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1663;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gZDBaQlTW8qVK94ohGsrkv4Y67O6wOsU771R8T5HBCcwyFxZyUjCYO5m/F5GoBMce5FfNdgwNAsafZ2fi2QYgDxb0Z+2XrluyzOdj2wdbXo62ExxjoXNwG6J/QDA1yJCxRJhfUOoJzbgCAxtDs28goAwjj0PEeD8LGJsHdXgnOmT5kFLCz0SRUaSoNxGRe9fcaPWw191NlOxcmlj2sfyX2R5CtK5TSol3G/nbyd5mSywCBnhjs7j1vk4cHEubUyNN7Jcf/Ey+8Tksgn8GPMKZRNNKG/J4LBRMEzJH2VFwPZqteVKxury9r68i5b1DB3CdQAY6oOhvkABtGPZeiG12U8bHqCP2t4cC/b9h/yJuYIPK74pyVWm1MORy+9eskB8eZfrS4iRHD76VPonk8HVgk+qSe3r7Dyyw6T4sUKhtUY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23F61625E3519343800955F5176AA080@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b76d65-7108-4170-abe5-08d73537e66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 15:10:49.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdd2nx6y3XvoNThnMMt7Emh/9AQ7+Yef0IzpXGGwFaOtaXy9o2ElsXEQQPuBNJGCl9stHExo9cvvo7DK1sdFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_06:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090155
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Sep 6, 2019, at 11:13 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>=20
>=20
>=20
> On 9/5/19 7:15 PM, Song Liu wrote:
>>=20
>>> On Sep 5, 2019, at 9:09 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.co=
m> wrote:
>>>=20
>>> Replace STRIPE_SYNCING with STRIPE_ACTIVE in the subject ...
>>>=20
>>> On 8/30/19 4:07 PM, Guoqing Jiang wrote:
>>>>=20
>>>> On 8/30/19 1:26 AM, Song Liu wrote:
>>>>>> On Aug 29, 2019, at 8:00 AM, Guoqing Jiang <guoqing.jiang@cloud.iono=
s.com> wrote:
>>>>>>=20
>>>>>> Hi Song,
>>>>>>=20
>>>>>> On 8/29/19 7:42 AM, Song Liu wrote:
>>>>>>> I read the code again, and now I am not sure whether we are fixing =
the issue.
>>>>>>> This WARN_ONCE() does not run for head_sh, which should have STRIPE=
_ACTIVE.
>>>>>>> It only runs on other stripes in the batch, which should not have S=
TRIPE_ACTIVE.
>>>>>>  From the original commit which introduced batch write, it has the d=
escription
>>>>>> which I think is align with your above sentence.
>>>>>>=20
>>>>>> "With below patch, we will automatically batch adjacent full stripe =
write
>>>>>> together. Such stripes will be added to the batch list. Only the fir=
st stripe
>>>>>> of the list will be put to handle_list and so run handle_stripe().".
>>>>>>=20
>>>>>> Could you point me related code which achieve the above purpose? Tha=
nks.
>>>>> Do you mean which code makes sure the batched stripe will not be hand=
led?
>>>>> This is done via properly maintain STRIPE_HANDLE bit.
>>> The raid5_make_request always set STRIPE_HANDLE for stripe which is ret=
urned from
>>> raid5_get_active_stripe, so seems the batched stripe could also set wit=
h STRIPE_HANDLE
>>> too, am I miss something?
>>>=20
>>> I checked the STRIPE_IO_STARTED flag, it is set in the path: handle_str=
ipe -> ops_run_io.
>>> Since both STRIPE_IO_STARTED and STRIPE_ACTIVE are valid, which means t=
he stripe
>>> should be handling in the middle of handle_stripe.
>>>=20
>>> Maybe the scenario is that raid5_make_request get a lone stripe, then i=
t is added to handle_list
>>> since STRIPE_HANDLE is valid, then handle_stripe sets STRIPE_ACTIVE fla=
g to the stripe.
>>>=20
>>> Meantime, another full write writes to the same stripe, and added strip=
e to batch_list by:
>>>      raid5_make_request -> add_stripe_bio -> stripe_add_to_batch_list.
>>>=20
>>> Then the warning is triggered when err happens in the batch head stripe=
. There are two
>>> ways to address the warning I think.
>>>=20
>>> 1. remove the checking of STRIPE_ACTIVE flag since it is possible that =
a batched stripe
>>> could have the flag.
>>> 2. if STRIPE_ACTIVE flag is valid, then don't add stripe to batch list.
>> I think we should not set STRIPE_HANDLE if the stripe is added to a batc=
h, so something
>> like:
>>=20
>> diff --git i/drivers/md/raid5.c w/drivers/md/raid5.c
>> index 3de4e13bde98..af19f08627ce 100644
>> --- i/drivers/md/raid5.c
>> +++ w/drivers/md/raid5.c
>> @@ -3308,8 +3308,11 @@ static int add_stripe_bio(struct stripe_head *sh,=
 struct bio *bi, int dd_idx,
>>         }
>>         spin_unlock_irq(&sh->stripe_lock);
>>=20
>> -       if (stripe_can_batch(sh))
>> +       if (stripe_can_batch(sh)) {
>>                 stripe_add_to_batch_list(conf, sh);
>> +               if (sh->batch_head)
>> +                       return 0;
>> +       }
>>         return 1;
>>=20
>>   overlap:
>>=20
>>=20
>> I haven't tested this yet. It could be totally wrong.
>=20
> The return value of add_stripe_bio should mean the bio is added to stripe=
 or not.
> With the change, '0' could also means stripe is added to batch list, whic=
h is really
> confusing. Or we can check batch_head before STRIPE_HANDLE.
>=20
> @@ -5718,7 +5727,8 @@ static bool raid5_make_request(struct mddev *mddev,=
 struct bio * bi)
>                                 do_flush =3D false;
>                         }
>=20
> -                       set_bit(STRIPE_HANDLE, &sh->state);
> +                       if (!sh->batch_head)
> +                               set_bit(STRIPE_HANDLE, &sh->state);

I think this works.=20

>=20
>=20
>>> Also, there is short window between set STRIPE_ACTIVE and clear the fla=
g in handle_stripe,
>>> does it make sense to make rough change like this?
>>>=20
>>>  static void handle_stripe(struct stripe_head *sh)
>>>  {
>>>         struct stripe_head_state s;
>>> @@ -4675,7 +4682,7 @@ static void handle_stripe(struct stripe_head *sh)
>>>         struct r5dev *pdev, *qdev;
>>>=20
>>>         clear_bit(STRIPE_HANDLE, &sh->state);
>>> -       if (test_and_set_bit_lock(STRIPE_ACTIVE, &sh->state)) {
>>> +       if (test_bit(STRIPE_ACTIVE, &sh->state)) {
>>>                 /* already being handled, ensure it gets handled
>>>                  * again when current action finishes */
>>>                 set_bit(STRIPE_HANDLE, &sh->state);
>>> @@ -4683,9 +4690,9 @@ static void handle_stripe(struct stripe_head *sh)
>>>         }
>>>=20
>>>         if (clear_batch_ready(sh) ) {
>>> -               clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
>>>                 return;
>>>         }
>>> +       set_bit(STRIPE_ACTIVE, &sh->state);
>> I don't think we can do this. We need atomic test_and_set for the stripe=
.
>=20
> Hmm, it guarantees only one process can handle the stripe, others have to=
 return
> earlier. And the side effect in current code is that stripe could set wit=
h ACTIVE flag
> shortly even it is in batch list.

I guess this is not a problem with the change above?

Thanks,
Song


