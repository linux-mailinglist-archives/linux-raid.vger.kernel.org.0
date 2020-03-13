Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B248184344
	for <lists+linux-raid@lfdr.de>; Fri, 13 Mar 2020 10:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCMJHu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Mar 2020 05:07:50 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:58988 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgCMJHu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 13 Mar 2020 05:07:50 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Fri, 13 Mar 2020 09:06:37 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 13 Mar 2020 09:05:39 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 13 Mar 2020 09:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5ZIULHuGwPCF+UnCmmE/70C6IPidPcuSPA3bLL/ANd8yfSeyDZZDwtmcyQAbagMnw7ai0RBPinaLGh+OkRt/qA+eRKSB0NMx3+f24TqesVXjvL1kf+XFr3KK3UhjvLvf2xDmb635yk+vOzv+O4eGtwCb5Nn8NAZwceE9TTPwfIgktqYAj6absrGBBythlrnRJ/YeYdmUNGbCZsTuGAzq7xOvbqC3+d9ME2IfzcyqnwBVtQZv5X88hSAA3X/BhN6oLOA+rrxrMb2cA5HqNIvEW+bo568qimYBCTzLSO2uYCPnRg6SG+IfIPpw5dxnHu9jQT6qXJQ+dpBGzPeaVDTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g6ZYaEy9gH844pghsjeFVd4sVN9MLEpSLmuJ45n65k=;
 b=RSmLAbOBEtQ5WCOiCYqL0hoCu5BLNiZa7hxRPGZcdBdyNpwdznl+Y3Y+f/VtfSmU1MHwRW1Eyt8oS8LiKYaNapgiBdcykJQxnyEzDCQ5Tnde9KKBP9dxTCpAKcShGesap/hTwjPYwFji/ceX6n9jvx+584bKdDRvtndNYvdOjr7lvmg0q/gjh265AtBH+f48dHFefMkIPc6wDoTVULBPZgLUaWLJspV23TGYV3NJpuhAs//0duOVQqlQckDDsgR96vR+9SMkWD99Z1kwWZ4dy5Taj4kYzAsY/J5JnTGxG4yqdueuYs0h4vnx26lgoxv88XNmLa9uNgnrl2yCOwG6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB1306.namprd18.prod.outlook.com (2603:10b6:3:bd::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Fri, 13 Mar 2020 09:05:38 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea%7]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 09:05:38 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <jes@trained-monkey.org>
CC:     <linux-raid@vger.kernel.org>, <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] Detail: show correct bitmap info for cluster raid device
Date:   Fri, 13 Mar 2020 17:05:04 +0800
Message-ID: <20200313090504.13058-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::32) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (112.232.36.53) by LO2P265CA0044.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Fri, 13 Mar 2020 09:05:36 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [112.232.36.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be2a936-fd26-47d7-0c2d-08d7c72db2b7
X-MS-TrafficTypeDiagnostic: DM5PR18MB1306:
X-Microsoft-Antispam-PRVS: <DM5PR18MB13063D2976039500AB872A0CF8FA0@DM5PR18MB1306.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(2906002)(36756003)(26005)(5660300002)(16526019)(6486002)(186003)(8676002)(81156014)(81166006)(316002)(66476007)(66556008)(66946007)(8936002)(6916009)(6666004)(1076003)(956004)(4744005)(4326008)(6506007)(478600001)(86362001)(6512007)(44832011)(52116002)(8886007)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR18MB1306;H:DM5PR18MB2150.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLCAEWWXY3gN0f082O48cFv9W7itdPyjxVr2rAJOpbRQs48ide9myDxoc+w36v77DY98arzrfy5GpEYaPbou4+GMjt2b/IsGQnvavVyM4OTrt7+fB/Htvm+2p6mkpYMQ384ViJ3S/DxgkCdwmnHG+QL/ottRLj/Vk64MeKYMnoIgQgrwEFqfba7TvUqz/pPaxXmn11iDCAVFnq86lN6cqn7tNO+HSBy//0Os8z+bWKawba2BD63KUI3L1+xp76xZO71wv6M++qrjFT1w99ftdHH4uu1uOtpY//FjdzyaC0NWF3IItCALF1AaQtjcq0/4IMF0WhezOn2oVRANkEmuSVmloZRvUg04+wzn3cYxAOXVePT7+yitzug6+xH2XW5ICwCBBepdM0JuuOLB6ORaR7b6zcROOTeX7eX8mjRIDTJP51a4EqvuIUnJB7SeT9fj
X-MS-Exchange-AntiSpam-MessageData: ZKF2CyShCqz/4dVfI8HFn2jFf+qPEiSWRrdXSmGhADpDkvHCxstcHvcAQStzDTPdfnHDfETLSHwodAWWDHuu7aGvyg9oR7Dljw6ibg1GMVWXz0Lfq24xtAozlB4veZd89c790Yx7tFkaOdBty6JRwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2a936-fd26-47d7-0c2d-08d7c72db2b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 09:05:38.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upd775U9lRVVc5+y/w+DrZIl+Ymi6Q8yIi4HouCKtFK2u2MBv9bn4NRVaNtT9n4dkT37zCIxfbXPowI45FMXvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1306
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
---
 Detail.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Detail.c b/Detail.c
index 832485f..39fce29 100644
--- a/Detail.c
+++ b/Detail.c
@@ -468,7 +468,9 @@ int Detail(char *dev, struct context *c)
 		if (ioctl(fd, GET_BITMAP_FILE, &bmf) == 0 && bmf.pathname[0]) {
 			printf("     Intent Bitmap : %s\n", bmf.pathname);
 			printf("\n");
-		} else if (array.state & (1<<MD_SB_BITMAP_PRESENT))
+		} else if (array.state & (1<<MD_SB_CLUSTERED))
+			printf("     Intent Bitmap : Clustered\n\n");
+		else if (array.state & (1<<MD_SB_BITMAP_PRESENT))
 			printf("     Intent Bitmap : Internal\n\n");
 		atime = array.utime;
 		if (atime)
-- 
2.16.4

