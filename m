Return-Path: <linux-raid+bounces-312-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0382916C
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jan 2024 01:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E8B28308C
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jan 2024 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09AD634;
	Wed, 10 Jan 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VuBroZRI"
X-Original-To: linux-raid@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A78C1A
	for <linux-raid@vger.kernel.org>; Wed, 10 Jan 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409MV0DT006917
	for <linux-raid@vger.kernel.org>; Tue, 9 Jan 2024 16:29:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=qZLeQzncOFMa1/SMAkP6/YuJTiQtpNJyLovnTQhtbXY=;
 b=VuBroZRInYCRv4u0k8xNeV40P7H+3UUhXjX1iCqgoofyduf+FSdG6XyMWcIEG8HXfYiC
 x0li20DedbIJtzihQx4QivyFJ1gGJ245rZd9EI+SgKFpJH7WtGZCM4nKE0o4Wpcf9aF/
 dFDyiaXX14sG13V0n/CnSX3ZzDStybDl5xikkUWj026u1Is4gW/IWnOJrp9iSwtHzuaG
 az+47ifOo1VIclHwb94fFY77oMjFCO2aBaAVU4sNm6d3PSgtoQ8G6o8/3UnOMEbPIdyN
 Q5aHZECIfl94yy0KmtYVFvgezLiAtDs1wrIOQHGIl3mk8wmDWyj4jfqXwKB7L7g5lw8w 2A== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vhcmqhudc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-raid@vger.kernel.org>; Tue, 09 Jan 2024 16:29:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeZRsXdUhY6m6VX+OBXyJopGHD5Bj65kE3+n2ClWzX7XSMND3aKaRIxinQhlBJmRB25FS01sE+N+rYaJ3WGzA3rJO1seWVmo4bI4ZUQBD8yCZEMDbS1DzLISknE570xFG3ljmLZ9e7K4RMzVjIda+g4NDpxYIYQUrhX0H74MBUKPhcksDH25lGHPwReI5m9tZI/22fNnboTvDZGzq1uESLHd8Jvo+oyLzS/r9WnI7Tg9uN8MCNFOtVMNxkw8XG59JDPFrR6z7c4iswSmyRFa3d4B5wf79jknz9ZbftUcIQtyCkWCW6UcSKOnrOQxQp4sOCdlXOnm0cFYzZvH0F+ijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZLeQzncOFMa1/SMAkP6/YuJTiQtpNJyLovnTQhtbXY=;
 b=b5ZOAm8Gb0SHSDMk31+5bs08dXL3eHinIEsrKPWddZRSR/R12WUwMv4jk8l/TFVnhbe9t4k5pqUq6IYu6EEWoL9em801oYB00JdLd5SUBlVCLqI9xhvb05ZQTfW/g2WGvy96hSfcZXi4dx+Lf+zbUhK/f6L5vjo6/9jzYRqZMEgzzwgHt004y0w2HaHHMcUbtv8L6CchSPxv1OkfRDtHDq6UAawvBiDlIbOguG05eydVxbnKgv8RAsDzJ+hE0bweZWHNrQH7QDJ6DE5zF7o3WKWU2WoZX4myj7i/9zJ8hd3tSg7d2Ql2KRkkwUGNJabVsZbhS7BoYcucIbDJj4khEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4756.namprd15.prod.outlook.com (2603:10b6:806:19f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:29:33 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378%6]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 00:29:33 +0000
From: Song Liu <songliubraving@meta.com>
To: Jens Axboe <axboe@kernel.dk>, linux-raid <linux-raid@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
        Yu
 Kuai <yukuai1@huaweicloud.com>
