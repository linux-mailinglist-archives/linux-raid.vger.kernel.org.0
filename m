Return-Path: <linux-raid+bounces-1115-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD78726E1
	for <lists+linux-raid@lfdr.de>; Tue,  5 Mar 2024 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BBB28631
	for <lists+linux-raid@lfdr.de>; Tue,  5 Mar 2024 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D8A24215;
	Tue,  5 Mar 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U2KPVU35"
X-Original-To: linux-raid@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A818639
	for <linux-raid@vger.kernel.org>; Tue,  5 Mar 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664444; cv=fail; b=PLyGVfCZNmwbpZHK66cSXLzH2+IIhTTY717ReI6FVAAQR6iHCZnK6FIV0qXrLVZEU39lYHsu64sDFStYoekBeRpkeD/Gw9nz5aW04qwwFgqN1WGpEGaNQ2vuGDJbxdVaGg02vqGYQObaSrOXakLx9Fhomut923xlSMiM5DHrGyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664444; c=relaxed/simple;
	bh=gL66Cwr6m2DbkG2fwtts51UZOUJeYe1dijfhSs9mitE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AtraP8Wj3lwBcBn6lpXpMNfHVcC/JEd2TH8RNHJNNlquDVidKnnSL7cOIPsfdh80peP2KwgMaE9uHRP+J+0NSsdyEvbZ3A14EQVQSMxK6aQbvhdYmRGdHZrvWqmaVMDYB7zF05I7pBTD/iD4PTEJXxkosmUJtMQF3fwyO2J5qOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U2KPVU35; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425Ek8aB007345
	for <linux-raid@vger.kernel.org>; Tue, 5 Mar 2024 10:47:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=cF2bT9KRPB9JcgCt56Pg82wwb5AAAEUGl0b4zQRAJoQ=;
 b=U2KPVU3529sS56pw0MhvGxehKzYlWn9G8DYshMAMtJkAaIvMFo7grKx2Jc2bp3aaog0T
 LFZrpvaB2QVMCdftYAUr/p7xDYlSjhXDqzcGCVn8rcl2RUTbOWljQfp8ZdlPFaqjjXtt
 3k8ADgC0GQ35qJVhY03BhW2nGz+U/s+r1gbByriB7FD627TMHxGRF8yjTyPaJrWltxfF
 ro+OWeaM5Madcx8qwlgElCWEL/wibQDdTZOjrqEBkfJ9QlTxrgqLjQW2x3v6ZbIWHJRQ
 WoRXNidKXxkLvFhSiHUxBXLhUaneRgBom8ehd3hrpiW/GvkMUXTODSljsWNLVkfcdpgZ SA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wp39strsu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-raid@vger.kernel.org>; Tue, 05 Mar 2024 10:47:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVlTJ1KHfvTD4X6b9QOzxMOWh4HvTA9VCRz6bC3vsl8XJsTvnPhcUc2LQxp99TbA5vzGD8G0oNLLKkvYsYetp8LaWTiyRW/X2F40BtINHDYoa/jB+kL/vPYEhFASta8T92tz1RXgv9Ccl1HecumaG5vLtSpk5eYm9bSARTWeIqxjdoN2WXhuTqGg9N3dzRJjsx+AaU2xs00TVbbOGvk0q+ta9yiPdbiTwueAp9ak0QkwjKbNc1gVYNpiSJiEAY/+7remQN3AowGKGNb+aOkdyffEluYWAkX2w9b+X5ltCFRkR3QluklMbzKd9OLPr7Ot8NQBdin5iYaYoWBToJmx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF2bT9KRPB9JcgCt56Pg82wwb5AAAEUGl0b4zQRAJoQ=;
 b=PRsP4ONBrSDMsDJCDhKWxQwyWl9ddYIYDKC15cetGRlpjwjE2lIPlXYFGKv2nIHuXheDt9gji9kTRyiGJJ44MYut7MZaDiggQ/SwWg4bfN/ayP0t3tjxHA5C+38B7gD9Ep6y45FQA3M8FX9TJzkEr9iautllukKevnBkFFvo6UpgJjHVimCDMvDRvQ01wyL1o0HmE1f4nWPAM7Y1ygak7NEN7yLOiPihyqPHMmhr8ef7s7XADAzFH39n+5Nx4x2FGtzYKm9SfZYcil/sct/7W7mJV0MtXT1mef29NqZhsgLVvSXdXyk6Z3Hj9uCv9A6qcJ+Xg2QrmBJU9mBn5owy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4848.namprd15.prod.outlook.com (2603:10b6:510:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 18:47:17 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::19:4b77:a9ef:b084]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::19:4b77:a9ef:b084%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 18:47:17 +0000
From: Song Liu <songliubraving@meta.com>
To: Jens Axboe <axboe@kernel.dk>, linux-raid <linux-raid@vger.kernel.org>,
        "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>
