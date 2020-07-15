Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39DC22030C
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 05:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGODsn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 23:48:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:47265 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbgGODsn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jul 2020 23:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594784920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m7g8M3tM4vo6KruSpZuJayd24g8jlhVxyL/XzyODJso=;
        b=DmbWCUB7bEH+JpFMx8U5oW2hZ2vaG0vmdzCb1Jor3HHn7qAIHoKaAo+/Pd00Xfl8Npwfyi
        ytNxYXnPaCQpJstG5h2KEzluGQpz6dwi+hZgBqne7o4ilEaphWhz9toFfY2tnPKQr3fKHZ
        BbLhKQInsiRd4C9a3DS2pFx7IIiieB0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-gYTmV3TNPr-F3IOnQ9f1Sg-1; Wed, 15 Jul 2020 05:48:39 +0200
X-MC-Unique: gYTmV3TNPr-F3IOnQ9f1Sg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1L+4MUZBOaRG7iPAz6V1qvrmfJzgfDA4yx4v/6/5RlgcWbPjZl26pUk3Za82M6hjsI6sVGywifEeR4Vdm9jD2EKoX+vABLPut/45lsU9AwVJSvVB7mYbbMnGDOPCtcSOXDmf3wKJ45XZMRLOe0Kwpnltj7500x62JLmbrMgASjtw8cyzl7lMxOoHfguTlpf6yDTktnxBMm+8/QIG4ZvyKZc/lZbGb6vSnpm04uICS9e+iK03XELcBNbqg+SQuU+3EYsDN2jkjSndSLqyGMQPSLQE/jEBQ067kxeAwpZG51WklDg984+Dve3TDrHZQca55/u0Ewjmq9n+vjNEqf1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7g8M3tM4vo6KruSpZuJayd24g8jlhVxyL/XzyODJso=;
 b=dhKPlAcGDH/hGQwudbcVyyqLAXegRxms8sapBkFiWpI+LaEFoGLhEG6iFk8n6fuDjKlNA+SitOk3twd/EqQM8vspOzksAk3sKhlSHY+TdKo92c5Tf28jYdAuoqLIcEK/uqtqi6KY5NfyACUGmazKjuOewRKgA9pnXSPgXKJqLegYpN9Mmshlx74BNFeKF23xQy3sTMvLNcD9WbfelDek4ZSR3An7orVpSpBcrV5/51ZDTWmoIJErAG0l8AOm7PE3d8MnohWRMasewFMF0OwgE0XGsk32+M/eQP95SUdAEhc2bN9C5SuVgp54t8pG1F+UfiBZD86EbZ6dE+XyXQ9GAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DBBPR04MB6219.eurprd04.prod.outlook.com (2603:10a6:10:cb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Wed, 15 Jul 2020 03:48:36 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 03:48:36 +0000
To:     linux-raid@vger.kernel.org
Cc:     neilb@suse.com, guoqing.jiang@cloud.ionos.com
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Subject: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
Message-ID: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
Date:   Wed, 15 Jul 2020 11:48:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:c8::22) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.9) by HKAPR03CA0017.apcprd03.prod.outlook.com (2603:1096:203:c8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Wed, 15 Jul 2020 03:48:34 +0000
X-Originating-IP: [123.123.128.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f42b1eb-d432-4ac6-a7fc-08d82871f3d4
X-MS-TrafficTypeDiagnostic: DBBPR04MB6219:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB621913CE0E7BD339C9748103977E0@DBBPR04MB6219.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G50M+OkBRG1BgjQ4/w7kCS0Egv6z534aaEu4H+FJwp2R5xInUuyPoZ1D0yaCsszOVMDx80afx5gMnvzR2G8qkIOb01M43Kyi+Mc7Q0MuIvbIi/FXgcBlpb6xL0P39wz/yFADBOm5SaeS8V/HK1suxAB6vzry3ojLO1cike1XcDkenTmcwa18aEFA8r9zXdWF1muq7AiyJNjo05/M0C08sgq+7jENPH9AoCQWTAdrW7yB3H8ffDrrXy/Uozn1zX28u76YGmCI141rgynnlpwVvKD3ooQ9f89b77QpSB/6gwwkl0Zuonv8eOe7ESUGG/JazTPBAO9zAaRiA+SXuxcMesdnnpRdHuh8V7K2RrpzB+B4q0zCaAoDUrhKZ2oImJSpSyIn90kIQPKI1DRbwAyXoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(2906002)(66476007)(6666004)(52116002)(6916009)(86362001)(31696002)(8886007)(66946007)(4326008)(478600001)(186003)(66556008)(26005)(8676002)(8936002)(6512007)(956004)(36756003)(5660300002)(31686004)(2616005)(6506007)(83380400001)(16526019)(316002)(6486002)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uwYyKoFXUOChb1k9bRt3FEKQyNIhXhjpxTTmBocbogKacCbdPyOVW4xpjn5cot/j22P+9eFNU8B7F9i6C+f/zuda83De+FoM/qtWzRHrKHMItU6b7azad3mtrt5IKYQIHiPYrWCVI3fPm4ysMz5siPlaHDyIPtpJRYfri8HWxoxdHigCw9NGHxcc8HNEDntk6fXNB2HpLLXcPLuDuP+I7B1BaGV6Isc4Jm+gfzeCaka1VY0zbtBGw/AAKodKyktB5u5oJOBPWMgCpIz3vaLUMNExyAPlR/2/uIIYsiwugGvtWGKPoadvC5Fq6vaQ/S9qbxSAC54/0Cv3czXNPI+qTlPs4yVTZM1knjjumhT9N/kM5SsrKclyKUPErGY5xLged/IwPigiAxPt5sxNBY9gkxXqxn1U9R2VuJATlBmLHTCX6L5e6rZ2WyXYO4cYKBeGrlintBS53Kd2r+xXgzuWCbZuxU4jNBaYS0cXWjtJFfU=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f42b1eb-d432-4ac6-a7fc-08d82871f3d4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 03:48:36.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ej1shaxF4OqhNZZ4QToI4SiI0WnbArlYRSWDyAI9QAgmLevh2Gy5FJ2UliwFjBmY6bNRtlSt6TfmAcsPalYkYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6219
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello List,


@Neil  @Guoqing,
Would you have time to take a look at this bug?

This mail replaces previous mail: commit 480523feae581 may introduce a bug.
Previous mail has some unclear description, I sort out & resend in this mail.

This bug was reported from a SUSE customer.

In cluster-md env, after below steps, "mdadm -D /dev/md0" shows "State: active" all the time.
```
# mdadm -S --scan
# mdadm --zero-superblock /dev/sd{a,b}
# mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb

# mdadm -D /dev/md0
/dev/md0:
            Version : 1.2
      Creation Time : Mon Jul  6 12:02:23 2020
         Raid Level : raid1
         Array Size : 64512 (63.00 MiB 66.06 MB)
      Used Dev Size : 64512 (63.00 MiB 66.06 MB)
       Raid Devices : 2
      Total Devices : 2
        Persistence : Superblock is persistent

      Intent Bitmap : Internal

        Update Time : Mon Jul  6 12:02:24 2020
              State : active <==== this line
     Active Devices : 2
    Working Devices : 2
     Failed Devices : 0
      Spare Devices : 0

Consistency Policy : bitmap

               Name : lp-clustermd1:0  (local to host lp-clustermd1)
       Cluster Name : hacluster
               UUID : 38ae5052:560c7d36:bb221e15:7437f460
             Events : 18

     Number   Major   Minor   RaidDevice State
        0       8        0        0      active sync   /dev/sda
        1       8       16        1      active sync   /dev/sdb
```

with commit 480523feae581 (author: Neil Brown), the try_set_sync never true, so mddev->in_sync always 0.

the simplest fix is bypass try_set_sync when array is clustered.
```
  void md_check_recovery(struct mddev *mddev)
  {
     ... ...
         if (mddev_is_clustered(mddev)) {
             struct md_rdev *rdev;
             /* kick the device if another node issued a
              * remove disk.
              */
             rdev_for_each(rdev, mddev) {
                 if (test_and_clear_bit(ClusterRemove, &rdev->flags) &&
                         rdev->raid_disk < 0)
                     md_kick_rdev_from_array(rdev);
             }
+           try_set_sync = 1;
         }
     ... ...
  }
```
this fix makes commit 480523feae581 doesn't work when clustered env.
I want to know what impact with above fix.
Or does there have other solution for this issue?


--------
And for mddev->safemode_delay issue

There is also another bug when array change bitmap from internal to clustered.
the /sys/block/mdX/md/safe_mode_delay keep original value after changing bitmap type.
in safe_delay_store(), the code forbids setting mddev->safemode_delay when array is clustered.
So in cluster-md env, the expected safemode_delay value should be 0.

reproduction steps:
```
# mdadm --zero-superblock /dev/sd{b,c,d}
# mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
# cat /sys/block/md0/md/safe_mode_delay
0.204
# mdadm -G /dev/md0 -b none
# mdadm --grow /dev/md0 --bitmap=clustered
# cat /sys/block/md0/md/safe_mode_delay
0.204  <== doesn't change, should ZERO for cluster-md
```

thanks

