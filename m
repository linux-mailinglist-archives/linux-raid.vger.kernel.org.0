Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837629F3BA
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfH0UET (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 16:04:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730221AbfH0UES (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 27 Aug 2019 16:04:18 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RK3h4G017934;
        Tue, 27 Aug 2019 13:03:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RCWoQdPnzPL2RjJ2ipRv7rRS/ctmILZyFY6lhosIUVs=;
 b=XQL6PeBjhOdc3Qm13tw9Gv0G7BKMdLnh4uYGaKOwrY/7KmOdwW3AMoOKV5T3rnkTe7TJ
 I6vAf5FfwLeth9cdNSi8tiukcPooq/rnry/nZAbu6veBBNj1gT2EOEQj0qBBguKmbFrd
 0F5pyw1zE+Lao982q/3RC6i0hEL1MyjjaaE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2umhkpeqra-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 13:03:51 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 27 Aug 2019 13:03:42 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 27 Aug 2019 13:03:42 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Aug 2019 13:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx8dNuv/kjhDcX13ccE4cgzJzf/h6AWpcShbrsMy/fEdkn1jpNagFX/UJwQzVwax1zL5wSLR6cJB7VqCpCoG0bxXH/SQPA5RE2+poTYwxj5F4Z9XBxLqCNdwnc28S06OcRxKYOW2QVh7TDLDDhsx8BflVfEaxaah0AIXkZ+w/EU5/RAihNtZok4+fZYQZGVMsmkPUySqqo6vFNZbVrSqCzLIQqE4NTwareX63iNlcS+yx8MbhLo4K/M1iKrk+SusMbekZ8XBuZX63+3BxR9KVUhYpt4xiZ9bXsv6fhy6w2UhtWtgEVk/CARCvqPmM8Kh6o7bccMcf8wCxGPeR5QQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCWoQdPnzPL2RjJ2ipRv7rRS/ctmILZyFY6lhosIUVs=;
 b=UaJMvP44Ak+DKLpuLMqDrhGGiQteVlQmkwMBszNCuEPbDbscm5HDEjWga0gXelf5S7lTL195F2z+1hCfXMaBYi+yAoOBICF2spwss2SteNOSqHDj7pCia5oYzv596kw5Mxhdqbyc8DXPiSRMG3e9fdbCnzp9cH9mBLtf3CMLl1cu4RvAKEUcI+c+7ObRIbI+KJa0zijGMHtknAcPUqIY/lc6vIN2vMbRIj1tEu5QYKYpfkSvkvH7XchT5rFCavr8gRGmOu4/SWWl6Ln0QJbEgiGA7f6OPJvYyffyfyyCrIOa46rUxR83cAxFzlT2THMcZzWqNCpKWeRnANdlS+ijeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCWoQdPnzPL2RjJ2ipRv7rRS/ctmILZyFY6lhosIUVs=;
 b=B/Ss7svXtLbQ5VYvHTFYO0Trm14cd++VrQyZER/dJRyaItZLf0LuujBhkbYKPVTWX/2J57XwrNO3OTa2QCpkUP3CM9yRtRdrxgTm4GVmEKgcjSegHfq0E8T+dmOMPw5Tkx7hr7fryuGhU7zabLDYEQHuKJvAqpBtEg40mLuX6Cg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1438.namprd15.prod.outlook.com (10.173.235.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 20:03:38 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 20:03:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Nigel Croxon <ncroxon@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [GIT PULL] md-next 20190827
Thread-Topic: [GIT PULL] md-next 20190827
Thread-Index: AQHVXRA9WjV7JP01aUKw1jIN3sWCI6cPaVeAgAABj4A=
Date:   Tue, 27 Aug 2019 20:03:38 +0000
Message-ID: <2E921D63-D2AB-43D0-B7D8-6A10CD06CA4B@fb.com>
References: <D4B2FC6B-6939-4EFB-A8A6-9105C04AFAFB@fb.com>
 <43e21a6d-b1e5-b91d-9320-2b90bd230cab@kernel.dk>
In-Reply-To: <43e21a6d-b1e5-b91d-9320-2b90bd230cab@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:aca3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b44f17b5-0323-409f-6db9-08d72b29a6b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1438;
x-ms-traffictypediagnostic: MWHPR15MB1438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB14382738073549A974128A06B3A00@MWHPR15MB1438.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(39860400002)(346002)(366004)(189003)(199004)(186003)(50226002)(102836004)(6116002)(66556008)(46003)(446003)(36756003)(8676002)(64756008)(81156014)(229853002)(54906003)(57306001)(33656002)(2906002)(305945005)(8936002)(7736002)(14454004)(478600001)(99286004)(81166006)(53936002)(66446008)(53546011)(25786009)(6506007)(71190400001)(71200400001)(256004)(6512007)(86362001)(6486002)(4326008)(14444005)(76116006)(66946007)(11346002)(2616005)(5660300002)(6436002)(476003)(486006)(316002)(6246003)(6916009)(66476007)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1438;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EJnENorGTYyCNq34boUWmA8gAZCBxcIl6rHZ9X+exfFpZ7Mp6xsT9y4nnfOiBUsViBVbpzHdUoL7tZkXy043W/k6t1nLTxCLzzGnkcwvss+taYV7+i+l17oF9H9KmgoKR0S5Rm9e2UUm6VxsdFAQ8rC9S84jtJ4KcZ0vBfCHYk1bB53kF5NqFyMRA3lBfnXxPH5r4StaOZf9pWW4XQeENmU9J87EbnySj/q1eEDhKZpGYlzDuP4olxyGTAWHzY7V10KrFZnzwvPCaQgiFZ3eqBGLm8l6yzjHu7AxUJlQRe8LHBGhDh/O+uaXlM8G390rjip/Aw1/gqosHOgMIClVvS2StKYAU2cKID4rEvDPd7dEDfeA9811u0ChnpEqje45YzMOTfS7x/ilY+/kdj8iTMj9ZPgufUtiqejQewfeV5M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF26F139C7786843B8C97AA27ABB98B7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b44f17b5-0323-409f-6db9-08d72b29a6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 20:03:38.5083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JmF2s/FYfZoE1aPlrkKm1gd6aQM9PlLppI7hyQfClcAvNro+KRmxT+1quoaDNjtieeV3ue6X3rRdRZw8REX0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1438
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1908270190
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,

> On Aug 27, 2019, at 12:58 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 8/27/19 1:47 PM, Song Liu wrote:
>> Hi Jens,
>>=20
>> Please consider pulling the following patches for md on top of your for-=
5.4/block
>> branch.
>>=20
>> Thanks,
>> Song
>>=20
>>=20
>>=20
>> The following changes since commit 97b27821b4854ca744946dae32a3f2fd55bcd=
5bc:
>>=20
>>   writeback, memcg: Implement foreign dirty flushing (2019-08-27 09:22:3=
8 -0600)
>>=20
>> are available in the Git repository at:
>>=20
>>   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
>>=20
>> for you to fetch changes up to 0009fad033370802de75e4cedab54f4d86450e22:
>>=20
>>   raid5 improve too many read errors msg by adding limits (2019-08-27 12=
:36:37 -0700)
>>=20
>> ----------------------------------------------------------------
>> NeilBrown (2):
>>       md: only call set_in_sync() when it is expected to succeed.
>>       md: don't report active array_state until after revalidate_disk() =
completes.
>>=20
>> Nigel Croxon (1):
>>       raid5 improve too many read errors msg by adding limits
>=20
> You've cut the bottom part of this off, which is a bit problematic as I
> always verify that the diffstat matches between what you send and what
> I pull.
>=20

Sorry for this problem. Here is the full note from git-request-pull:

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
      raid5 improve too many read errors msg by adding limits

 drivers/md/md.c    | 14 +++++++++-----
 drivers/md/md.h    |  3 +++
 drivers/md/raid5.c | 14 ++++++++++----
 3 files changed, 22 insertions(+), 9 deletions(-)




