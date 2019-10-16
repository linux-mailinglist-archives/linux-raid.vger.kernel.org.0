Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A70D95E8
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405737AbfJPPr1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 11:47:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbfJPPr0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 11:47:26 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9GFjJ2Q021794;
        Wed, 16 Oct 2019 08:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qqT1RhCP+DtWLWraxwmGQwGILSAI/IHLEtvuIlic6Js=;
 b=GSi48KkaBjFcaDPlon0w3dlJSou7zYcTSaGTC28CAhdlpb8FcoEqaZePUDdAIpsqrCVi
 iM9zNhfrpjC1yJV0DWaYyzI5JnJKcwZJk096KowOGoz1EyrBkNWOKWobTmjtp0tj8BNB
 APbUUcwvXSreW9GG8K6ZgJO3EYcr47Mx5gg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2vp3uk0qa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Oct 2019 08:46:28 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 08:46:27 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 08:46:27 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Oct 2019 08:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7yK5twO9Kmi8Gkep96wq54eRn914kh+p/7TQsRcRldk12g+pLpwsHlbPEO+3tOMU4BLbJI5P+YFxteiR8HjmegCwlGb6CGV/zIb0KqpxfVUalY7r5j+xbu0hIyUVe5FNoZvURHEq+FTB9qJjlyHYYeHuivoXZBn2+oAl0Q6uzAcP1Qc3V+zmw9/uv/ITmhtJgmvr/HuRwcbUdZoQ4zDIA7gK/IU2cqCyJCMuNLHpkhnmhBh9xCiGhPRxK6RTK58fu1/JEwrzOqkYptKPvv1WwF7Zmvm6V/1NF4JukPVQycHxtHKW7zPN3PvldfCJprB6+XknXl3FiKZYN1TUg/aBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqT1RhCP+DtWLWraxwmGQwGILSAI/IHLEtvuIlic6Js=;
 b=QlxEV1uYKvUNu356rKclRKEWo0dh6XUgvQXA2k3ki3bEgDt8vweUzFmmUGV2ryXTrWjL6BMqMTWYe8jCFDA6F2SN4OR3WIWJ1bZXSjJOnXI6ugTBgpY++ScQqrnkFsxmj2XNUpRlbiuiEApqoLhCq8YWVljjQINZqp+hLu7gNhu4K64fs6oAq36hJlZCsKoq0u4Ypze3zyaNmvvs00KHksfm8jR2rOs7MeY5rlNVqCStzCvK9i4xI1b9vvOd96mQSaphRu/BBpMvGycQotycO5NvoOBUjp2kfpxbzTlCBDMgOSFS8F33gV9hrVEL7XgtwdgTVqLVHUiT4OoKJmzJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqT1RhCP+DtWLWraxwmGQwGILSAI/IHLEtvuIlic6Js=;
 b=WXqh235DArKlG7Cu6HFw5YPeyZ9l534OUkun0q12cw/WlbFIHC59YPOvwxqA0uJWi8aFUziTfjIUzUTq23bVlaqbYxLLxuoaa3askZ/AArCdK9wDkpztMz1TCmLBRyW4elRnImj1718sGaeeSIAwernUykLXRHwFvkTRdr6K/Sk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1280.namprd15.prod.outlook.com (10.175.3.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 15:46:26 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 15:46:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yufen Yu <yuyufen@huawei.com>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH v4] md: no longer compare spare disk superblock events in
 super_load
Thread-Topic: [PATCH v4] md: no longer compare spare disk superblock events in
 super_load
Thread-Index: AQHVg/TJDL03ZbG/CUSIU+N+hJaPo6dc47WAgAANK4CAAHjxgA==
Date:   Wed, 16 Oct 2019 15:46:26 +0000
Message-ID: <E1E40FE7-BF64-44AC-8390-2490E60745A2@fb.com>
References: <20191016080003.38348-1-yuyufen@huawei.com>
 <E660B713-3623-4C8E-BF22-41ACC09F26DD@fb.com>
 <262b85c6-8e55-62f6-7861-43db7e9ecc25@huawei.com>
