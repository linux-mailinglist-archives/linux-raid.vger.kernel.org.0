Return-Path: <linux-raid+bounces-1119-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3B872B3D
	for <lists+linux-raid@lfdr.de>; Wed,  6 Mar 2024 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5436B22697
	for <lists+linux-raid@lfdr.de>; Tue,  5 Mar 2024 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2F12D21D;
	Tue,  5 Mar 2024 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VkrfXudA"
X-Original-To: linux-raid@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479412B17E
	for <linux-raid@vger.kernel.org>; Tue,  5 Mar 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682149; cv=fail; b=nRN7W1LZWRRrgSR51w9lBHoCmji40Q3bj+PWbEeT+QbDMZK4i4G+gnKKs63GftL6+Tr8gIf6v6To/xI2kHlH7xcniTpFrCuB0eDEuF3/T9jFIyd2b9fIVPdOFriljRNXYqAaP1pX9nWvi0mAc0yfUmBHhSe6JbJfrXv1+dnneWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682149; c=relaxed/simple;
	bh=+4bIOESwqUiKo71UrHCjOYI9mN4n842sm9W7E8BKfUQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cu5REo02/FquWXnvD0UVX03cY2A2ryvv4ZR7NGl4WYRGLQkTsMV0g068M6oDlI12/Glmv5gsTWYw+tkIy+zDA4E7IMeRGfi7xLEYi61hFUo2mplPVaV4oHOi0h89aMSU/WIops6vJKYnbZSHVMEC6NrA7Ad5Y2OiFiyKFI9Brbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VkrfXudA; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425KJdTn017225
	for <linux-raid@vger.kernel.org>; Tue, 5 Mar 2024 15:42:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=IZT+AcdsR7G/ZHsMYOq4imNwml6XoHvQJAMtYBUz+CY=;
 b=VkrfXudAnKmxjiQqN6P/2aI7gA32ztZirhdEo1LkX/AkrpToxc6VdxtiHVUk0Gp+eEqv
 dTq4i6tUH2WF/wONgxCJTB2q5ruX2qCaowUYMQzgyMu2EbTSxjknJvsHRptgAEuP2544
 x+xA1ACzJXxX4kH+tKggB+ZnL9wyrfJQmH46AsuOj5HhDoZFSUtHOQx9c9kVkpamzLOP
 Q1NvnM0DyoyvwQ4ybmiZKdE+7nPmFx9VlmEdTo4hjLkBBAgxV8xZZW2390ozjFuJShKP
 XP0d2JXmwhxMXcr7hu4rdq8wLYVAMdiyPvv5XlBKXURybAh8RDdDTpaghqzGsOavwYVT bg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wndeuuwpv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-raid@vger.kernel.org>; Tue, 05 Mar 2024 15:42:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkf8QucW5TZ0fqO74GEMkqk0yWjNrfE5SYNp9ic4QiF6krbhm5QPDoPmg2PAzskr078yj4TGLfgvz+m7Z9cWo6RSUd7lg0LslmpJmzdqc9fzhNRuraoYh8kJoQNSp24Jex6Mjiw0q17Tpg8dVPO3FH7D2yIzjqsVQSq1b5z/cww03VfsZA2JUIom4JEKUAXJoWIQtqYytB/k50jZjA7MfdhV3kyCO87sDqINFwtaCDJqqikLmqrCENMvg706vVmxY8lt6G5Ia09oY47C42Q3uBkxglyiHqaOReoDtHhcwwr4N6wHynLFqweDT3P9wDGuYogFvR+UlZ76L89K7ta3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZT+AcdsR7G/ZHsMYOq4imNwml6XoHvQJAMtYBUz+CY=;
 b=NFXIblx9EZLq0DKlN0W7/enU2eWNz5HZ5jqgVhcy1bkCCjVW+/iLQ+3wtefh+OYS6ROq7nZvctTfQFE0R5yCRb6HdQNwyzI16gblgRfUiAfuRzptvqgN0QzWeHE0mLJyW1AJPyTl7Y9Q4eg8M9om2TYqDIJYRBk1kXVzWWVBp4qkTxlNdK1bcLa85cKeXh8eZxCoAk8rTE/dHZIMFVndIzUo7h/V62sHOOBrcWjmiTKn1SVVWRd1v0sDNMXCkGN9ExiMQbpgcvIedLJi0thD7GcG77xmPVZKx63AXpo0mW3i4t0/wHQk4FdetmpOivb7EOLr3bz0OeLy802R9FG8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ2PR15MB6369.namprd15.prod.outlook.com (2603:10b6:a03:569::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 23:42:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::19:4b77:a9ef:b084]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::19:4b77:a9ef:b084%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 23:42:23 +0000
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
Subject: [GIT PULL] md-6.9 20240305
Thread-Topic: [GIT PULL] md-6.9 20240305
Thread-Index: AQHab1bFkSjYmr1sj0qLpn+ZVB9JDQ==
Date: Tue, 5 Mar 2024 23:42:23 +0000
Message-ID: <1C22EE73-62D9-43B0-B1A2-2D3B95F774AC@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ2PR15MB6369:EE_
x-ms-office365-filtering-correlation-id: 5fb2224e-42fa-4ccb-f810-08dc3d6de84b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 H5S9BD8nzaspToAYA08VmwmrGMn/pB6IPdhupx9vzC1UyabhZFrR/fN/vcInTncF5I8f/3XhRzkwYc3Njq2gPU9g43re6EQ+4mugtZz338uDoE8O6WQnmMVKpBFOhJneAzvfIVQtOhzp9f6QRk0ZrhfQrh3TtjAKqm2YQuN3SZr5gPPD3lAURCdzRLTSp6nneZRn6GWZCatuLxOEPPMc39wyO7uoKyS9C9wfhp65YdkJhg1z6l88WVup0ORtrWbKa77HMqTXvKFRN699WmW/twsfDfV3QHDZX5g3dE3nxkbs1ihAd2Z45GesFaFpWW67WuX6G46s2ypJ6foeGnUJ+n2JV4vw5mcT/n4vubFm+hCWvGc88ffyHNgr6rVXsQYFY4o6QDiTcExJ9dmw++VDCRAO9qZ/6U+dTzckY1BRNnQjRAfOE9kX5y0BF21YBo3P0v7ZQOw0kl4GUTeJ7rgBNpf6M4tbXOTirARV9a77AQ4sZqmt9VzINGzW16nFhAWEIdk6297dKARDeqjHczK0gpyzBUKNfB1pSlwdmLpkzquBr8UrOe/no59bNdzJHAp4SvDyX7QhLpST5FP6s1NviTEiH/BmRXopg6mjsUCjpy5PvtV53SvEm2s37/KiB3MkQN2cokQBU5hlWQFixBGDyLipXauZ72k6vV0jdxhbYmg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SXAe4LFPcmInV78S1MEM0jBhr44PpmKcSbHsahI7bUXSLKvbWn4kLRHhgvmd?=
 =?us-ascii?Q?NrSiTMLRkqVjxszwpeEmNcD3+3n5bESjghYg87IGh+XR2xaI5VJWhPCOzbN+?=
 =?us-ascii?Q?3ZSIGhNoJdrP7S+LCaLoe95ILKHb3Gfaehvr7bLeYroB3/sY/1AAK0mkaNgP?=
 =?us-ascii?Q?pzhrjQ7NsU+aJEzG5q5FiFAqzy+di1SBJKI+nuuJiNNNSoH+GOJUfmw6mLqZ?=
 =?us-ascii?Q?KjxfE2IXAOIbbieEDhie7dr9s4HbSLSan7g7R9edlNu7i1B5BPghFPPstBSx?=
 =?us-ascii?Q?JosdOP1Jlm41yfL7e1Wv87nWrWXu47u9qZbvz+PfLv/iDZ6tFn4Iw5TjoKit?=
 =?us-ascii?Q?aCvbQkKJL3x6m5QnCs6MHwleFGS/9tiJsBUsrNP9POtYxL6OYlnOBNegWbcV?=
 =?us-ascii?Q?fR3fkzDEt5IhZlrGlYO2vhiEV9yYkGHhZNI5ZUGWX3cfHz8B7NsUJpZnqwyn?=
 =?us-ascii?Q?fb7nZ4EaQwed51rbNrnPhbV292daJKkqqvwlC1nU9INGDC9u7zKztVtZ0xUE?=
 =?us-ascii?Q?ufUfqUPxUmtCXNTpoa4GbwdeDw+sYK1s/h6mhtUCVINqA3A4a3L1rr7a/ow0?=
 =?us-ascii?Q?iIDr4KQarHyT52ryVh2HEN3+32L2FwLJ37ylkB+f5d/skw6E9WXHo6JS7k1V?=
 =?us-ascii?Q?14XxBxzcYmT9ss8rly/BZ2q29/CV/1S/TYNSPbP0M9xEt37rIEDnjkZhFVsN?=
 =?us-ascii?Q?f98N1n/2uYEP2yLZhyTMbZLskduypqUWi2e2lom/GrAvgTT7MGIio8ULQu9B?=
 =?us-ascii?Q?5kGQAPrIYrPJOhmgo6JgzTPNkPOAUeV+yajJ1V6od39iuXJF0XlyYSxugo2d?=
 =?us-ascii?Q?RLWU3CUsUC+jjTxFcixL+tA3nl/EjeAaWiBev0BVXp2VOIO2JxKuNNVUQk+0?=
 =?us-ascii?Q?L5EQTrScaVTbROkYr1lzTDkvwheQg1f/vnuNO1ImqxLEfVoQf/JSVaeCkedu?=
 =?us-ascii?Q?9pUeLq1hx5iEiD8MTo9iNeaXYWIH/c+Jjr+eH9WTri3bSPpUnzO7qODetmJ3?=
 =?us-ascii?Q?IAW7haDb+zJi5K5HWojLserrumCu7h8j5SjKoF8rFYVse9iaiDOKJBZj1Gjf?=
 =?us-ascii?Q?T1hC5kIl8ggJ1sXJa1iElDXXVaDqJrddnLQZNw+1OzKzxwEiBOetPWiO1gtP?=
 =?us-ascii?Q?QYG/1Xz2ZPzczISMkc5gwDn+6QMDCmzkwYkhH+bJFIhhszqxwo70tFJXGWyS?=
 =?us-ascii?Q?dFZuSpDTyPiAfkguKnWsEiVlL8EZWtiXv0qVAr+rFWoTacY02xx3W4noQ9nD?=
 =?us-ascii?Q?krKbnWMgBdXPcnxsBJCYnpMf4lUUla72F2HGbW5pPzgrxiyxQpalaVpteSWR?=
 =?us-ascii?Q?39PkitTTqTjlVuDX3AtVdg5Uw1v1OJaYxGR1zPs6+fqN4Hkbieq1aHt3NZYZ?=
 =?us-ascii?Q?bgDSHomh6Sy6edV36cxg98/4JegPRXsjCXvEg2JAfXKpW2GxafXF7YRJCpUU?=
 =?us-ascii?Q?S4cyXU3IIIfRlxRtPL15sXOxL321Nd778TZ8DOAdIECssVkAFHQVB4yPvWqJ?=
 =?us-ascii?Q?8rYffZ0zuDyGmCkuW58Ow0G5DgednJtMduxEGKMf6F5QAM18C+bRaXG8UO0h?=
 =?us-ascii?Q?O8oriR+TtBP05SonhK1SS02OL2WqdGMqCJBey6i3hZpYAe3ykxOPxim9C1/w?=
 =?us-ascii?Q?K3DR6KzhWB6+mUt6SfTYxKE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB2CAFED767DA64981CBB702EE7FB869@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb2224e-42fa-4ccb-f810-08dc3d6de84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 23:42:23.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5qsybWDqTrOvvb4s6dfm1JlLSXE7zHV6f5zWDNbd+x+5ePM7nh7+z+J++nbn+5EoGm+pBk0Y2H9IMrATpuoww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6369
