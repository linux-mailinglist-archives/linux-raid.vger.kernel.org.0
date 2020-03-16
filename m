Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB9186181
	for <lists+linux-raid@lfdr.de>; Mon, 16 Mar 2020 03:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgCPCSq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 15 Mar 2020 22:18:46 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:44767 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729324AbgCPCSq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 15 Mar 2020 22:18:46 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Mon, 16 Mar 2020 02:17:42 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 16 Mar 2020 02:17:08 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 16 Mar 2020 02:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/tipaX1afTw2GMLTCTyKG7Z5PGEEWU+yZeyA/FyIxj0pCB++VIXb2w4mN1GVXxstMs4aeshA+7Cj6mCd3ix7+iNUpeSAW/lLVVafPJqv+ZhLaQPE7sTuFhwR4IlwOsIGZAo4ZVo5MLMj7aG21EiZrwYZQuT5PkulV/jmCcXj2sJQSM2FRm9gg2zC4j16dFND0UAz9oAKFbKDEBpU5qyZso2PgjT0SsOTPRMNkZTSmKxdcUmgXRfQ/NPEsa2vI/fAfPtjuuK0TyVTNZ5beSU7s4yTOV9WJi8qsrXo6M8/EzF4XDROvH/0ehVFCqKAo3rV/fs77ScSAgzRkluZnzG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hs7slTmk8wPYmeuICCDPPdI8U85h6rFUYWqqFbjHUc=;
 b=kpoc9tmfY1mULq0ZeGlq12Mo5+XcxwdV71BoKmNU2vCvspxG81m4GRkrKD0OsD+DZ/q8y2WKKTIpUHg2wrQwdc2ig8jMt6kVZqSCfo9l8OVLD3Mr3xETGlQ+ktwVYh+rtvA5z0xH34vzl1MoPCpQDZEXNMdmH1S2R1KKf15XbCeczaCc1hTx0lMs9KP7v48LNFcIW+X7ImOGzmtdJs7DfbIQ5zBXlXogBK72e+K2PMwjLnYnRGFdgfCaQOkxN6sDwABIWR5xHRvVP4iIXooBT2Bbj3bBumbD0uux1ZdvYQNAAa/vYTxvzDoAm9ba/BOMb6rzQSGqy/57hUkyuCnH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB2213.namprd18.prod.outlook.com (2603:10b6:4:bb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Mon, 16 Mar 2020 02:17:07 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 02:17:07 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <jes@trained-monkey.org>
CC:     <linux-raid@vger.kernel.org>, <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] Detail: show correct bitmap info for cluster raid device
Date:   Mon, 16 Mar 2020 10:16:49 +0800
Message-ID: <20200316021649.4423-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (112.232.36.53) by HK2PR06CA0024.apcprd06.prod.outlook.com (2603:1096:202:2e::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 02:17:05 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [112.232.36.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5ab3d0c-a948-4eb4-38b8-08d7c9502024
X-MS-TrafficTypeDiagnostic: DM5PR18MB2213:
X-Microsoft-Antispam-PRVS: <DM5PR18MB2213E5010366EB68D22A62AEF8F90@DM5PR18MB2213.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39850400004)(346002)(396003)(366004)(199004)(6512007)(6486002)(6506007)(44832011)(81166006)(81156014)(8676002)(2616005)(186003)(26005)(16526019)(956004)(8936002)(86362001)(316002)(52116002)(66946007)(4744005)(478600001)(2906002)(66556008)(66476007)(6916009)(5660300002)(4326008)(8886007)(6666004)(36756003)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR18MB2213;H:DM5PR18MB2150.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZ7Tv5GZRuMidOsSiC8+4E2Ya9vmoqWCYkdOEpLp62Y+ACvO7xTo87RB8F+D1mMqi6vn5mN6VdD4TjNarB346s/nnNdPDycpDGTIGrhJZWbtz6SPn69xIq1uKpkRo/dIh8KHzUywCxKTAryMfXWxDIAeBZb+2+Q3lO/cCklnE7pofPEeQsFV8qSjmmeeGHmf+eTozOHw8OVtQwIWgBwq8Ne1cwFfRAjlv1Cjkew3EVWZye364aWRNXQSWGX5KE0ManAVf2orfeAlbTcF5y6MJhXOJDNIHC9DFnPQMoLjAeYiqzJopUSDsEryc5qkgkzt1gN4A2+rLnNzd8C5O1XqbrNKp6Ct/4XT1J0SBtMxa0qqspLrAK0B8e7e8tDB2vls8u6bcQFeSHE6w0KYhN5cgjZQWgjFptd+BYK6Ssp5Qzsu5or2Udz0DdYnRu54/DhP
X-MS-Exchange-AntiSpam-MessageData: ORWivxFGNELhZfV7Zq+7AQcUE/XbfQafcX5uTArr1sV4jJQf56GAQPCpl+sO0hxto+UxJ5jpzpxmMyYdq8PpQ4mX+pH2BPldX/t/i4A0lhv+7HisQi9CTFMQPcD+qQxuWGpe60Oza9DynTQvyS9f4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ab3d0c-a948-4eb4-38b8-08d7c9502024
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 02:17:07.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRuRceUUR6xQxJpJdnt5mFoZUAoW+lcEv9qhMKRZrdfyYJpAMFoJEndpfZeWZql3k40BEUfxhxfGUONIaTxbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2213
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
index 832485f..daec4f1 100644
--- a/Detail.c
+++ b/Detail.c
@@ -468,7 +468,9 @@ int Detail(char *dev, struct context *c)
 		if (ioctl(fd, GET_BITMAP_FILE, &bmf) == 0 && bmf.pathname[0]) {
 			printf("     Intent Bitmap : %s\n", bmf.pathname);
 			printf("\n");
-		} else if (array.state & (1<<MD_SB_BITMAP_PRESENT))
+		} else if (array.state & (1<<MD_SB_CLUSTERED))
+			printf("     Intent Bitmap : Internal(Clustered)\n\n");
+		else if (array.state & (1<<MD_SB_BITMAP_PRESENT))
 			printf("     Intent Bitmap : Internal\n\n");
 		atime = array.utime;
 		if (atime)
-- 
2.16.4

