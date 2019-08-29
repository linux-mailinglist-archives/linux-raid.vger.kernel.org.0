Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F3A1118
	for <lists+linux-raid@lfdr.de>; Thu, 29 Aug 2019 07:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfH2FmY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Aug 2019 01:42:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfH2FmY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 29 Aug 2019 01:42:24 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7T5eHh9016543;
        Wed, 28 Aug 2019 22:42:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MqdhnQX89FPKbkyZTBYxSm+LMMfy28jgMYJhMW8tLfM=;
 b=H8RD18LLjBwheYdgUdUutTIFkvNMLeX+EQCQtChQx1e6nXfgx0VxMAZlv01HsfzaAa6T
 l7tA010wftJzDswgs06S64glcsEO5MCZ4D3Tbs+dDwlvtNgUm4apiCQF1Cet91GyVvJm
 wR7pIrFGHbRQxKTyngjhoBpcSCrYVD8pkOU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2unvnk3615-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Aug 2019 22:42:22 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Aug 2019 22:42:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 22:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/LgWl2YWujPZ1QQQPXEMpq6J0dC4OuZTXoEYN1LHx3puT3IEZFJPm+89FDKU8LrT7XgXesFCRJO8Xfs2tY1DIhB8pgh4Sbzwjnja7LnqZ3ue5IpGspI1q/eBZ73LR34797Io+oElXNL6vVEWmFQfP6F6ho2p1g58TpQygqFCZW3DtZq6+At5qIeqboztYfNmgua6iZci/lLk5S5Ti6VwwK4F0wtzHKjZkEWgTuc5QbM191rcBKCO3fsz/XcD6IWrXH5TUNlTVIgM4qqTPyMJPbnXtAds4n0G0XrnngXkVq6GXKqNaUpYENJ9/iYciGK649yLL4m/CK+LA2nKwfUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqdhnQX89FPKbkyZTBYxSm+LMMfy28jgMYJhMW8tLfM=;
 b=TRzJKTTyJgeDvLlJYPSbq514hAgddWLrNMEKTxeTY8wysvuiGWal1LKvhlVZbqu5gtdDsie/oTuqzvgNNu5PuUdBaFC+Ybi5yvcqYbxHA7byhzpNg2btujzulM/Ki/YYFhmYXWsOK4one2cap0lIfBHosx/0nF05HKjMsS1DFLQZrcnJqMLFH1cG+Ap0MMnrfeGV0/NyiZwiYwRRZfV4IsL/VvSnPSdA8Qm+7YwMwqLVrPLVZxzhg2RQ+G82g3JXjUW0fihtFsaGCyhZY2p5ODc0Gdk9kW8LEh7ByhLWuIAEQjHtMPpH/dw4tBLLat1zloZiDklTkDWNvthQxCt82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqdhnQX89FPKbkyZTBYxSm+LMMfy28jgMYJhMW8tLfM=;
 b=Uh5vOjl+PgF/XYbFAO46dbURZB8PBjgHiKh6Om4qXdSs4cHo6LEUUN6IRaGyqAfJpRGeCplw/7aam4JPy4E9mS3XUl6/8FMM7bWhpE/Zcw8Rvqlic6Go/MD1TjSR0INse+rTRxu8nvmAeN4Qk0fvJTwcR5XKl+OgkEBi4AxRt/c=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1341.namprd15.prod.outlook.com (10.175.3.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 05:42:18 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 05:42:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <jgq516@gmail.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
Thread-Topic: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
Thread-Index: AQHVXXJ5FXpHdA2IaUmgjRFDKVxJWKcRniOA
Date:   Thu, 29 Aug 2019 05:42:18 +0000
Message-ID: <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::6d75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a20702b9-5ba1-4f3f-34c8-08d72c43a7d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1341;
x-ms-traffictypediagnostic: MWHPR15MB1341:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1341FDEF365F66642BD8A403B3A20@MWHPR15MB1341.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(51234002)(8936002)(54906003)(6246003)(6512007)(6436002)(66946007)(76116006)(46003)(53936002)(53546011)(1411001)(66556008)(966005)(6916009)(6506007)(33656002)(57306001)(25786009)(478600001)(229853002)(66446008)(186003)(316002)(446003)(11346002)(64756008)(66476007)(91956017)(6306002)(36756003)(81156014)(305945005)(14444005)(256004)(7736002)(6486002)(14454004)(102836004)(2906002)(71200400001)(486006)(8676002)(81166006)(50226002)(86362001)(71190400001)(76176011)(99286004)(2616005)(476003)(4326008)(5660300002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1341;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Ki0LZKFqvbLFP/yj5Gp84ARvcxkX1T6iPNuZzwOY6eSU5Dz0S5pbC3nNZ6LK27BYW0ShciiTJN0YobC9Aun59QEZacFFPRTJdSRDcMOZ4Mip6wCPe/8JH/L/oziYcmdTaCQ69r8V4J5v6UCrybUPkbcn/wJjP8vDlA4a9g7fcEnR7gkmO6XLY6vSEaR1KyCBGd3t3ZwvWlKJ+ETQjyCa1H+u/W4/uaZQwVvV4vKTm6iksXKolEgVZPHB4GTWGabSjEoyGoU1qJEP3a8y8+xp3pn065cHd+XuVjduk1hGcmTNGNEHMDZ0YMX6p+sCxhEX+nHS058K9wabcV+OanCOP5gpuwGaQpmR5pSbDDCsLVQOHtBsmSbG5F3qIIdVJGPypBm8LKGETzAJ+K8q77u5pFl+ETjsaLdck6pjrJ3LxE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF551B844260BD47A64CB49763D5EEAD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a20702b9-5ba1-4f3f-34c8-08d72c43a7d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 05:42:18.3556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ioyK/wZZc6H3oNUPI5MSAxKSDe/T4lXu+GQmYQfxlmuBaOcmHBOgxoMaenDfjpIW5SGxKdhxRZdM5WeDJDthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_03:2019-08-28,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1908290062
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Aug 28, 2019, at 12:29 AM, Guoqing Jiang <jgq516@gmail.com> wrote:
>=20
> The break_stripe_batch_list function is called by handle_stripe and
> handle_stripe_clean_event (it is also called by handle_stripe), so
> the original caller of break_stripe_batch_list is handle_stripe.
>=20
> Since handle_stripe set STRIPE_ACTIVE flag at the beginning, and it is
> cleared at the end of handle_stripe, which means break_stripe_batch_list
> always triggers the below warning if it is called.
>=20
> [7028915.431770] stripe state: 2001
> [7028915.431815] ------------[ cut here ]------------
> [7028915.431828] WARNING: CPU: 18 PID: 29089 at drivers/md/raid5.c:4614 b=
reak_stripe_batch_list+0x203/0x240 [raid456]
> [...]
> [7028915.431879] CPU: 18 PID: 29089 Comm: kworker/u82:5 Tainted: G       =
    O    4.14.86-1-storage #4.14.86-1.2~deb9
> [7028915.431881] Hardware name: Supermicro SSG-2028R-ACR24L/X10DRH-iT, BI=
OS 3.1 06/18/2018
> [7028915.431888] Workqueue: raid5wq raid5_do_work [raid456]
> [7028915.431890] task: ffff9ab0ef36d7c0 task.stack: ffffb72926f84000
> [7028915.431896] RIP: 0010:break_stripe_batch_list+0x203/0x240 [raid456]
> [7028915.431898] RSP: 0018:ffffb72926f87ba8 EFLAGS: 00010286
> [7028915.431900] RAX: 0000000000000012 RBX: ffff9aaa84a98000 RCX: 0000000=
000000000
> [7028915.431901] RDX: 0000000000000000 RSI: ffff9ab2bfa15458 RDI: ffff9ab=
2bfa15458
> [7028915.431902] RBP: ffff9aaa8fb4e900 R08: 0000000000000001 R09: 0000000=
000002eb4
> [7028915.431903] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff9ab=
1736f1b00
> [7028915.431904] R13: 0000000000000000 R14: ffff9aaa8fb4e900 R15: 0000000=
000000001
> [7028915.431906] FS:  0000000000000000(0000) GS:ffff9ab2bfa00000(0000) kn=
lGS:0000000000000000
> [7028915.431907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [7028915.431908] CR2: 00007ff953b9f5d8 CR3: 0000000bf4009002 CR4: 0000000=
0003606e0
> [7028915.431909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> [7028915.431910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> [7028915.431910] Call Trace:
> [7028915.431923]  handle_stripe+0x8e7/0x2020 [raid456]
> [7028915.431930]  ? __wake_up_common_lock+0x89/0xc0
> [7028915.431935]  handle_active_stripes.isra.58+0x35f/0x560 [raid456]
> [7028915.431939]  raid5_do_work+0xc6/0x1f0 [raid456]
>=20
> But break_stripe_batch_list is called under conditions: too many failed
> devices, write error happened or failure of pdisk/qdisk etc, which means
> the warning is happened rarely. Though I still found the same issue was
> reported in list [1].
>=20
> So let's remove the checking of STRIPE_ACTIVE inside WARN_ONCE.
>=20
> [1]. https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.n=
et_lists_raid_msg62552.html&d=3DDwIBAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR869=
2q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DARYLe8Z4AXE4keb4zF4aJP5fxg0WGULz=
lDh6cblUN64&s=3DTLYHQPA7jhD1nhLxgsZkcx6DZT5NgRf7WtTSH4b3xpY&e=3D=20
>=20
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> drivers/md/raid5.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 88e56ee98976..e3dced8ad1b5 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -4612,8 +4612,7 @@ static void break_stripe_batch_list(struct stripe_h=
ead *head_sh,
>=20
> 		list_del_init(&sh->batch_list);
>=20
> -		WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
> -					  (1 << STRIPE_SYNCING) |
> +		WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
> 					  (1 << STRIPE_REPLACED) |
> 					  (1 << STRIPE_DELAYED) |
> 					  (1 << STRIPE_BIT_DELAY) |

I read the code again, and now I am not sure whether we are fixing the issu=
e.=20
This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTIVE.=
=20
It only runs on other stripes in the batch, which should not have STRIPE_AC=
TIVE.=20

Does this make sense?

Thanks,
Song




