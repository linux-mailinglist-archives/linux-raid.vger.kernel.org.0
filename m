Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6221A198
	for <lists+linux-raid@lfdr.de>; Fri, 10 May 2019 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEJQfK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 May 2019 12:35:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbfEJQfJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 May 2019 12:35:09 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AGNE10013347;
        Fri, 10 May 2019 09:35:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=koHLi4Whg7vDzZMwb7bTdUS/tSLQuVMX3l0dDvaGo20=;
 b=QFsqcjfJRl7RSzzByFrkauBt1DK3UNf1OTTIEm8uBB5hXGnxyqJ1OaR8pfcl5K/XUy+I
 ExtEomDLWTs0WCM5DLEUNgas9YI7h3xcfv6yrWfhTBun1SZ9NERJYkbXX21ghSdpoU8B
 jChlKz7aFqUbp8o8PjH9k2KNNR6l5zOqBKY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sd3jk9v05-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 09:35:04 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 09:35:03 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 09:35:03 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 10 May 2019 09:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koHLi4Whg7vDzZMwb7bTdUS/tSLQuVMX3l0dDvaGo20=;
 b=YEpQC96OZ1502FHPEVRK3FASgDRfkm3RjLxCczSx3rZSy9Bg8sMWoGvmwtm5KiA7YRfG670VKXQ9JdAQbEdAIB7OpqAhtb2brjnYk6584Sj8TtF49dEcY3lwHlziv7x7OQNSUwBn8K2LF2lcV2sezvKJdj0qBzHrjYyTJngyxqg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1933.namprd15.prod.outlook.com (10.174.100.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 16:35:02 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.016; Fri, 10 May 2019
 16:35:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Xiao Ni <xni@redhat.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "heinzm@redhat.com" <heinzm@redhat.com>,
        "ncroxon@redhat.com" <ncroxon@redhat.com>
Subject: Re: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
 r5l_flush_stripe_to_journal
Thread-Topic: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
 r5l_flush_stripe_to_journal
Thread-Index: AQHVBwRjvd/SXYsqzE21nQqCcjj/RqZkjpeA
Date:   Fri, 10 May 2019 16:35:02 +0000
Message-ID: <FF9BB066-7ED5-4066-B202-D64CFA065ABC@fb.com>
References: <1557474339-18962-1-git-send-email-xni@redhat.com>
In-Reply-To: <1557474339-18962-1-git-send-email-xni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:d26d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1266c44-fa61-490b-7fe1-08d6d565737e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1933;
x-ms-traffictypediagnostic: MWHPR15MB1933:
x-microsoft-antispam-prvs: <MWHPR15MB1933036F3AB5044AEA86389EB30C0@MWHPR15MB1933.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(8936002)(6436002)(71200400001)(53936002)(76116006)(73956011)(46003)(316002)(6116002)(36756003)(66556008)(64756008)(66446008)(33656002)(66946007)(6916009)(6486002)(66476007)(2906002)(83716004)(54906003)(186003)(476003)(446003)(11346002)(68736007)(2616005)(57306001)(6512007)(486006)(14454004)(99286004)(71190400001)(86362001)(76176011)(50226002)(81166006)(81156014)(8676002)(6246003)(478600001)(14444005)(305945005)(25786009)(229853002)(256004)(5660300002)(6506007)(102836004)(4326008)(53546011)(7736002)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1933;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JgSfhPkBaet7lxGDfW8UejWb87zFVlCmSyUQhJ5fDZYZBqzvTuqjLe1pBpCU/2wR+51gyEaMU3jUHrl+mKO1ZPqxCuS0pEkgOTnAOONz58jeN93OUKxAtlsJUxTVxuiZNA3ux0Qi0ymP6CJNWMmR0zQCG3XaZ4PMAp87RR8SJRbGxy7oPg9ed30POANO9mrBM9RzdShD0QR0s/VnluUgqKh00lsfJLzGxmpw82oZq6ElqeyO8YyRAVfX7QU06NLyap4N3+zvFHdk8jrpZaN8m1WAlRyocCWLOC8McXf19eIyu0WTq/iSO16e3cC8kQh09Ua5CFAAlaowEmMj5sGMY+rEQlXdFd9OwmVFLl+sey222AyIIQi9wbDaov/ItMBPgT6PWsgOLWczkIMGJdAKsiCqrcSg0K4GPhr8rqsMKmY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A695753BF311CF4CA64601D8ACBCF4E1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1266c44-fa61-490b-7fe1-08d6d565737e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 16:35:02.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On May 10, 2019, at 12:45 AM, Xiao Ni <xni@redhat.com> wrote:
>=20
> When journal device supports volatile write cache, it needs to flush to m=
ake sure data is settled
> down in journal device. It's the usage of function r5l_flush_stripe_to_ra=
id. The data is flushed
> from stripe cache to journal device. Rename the function name to make it =
more proper.

I think current name is more accurate. It is actually the beginning of writ=
ing data to raid
disks. While it does flush the journal device, it also calls r5l_log_flush_=
endio(), which=20
kicks off the write to raid disks.=20

Does this make sense?

Thanks,
Song=20

>=20
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
> drivers/md/raid5-cache.c | 2 +-
> drivers/md/raid5.c       | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index cbbe6b6..689a59e 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -1294,7 +1294,7 @@ static void r5l_log_flush_endio(struct bio *bio)
>  * only write stripes of an io_unit to raid disks till the io_unit is the=
 first
>  * one whose data/parity is in log.
>  */
> -void r5l_flush_stripe_to_raid(struct r5l_log *log)
> +void r5l_flush_stripe_to_journal(struct r5l_log *log)
> {
> 	bool do_flush;
>=20
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7fde645..56d9e6e 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6206,7 +6206,7 @@ static int handle_active_stripes(struct r5conf *con=
f, int group,
> 	release_inactive_stripe_list(conf, temp_inactive_list,
> 				     NR_STRIPE_HASH_LOCKS);
>=20
> -	r5l_flush_stripe_to_raid(conf->log);
> +	r5l_flush_stripe_to_journal(conf->log);
> 	if (release_inactive) {
> 		spin_lock_irq(&conf->device_lock);
> 		return 0;
> @@ -6262,7 +6262,7 @@ static void raid5_do_work(struct work_struct *work)
>=20
> 	flush_deferred_bios(conf);
>=20
> -	r5l_flush_stripe_to_raid(conf->log);
> +	r5l_flush_stripe_to_journal(conf->log);
>=20
> 	async_tx_issue_pending_all();
> 	blk_finish_plug(&plug);
> @@ -6349,7 +6349,7 @@ static void raid5d(struct md_thread *thread)
>=20
> 	flush_deferred_bios(conf);
>=20
> -	r5l_flush_stripe_to_raid(conf->log);
> +	r5l_flush_stripe_to_journal(conf->log);
>=20
> 	async_tx_issue_pending_all();
> 	blk_finish_plug(&plug);
> --=20
> 2.7.5
>=20

