Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7E1A6B9
	for <lists+linux-raid@lfdr.de>; Sat, 11 May 2019 07:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfEKFmB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 May 2019 01:42:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbfEKFmA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sat, 11 May 2019 01:42:00 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4B5bvFk012069;
        Fri, 10 May 2019 22:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FnjZ+VRdGfngGs0FFaitTlX84/P75BCyP4/OAhyO7oM=;
 b=BNpjqHyX9tcCwHiYQYRqE7XX1XdBNu2Do50ONsoKT7w68CXhSc3vKDUCulwNk57dhUDY
 la+YePTQcxN1T2IweLYRVYnfU+gXBO5gS7MA4tlyzL6WjSk8J45Mwthzzf34FF0GY8nm
 75eDD+ea69xA8KdLx2g/W1l/clAd+X1MBGo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2sdd3e2c70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 22:41:56 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 22:41:54 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 10 May 2019 22:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnjZ+VRdGfngGs0FFaitTlX84/P75BCyP4/OAhyO7oM=;
 b=PD5NG1rxvJ7OXu682cUYgqt1dwQkq5SREemP62NqZj8XNWKDIto1lLLsU/I5x1Lb8msHstB7qzmps6eRjufROlwSAhAxBeML8JfBT5hM9mC/Xm/kT8kI6vpS1+lOUuCCP9t0i6BBrItnUTruwKQZ1kgb2mr6FQlVPB49XqGsJC4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1293.namprd15.prod.outlook.com (10.175.3.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sat, 11 May 2019 05:41:52 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1878.024; Sat, 11 May 2019
 05:41:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Xiao Ni <xni@redhat.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "heinzm@redhat.com" <heinzm@redhat.com>,
        "ncroxon@redhat.com" <ncroxon@redhat.com>
Subject: Re: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
 r5l_flush_stripe_to_journal
Thread-Topic: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
 r5l_flush_stripe_to_journal
Thread-Index: AQHVBwRjvd/SXYsqzE21nQqCcjj/RqZkjpeABNkMKcr/2hNcAA==
Date:   Sat, 11 May 2019 05:41:50 +0000
Message-ID: <8404E824-E38D-4B78-8AF6-FDA1F3E534FF@fb.com>
References: <1557474339-18962-1-git-send-email-xni@redhat.com>
 <FF9BB066-7ED5-4066-B202-D64CFA065ABC@fb.com>
 <1021110953.28040133.1557533155006.JavaMail.zimbra@redhat.com>
In-Reply-To: <1021110953.28040133.1557533155006.JavaMail.zimbra@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:180::ae3a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e26b3bd4-8e2c-4d6b-e04c-08d6d5d35e8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1293;
x-ms-traffictypediagnostic: MWHPR15MB1293:
x-microsoft-antispam-prvs: <MWHPR15MB129388187218BABA6DF5D2DEB30D0@MWHPR15MB1293.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00342DD5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(13464003)(5660300002)(2616005)(66446008)(66556008)(46003)(68736007)(486006)(86362001)(102836004)(53546011)(6512007)(476003)(6506007)(11346002)(446003)(53936002)(54906003)(186003)(82746002)(66946007)(99286004)(66476007)(25786009)(76116006)(36756003)(64756008)(91956017)(316002)(6246003)(2906002)(73956011)(76176011)(4326008)(71190400001)(33656002)(478600001)(6436002)(6916009)(229853002)(6116002)(50226002)(81156014)(8936002)(14454004)(305945005)(81166006)(256004)(14444005)(71200400001)(8676002)(6486002)(57306001)(7736002)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1293;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f0DdJkqQVZgvNTTZc2YxurGXMc7Wvy1v4/vslttEw8isokfIdfJDd4KSgp48DR9JoMhU6aV01MziyP3DsYK33jJS9JRg5K4Vn+jJsiUUp7ASOq52yr0NvOBrgXZvwCxr6GCGZKCFQstoUXMuRQNZamJuHBSOzUc68Fxv54pPgdhYjP8EdCnXYJ/WwHQJXJNpJM+5CPJVP+yH40s3DxDNjFvddeusxeEaROc7Vgc+2Go42dpVylYcY6lMXuCOdnt1pqVNOZs0dndJAvN19TMhP4e3P3TKzzgAm2Ajyr0FJ2ke6R2DcQcPzouR5/cRCZR3y/ivCIB4i+iEj3b1dmpvoz8AJQjFeYwhPGkayeKmCRwnpOXUCQHUdqOjCOBQm89XQFToel/cOI8AyOHD9CJI/ahFQkdqO4HsAq1Q2NWapGo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7181DE00E428BF4B9EEF1419B7F06221@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e26b3bd4-8e2c-4d6b-e04c-08d6d5d35e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2019 05:41:50.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1293
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-11_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On May 10, 2019, at 5:05 PM, Xiao Ni <xni@redhat.com> wrote:
>=20
>=20
>=20
> ----- Original Message -----
>> From: "Song Liu" <songliubraving@fb.com>
>> To: "Xiao Ni" <xni@redhat.com>
>> Cc: "linux-raid" <linux-raid@vger.kernel.org>, heinzm@redhat.com, ncroxo=
n@redhat.com
>> Sent: Saturday, May 11, 2019 12:35:02 AM
>> Subject: Re: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to=
 r5l_flush_stripe_to_journal
>>=20
>>=20
>>=20
>>> On May 10, 2019, at 12:45 AM, Xiao Ni <xni@redhat.com> wrote:
>>>=20
>>> When journal device supports volatile write cache, it needs to flush to
>>> make sure data is settled
>>> down in journal device. It's the usage of function
>>> r5l_flush_stripe_to_raid. The data is flushed
>>> from stripe cache to journal device. Rename the function name to make i=
t
>>> more proper.
>>=20
>> I think current name is more accurate. It is actually the beginning of
>> writing data to raid
>> disks. While it does flush the journal device, it also calls
>> r5l_log_flush_endio(), which
>> kicks off the write to raid disks.
>>=20
>> Does this make sense?
>=20
> The write bio writes to journal device first. In the callback r5l_log_end=
io it
> checks whether it needs to flush the data to journal device. If it needs =
to flush,
> it calls r5l_move_to_end_ios which moves io_units to log->io_end_ios. The=
n
> r5l_flush_stripe_to_raid submit the flush bio. If it doesn't need to flus=
h, it
> calls r5l_log_run_stripes->r5l_io_run_stripes to kick off write to raid d=
isks.=20
> In fact r5l_io_run_stripes is the function which kicks off write to raid =
disks.
>=20
> So there are two steps here. One is write data to journal device. It need=
s to flush
> data to journal device in this step. Two is write data to raid disks by s=
tate machine.
> I still think it's better to change the name to r5l_flush_stripe_to_journ=
al to describe
> the thing what it does in this function directly. Even though it calls ha=
ndle_stripe
> in the callback function.
>=20
> At first reading of this function, I searched where are the bios that are=
 submitted to
> the raid disks. Then I found it calls handle_stripe in the callback funct=
ion. It's a little
> confusing. It's the reason I want to rename it. But it depends what peopl=
e understand.
> So it's ok for me if we use r5l_flush_stripe_to_raid :)

This function is called to finish processing pending stripes (at the end of=
 raid5d,=20
and raid5worker). So the goal is to flush all data to raid disks. If we cha=
nge it=20
to flush journal, it will be confusing from the caller side: why only flush=
 journal?
shouldn't we flush raid disks as well?

Let's keep it as-is for now.=20

Thanks,
Song

>=20
> Regards
> Xiao
>=20
>>=20
>> Thanks,
>> Song
>>=20
>>>=20
>>> Signed-off-by: Xiao Ni <xni@redhat.com>
>>> ---
>>> drivers/md/raid5-cache.c | 2 +-
>>> drivers/md/raid5.c       | 6 +++---
>>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
>>> index cbbe6b6..689a59e 100644
>>> --- a/drivers/md/raid5-cache.c
>>> +++ b/drivers/md/raid5-cache.c
>>> @@ -1294,7 +1294,7 @@ static void r5l_log_flush_endio(struct bio *bio)
>>> * only write stripes of an io_unit to raid disks till the io_unit is th=
e
>>> first
>>> * one whose data/parity is in log.
>>> */
>>> -void r5l_flush_stripe_to_raid(struct r5l_log *log)
>>> +void r5l_flush_stripe_to_journal(struct r5l_log *log)
>>> {
>>> 	bool do_flush;
>>>=20
>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>> index 7fde645..56d9e6e 100644
>>> --- a/drivers/md/raid5.c
>>> +++ b/drivers/md/raid5.c
>>> @@ -6206,7 +6206,7 @@ static int handle_active_stripes(struct r5conf *c=
onf,
>>> int group,
>>> 	release_inactive_stripe_list(conf, temp_inactive_list,
>>> 				     NR_STRIPE_HASH_LOCKS);
>>>=20
>>> -	r5l_flush_stripe_to_raid(conf->log);
>>> +	r5l_flush_stripe_to_journal(conf->log);
>>> 	if (release_inactive) {
>>> 		spin_lock_irq(&conf->device_lock);
>>> 		return 0;
>>> @@ -6262,7 +6262,7 @@ static void raid5_do_work(struct work_struct *wor=
k)
>>>=20
>>> 	flush_deferred_bios(conf);
>>>=20
>>> -	r5l_flush_stripe_to_raid(conf->log);
>>> +	r5l_flush_stripe_to_journal(conf->log);
>>>=20
>>> 	async_tx_issue_pending_all();
>>> 	blk_finish_plug(&plug);
>>> @@ -6349,7 +6349,7 @@ static void raid5d(struct md_thread *thread)
>>>=20
>>> 	flush_deferred_bios(conf);
>>>=20
>>> -	r5l_flush_stripe_to_raid(conf->log);
>>> +	r5l_flush_stripe_to_journal(conf->log);
>>>=20
>>> 	async_tx_issue_pending_all();
>>> 	blk_finish_plug(&plug);
>>> --
>>> 2.7.5
>>>=20
>>=20
>>=20

