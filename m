Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAF1BF05A
	for <lists+linux-raid@lfdr.de>; Thu, 30 Apr 2020 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgD3GhB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Apr 2020 02:37:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28256 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD3GhA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 Apr 2020 02:37:00 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U6Y7Ti028754;
        Wed, 29 Apr 2020 23:36:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TFgBrVPIlfa1N+s1qFRlU+WvqF1nfrGJ68mJc626hxk=;
 b=ip3abP4nNgEip6deof3MA27dBo5yytchsXayK3jUIiaTfkKw0ZTSvH1DSX3KRHR1sC19
 f7q0TWnjfJ0CP0mYNPTFQmOyaKRGib45Na2hC3Kje8eXCZjiZt1NBWSJMHx1ss8cN6fX
 RK4DNk8op2SMmDIG4wecsOPP0ocNYGKk5fI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30qd20m268-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Apr 2020 23:36:53 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 29 Apr 2020 23:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljhh/tsrZ8haROzmC+Un8JcGjL/wDyr8USCZP3y70ER9t74Ej3mHksGJJmDQ+usblpyB0yJtxxbTmU+wLmwQAoVHtVD3QQh62GrCVSYQFbjQN3Z+k3o/f78U3PhpKo/8oDVOuhqj7unUUweVFHdA/nkXViOgAVxIKSLkuRZhaa3m64RepWRupdjuqUnX/UmlQdtWY2DA10HdbEzog6GAGndotcIpqqWLK6q36DX1WrtuUkGhl2l0Pxu/wsRQ83de3i7uxG8Qr9GP8zu6/wUndOy+FYhdZatGU3u7tGt1lt4X3gez76nxJ4StV42PG3cbtS3DHyfgG6w+rz8hZSQuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFgBrVPIlfa1N+s1qFRlU+WvqF1nfrGJ68mJc626hxk=;
 b=bLU9X45R9qEP/hGvShrMat2PyWOL85rUkGvcpw/ULiSTbaJwPvrPLVenkdGfz0MTxZ8ekrOPkBS+42hZxZ3cpcn6zUVQ0jVHU7761+1pAPZylzADcZy7PXkKoBZLewNxwmbdMBtaQ9V1OgGvG/arNSCODIS1WoVzJBK93tHsjbvsl6UKzCSP8hzn4Rzit4yIvPDNk5B9TIBiO3dFL6Mg4uaCM7TuV3Qp5xHcKA8a3FuLG8x8+jOJefNrcpFxnnZMLUNYpuDxjVa3Z6OMtJ8FV3rrklehiJt5j7/57z5lqhRFqJN/tO8NgFcUcexuUI5b+rbQgw3jffSR72ANFmyQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFgBrVPIlfa1N+s1qFRlU+WvqF1nfrGJ68mJc626hxk=;
 b=bwgWzic4ImQ9FHQV5Jit4h1sY39YxkrvaJ4R5jhOLZOQJAeP10yHgiuqSHCL6ZuetTooMu4Ght83yAZ0MRQq+Nx1q1m0nv+bgDQOlYfdUNgleaGlB6x2cWKzYsp8CYjXVggAdXnTwGU9XEgPK1joWJxWOf9wd3tZR0f1rxcn3zc=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2789.namprd15.prod.outlook.com (2603:10b6:a03:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 06:36:37 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 06:36:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     Michal Hocko <mhocko@kernel.org>, Coly Li <colyli@suse.de>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
Thread-Topic: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
Thread-Index: AQHWCMaZPtL1EAJCIkGgkby2AYbB9qhqswwAgAMYboCAA5FQgIAIySYAgAAnpQCAAAOcgIAACY6AgBcHGYA=
Date:   Thu, 30 Apr 2020 06:36:37 +0000
Message-ID: <1B9A34D3-C98E-49A7-9222-7D25F5F7CCC9@fb.com>
References: <20200402081312.32709-1-colyli@suse.de>
 <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
 <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
 <204e9fd0-3712-4864-2bf5-38913511e658@cloud.ionos.com>
 <20200415114814.GJ4629@dhcp22.suse.cz>
 <a1e83cb5-366c-17a7-3a4b-9cd8a54c3b48@cloud.ionos.com>
 <20200415142303.GN4629@dhcp22.suse.cz>
 <b7584395-6230-36a6-9d78-dd1e1b630bbd@cloud.ionos.com>
In-Reply-To: <b7584395-6230-36a6-9d78-dd1e1b630bbd@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:67b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b7aab0b-1da2-42ed-03fa-08d7ecd0d587
x-ms-traffictypediagnostic: BYAPR15MB2789:
x-microsoft-antispam-prvs: <BYAPR15MB27891919B01923C82AB2C8B6B3AA0@BYAPR15MB2789.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(86362001)(2616005)(71200400001)(186003)(91956017)(76116006)(6916009)(53546011)(6506007)(2906002)(54906003)(8936002)(316002)(66946007)(6486002)(36756003)(64756008)(8676002)(66556008)(66476007)(6512007)(66446008)(4326008)(478600001)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EwLAVIiQdbtOkI0S6Vs3L0/Ks6TqKXRWEpYnxA7cZCIUfm75CY3R/fH8DYJO2gak1ahMIJnXrlC+75b0eimbwRjETAcM/Vejm+JO/ezZH9o3ywq1rNcwICkB0rq+DVTw/eGgtz5kIyy8SohHlhPOsfamXPPQCEzNZsu0C+vT3pXZNMdYx1arJNoIPB8Lv81H4m6tN+6hhktrMAz1Cypz4oJ/80EtZZSBo4G0tJ1xI2ImFEc6d4HkzTAnCh0mYjp0S608N/9zQGZyM38A6wHpqk+JeeQqDOJwtUF4InIt/iK+clLdko/72AvTJKZUfmdy0hCM4gGUOJXj6Qa65BE39jupqrqD/y5cmOQDN/uJ0OPedQ7NOSCKMosf+xvMMs/gBqrFMsECr6cDXGnOkVUpLUBLjNmUbS08EOmszdB65oLYPo6dtNKdlLLqhJ8YKOiI
x-ms-exchange-antispam-messagedata: dicLGhQ0vCAky9uSsI0o3Mqj/tyQECC2hfoH/IJUmGYrHJu+ET8NICpWe7yvNlBcgqjNh0Ob0INxXnaOFDWSUOmGKXKc/Kb/bxc4Xgfj5Ou0l5/t1nzLGIV6kfzTEa3SbbyotJnxnkY2PwxKOxYPUujH1wQ8dmVOBfGizau9NNk9ogbzWzFuDJ5GYTd7QiK3tXMyOhGi78MGO6fTmzDFS9h3T7Q/dobphuLhudtSPC24J4bZnXsEu2bTR98Dp9Tp8bzmxcL3/yS9ffXETpXqm3EujSeUjjinT45mNZEmMFf9cuaWqh5stEdnTgMbvuGmN6Jh1ClMuUuZHx0d9dfAWxZc7gVTtCMnlZbGd7jCD1gCAAomuF57fdN6vJVVXa8kpDPBJSj/8XQVrljjBy4nbQ64btaJdehMmY5zyQ6crpRyAsVaP5Dp671rGl75x5qYoXbi7xA/4XQRliPCviB5E9QLRF6YyszD3tt8qJIZ68fFhfuS8W8Joede4XKatRN9afcf296w9NypMkmooQPY4xesUuIblj3vRgI7Z8B6G0kV08dPIMpnga2AKWFE1AgBovyFvly9P33U9PTVqlUH5VhbEzNpQhF+N/q50MWfN6wmYgH7h8B+FxchqsZqybrJjEYBxhLNs3p+I3AIb/eJkLmRoysr5HpKd5SX0gnrgxciEKkVvGRVjP4Z0ruTrwtLQwqUkcosha5rW03eCUd4QNHl8zghDp5Z18j03nzY5fprPRX8kRSDE3wB7eoDGZ4cA7TWFM18+0q2jvG0PMg7HzrE42W+sI8PFVTFYazQTiqy3ZEinfAkD2maqYWNMsTnSTWLPx9A2qp2sXAzJXVDVQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E886392282A0F64BAAAA3879F52851FB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7aab0b-1da2-42ed-03fa-08d7ecd0d587
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 06:36:37.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaZondVNd8w/EliGhKX4QCVg1ULW4CCJlYxZlSGKoT+4l7oY/Et9vNolAA3lVcqcuYABr/4/COLW4tlS97vHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2789
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_02:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=975 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300052
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Apr 15, 2020, at 7:57 AM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>=20
> On 15.04.20 16:23, Michal Hocko wrote:
>> On Wed 15-04-20 16:10:08, Guoqing Jiang wrote:
>>> On 15.04.20 13:48, Michal Hocko wrote:
>>>> On Thu 09-04-20 23:38:13, Guoqing Jiang wrote:
>>>> [...]
>>>>> Not know memalloc_noio_{save,restore} well, but I guess it is better
>>>>> to use them to mark a small scope, just my two cents.
>>>> This would go against the intentio of the api. It is really meant to
>>>> define reclaim recursion problematic scope.
>>> Well, in current proposal, the scope is just when
>>> scribble_allo/kvmalloc_array is called.
>>>=20
>>> memalloc_noio_save
>>> scribble_allo/kvmalloc_array
>>> memalloc_noio_restore
>>>=20
>>> With the new proposal, the marked scope would be bigger than current on=
e
>>> since there
>>> are lots of places call mddev_suspend/resume.
>>>=20
>>> mddev_suspend
>>> memalloc_noio_save
>>> ...
>>> memalloc_noio_restore
>>> mddev_resume
>>>=20
>>> IMHO, if the current proposal works then what is the advantage to incre=
ase
>>> the scope.
>> The advantage is twofold. It serves the documentation purpose because it
>> is clear _what_ and _why_ is the actual allocation restricted context.
>> In this case mddev_{suspend,resume} because XYZ and you do not have to
>> care about __GFP_IO for _any_ allocation inside the scope.
>=20
> Personally, I'd prefer fine grained protection scope, anyway just my own
> flavor. And I think Song has his opinion about the proposal, I will respe=
ct
> his decision.

Thanks Coly, Guoqing, and Michal for these great inputs.=20

Coly's v3 set looks good to me. I will go ahead apply that version to md-ne=
xt
branch.=20

Thanks again,
Song

