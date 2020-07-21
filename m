Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80F227B4C
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jul 2020 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGUI64 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jul 2020 04:58:56 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:58724 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgGUI64 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Jul 2020 04:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595321932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPMK5y6rVqcV62qf/1IGQYayDi1aMJO+c+dEMc/5G/Y=;
        b=dqKYioFnx6yaL5UFNpJrbMXHfN3gr5ZL+YDgOXJL534UCaAKvsCfGaDepcSgxdvEfjqYSU
        Fu4ILJFi53D64grzK7WGZ/xl4ut7v8KhEzt3w4fI3WDQCX8HuCHfQjrhcBzrKjNGGHSPLl
        h8oxj+mQRlmt6hQKuQFHbpUxUlWGrDQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-2-NH-_GMCTMbe0jg_hCixbGg-1;
 Tue, 21 Jul 2020 10:58:48 +0200
X-MC-Unique: NH-_GMCTMbe0jg_hCixbGg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKadk13C1X/0Y0CNFZCTAhoXP/Lu9WHBsuEelwI6FhFlIIJYOxOEpme2hxBCdj7YG9WY876BlXaUgqpz8CqLUxVCgVwwVszAc/FfFYNENYDd3O6AKUC4+ctWZjTvA3G1eg0MsMox9Jp9KnJh63xS3cBrDsfBCCetMQqkiR5fBpnYV2Z/yXMuDHtCno/ffEo6wfsGzxUw4vY4tf4RN2yq7qlP+itkTWaIU6uqZ9h64O6BussQG3zJNe7Y+zjODT9uS6zeQ5Jf8KFro06y6YfvXFbbL4GuvodhRlpJyIYOULOBtqzYlkaRb5C7V/JIOU6IZqLahrXsSDpS/tMiImn6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCK7cszd0BShPirCZL/4P3AZWriezKrt0qMYDNzHmJo=;
 b=SXtFrCbbMqHdTvesb3K7de6SkMFBYuTDNlvI/sOuwDvOa7TL7N06ukeMy/51i1RAjEfyg8iJ293i8U5DoaoK4F71ldiU/qy+cqWlnVnnJMHCkQybNfm/qbao3U9+zBEVPtc1HrQfj8xcBVNacOhzfPMPJ1+PXDcDhdoHWdYmFu3TmrgtCtLvKyul/ydMXReqtHWvIlqLLbKbyEC1Ptjkgq7PaCNSz53wM+BeeL4BDMY8g4IB/MNf7p9F1lj9CdojxLxBwtEwlfM+Lq2sN6eD0dksAi4gQwTLk4/v+2E28NI1YlMVuwE7abuyJ2FlLxC4pXVMCG4PAPUEf1G4JRcZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4731.eurprd04.prod.outlook.com (2603:10a6:10:15::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Tue, 21 Jul 2020 08:58:46 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 08:58:46 +0000
Subject: Re: [PATCH v5 1/2] md-cluster: fix safemode_delay value when
 converting to clustered bitmap
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
CC:     neilb@suse.com, song@kernel.org
References: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
 <1595268533-7040-2-git-send-email-heming.zhao@suse.com>
 <8f122dea-2a4a-4523-653f-fe6fc2842653@cloud.ionos.com>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <f1b63409-5837-cfcd-2a6e-05d9cb753d3f@suse.com>
Date:   Tue, 21 Jul 2020 16:58:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8f122dea-2a4a-4523-653f-fe6fc2842653@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HKAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:203:c8::18) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HKAPR03CA0013.apcprd03.prod.outlook.com (2603:1096:203:c8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.15 via Frontend Transport; Tue, 21 Jul 2020 08:58:44 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3bb2bb4-7487-48e9-df13-08d82d5446ba
X-MS-TrafficTypeDiagnostic: DB7PR04MB4731:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB47314EBF848728D62FCB7F3F97780@DB7PR04MB4731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAMFFgTa25ApCGmBrQKjuW2stSUXzHEmFkazh94P4oKQFQnvZOJH+PnhgkItNQOgZt8z4lo0g2ZyCnrqlVvaCwKTB/EVWDMUwq3K42aY5UyglNYcntQHjA51sX4p70F0irC1JxPEa6rYJhrFAd2HpK2UZ7iDT+a+lhUxEs0qZfsQ2oP/9BR6YJiHCcOEV/PJZfp4ryOvOIgC8qzZIhdPYNsm/0mGuLRJfJavrXutnSmk5japFqEnjbXrNN+zy5UedR9SDrTqCFWlQ8kaTnhQpNR2jqB4+NTzdmXA2NA4OQTo+dg7uR41mY9vL0O51RT//eLsY6aahZTP8P6FMRr/0grXjELmJvdcYRTIBAYAXO3jnRkdKlcfh397h+TtcaPTzxBPA0gy6nMLlEC+jf+VQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(346002)(136003)(2906002)(6486002)(6512007)(66556008)(66476007)(31696002)(86362001)(316002)(66946007)(53546011)(52116002)(31686004)(26005)(4326008)(6506007)(83380400001)(8936002)(956004)(8676002)(2616005)(5660300002)(36756003)(478600001)(6666004)(8886007)(16526019)(186003)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Nif8Dt3eQy3jMi1kPfH7Ry5fVqQZrB5oqhvwvfZzPolvXv5afaPLKLZq5TtZ/+q7coqotTgqohkGd7mbdeau8sYbsWD/vXT52AA7OUh/NIkzhCeWZ4s2hA8TGUePLJbTUxLiQEzkOdqfbNWnWKoM1yVbcYMeWU/lNajNxZPFWAUgIwPdcnkaI/pPVuB/tYNt1SDqkrVsfXrhXlcGCUKjHn1cgtsettrVFA/0+WwTYj4E9jjOWI7kvohIeR+FFZUkFfCQBQMrJhdv19tXX8qTBhgN7Qg5yArmdai++V4zxJZeAtw+JsNHLESN7oXd3iuEq0Xk2qRgm+WVdiJM8k/kRzm8lmc6gHzii4dpBgm3VeukvMVj//2g8JHl6mVtyR4WiRnCDagLjChvfWAp1DbTPT0NcTgzmnAZ29gjNcmgGzP9X1UW971KrX3BqQ1MHecnNxxDHW2GWyhCmgJI1D2DkTW5ruGCdanjjtPKmMdo9hg=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bb2bb4-7487-48e9-df13-08d82d5446ba
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 08:58:46.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GPdcOiouv/pyuC491Oo0sn+O2syEAe/FKfROj3jn4oHAkaqye2uNXv7eEk73LpDcrwg343Dyt6pLyU2z8D4eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4731
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/21/20 4:35 PM, Guoqing Jiang wrote:
>=20
>=20
> On 7/20/20 8:08 PM, Zhao Heming wrote:
>> When array convert to clustered bitmap, the safe_mode_delay doesn't
>> clean and vice versa. the /sys/block/mdX/md/safe_mode_delay keep origina=
l
>> value after changing bitmap type. In safe_delay_store(), the code forbid=
s
>> setting mddev->safemode_delay when array is clustered. So in cluster-md
>> env, the expected safemode_delay value should be 0.
>>
>> Reproducible steps:
>> ```
>> node1 # mdadm --zero-superblock /dev/sd{b,c,d}
>> node1 # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /de=
v/sdc
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.204
>> node1 # mdadm -G /dev/md0 -b none
>> node1 # mdadm --grow /dev/md0 --bitmap=3Dclustered
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.204=C2=A0 <=3D=3D doesn't change, should ZERO for cluster-md
>>
>> node1 # mdadm --zero-superblock /dev/sd{b,c,d}
>> node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdb /d=
ev/sdc
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.000
>> node1 # mdadm -G /dev/md0 -b none
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.000=C2=A0 <=3D=3D doesn't change, should default value
>> ```
>>
>> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
>> ---
>> =C2=A0 drivers/md/md.c | 11 +++++++++--
>> =C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index f567f536b529..1bde3df3fa18 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -101,6 +101,8 @@ static void mddev_detach(struct mddev *mddev);
>> =C2=A0=C2=A0 * count by 2 for every hour elapsed between read errors.
>> =C2=A0=C2=A0 */
>> =C2=A0 #define MD_DEFAULT_MAX_CORRECTED_READ_ERRORS 20
>> +/* Default safemode delay: 200 msec */
>> +#define DEFAULT_SAFEMODE_DELAY ((200 * HZ)/1000 +1)
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Current RAID-1,4,5 parallel reconstruction 'guaranteed sp=
eed limit'
>> =C2=A0=C2=A0 * is 1000 KB/sec, so the extra system load does not show up=
 that much.
>> @@ -5982,7 +5984,7 @@ int md_run(struct mddev *mddev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mddev_is_clustered(mddev))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev->safemode_d=
elay =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev->safemode_delay =3D (2=
00 * HZ)/1000 +1; /* 200 msec delay */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev->safemode_delay =3D DE=
FAULT_SAFEMODE_DELAY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev->in_sync =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_wmb();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&mddev->lock);
>> @@ -7361,6 +7363,7 @@ static int update_array_info(struct mddev *mddev, =
mdu_array_info_t *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev->bitmap_info.nodes =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_cluster_ops->leave(mddev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mddev->safemode_delay =3D DEFAULT_SAFEMODE_DELAY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>=20
> Not about the patch itself, just confuse about the meaning of safemode_de=
lay.
> As safemode_delay represents 200 ms delay, but md_write_end has this.
>=20
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 /* The roundup() ensures this only performs locking once
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * every ->safemode_delay *jiffies*
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mod_timer(&mddev->safemode_timer,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 roundup(jiffies, mddev->safemode_delay) +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mddev->safemode_delay);
>=20
> And the second argument in mod_timer() means "new timeout in jiffies",
> does the above need to convert from ms to jiffies? Am I miss something?
>=20
> Thanks,
> Guoqing
>=20

The safemode_delay stores jiffies not msec. it converts to ms only in safe_=
delay_{store|show}.
please see default value:
#define DEFAULT_SAFEMODE_DELAY ((200 * HZ)/1000 +1)
in safe_delay_store, user space input will multiple 10^3, which will conver=
t from second to msec.
then  (*HZ/1000) to jiffies.

