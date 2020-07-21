Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA32286B2
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jul 2020 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgGURDd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jul 2020 13:03:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:44414 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730427AbgGURAr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595350822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yIj0wAWrq+Bk4UG8QAB1FG7yj4vzRSztVfTIGhwL4tc=;
        b=ZtJRmSDknNYTS+LL2bhUbXNmSB3C/OIYJGQtEGLUt95yidg9+AnXClBGOZdkxdh3iGmv2S
        F0SDNY6tAT7kYvlAZ7nDGxmtKAhnKE4PPhWVYaxMEV/QTJYpdpVv7Jv9OHFX42rvDDyZwt
        jy26f2s0+1zfu0J+K0fDwINHsxKJNJE=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-glNvx51dM7CMUNqSMLX1tA-1;
 Tue, 21 Jul 2020 19:00:21 +0200
X-MC-Unique: glNvx51dM7CMUNqSMLX1tA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUEYNxM0PvJcowqQ0dAdor0qGJoFnKbOGMOPqtZB1jtABVRyS6boYkXKRFS0YPfwTk3UXIlrsw2O3oFRWIsmdJvwBQF7xNGEQuD4vWmv897sZIuiSOplPsHWP2Fg4wUyBb0xhGq0+6jAujusSMwx/TWsv7ByF8u9ZpWRoeJQwDzr+nGuxNzMhRtEv7poP36FVBUAa6U03VS4IpM/pSpCetjqGSDmc2bac3qy59o8T9IiXxsM99x7PXj5HuroHd0FPfe3SiNryctGm1grzyTI8aRslwb1d0q5cWg98/tdYq/oO7FBI58/PHaYAZgVF9LcxWGHsurJQjgw4SD8jX5lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwigoXKVs/CBKwtdRzW3aA702qXf5W3Z78kFMIKV5As=;
 b=A1shVjiBHKsckmt7ZmbPkZgXymoI1pIldYzLcCKjLYSSYd+NPxbDiPvZTj06hVEAcUMo5AxJtVaD8Rhp1f0JKeQBXixxAHjzl841SWQDeQEmZKAdUOFAd34y0GC3+G13xM7JvHV4e+XgeIQq4/tAqq2TDReStckemRI/2HlzHF4CzVmyPTPrjOOHkEEBEYp469cnJIIBDkntaJ++qg5d4IvRyI4ZqnveqCotUv7b8d51QI5UMlPcvykV2MZcgiCkUMeDWZ0zHN3o3/2/fxAZKFofBVXJPVm7o1jOwXxq5/S06//ewxNbXqjFBBE31/LwyV5enXN48cs9eJ92k3YIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: trained-monkey.org; dkim=none (message not signed)
 header.d=none;trained-monkey.org; dmarc=none action=none
 header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Tue, 21 Jul 2020 17:00:18 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 17:00:18 +0000
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Subject: mdadm: Does "mdadm --grow -n" need to do racing protecting in some
 conditions