In-Reply-To: <262b85c6-8e55-62f6-7861-43db7e9ecc25@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::1:35f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5425df-eecb-4755-c866-08d7525000f2
x-ms-traffictypediagnostic: MWHPR15MB1280:
x-microsoft-antispam-prvs: <MWHPR15MB1280E95FA21ACB03E94D0515B3920@MWHPR15MB1280.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(39860400002)(346002)(51914003)(189003)(199004)(478600001)(2616005)(71190400001)(91956017)(81156014)(446003)(86362001)(71200400001)(6436002)(36756003)(50226002)(11346002)(14444005)(256004)(8676002)(6916009)(102836004)(4326008)(14454004)(476003)(66946007)(66476007)(5660300002)(6246003)(6116002)(486006)(316002)(46003)(64756008)(66446008)(305945005)(76116006)(66556008)(81166006)(7736002)(99286004)(186003)(33656002)(53546011)(229853002)(2906002)(76176011)(6506007)(6512007)(8936002)(6486002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1280;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXsmtKE2r2tmBEERi/KfrUa1jj/0RTWn49nAEXOs6REuue2FSpzJdTZCwPafHOTUm/mhEeGZ9eirJS0Mn6gZcIq5LxRC9WEmQqt4VYIRvG2r7xJU0U5ZROhfaSPfcDywEydnkIh7+u2Drevx8lo5Od5sfPhzd86wxGsbU9YiXF9d9jLTBbU1Z5sq+FkJ37ceIK5JVZN5BmtPokh/CViiChts94Cwu0SSUBhFdxmxc4XiyviXlQboRCbrdmT8sVQUDJ1+0CLqsThfiqnBUIgnFkK4pwi9gfki8OdTPoy9UMaEVgxxCVLl03ypkSrrqkVZx8Gc2bA4Ir6DjQExMZFczFW0P/RwWbQBIVn7i/IY5qQO3wTRBS/CJrzo8SYm3Cz5byuOELbR5j6NaPDVWE8PMq6ow/EbkffxpMG3OqMsx28=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74D9EFD445A3FD4B83B85E009109F61E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5425df-eecb-4755-c866-08d7525000f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 15:46:26.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WahfLvI8NSDC6b2/r6U3a0WpWXO+j3gm99jN7Z72uHJEU0hV16rJR7JjmUCkkvk+Rw0lgZwv92vdy1jc+fLRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1280
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_06:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160132
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Oct 16, 2019, at 1:33 AM, Yufen Yu <yuyufen@huawei.com> wrote:
>=20
>=20
>=20
> On 2019/10/16 15:46, Song Liu wrote:
>>=20
>>> On Oct 16, 2019, at 1:00 AM, Yufen Yu <yuyufen@huawei.com> wrote:
>>>=20
>>> We have a test case as follow:
>>>=20
>>>  mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
>>> 	--assume-clean --bitmap=3Dinternal
>>>  mdadm -S /dev/md1
>>>  mdadm -A /dev/md1 /dev/sd[b-c] --run --force
>>>=20
>>>  mdadm --zero /dev/sda
>>>  mdadm /dev/md1 -a /dev/sda
>>>=20
>>>  echo offline > /sys/block/sdc/device/state
>>>  echo offline > /sys/block/sdb/device/state
>>>  sleep 5
>>>  mdadm -S /dev/md1
>>>=20
>>>  echo running > /sys/block/sdb/device/state
>>>  echo running > /sys/block/sdc/device/state
>>>  mdadm -A /dev/md1 /dev/sd[a-c] --run --force
>>>=20
>>> When we readd /dev/sda to the array, it started to do recovery.
>>> After offline the other two disks in md1, the recovery have
>>> been interrupted and superblock update info cannot be written
>>> to the offline disks. While the spare disk (/dev/sda) can continue
>>> to update superblock info.
>>>=20
>>> After stopping the array and assemble it, we found the array
>>> run fail, with the follow kernel message:
>>>=20
>>> [  172.986064] md: kicking non-fresh sdb from array!
>>> [  173.004210] md: kicking non-fresh sdc from array!
>>> [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
>>> [  173.022406] md1: failed to create bitmap (-5)
>>> [  173.023466] md: md1 stopped.
>>>=20
>>> Since both sdb and sdc have the value of 'sb->events' smaller than
>>> that in sda, they have been kicked from the array. However, the only
>>> remained disk sda is in 'spare' state before stop and it cannot be
>>> added to conf->mirrors[] array. In the end, raid array assemble
>>> and run fail.
>>>=20
>>> In fact, we can use the older disk sdb or sdc to assemble the array.
>>> That means we should not choose the 'spare' disk as the fresh disk in
>>> analyze_sbs().
>>>=20
>>> To fix the problem, we do not compare superblock events when it is
>>> a spare disk, as same as validate_super.
>>>=20
>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> Please add "---" before "v1->v2:". etc. This will hint git to not
>> include these change lists during git-am.
>=20
> OK
>=20
>>> v1->v2:
>>>  fix wrong return value in super_90_load
>>> v2->v3:
>>>  adjust the patch format to avoid scripts/checkpatch.pl warning
>>> v3->v4:
>>>  fix the bug pointed out by Song, when the spare disk is the first
>>>  device for load_super
>>> ---
>>> drivers/md/md.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
>>> 1 file changed, 51 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 1be7abeb24fd..fc6ae8276a92 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -1149,7 +1149,15 @@ static int super_90_load(struct md_rdev *rdev, s=
truct md_rdev *refdev, int minor
>>> 		rdev->desc_nr =3D sb->this_disk.number;
>>>=20
>>> 	if (!refdev) {
>>> -		ret =3D 1;
>>> +		/*
>>> +		 * Insist on good event counter while assembling, except
>>> +		 * for spares (which don't need an event count)
>>> +		 */
>>> +		if (sb->disks[rdev->desc_nr].state & (
>>> +			(1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
>>> +			ret =3D 1;
>>> +		else
>>> +			ret =3D 0;
>> Have you tried only passing a couple spare disks to mdadm -A? I guess
>> we will end up with freshest =3D=3D NULL in analyze_sbs(), which will
>> crash in validate_super().
>=20
> Yes, freshest can be 'NULL'. So, I have added a test in analyze_sbs() in =
the patch.
>=20
> +       /* Cannot find a valid fresh disk */
> +       if (!freshest) {
> +               pr_warn("md: cannot find a valid disk\n");
> +               return -EINVAL;
> +       }
> +

I am sorry I missed this one.

Applied to md-next. Thanks for the fix!

Song=
