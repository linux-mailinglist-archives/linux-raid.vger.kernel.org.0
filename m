Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA46A2AA3
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 01:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfH2XXz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Aug 2019 19:23:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5400 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727673AbfH2XXz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 29 Aug 2019 19:23:55 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TNNnoj026510;
        Thu, 29 Aug 2019 16:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2eME+6qkgWi6HasLN/NXTH+HDK+76LqToEMBLQQmZ98=;
 b=K2AvvZ47VowH7zio3A28wR0WWKyXh7b4XqScOPoEIPOOHiLY2bl2CPpLlmAvNi0rSm33
 d1qPvN7clJ/y7P3pJ6wK4QQmG+uX/0fn+OEUMJu79zWDA7U0azlqu3zKP0g4jXP4llDJ
 F0nghpdrpxvdY6EZ9nNsIRemllzXMZndZ0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uphm723sa-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Aug 2019 16:23:53 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 16:23:48 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Aug 2019 16:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0pWv+T2eQiql/U7vaegbsbam1ahZjpKtDjIyIQ0QJhPcMBwzv4tK9EqJ54C+GWp+HLkds1dzkGSCD1JDkQdBN5+rQDBt9BE7iW3auNUA0hNya0nwS6pWt+XLw/EhxKppskfFxuJXNqRMlFjbY3YTTjM3ponMCSFXm60MKigMHigHZUarovWTtYDKZT5YSoTD5kV4HBDHLqy9HuBvEeoUvh6G/VdnD4qihcdKhcKqL8g7g2vBcrDW5UBy1MUgvdthium/CBAY9NPI7UQZZ0cglBqqZcqfM/6bhg3EsBNFXNnNYtXz32MrbbN46JRuq7csf76/AxaWUhjVO9tbfx8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eME+6qkgWi6HasLN/NXTH+HDK+76LqToEMBLQQmZ98=;
 b=CCX07ditoyjIXoNNChwOqIT5XyfWkiAvJrT2FJY268Gy4X8UYyJq6VqPwvEMZoOeLWhRjaP2ceV8oEGgsDyyA7dKWrY1omZgMPcrjltS/XFgt7gCo0FUl9bczEPs+Fdmbpu8QBc4E7Vim0vjmo3qLhkDNBPOqze6ILCVK4TuXT/ANntCcUoErAeCAxxofPM3jy+JH/EIa0GMrjKIm02sSbYx/lm6hVq2WYbxMYDg3fspOjgrNQjhehWeW/TmkjtKaFwNgZ1uG+BJhUzbvMHgvOZYLpd2N6WDkTEWbMTZQ+lrYCW0D4Q+hWX6ZTauUMsi1VuFSTW4pj8qQfD4HZ5W2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eME+6qkgWi6HasLN/NXTH+HDK+76LqToEMBLQQmZ98=;
 b=JX3D6G/0ZtZ22RbYHIDsJW6Z0KmoVFwDdDn7YlMYAmXyhTFCFtbXdHUmsptBE3Ksuc7qWTrh3mfBmXejY8QsBGkKTyvuvmpXw/dmLOeGDyoH6P2it9MsysRxgt8BTwx4vghjXExeRSOSuZW6dAtmPpiPi4xxlezke7mjZ713qE8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1790.namprd15.prod.outlook.com (10.174.97.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 23:23:28 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 23:23:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
Thread-Topic: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
Thread-Index: AQHVXXJ5FXpHdA2IaUmgjRFDKVxJWKcRniOAgAA4roCAAO/QAA==
Date:   Thu, 29 Aug 2019 23:23:28 +0000
Message-ID: <5BBECAF4-65AD-4BE0-B442-E35CD2513A20@fb.com>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
 <94a850d9-be0e-5b17-a6ab-7db50f1c0961@cloud.ionos.com>
In-Reply-To: <94a850d9-be0e-5b17-a6ab-7db50f1c0961@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:3161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7affcf78-091e-4e22-f310-08d72cd7e61d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1790;
x-ms-traffictypediagnostic: MWHPR15MB1790:
x-microsoft-antispam-prvs: <MWHPR15MB17908248E75D08F07C60A80AB3A20@MWHPR15MB1790.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(305945005)(81156014)(36756003)(186003)(53546011)(66446008)(6436002)(14444005)(76116006)(8936002)(2616005)(256004)(5660300002)(486006)(6246003)(6506007)(86362001)(53936002)(476003)(64756008)(66556008)(6512007)(6486002)(2906002)(11346002)(71200400001)(71190400001)(446003)(66946007)(25786009)(316002)(6116002)(46003)(102836004)(50226002)(57306001)(99286004)(6916009)(66476007)(478600001)(8676002)(76176011)(7736002)(14454004)(33656002)(229853002)(4326008)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1790;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ANh1ka7Ujhhken3vWeHQ82Zbx9RJsxOW7Li0tU9l16/e6CUXvKBnTJ0Si4DqvGC+Wawj7sMjlU3hvoimRgn3UKNFeCHHKsD0DRcYOLu54cnO6tM+7PgYPP8NbWhkEmdUs1+YQSbGiROOoGZOsrVQqzKmj3mpv5RCo26QyKF1L7Q7u0dGLY4MCoopBn3WntHVWKgn9UAu+bq/Vxtdp5RRZbhI02BLEJ0v5lb1BcpXzePI/y+ehAie/cfQBPIjCWirKQofxepymp/UeCLiSIDMt8oZSfZCa2X6LwwOqupNCmUuibBOahA1HwjQVkogGP7ZQ6vekkEaBh1zBHdPIwCAo7aSGeKpVpn1Qc8nuLmASYdI7SsdYBl6VpHCB1H4zfix01DlYOb5LF4apFhjKM4ayYo7yDRT9p48o+Qa9V+U9wE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECFC42D2B70F3E49B805DBCA32E1844C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7affcf78-091e-4e22-f310-08d72cd7e61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 23:23:28.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2PIbepal2lnuJ5rKL1lYGEf4j/BxcuCyf7crHc7CkOrkfmJqqYZWYFZt+foG0mzVhFZcSmrvZCsDkY4F/23VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1790
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_09:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908290234
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Aug 29, 2019, at 2:05 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>=20
>=20
>=20
> On 8/29/19 7:42 AM, Song Liu wrote:
>>> drivers/md/raid5.c | 3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>> index 88e56ee98976..e3dced8ad1b5 100644
>>> --- a/drivers/md/raid5.c
>>> +++ b/drivers/md/raid5.c
>>> @@ -4612,8 +4612,7 @@ static void break_stripe_batch_list(struct stripe=
_head *head_sh,
>>>=20
>>> 		list_del_init(&sh->batch_list);
>>>=20
>>> -		WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>>> -					  (1 << STRIPE_SYNCING) |
>>> +		WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>>> 					  (1 << STRIPE_REPLACED) |
>>> 					  (1 << STRIPE_DELAYED) |
>>> 					  (1 << STRIPE_BIT_DELAY) |
>> I read the code again, and now I am not sure whether we are fixing the i=
ssue.
>> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTI=
VE.
>> It only runs on other stripes in the batch, which should not have STRIPE=
_ACTIVE.
>>=20
>> Does this make sense?
>=20
> Yes, maybe some stripes are added to batch_list with STRIPE_ACTIVE is set=
.
> could it possible caused by the path?
>=20
> retry_aligned_read -> sh =3D raid5_get_active_stripe(conf, sector, 0, 1, =
1)
>                                     ...
>                                     if (!add_stripe_bio(sh, raid_bio, dd_=
idx, 0, 0))
>                                     ...
>                                     handle_stripe(sh)

I think retry_aligned_read() will not add the sh to any batch list, because
it should not be a full stripe write:

	if (stripe_can_batch(sh))
		stripe_add_to_batch_list(conf, sh);

But I am not sure.=20

>=20
> The sh is added to batch_list by add_stripe_bio -> stripe_add_to_batch_li=
st,
> then the state is set to STRIPE_ACTIVE at the beginning of handle_stripe.
>=20
> Maybe introduce a flag to show that the stripe is in batch_list, and don'=
t call
> handle_stripe for that stripe, some rough changes like.
>=20
> gjiang@ls00508:/media/gjiang/opensource-tree/md$ git diff
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index e3dced8ad1b5..c04d5b55848a 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -817,12 +817,14 @@ static void stripe_add_to_batch_list(struct r5conf =
*conf, struct stripe_head *sh
>                  * can still add the stripe to batch list
>                  */
>                 list_add(&sh->batch_list, &head->batch_list);
> +               set_bit(STRIPE_IN_BATCH_LIST, &sh->state);
> spin_unlock(&head->batch_head->batch_lock);
>         } else {
>                 head->batch_head =3D head;
>                 sh->batch_head =3D head->batch_head;
>                 spin_lock(&head->batch_lock);
>                 list_add_tail(&sh->batch_list, &head->batch_list);
> +               set_bit(STRIPE_IN_BATCH_LIST, &sh->state);
>                 spin_unlock(&head->batch_lock);
>         }
>=20
> @@ -6161,7 +6163,8 @@ static int  retry_aligned_read(struct r5conf *conf,=
 struct bio *raid_bio,
>                 }
>=20
>                 set_bit(R5_ReadNoMerge, &sh->dev[dd_idx].flags);
> -               handle_stripe(sh);
> +               if (!test_bit(STRIPE_IN_BATCH_LIST, &sh->state))
> +                       handle_stripe(sh);
>                 raid5_release_stripe(sh);
>                 handled++;
>         }
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index cf991f13403e..dee7a1dee505 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -390,6 +390,7 @@ enum {
>                                  * in conf->r5c_full_stripe_list)
>                                  */
>         STRIPE_R5C_PREFLUSH,    /* need to flush journal device */
> +       STRIPE_IN_BATCH_LIST,   /* the stripe is already added to batch l=
ist */

I think we don't need a new flag. sh->batch_head should be sufficient.=20

Thanks,
Song=