X-Proofpoint-GUID: WMBxhr_vFRXdzlksuqFG9wR2pCz65I3s
X-Proofpoint-ORIG-GUID: WMBxhr_vFRXdzlksuqFG9wR2pCz65I3s
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_18,2024-03-05_01,2023-05-22_02

Hi Jens, 

Please consider pulling the following fixes for md-6.9 on top of your 
for-6.9/block branch. This set fixes two issues:

1. dmraid regression since 6.7 kernels. This issue was initially 
  reported in [1]. This set of fix has been reviewed and tested by
  md and dm folks. 

2. raid5 hang since 6.7 kernel, reported in [2]. We haven't got a 
  better fix for this issue yet. This revert is a workaround. It has
  been applied to 6.7 stable kernels [3], and proved to be affective.
  We will look more into this issue for a better fix. 

Note: Some recent fixes were shipped via the md-6.8 branch, so the 
md-6.9 branch doesn't have all the fixes. I tested that there is no 
conflict between these fixes and those shipped earlier. I run the 
tests with upstream kernel and changes in block tree and md tree 
(v6.8-rc7 + for-6.9/block + md-6.9).

Thanks,
Song


[1] https://lore.kernel.org/linux-raid/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com/
[2] https://lore.kernel.org/linux-raid/20240123005700.9302-1-dan@danm.net/
[3] 87165c64fe1a in linux-6.7.y branch. 


The following changes since commit 268283244c0f018dec8bf4a9c69ce50684561f46:

  nbd: use the atomic queue limits API in nbd_set_size (2024-03-01 09:08:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git tags/md-6.9-20240305

for you to fetch changes up to 3a889fdce7e8927a7d81d11ca3d26608b3be1c31:

  Merge branch 'dmraid-fix-6.9' into md-6.9 (2024-03-05 12:53:55 -0800)

----------------------------------------------------------------
Song Liu (2):
      Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""
      Merge branch 'dmraid-fix-6.9' into md-6.9

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