CC: Xiao Ni <xni@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Yu Kuai
	<yukuai3@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        Benjamin Marzinski
	<bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>, Dan Moulding <dan@danm.net>,
        Song Liu
	<song@kernel.org>
Subject: [GIT PULL] md-6.8 20240305
Thread-Topic: [GIT PULL] md-6.8 20240305
Thread-Index: AQHaby2Lum38A0FMT0WbjN6BJD4u3Q==
Date: Tue, 5 Mar 2024 18:47:17 +0000
Message-ID: <2FCF4E06-B33B-44A8-95D7-8BA481313BB8@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4848:EE_
x-ms-office365-filtering-correlation-id: 05a555e7-885e-4a88-cd1d-08dc3d44ae47
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GxQPtMkxTsZRf7yfWiDJYvmXTtY8cZiB0a7f5pG1jfUhAhl8SmajHr+HM3c/YRHmLzB/RLjBDyZQTVuGNw5v338O4Q4/H6T6WbsfNxdkOt/Ijt9GOvu/dKp6Ltl6ZtLrEmRrZmMbjB5jauFEGpKx0chLwKoZcqtRSrn96g8lY7zALRg59cH7Qj04CPMT5jTUDNcXPdlF/lpKxM7+wtLDoQboORb3PP+WkH9g9Y09JHD35nKqjr+UJMELkoqgN842y+Dt8ACfVR1WmoLja1PZXuc35WznO57aF99KDfIcGvlXThzwc8+S6+xZl5MiX1GnrSt4IVCaRc78NOs/vemBGmsmzNHdiUsCjrFBsSSsUvAAbXtM8iKAUv7y6pP521Egw56RPsuaim42u82Gm+ttUh1TQHtV0o3ixSvUExPtMA3Q/K84xdr2mAEHgR+gHuCUIvYDcyhosKY+kxQ9It8UsryffHcoH1iu8vAaApWJM94cysd8An4rQpSJpkmZk9JPEvOjH+/9WRs3GPMxiMHfgvaNLabqeCEUvfopJfpJijJ8VSC+joJuFT6XFFtMXu0FnizW8l3lMJGtmPF6QM5W4o1RuQT6ZJkeR/phqcWWsx34TbP24YckrezkhOm/ic75jEpHsgx3lO0WnbqEN4jdrtZhCVVfRQB2jSZRiZjzOOM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Gj6cbqn85rZkYHA7XG2NaYOiyJPokTquTu/Y5xdzfgUuaW3n4EF+eX5j0r3N?=
 =?us-ascii?Q?VkOjmA11iK3i5nlmug8ZE1gKU+xZgw0pcnYwA1+QING0b1aoac4r4zfvt+pg?=
 =?us-ascii?Q?TFDyzIyAbeVTfUxMyq6yufPYQHS06vQXPPPicOJtuclE0+8gf8BdD2ORgJ6u?=
 =?us-ascii?Q?Fjiqw1E0eVVzjFnkA7VchOqnkV2cK3FJR6GCuxxI5SNfchjqkq/dNIRUr2MF?=
 =?us-ascii?Q?YytoeOHTdtp6FR7DLh9SKz9sITS7ULdCB2U8DppIpeY98acfGLpTehbETvgi?=
 =?us-ascii?Q?MZ2r35qAZr1+8p9aY27BuIywFf1YNYJ7LzPF8vfmRUqAUkaDDEgovyG+hx+A?=
 =?us-ascii?Q?BXGaZ6s0jj83J57DiT3hu1zPtzRQYiVy1BQAShpDwOPZF/jP9cCknZshsWvh?=
 =?us-ascii?Q?azMVLPRKZsQkEisL1WjBjSNsfWxgZkOQ4j4wDLvlB77c/+LQv/ydclJApBKY?=
 =?us-ascii?Q?CjWxXaXyVqXYl9wXEXxCkum72BUsd1p5vK8X+LAxRoJgjfwCZdleuoIVJ6yI?=
 =?us-ascii?Q?03xGnE7xfzZCEWMuv0D8NuUwBK+K5Ylp959jthIJoDej9Ttu/rQ66zgcTNPF?=
 =?us-ascii?Q?Jck/xJIfJmEgrcutFI8shDtXqPKToHcOQMYrC6Y1jqTJRFRTRBfeSozyQAwR?=
 =?us-ascii?Q?Yb2MhPLckl54YtcJUAPK2Q88tEAvuV0PoA2DOfpRPvCPeelS1I4ecnRt9Ojb?=
 =?us-ascii?Q?2XJHKqe13VwuTbsRQ6AWRCBkMzdAUTuIryQ60gZt9HB/KrqK1zzeZuwqqpRW?=
 =?us-ascii?Q?TO9zynRXt9WaNtGpvBf+2FxV9SQt1+XBptHP44I+p6uJvpsJ4qm/VbgkcBH4?=
 =?us-ascii?Q?SpBJhSTS2LniYpULgOuzyw0nLniuMlJbMf4/Nd1icVpPMY4Ztx4HlgGfyZWs?=
 =?us-ascii?Q?NM9FUAlI8LkVQY5irKVvhChdCVYtKuAbvxweHmk/U/92XzJ+9oycRxZovGez?=
 =?us-ascii?Q?o+qha1VyuVjX869CZERrMlbwic+kppTP7ibEivwNHvBa1Qkg31Ts5TLXHt5A?=
 =?us-ascii?Q?Td2E0xS8fxCDak9vWMRG4BHXcZfGR1D5uS4rOCF8hMN25zxAgw0qNkGYercJ?=
 =?us-ascii?Q?zl9fppoYtq4txxm5yoEtvWVFo1rFFxmv63ClL3AJdeaNUneYo+qvEkTm7VrI?=
 =?us-ascii?Q?SX6VYQt0PNBG1a3urS+hFf0bzmE7NrG2lwax7/4lADkpw3CYlniXK6fHc+Pj?=
 =?us-ascii?Q?ltG93jhRLHJKJ47FOyquEiO/j7evrC3Z7Auoz6k7+LvmTUXRKZdNePxHSQRm?=
 =?us-ascii?Q?Wnsl6PkgJxu5iLTKP8y3EYF/OaGL/lah55W1zFzhbyRk01RfWAyPAfS/D63K?=
 =?us-ascii?Q?Gck6MQm4x62lqyudmhfVb5DSCJ5UKqMyymlb4wSbaygKRTdEwRYeRtS/mXke?=
 =?us-ascii?Q?vD+pznQ+M0wjpLX6xGHJVTsj8NUAPNmF0JiooPE6JkeWa+WzBJ88jMG5nnHP?=
 =?us-ascii?Q?2qKKvTKQzigIDxDXjYBmpvIhFE1gw5t8whHfEC5sWch7l5ITwwIKKR5gBWww?=
 =?us-ascii?Q?CwZF4EeuJnZ7BqDljQ2iVVQt/gJgn5Q+Br8wbR3p5PFi7g+6Fz1clUBDbvod?=
 =?us-ascii?Q?+bIH30xOskuAEKxqDhkcSrpthLuSq3BuwHn/65XGLBx8nBQkRIc6hb5jbM/e?=
 =?us-ascii?Q?fw+TVhto+DbrBBHKzO47VNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECF41CA86696C34083C72C11BE33178E@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a555e7-885e-4a88-cd1d-08dc3d44ae47
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 18:47:17.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gy3EEG5UMzNL/FiebLrwsUXGzrdR0KXOxO+FxSzRqSDG2Wzzqrs4WJdSq7yRLyWTQtYoBwLTLK+kvoiWMGwRwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4848
X-Proofpoint-GUID: lrnsQB_uu6k9HJHSe-2CxIcec7AI2EDT
X-Proofpoint-ORIG-GUID: lrnsQB_uu6k9HJHSe-2CxIcec7AI2EDT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_16,2024-03-05_01,2023-05-22_02

