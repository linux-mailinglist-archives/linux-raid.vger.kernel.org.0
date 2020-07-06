Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6412F2151F1
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jul 2020 06:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGFEyG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 6 Jul 2020 00:54:06 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32020 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbgGFEyF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jul 2020 00:54:05 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 00:54:04 EDT
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-4try-iWlOMeLRYkZ_kzrSw-1; Mon, 06 Jul 2020 06:47:11 +0200
X-MC-Unique: 4try-iWlOMeLRYkZ_kzrSw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6I6tuuOKFz/wIuDhSB+Kwz/jhSsvFmP6ScxKHEOLKQoz1+SU+UxihEdXuQ3Vj77Dh+Paj2GbQVFq91VN6dIakF6ytpPGhi5jcM+7K8YmNNnB6xLovuTE779UYulK3dCVfCaHMvw2TXn7+yuiIVzzB4mfM1h+BLiAtaUjKLjn+IK6qqVaiTFG0+M0UddG1i3gy5CzuxDVif2HuDRxlbagqUutAo/jkBjOsWG6U3fvV86/FMUzxLdBq3eWfPtjy+fZoYcZ1wyCa4aM1/lvA0XZDf39UGwgMAdc15YhxTVwZvN5UBMXaVaC4CVCLwqkU9lNXkUdUb6gg+vZUBSDJU25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjH47B3bpH2GpVmBowACAsMJOkBxR6rP2q4a0kicTmg=;
 b=VQQyAZgTftHd0nGq9vf8EzGU9m+RjSoHjEskpewm4NCtEgJeHxJqw9g2EbgdtqCH4urB+0gMub8rUZ4K+YLZ5dFQ54DRTeGAcNAwerGPFFEoEiyjy8r3HLdjpUYlPrFfW2o97TFU+UOAXMoCPl601RXU96lcKw4ILHGkaXs5ZjlC5c8Tp7lYsXtkwq4eO1FFWVqmj6LD+NLQ+5kW1jyQt7JWfFE1WWtOTYnQhWLs9uFMZaG0309hkA8Cy5Mw3dmQgMA775fVooOHn+3rERAeC7xYe1EHLnb0bebMKlVDs2F6asgBDxRyq3Oc9MHZluGAKJ94Cz5qPBGS34ACgjUTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24; Mon, 6 Jul 2020 04:47:10 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::e5c2:f444:edb6:3c52]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::e5c2:f444:edb6:3c52%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 04:47:10 +0000
From:   Heming Zhao <heming.zhao@suse.com>
To:     linux-raid <linux-raid@vger.kernel.org>
Subject: commit 480523feae581 may introduce a bug
Thread-Topic: commit 480523feae581 may introduce a bug
Thread-Index: AdZTT/dhR32wX/4ORtGrGpcNREDqyA==
Date:   Mon, 6 Jul 2020 04:47:10 +0000
Message-ID: <DB7PR04MB466640DAB67751FE3375C9C297690@DB7PR04MB4666.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
x-originating-ip: [123.123.128.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7967d8d2-3fbd-4622-6c30-08d82167a4c0
x-ms-traffictypediagnostic: DB8PR04MB7003:
x-microsoft-antispam-prvs: <DB8PR04MB7003114CF5A2DDF6F3F3EBDD97690@DB8PR04MB7003.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwfXs5Mf5ZPED9qHsfSEcbsDvuidW7YynRzhC80Su2LHHvH+xyVigfjQNPomVMFLG/kpMHk8kgIR0dHbUkBoq2bBgXWp2LxXUbmYw/mFT0nUoVgEKOQkuAq8qsviPsDa8/Kw/KnNRyvx6Txo9y5MssIyEJN228NQaCyCzoQPAeNanXxjTuZpVOVDG18SYsdhh+XyHCbx/8atRwl8Z5NIUMzztDjZrDDch300lWeapH6MVMVwmuTOwIlTAQLytalnns0fobCpcKOXhcCJRfpxJ8VL+uaK07ewWAmWUcrY4soGt52V5aZ0oiETASymEWyGIc4UG6DLdP86rlrE+miC4LY1tAEy+R19PupkmVBFu6s6za//pYTPbc+PF2wPu4YF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(346002)(376002)(396003)(83380400001)(71200400001)(186003)(66446008)(52536014)(66946007)(8936002)(6506007)(64756008)(66556008)(66476007)(76116006)(2906002)(55016002)(6916009)(9686003)(44832011)(26005)(5660300002)(86362001)(316002)(478600001)(33656002)(7696005)(8676002)(9126004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4ucVSXzVJIk9TaehkCNsjEV2krKm42YfXMD4z56rXnePqZhqIiVND3gwZ2o0mz/1U4rX8iWsNztulthpOqhs73vle5RiH3GHQSQO1Ft+E6t7hE5wFIwiAj7PuhCnfCXpB4YLG3QUEmm0SwF26wA+6NqWuWl07yGUtF9ytDPuQyKgpJDY5O934d3paxrDySLeaBqfQXZBIDl334FtnRpTU+6aQmNg7XSPY+omr+Pbfgw93LFRSdvnflLI2cPZQwZt+2qTHIJwM9LaF2+HAIWCg3ouQcRccePx5UDA5X0sCZX3JDNF9mTJsLfHMo2qqRsS7e0bbS86c0/unV/Me54xAJIUAZrES2dzx54LFF9aBHfIzJw2n4Mj4eA27XvxY1f05hiZ1ptVeivfuQSbUdIAOcaaDCK+rDlLyAOhCd9DU61c6ib3Z7b2H02yO8Oc1dXxH23f+MTB47PUKUxw4CL1UV8gUHA6gyEHbPiNBcGZBPc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7967d8d2-3fbd-4622-6c30-08d82167a4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 04:47:10.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzIyb4T+nnnUHf+npuUJyJZYHoPn29TWqr+sH0b41gI0u3UpjWm9a2zuyqB8GKyehcmsD/vXmN5LdUpD6O9maQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello list

In cluster-md env, after below steps, "mdadm -D /dev/md0" show state is "active"
```
mdadm -S --scan
mdadm --zero-superblock /dev/sd{a,b}
mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb 
```

```
lp-clustermd1:~ # mdadm -D /dev/md0
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

I am not sure if the active state is special on cluster-md, but before 480523feae581, The state is clean.
the related code in kernel is the value of mddev->in_sync.
with commit 480523feae581, the try_set_sync never true. so in_sync always 0.

I am not familiar with md module code and can't give a good fix for this issue.
Below is my silly solutions, there are 2 ways to fix:
- modify md_allow_write(), let "mddev->safemode = 1" also suite for cluster-md.
  The safemode will change back to 0 in set_in_sync(), and never change to other value later.
or
- in mdadm, add a action like 
   "echo clean > /sys/devices/virtual/block/md0/md/array_state".
  do it after creating a cluster-md dev.

