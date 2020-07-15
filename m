Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956A221462
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGOSkU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 14:40:20 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:22018 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbgGOSkT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 14:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594838415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqSSdhJ3gu+5TxTF1pGGGdx6W5q2540uyTza5YqTh98=;
        b=ArLVbhM2tC0uN9D6/mYNr6AaWm9172Ir046WYt2SW1G4QjpigUODVWPTSCAfIucLGh6Ive
        CjIvBNrRYSxNCUTUITj9rtyojafzzJPrKOnD5F0DW0eYwCus5m7C97l+3ZZjINbmD0jyXp
        n+YG7ib331p/KohdM+xM3O/sCTt+8dQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-HH90Fg-UPb63DD2kXC-AXA-1; Wed, 15 Jul 2020 20:40:14 +0200
X-MC-Unique: HH90Fg-UPb63DD2kXC-AXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbwZL9TCoIS2Jkx1l2Tr8wCVdmTCfaDlGtyyqfxgpjozRZk5vSRWI/50OArYhLzAYFoqXYGRnp4+LBb0bNzTd8zwkw7cpuULidD6tglSfI5/l3ZDzT/EG5hsejCcQpgZdFrI0x4JZe2PxylE9ytE1E35P9UiJ01zPmm5HwOVjuXLoOmvCmm51F6CN9/LFPVjSrZZXN1s/C0shwQSyOgzZ53VeEjoGLMvs33c2wlziFrl7fdJ9MANObJktI+uVW5dZIsWyjas38jWtYd+KOOEm3RKZ8UWe+KkT37h+qO28b4CNLVZbmLUTRD6QkRT+fll1cCJCzOxFsFrC7jhQNta+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsMOLYO/L19Hit+0X8liyMUc4SfC2Py1LLSTYht9ecE=;
 b=MBzaxteO7F48ZFZjxoJbimPjDl8OeJNBBZsILV8ZfIh/n0a6MXKPZ2QFD5wRc5RTXH3bXh0oP3fVzC8QQp8YyCXjaTGWTuFU15vnobPqKUsg+mu6CU+ssb1z5j3iZJNbQTVSSteyGffPLRfhst6z0H+wlSV9WmB2CZ4nzxY4SUMh7G7Yk9MKu+mgFXP8eu4k6iLNPvOEQiRzJ1QScFi3MqKeQSVXwAu3SagLJ27D4AmH5KkEiS+8jILl8D7y+WDlDk3ixvpg75CB+TYJaIOPx/AuUABF5iQKi25x4t1WJeOt40KnQ/ODYHe/VVapCSU71OTIX+Nvr9TzyDLo5exOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 15 Jul 2020 18:40:11 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 18:40:11 +0000
Subject: Re: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
CC:     neilb@suse.com
References: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
 <91c60c65-11c4-35e7-41d2-77a1febc3249@cloud.ionos.com>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <57e70970-814b-3a55-35cc-b1415a301895@suse.com>