Hi Jens, 

Please consider pulling the following fixes for md-6.8 on top of your 
block-6.8 branch. This set fixes two issues:

1. dmraid regression since 6.7 kernels. This issue was initially 
   reported in [1]. This set of fix has been reviewed and tested by
   md and dm folks. 

2. raid5 hang since 6.7 kernel, reported in [2]. We haven't got a 
   better fix for this issue yet. This revert is a workaround. It has
   been applied to 6.7 stable kernels [3], and proved to be affective.
   We will look more into this issue for a better fix. 

We understand this is really last minute for the 6.8 release. But based 
on the data we have, these changes are safe and fix issues in the 6.8 
kernel. 

Thanks,
Song


[1] https://lore.kernel.org/linux-raid/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com/
[2] https://lore.kernel.org/linux-raid/20240123005700.9302-1-dan@danm.net/
[3] 87165c64fe1a in linux-6.7.y branch. 



The following changes since commit 9e46c70e829bddc24e04f963471e9983a11598b7:

  md: Don't suspend the array for interrupted reshape (2024-02-15 14:17:27 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git tags/md-6.8-20240305

for you to fetch changes up to c98ebd219303a265cf735f77d70b2f80302dc6d6:

  Merge branch 'dmraid-fix' into md-6.8 (2024-03-05 10:13:09 -0800)

----------------------------------------------------------------
Song Liu (2):
      Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""
      Merge branch 'dmraid-fix' into md-6.8

Yu Kuai (9):
      md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
      md: export helpers to stop sync_thread
      md: export helper md_is_rdwr()
      md: add a new helper reshape_interrupted()
      dm-raid: really frozen sync_thread during suspend
      md/dm-raid: don't call md_reap_sync_thread() directly
      dm-raid: add a new helper prepare_suspend() in md_personality
      dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

 drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 drivers/md/md.c      | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 drivers/md/md.h      | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/md/raid5.c   | 44 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 208 insertions(+), 40 deletions(-)