Subject: [GIT PULL] md-6.8 20240109
Thread-Topic: [GIT PULL] md-6.8 20240109
Thread-Index: AQHaQ1wVxFQHkLXOLEqPHuW94kF83A==
Date: Wed, 10 Jan 2024 00:29:33 +0000
Message-ID: <34CC54F8-1887-4DF2-A073-4E815510C3F1@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4756:EE_
x-ms-office365-filtering-correlation-id: 888fa226-1b79-4683-b9b4-08dc11733796
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yxFJiK3gVP9YnKbsCvTHQyup0fEuI407lzLBubhwPxq3WX4uby4AVc9YZPJb0goY+Y/ZTMTC0slyTNdcpq9Zkcyc1VSOv7LSLZkdSzd4gtyimAx4ObiT/v8fewMt+D+LaE8yk0L5Y8M3XPTkgiK2ABafcfOIKJd5t2Z9n2L3tpRIHWgY0EqiQoDR5CRrnfl1p5zRc7fqVvpM0lnYBul8QF/cWtH3s5Ka/pgslZK2SkA8qky+NBXePvyum5YfpyL5llG3MDCwoAHyxq9cX575JvyeIBs23D0F+UVP8S3+fkyFrRw+Ja3cDEyCqiMMETh/2QYHjye12UM0QZgWzBBOC3AxhLDWy2SN6x8Av/w7VzjfUylqB2t7a+zDZO+xSLFO31SrRm1xvPrFezjQt8oBE7lsjZTTnBH0kUFMaIfsAMEmxzWFnMapmbrRfMbbNrBPFHyTW4gxfYHQFQrNJMXgK3ZiQraD9UcpaN4oJcQHlMDrLTezYESFF0NlSBrdtGX0OO0hBBambTtGbLs9jW6l1aaEsH/EfTe4cpiBRXHkMecV/wh56A06qGbV+qB9cYigHiADf/wqkfLK6LAMN4InayvIdkg3DTb5am0eztENgC8ngn8m1Y4I4zKrkN28K0fdm5omLbA8U1AOsP0pfIlWMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(66946007)(91956017)(76116006)(41300700001)(38070700009)(33656002)(86362001)(36756003)(38100700002)(122000001)(9686003)(6512007)(6506007)(966005)(66446008)(64756008)(71200400001)(6486002)(66476007)(66556008)(2906002)(54906003)(110136005)(316002)(478600001)(8676002)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cU5os//ReNq1jHPTNDhsvzaqWnEXNe4VQJ1K4rUnKWOAmjSNiYJw4bs4qkoU?=
 =?us-ascii?Q?a8c7Mrqtqe5KPcDQnjzEuNxiaYtmgVKTAzqHHgy4bBrBD0MRfUqgJvsmoueu?=
 =?us-ascii?Q?7WZdXv3eqjYHCmrYLCZxokGa1xfiDwWS9kioBFPlMCQ1iC1qH/pC2gN4dgtE?=
 =?us-ascii?Q?wJqBOQd7TjPOV9UdnFLnKkXprdsI2ZrGXH/XaFjZz0KDtNQMDnJlCBWuMW+O?=
 =?us-ascii?Q?9qeCI3Yy16uiKcaFA4H9H6BjZx5O3J4N8wOcLXtbSXaifbjXvnBkEXVhP3MG?=
 =?us-ascii?Q?wWUwWjAnvEsy8nrhMXq77KnV0aHTIQLt6Y39T+4nXfXXM6GjYXgAsWxUOBXq?=
 =?us-ascii?Q?Oore4DzGA7ZkPGonPGrTLhHZ0ZlFKHa3G7FA62MO8Mb0U0XnRUojI+y1QSBx?=
 =?us-ascii?Q?vT+IsQE0YMetc1xHLCOOSwrk3xOdXuZM7Anp8/b3r0d9mpQOHa0p+JtFpg+7?=
 =?us-ascii?Q?nVjAPErU347iua/NJ2k0uJk4cs4N1bc7AGursyRfNAbRztiKxRQRbMnD/Akp?=
 =?us-ascii?Q?BjeMprMy5SNgZOa4l7K8fbxOVTlscCTHr3YVt0HNNLr/jz3v9NgUoMU/KmYj?=
 =?us-ascii?Q?FTCBoTPJfQo+jGm3N2jbgosQWRHuEIe5IC+XNwh1GFq6vOOChspkBycr3/PF?=
 =?us-ascii?Q?igkNuQ1/HMS8N6YFuPKfuSbrSVkDlIhrcwFvo7gbP6BL1LAcgrKvHrrw+Nri?=
 =?us-ascii?Q?Q8TeN0vO2iMS6/MLlmH32IzjHdkYosqg6d/la4mxHdhlHB6k9Inw9Jl0vprY?=
 =?us-ascii?Q?iM2+DT5XTWwbhUiz7zZrT4IEe9bcvbwGKbEZaovhsu01zcKpWTSvwX+yuJ1J?=
 =?us-ascii?Q?BS4aMiA8dZ0pE2m1FGzbqXukaeuL0EDRuzD/YRgJt4QOsAYW7GwTKRd/f+sD?=
 =?us-ascii?Q?JAh3dIBrWLI4A3Yiq/RO/IyJj4PD5c/4ADrT5AbT5LF+icZeMJtHhQ3uK9rb?=
 =?us-ascii?Q?qMt0HN2MJDXQ3uJIyIgorvHiudK0n6Jj9rQKOrGIjOHkYZJPz+zKhPnTqZit?=
 =?us-ascii?Q?27TyW097Fp3c8ZH56OnilF0aHJsUF4izc7PvEtMKee4IHb8iXKE/cYi45el+?=
 =?us-ascii?Q?mh0iTT8NAlLfuT4XCu0vtv7dd247m9hhO2XwCL9KuM8sux62S1GcaAiBXKXu?=
 =?us-ascii?Q?2Z1pEKpcIAnMxYf6ZqYNpt6cTRrQmF+5G1stfT8KGautQfyIseU+yJrioxJ1?=
 =?us-ascii?Q?85srhrngUrzHZt8fGD/MalKJ6hjlRoDkHgxSv/93zjomhyjRkFKf8MmrD9pp?=
 =?us-ascii?Q?qbj3j5MU/2Y46XOaWgx35XVoj7NQNRZDyLTgenu7ch/txzIJPfZm8A4yF89Z?=
 =?us-ascii?Q?N9hDxN9qCiRs1XAKc4JAenL2BOAlET4OBY6M7zLRlOTfsgkQURX0I+GEf4yF?=
 =?us-ascii?Q?Q5Tm6RxPtoNo+HC3cEOsQIzSSI/rhCDvmP+qemPnDy6kPHup8Bnm2OjtmLUh?=
 =?us-ascii?Q?IVyAsjNLTgUJY2Pwglmp3itHZbID0TjArDHK2jOEUtOJsrj/sL6UxriViz5Z?=
 =?us-ascii?Q?AjxNcljCPn4vT+/+8OQMX7reconfCn28iJu3i0/E8f95cWyFWwFnW7LkTTEA?=
 =?us-ascii?Q?5940U6BwHIXBK1peAech0ChYg33mJ+vGOSoNDbQioZ9xp0gU1YhAPzudBLuv?=
 =?us-ascii?Q?0xhY5j+eyM1eLUKMDN+ENCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EC891E5B646614FAF11184194588323@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888fa226-1b79-4683-b9b4-08dc11733796
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 00:29:33.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8U8Ff2s8JvC0LusP00OOIMqkWawonf951cChMuVtyuRn+6jb5SyeYUxleGar+H8MivlfrYTIxgTRNHqHJmBIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4756
X-Proofpoint-GUID: GGPcPLXcmIBSwkeGiR3wqEPkbYlvuI_x
X-Proofpoint-ORIG-GUID: GGPcPLXcmIBSwkeGiR3wqEPkbYlvuI_x
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_12,2024-01-09_02,2023-05-22_02

Hi Jens, 

Please consider pulling the following changes for md-6.8 on top of your
for-6.8/block branch. These changes fixed two issues:

1. Sparse warning since v6.0, by Bart;
2. /proc/mdstat regression since v6.7, by Yu Kuai.

Thanks,
Song

PS: I am updating the branch names in the md tree. Instead of md-next 
and md-fixes, I will use version numbers in the branch name. For 
example, this PR is for 6.8, so the branch is md-6.8.




The following changes since commit 53889bcaf536b3abedeaf104019877cee37dd08b:

  block: make __get_task_ioprio() easier to read (2024-01-08 12:27:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git tags/md-6.8-20240109

for you to fetch changes up to 7dab24554dedd4e6f408af8eb2d25c89997a6a1f:

  md/raid1: Use blk_opf_t for read and write operations (2024-01-09 15:14:01 -0800)

----------------------------------------------------------------
Bart Van Assche (1):
      md/raid1: Use blk_opf_t for read and write operations

Yu Kuai (1):
      md: Fix md_seq_ops() regressions

 drivers/md/md.c    | 40 +++++++++++++++++++++++++++-------------
 drivers/md/raid1.c | 12 ++++++------
 2 files changed, 33 insertions(+), 19 deletions(-)