Date:   Thu, 16 Jul 2020 02:40:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <91c60c65-11c4-35e7-41d2-77a1febc3249@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.9) by HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Wed, 15 Jul 2020 18:40:10 +0000
X-Originating-IP: [123.123.128.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c291509-f7aa-4427-5cbe-08d828ee8174
X-MS-TrafficTypeDiagnostic: DB8PR04MB6652:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB66526361CF30495C538AD70C977E0@DB8PR04MB6652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qneZ19BhXyv5X7fI6lGM5vaWx/AO0d4yUuAdfjqqMMs5KD8zIJlvJGzo/SYsyJQ3AD6v6gGbFGWrBIqHWtte8qsby+XfE4hAysoYSIOIcy3WwH452i7qvSCDN2hXfpiCuZJvSJl49Q1SUaDWOywVRgMsgfqAK3ehimFCwEBwelxFS0jkzW9oAWGWaK/6RAyX2e6e5RDFy6g55nsS5ajDGOM4NZ23zVfeVdeV3m3GkCzvpIi09ZpVQSvZLJjJbP1TEVrlWGfRPI0Dgh9MJFDi/6+xzTpNzkvIj3sOPJac1ZNxomJmMiH3ff5nKSKF3Qe1MLl+TyCEjU0G50o6D4W+8L8H+b6k/13En/aYPjqtYePcoAPMUSdgIceSO7T+Ij2TFn90SxmJ3cj3FKOMsqiSBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(31686004)(86362001)(6666004)(53546011)(4326008)(6506007)(2906002)(5660300002)(956004)(2616005)(8936002)(52116002)(6486002)(8676002)(186003)(478600001)(8886007)(31696002)(16526019)(66556008)(66946007)(36756003)(83380400001)(6512007)(107886003)(26005)(66476007)(316002)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pPqjOSzcgzE9/99p3hsU49j1ds5xW/tZ0aIwQxMt5keY50OQcLFruiKZseceYolGEtieqISGm9bM4NTgEtbAtR0AmTL66Zk9LKOVTp0DZpfyklN+FRwL+tyQ36Vvz1K5DjxoeSK723u9KD97hXMsnSb9fYH76QyR7wbf2VaWMsKMjuCA8KQTsL0mv0NU0ZNqcg+pElVT2wm4wfCQl1ULUlZezJTkERE+/X76KijXSXiEz+zfTNcIOqykFgju6JrNMU4fAcQ2bTc69OZ3e1iFDJIWVdR8tCmHZboSLdgGEkpL99BDLMdPbWt5oCWriNEHHzIMjWgVENl7p3cIdC5Fdhb6OMFKB1t3fX4Pej82J8stWBGb5VyXuE+iyY3EKIVihY8Rw6YhfeVGobNpk7puqCckAYHOR34VTNpOG3UUrmCtWa+AQed3WOJyvRwBOv/l9Ad7169l10sU8dYkhTG6Kuvt+57NFBaFfMMAG1osPoE=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c291509-f7aa-4427-5cbe-08d828ee8174
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 18:40:11.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmLm+5jSXCXB2HaBfQRpI8++zCB42j3Y2v19fYZct23biBg2+GFivQlYXLaJ+acKuBtvk3HZNWvFP15EK/kM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Guoqing,

Thank you for your kindly reply and review comments. I will resend that pat=
ch later.

Do you know who take care of cluster-md field in this mail list?
I want he/she to shed a little light on me.

On 7/16/20 2:17 AM, Guoqing Jiang wrote:
> On 7/15/20 5:48 AM, heming.zhao@suse.com wrote:
>> Hello List,
>>
>>
>> @Neil=C2=A0 @Guoqing,
>> Would you have time to take a look at this bug?
>=20
> I don't focus on it now, and you need CC me if you want my attention.
>=20
>> This mail replaces previous mail: commit 480523feae581 may introduce a b=
ug.
>> Previous mail has some unclear description, I sort out & resend in this =
mail.
>>
>> This bug was reported from a SUSE customer.
>>
>> In cluster-md env, after below steps, "mdadm -D /dev/md0" shows "State: =
active" all the time.
>> ```
>> # mdadm -S --scan
>> # mdadm --zero-superblock /dev/sd{a,b}
>> # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
>>
>> # mdadm -D /dev/md0
>> /dev/md0:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Version : 1=
.2
>> =C2=A0=C2=A0=C2=A0=C2=A0 Creation Time : Mon Jul=C2=A0 6 12:02:23 2020
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Raid Level : raid1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Array Size : 64512 (63.00 MiB=
 66.06 MB)
>> =C2=A0=C2=A0=C2=A0=C2=A0 Used Dev Size : 64512 (63.00 MiB 66.06 MB)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Raid Devices : 2
>> =C2=A0=C2=A0=C2=A0=C2=A0 Total Devices : 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Persistence : Superblock is persist=
ent
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Intent Bitmap : Internal
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update Time : Mon Jul=C2=A0 6 12:02=
:24 2020
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 State : active <=3D=3D=3D=3D this line
>> =C2=A0=C2=A0=C2=A0 Active Devices : 2
>> =C2=A0=C2=A0 Working Devices : 2
>> =C2=A0=C2=A0=C2=A0 Failed Devices : 0
>> =C2=A0=C2=A0=C2=A0=C2=A0 Spare Devices : 0
>>
>> Consistency Policy : bitmap
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Name : lp-clustermd1:0=C2=A0 (local to host lp-clustermd1)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cluster Name : hacluster
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 UUID : 38ae5052:560c7d36:bb221e15:7437f460
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Event=
s : 18
>>
>> =C2=A0=C2=A0=C2=A0 Number=C2=A0=C2=A0 Major=C2=A0=C2=A0 Minor=C2=A0=C2=
=A0 RaidDevice State
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 active sync=C2=A0=C2=A0 =
/dev/sda
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 active sync=C2=A0=C2=A0 /dev/s=
db
>> ```
>>
>> with commit 480523feae581 (author: Neil Brown), the try_set_sync never t=
rue, so mddev->in_sync always 0.
>>
>> the simplest fix is bypass try_set_sync when array is clustered.
>> ```
>> =C2=A0void md_check_recovery(struct mddev *mddev)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0 ... ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mddev_is_clustered(mddev)=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t md_rdev *rdev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ki=
ck the device if another node issued a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * remove disk.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdev_=
for_each(rdev, mddev) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(ClusterRemove, &rdev->flags) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdev->ra=
id_disk < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_kick_rdev_from_array(rdev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_set_sy=
nc =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 ... ...
>> =C2=A0}
>> ```
>> this fix makes commit 480523feae581 doesn't work when clustered env.
>> I want to know what impact with above fix.
>> Or does there have other solution for this issue?
>>
>>
>> --------
>> And for mddev->safemode_delay issue
>>
>> There is also another bug when array change bitmap from internal to clus=
tered.
>> the /sys/block/mdX/md/safe_mode_delay keep original value after changing=
 bitmap type.
>> in safe_delay_store(), the code forbids setting mddev->safemode_delay wh=
en array is clustered.
>> So in cluster-md env, the expected safemode_delay value should be 0.
>>
>> reproduction steps:
>> ```
>> # mdadm --zero-superblock /dev/sd{b,c,d}
>> # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
>> # cat /sys/block/md0/md/safe_mode_delay
>> 0.204
>> # mdadm -G /dev/md0 -b none
>> # mdadm --grow /dev/md0 --bitmap=3Dclustered
>> # cat /sys/block/md0/md/safe_mode_delay
>> 0.204=C2=A0 <=3D=3D doesn't change, should ZERO for cluster-md
>=20
> I saw you have sent a patch, which is good. And I suggest you to improve =
the header
> with your above analysis instead of just have the reproduce steps in head=
er.
>=20
> Thanks,
> Guoqing
>=20