To:     linux-raid <linux-raid@vger.kernel.org>
CC:     NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        jes@trained-monkey.org
Message-ID: <b28b91be-0663-d71f-9e10-9469d411a7fd@suse.com>
Date:   Wed, 22 Jul 2020 01:00:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR0401CA0019.apcprd04.prod.outlook.com (2603:1096:202:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 17:00:16 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a3f6d9-453a-467d-127e-08d82d978be0
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2438:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2438355101575353976071D497780@DB6PR0401MB2438.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /f6zIk0AGvM7DnQxntBuGslOgd9vMoDW0sjUX7WQHMkj1uS+qFbNnss9SXqEWKiIjrSvoDzkl5YihHx1jUCp9PHC9f1R5PbOO68O0KM30kS1gn1FJvup7q+O6qur78wJ1OE4wFyNCzRmbyvD65H6Vz/TdO031xcMf/ix1NdC+SUNjN3LGtnfaIJlLIGbHb+nrRXD/dK2sgmDRNpPr+VqasasiFPaXvO/XdU/djAJFLSqVRR0ndZynBrUYSgonEGVEyX8Ko08pQXN/sG+aefE1gdy55veb2/JldvarnYGu4kfxNj+6UyIGKgzv/hQJHQw3CqmWGoKiA9HYuxiPK26/UfxT1J4kAxh1DpBVkNJtChgdRULkkoAOAL/2OIGqQ7zmsI45QLoF2k+nJAUvpEtkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(5660300002)(186003)(31696002)(66556008)(4326008)(66476007)(66946007)(52116002)(2906002)(316002)(6512007)(16526019)(2616005)(8676002)(31686004)(956004)(6486002)(54906003)(83380400001)(6506007)(8936002)(26005)(8886007)(6666004)(86362001)(478600001)(36756003)(6916009)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: U5S6pxpkXbcKmY4EXhAwpPR5fX5zAW1k6jRC8LgCaK36BoMYoprRFUYbiLIIFo2UTstPlfCa5YfoUTvDAdcMLXwiinLI3O+26x4INw1shl0+lTO0pXhYvI+qZqcwSEEb0/L0JLeVuoH9K2685/kQAQ5Z6MmGAjp7AGvnzdCe/Ev2Y7hKicEtJkdAv8p+RnMisnQY9HLPj58fXgexGL+U8778K+bgq4haKdmllbxK6aiVlMjr63chLyvj4No70vSDDWs8QmrjTRNbNFKtCJT0rrEzbPYQvuOYZaY8qgve1pTmbVQV0eOe9Iu2CMEcHM6c6F2EFqMWQ5/NR0jGoqH9/sNwuC3LAA5LKXSluA2CJmLgzbnI1nouaHxL9uzmcR6Mvy5AWZDpIHz72zGfUItOgVahTaBGTpDvoRONRnwEgMoCGG5d+7V7RtG7NuNd4pYq2g0S29Vt6T68KRLgI89LpwRRBl8N0lOaPQbo0jAp9Kw=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a3f6d9-453a-467d-127e-08d82d978be0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 17:00:18.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzF/5UAuMHaDa55r2V6u2WFjFj8dBO4f2C2OajldQvlofys/KBokU3A/O+DcWJI8cdQo0ifujfi3CC3Ml4IGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2438
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello list, Neil & Guoqing,

One of SUSE customer met fs crash when doing cluster-md reshape action.

the key steps is user does twice "mdadm --grow -n X /dev/md0" in a very sho=
t time.
the rootcause is the second --grow cmd stop/destory first --grow reshape ac=
tion.
in kernel side, second --grow will trigger action_store which set_bit MD_RE=
COVERY_INTR & md_reap_sync_thread(). the result is to interrupt undergoing =
reshape action.

These is a workaround to avoid this issue:
- To execute "mdadm --wait /dev/md0" before second --grow command.
  like: mdadm -a /dev/md0 /dev/sdc && mdadm -G -n 3 /dev/md0 && mdadm /dev/=
md0 --fail /dev/sda && mdadm /dev/md0 --remove /dev/sda && mdadm --wait /de=
v/md0 && mdadm -G -n 2 /dev/md0=20

But in most of time, end user very likely forget (or never in mind) to exec=
ute wait action. So I plan to file a patch for mdadm, plan to modify Grow_r=
eshape(), add racing condition check before send reshape cmd to kernel. =20
I want to know, if I create a patch to fix this issue, it makes sense or no=
t?

I summary the reproducible steps:
(all below steps executing in single node)
```
node1 # for i in {a,b,c};do dd if=3D/dev/zero of=3D/dev/sd$i; done
node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/=
sdb --bitmap-chunk=3D1M
node1 # mkfs.xfs /dev/md0 && mount /dev/md0 /root/mnt
node1 # cp mdadm.git.tar /root/mnt/a1 && cp /root/mnt/a1 /root/mnt/a2 && sy=
nc && echo 3 > /proc/sys/vm/drop_caches
node1 # lsblk
NAME   MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
sda      8:0    0  64M  0 disk
=E2=94=94=E2=94=80md0    9:0    0  63M  0 raid1 /root/mnt
sdb      8:16   0  64M  0 disk
=E2=94=94=E2=94=80md0    9:0    0  63M  0 raid1 /root/mnt
sdc      8:32   0  64M  0 disk
/****** wait some time for resyncing between sda & sdb ******/
node1 # mdadm -X /dev/sdb
        Filename : /dev/sdb
           Magic : 6d746962
         Version : 5
            UUID : b5de5efb:3b95a168:9302bf2f:edcecd85
       Chunksize : 1 MB
          Daemon : 5s flush period
      Write Mode : Normal
       Sync Size : 64512 (63.00 MiB 66.06 MB)
   Cluster nodes : 4
    Cluster name : hacluster
       Node Slot : 0
          Events : 20
  Events Cleared : 20
           State : OK
          Bitmap : 63 bits (chunks), 0 dirty (0.0%)
       Node Slot : 1
          Events : 0
  Events Cleared : 0
           State : OK
          Bitmap : 63 bits (chunks), 0 dirty (0.0%)
       Node Slot : 2
          Events : 0
  Events Cleared : 0
           State : OK
          Bitmap : 63 bits (chunks), 0 dirty (0.0%)
       Node Slot : 3
          Events : 0
  Events Cleared : 0
           State : OK
          Bitmap : 63 bits (chunks), 0 dirty (0.0%)
node1 # echo 100 > /proc/sys/dev/raid/speed_limit_min
node1 # echo 200 > /proc/sys/dev/raid/speed_limit_max
node1 # mdadm -a /dev/md0 /dev/sdc && mdadm -G -n 3 /dev/md0 && mdadm /dev/=
md0 --fail /dev/sda && mdadm /dev/md0 --remove /dev/sda && mdadm -G -n 2 /d=
ev/md0
node1 # echo 9000 > /proc/sys/dev/raid/speed_limit_max
node1 # cat /proc/mdstat
Personalities : [raid1]
md0 : active raid1 sdc[2] sdb[1]
      64512 blocks super 1.2 [2/2] [UU]
      bitmap: 1/1 pages [4KB], 1024KB chunk

unused devices: <none>
node1 # mdadm -X /dev/sdc
        Filename : /dev/sdc
           Magic : 6d746962
         Version : 5
            UUID : b5de5efb:3b95a168:9302bf2f:edcecd85
       Chunksize : 1 MB
          Daemon : 5s flush period
      Write Mode : Normal
       Sync Size : 64512 (63.00 MiB 66.06 MB)
   Cluster nodes : 4
    Cluster name : hacluster
       Node Slot : 0
          Events : 34
  Events Cleared : 20
           State : OK
          Bitmap : 63 bits (chunks), 0 dirty (0.0%)
mdadm: invalid bitmap magic 0x0, the bitmap file appears to be corrupted
       Node Slot : 1
          Events : 0
  Events Cleared : 0
           State : OK
          Bitmap : 0 bits (chunks), 0 dirty (0.0%)
```


Thanks
heming

