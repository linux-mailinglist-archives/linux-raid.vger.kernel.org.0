Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD11E7CE4
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 00:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfJ1Xdg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Oct 2019 19:33:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfJ1Xdf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 28 Oct 2019 19:33:35 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SNXQG5013757;
        Mon, 28 Oct 2019 16:33:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+PPjz+em/i/6ovHY0qvmeo0Swx+YmssHZMOR8EJPwO4=;
 b=UcgeJ8LgwCYjvunV1JAYpRlBifBX3B/7Pp2v2GXgPG1dEmRVM3KdWYvvH4jYQeAbHP2X
 +SJ06WGJW4W3cTuhuLVN4Hn1NSCfjg/re/+kgfnSZ/l536S6hT+0SoVzzVfhZ8lqoiVX
 WHZb4fJBuwfwvG7W4IPL1DoefmziABq2qaY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vw5wp09cw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Oct 2019 16:33:29 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 16:33:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Oct 2019 16:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY9hWWJAwBNWAYMa71YXjtWSB6EMPI38Y6NdgcIE+1bD2Z+mJWDahW3Gl7MoXZKtVa2YITronCo4wQrI9/8vnGawq7LHNFRf33f9HQ3f2yD2iXUIjimYj5EHRDMNIrh1kM9vvtMN/KsU2F3IlrH3PlvVrpYw5SvhZPprUh5xfAxrg+WZhh7zlAXLf34Q3XktytS4ckxzdu/zWe8hNgXJPiiko9J09+Q2TW9PSd2Hqtnhz4X2XAxJRhRfVh3G8xWkhOlLGvLfFFpC1ZqiJ8DFXR4A8ymbfuRUCEAvqVahnomitu/lK9zC4JS2P1d4bjw73EOxBbABdtsyLD3l53vbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PPjz+em/i/6ovHY0qvmeo0Swx+YmssHZMOR8EJPwO4=;
 b=lhE+APKI+jdzyn88hogyUEJBVNkZtzpjpFHv9aLPMDO1rQhz6W6CrTFzoFwnZ604/e9K8FgSGCJxJ45TAmaQlWyhPfknBX1Z5d5suWDUoBx9maZ9S8BFMXAmudpv1iaqbNVld5xsUg9p8GSUMPNkbT/yP7UAa1ie/37/wdaUnhGdYCulm1t+WBSd2xTxBRW4TYBWyvOfpft45vpoD2LvajoK3Z8+VwGjHW0XJzzZ0dqnZLp5u8tLFd+VDeBP+n/1kIlfMmv/XHePLLtMMqVaQcCtlSRmCXxHQHIrvpG4JBd4eI0CklGpFyqkIUfv6KwEQwKNGCcZheFtmNN15XGwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PPjz+em/i/6ovHY0qvmeo0Swx+YmssHZMOR8EJPwO4=;
 b=Z+rVlU25vB+p4JiAcbzshUAW47l9IWm3zdo0I63ETTOR2AY0RNks2I0gQRwAxt8tYq6ukjQfRSoM6PUdx/DHJC2+qlY1/FfDxybyJ/lCqmbei3f1iDIiIwKzZ/obqkkM7/OXQ9++T8pAFHlnFeahXTPUhjE1rq+Y0bHya1TTuNw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1726.namprd15.prod.outlook.com (10.174.254.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 23:33:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 23:33:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     NeilBrown <neilb@suse.de>
CC:     dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "Ivan Topolsky" <doktor.yak@gmail.com>
Subject: Re: admin-guide page for raid0 layout issue
Thread-Topic: admin-guide page for raid0 layout issue
Thread-Index: AQHVisuWEqtwDBXPlES65SE85dvDk6dr/HQAgAR4TACAADYDgIAAD80A
Date:   Mon, 28 Oct 2019 23:33:18 +0000
Message-ID: <E57F64AA-229B-46FA-A34E-F765E9170215@fb.com>
References: <20191025003117.GA19595@xps13.dannf>
 <CAPhsuW6eYTF3AaisW+QsjEneABsh+fitw7bRz_NtD3Eo_gN0eg@mail.gmail.com>
 <20191028192326.GA24367@xps13.dannf>
 <87y2x4ebuq.fsf@notabene.neil.brown.name>
In-Reply-To: <87y2x4ebuq.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::3:4b54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db12e20f-1ef4-45bb-2959-08d75bff36c5
x-ms-traffictypediagnostic: MWHPR15MB1726:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR15MB172617D4303113838CBCECBEB3660@MWHPR15MB1726.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(52054003)(189003)(199004)(14444005)(256004)(36756003)(186003)(476003)(6116002)(4326008)(6306002)(76176011)(86362001)(6512007)(6916009)(2616005)(6486002)(8676002)(446003)(6436002)(14454004)(229853002)(7736002)(305945005)(486006)(46003)(81166006)(8936002)(102836004)(81156014)(6246003)(966005)(25786009)(316002)(50226002)(11346002)(64756008)(66476007)(54906003)(66946007)(66446008)(66556008)(71200400001)(71190400001)(5660300002)(76116006)(6506007)(53546011)(33656002)(2906002)(478600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1726;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVsNH3AiL0h4eFjcOgB5RPgV8/6QAmEb0+qBgA+DMwxoSXxSRxCvwb/XorWCtmgToFP6efD8hSYr8a9/bN7kIruP7rqncF8XWRCH1Hmkm94PgXxVKSF4os31glxvI8Cc09wwo2+R4XNdSiJGc5EWgTigQTSHygLAsmnq2qxZtIOM8Y844ob2RUJ8DD0Dr96BmxLRV2YW6CglPNlYx3EKQlWaSYPMZdmNl82JMluiJGQGxxV9+NVpRClsXNhqnetpWgF+SMW8TsdFDUSHbChqJ4qp9Z0QLUAPE9PfDwllH/B2sbWqZiuPgXUu0v4mjTDvC+GGxDvbhs4SQXw7Mxm4x7nKX8xv9JrpE/GyBTyeRsoPf48lnnrZGpM+ozKVPFsccPlHl8ta49pXqhtiF8lMiyj5FdvYZY/hqE1GXe3eWnqgSQ/a+hIjCuzo4mcf5NIp+nMyLuQR9W5gkRHsI/+bI16CNxAuXSjcwo62MAo5uU0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53749539EF8A0C4CA5548D97EB7A6A14@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db12e20f-1ef4-45bb-2959-08d75bff36c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 23:33:18.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiSoDrxBy558LZ6c3FViCxzkDq4214axmPukAo/rBFzZRZeR2OD3MYAMBXUEwHX9D9LOO82tQtdhp/2TVlTGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1726
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280221
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks Dann and Neil!

> On Oct 28, 2019, at 3:36 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, Oct 28 2019, dann frazier wrote:
>=20
>> On Fri, Oct 25, 2019 at 04:07:50PM -0700, Song Liu wrote:
>>> On Fri, Oct 25, 2019 at 12:16 PM dann frazier
>>> <dann.frazier@canonical.com> wrote:
>>>>=20
>>>> hey,
>>>>  I recently hit the raid0 default_layout issue and found the warning
>>>> message to be lacking (and google hits show that I'm not the
>>>> only one). It wasn't clear to me that it was referring to a kernel
>>>> parameter, also wasn't clear how I should decide which setting to use,
>>>> and definitely not clear that picking the wrong one could *cause
>>>> corruption* (which, AIUI, is the case). What are your thoughts on
>>>> adding a more admin-friendly explanation/steps on resolving the
>>>> problem to the admin-guide, and include a URL to it in the warning
>>>> message? As prior art:
>>>>=20
>>>>  https://github.com/torvalds/linux/commit/6a012288d6906fee1dbc244050ad=
e1dafe4a9c8d
>>>>=20
>>>> If the idea has merit, let me know if you'd like me to take a stab at
>>>> a strawdog.
>>>=20
>>> I think it is good to provide some more information for the admin.
>>> But I am not sure whether we need to point to a url, or just put
>>> everything in the message.
>>>=20
>>> Please feel free to try add this information and submit patches.
>>=20
>> Hi Song,
>>  Here's an RFC of what I'm thinking - but drafting this has led me to
>> more questions:
>>=20
>> - It seems like we've broken backwards compatibility when creating
>>   new multi-zone arrays. I expected that mdadm would still let me
>>   create an array w/o a kernel cmdline option in-effect, and w/o
>>   specifying a specific layout, and just choose a default.
>>   But even w/ latest mdadm git, it doesn't:
>=20
> Yes.  mdadm should let you do this, but it doesn't.  No one has written
> the code yet.
>=20
>>=20
>>    $ sudo ./mdadm --create /dev/md0 --run --metadata=3Ddefault \
>>      --homehost=3Dakis --level=3D0 --raid-devices=3D2 /dev/vdb1 /dev/vdc=
1
>>    mdadm: /dev/vdb1 appears to be part of a raid array:
>>           level=3Draid0 devices=3D2 ctime=3DMon Oct 28 18:55:38 2019
>>    mdadm: /dev/vdc1 appears to be part of a raid array:
>>           level=3Draid0 devices=3D2 ctime=3DMon Oct 28 18:55:38 2019
>>    mdadm: RUN_ARRAY failed: Unknown error 524
>>=20
>>  It also doesn't let me specify a layout:
>>    $ sudo ./mdadm --create /dev/md0 --run --metadata=3Ddefault \
>>      --homehost=3Dakis --level=3D0 --raid-devices=3D2 /dev/vdb1 /dev/vdc=
1 --layout=3D2
>>    mdadm: layout not meaningful for raid0 arrays.
>>=20
>> - Once you've decided on a layout to use, how do you make that a propert=
y
>>   of the array itself, and therefore avoid having to set default_layout=
=20
>>   on any machine that uses it? Seems like we'd want to "bake that in"
>>   to the array itself. I expected that if I created a new array on a
>>   recent kernel that the array would remember the layout. But after
>>   creating a new array on 5.4-rc5 w/ default_layout set, I rebooted
>>   w/o a raid0.default_layout, and the kernel still refused to start
>>   it.
>>=20
>>   Note: I realize my observation above does not match the text below
>>   in the 3rd paragraph, but I just left it for now until I learn the
>>   "right way".

mdadm should have code to set it in struct mdp_superblock_1.=20

>>=20
>> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guid=
e/md.rst
>> index 3c51084ffd379..5364c514d7926 100644
>> --- a/Documentation/admin-guide/md.rst
>> +++ b/Documentation/admin-guide/md.rst
>> @@ -759,3 +759,37 @@ These currently include:
>>=20
>>   ppl_write_hint
>>       NVMe stream ID to be set for each PPL write request.
>> +
>> +Multi-Zone RAID0 Layout Migration
>> +----------------------
>> +An unintentional RAID0 layout change was introduced in the v3.14 kernel=
.
>> +This effectively means there are 2 different layouts Linux will use to
>> +write data to RAID0 arrays in the wild - the "pre-3.14" way and the
>> +"post-3.14" way. Mixing these layouts by writing to an array while boot=
ed
>> +on these different kernel versions can lead to corruption.
>=20
> Says "pre-3.14" and "post-3.14" leaves it unclear what happens with
> 3.14.
> Maybe "pre.3.14" and "3.14 and later" ??
>=20
>> +
>> +Note that this only impacts RAID0 arrays that include devices of differ=
ent
>> +sizes. If your devices are all the same size, both layouts are equivale=
nt,
>> +and your array is not at risk of corruption due to this issue.
>> +
>> +The kernel has since been updated to record a layout version when creat=
ing
>> +new arrays. Unfortunately, the kernel can not detect which layout was u=
sed
                                          ^^^^^ "cannot"

Feel free to make changes and submit this as an official patch.=20

Thanks again,
Song

>=20
> As you note in the intro, the kernel doesn't record the layout version.
> The kernel doesn't change the v1.x metadata at all where possible. That
> is left for mdadm to do.
>=20
>> +for writes to pre-existing arrays, and therefore requires input from th=
e
>> +administrator. This input can be provided via the
>> +``raid0.default_layout=3D<N>`` kernel command line parameter, or via th=
e
>> +``layout`` attribute in the sysfs filesystem (but only when the array i=
s
>> +stopped).
>> +
>> +Which layout version should I use?
>> +++++++++++++++++++++++++++++++++++
>> +If your RAID array has only been written to by a >=3D 3.14 kernel, then=
 you
>> +should specify version 2. If your kernel has only been written to by a =
< 3.14
>> +kernel, then you should specify version 1. If the array may have alread=
y been
>> +written to by both kernels < 3.14 and >=3D 3.14, then it is possible th=
at your
>> +data has already suffered corruption. Note that ``mdadm --detail`` will=
 show
>> +you when an array was created, which may be useful in helping determine=
 the
>> +kernel version that was in-use at the time.
>> +
>> +When determining the scope of corruption, it maybe also be useful to kn=
ow
>> +that the area susceptible to this corruption is limited to the area of =
the
>> +array after "MIN_DEVICE_SIZE * NUM DEVICES".
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index 1e772287b1c8e..e01cd52d71aa4 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -155,6 +155,8 @@ static int create_strip_zones(struct mddev *mddev, s=
truct r0conf **private_conf)
>> 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_lay=
out setting\n",
>> 		       mdname(mddev));
>> 		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
>> +		pr_err("Read the following page for more information:\n");
>> +		pr_err("https://www.kernel.org/doc/html/latest/admin-guide/md.html#mu=
lti-zone-raid0-layout-migration\n");
>> 		err =3D -ENOTSUPP;
>> 		goto abort;
>> 	}
>=20
> I think it is an excellent idea to write this document and put the link
> in the code - thanks.
>=20
> NeilBrown

