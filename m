Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE711A7562
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 10:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406961AbgDNIFd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Tue, 14 Apr 2020 04:05:33 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:43276 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406938AbgDNIEp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 04:04:45 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Tue, 14 Apr 2020 08:04:04 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 14 Apr 2020 08:03:32 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 14 Apr 2020 08:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibkjCR7/jy3NbOUd/a41aJqNjdHNxLgEQ5PRnwmHi/RvFmxnD6mLRlqX8uO/QmJFuZ3T6oL86mQ+j64e1m+e3wm5cTQelUugbEZrbrCnCjkxxSmNboQQBof/1Mg6IwbvCQdPvmoS+4EoFqEpwIk6ZBH4NnEHXg+II/UIBg+ONfBmjK75BP+cghoCnclvg5aOdy2sp17soPlfl1xtfHcPNIyNIFtOe8PRNL0w0OUJ4OulRnYyOr8YGHtt15KlPEcFasd1MJajUGBIQ1WioTMab0rTQh+aRqFlXmo/lV/tUXl8EEiO2H8wh0p3etqECLZhOSDypoeTYwvfJ7EET1b0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrtemoZYniPvLm3Hq5MihQ3ExEGVWtS8NFi4eQDZeoM=;
 b=FXVpknWkyDxkgY9FAs/2AaplXI/CmxQGxzlW1J8qMi24fxYw0HrdKcNZf5Dg0ovdlechn/EEvDlAsbc970PwPX246MveeAjQk1joEdiYtzThJOrB6jP40NHrIZ7vL4waNXAt2o82dxC5ddN5VrJ4xiNvm6vXX7ecSNbcaOkH35TR2KsTPZ/Zbc3gZdI2mtS8y+7CJdpP+sRYR+a8PUWVsyroHwYahTXe6ydSYXAvTX2QV9ScfAjw71hDHiVN94IshWFLZ1umKEF6g8RTlFVj+YpzHdz0KB8CEipZKJLZal44+9xB8UuyODWhJWXZWXDJUKOLwMnX4/AX8N8IoI7RgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB2326.namprd18.prod.outlook.com (2603:10b6:4:b9::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Tue, 14 Apr 2020 08:03:31 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::4de6:2be:d5a:60b0]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::4de6:2be:d5a:60b0%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:03:31 +0000
Subject: Re: [PATCH] Detail: adding sync status for cluster device
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        <jes@trained-monkey.org>, <linux-raid@vger.kernel.org>
References: <20200413144128.26177-1-lidong.zhong@suse.com>
 <bcd5713f-d2e8-d358-17c9-323f9c125d1b@cloud.ionos.com>
From:   Zhong Lidong <lidong.zhong@suse.com>
Autocrypt: addr=lidong.zhong@suse.com; keydata=
 xsBNBFne5DgBCADQj9QdXtw20bP35mDylFrd0LWj4cjpQ9kHD693GVpwNqTmwJcxGJutRvhe
 8HJjiJhstnP60v6+Q+qoP7cNY4KS35LDZJHgXbdRcPYBSzabEdWfge6UH86HxK8MHY0w+GDu
 TseKNwt6fr6NH2FVQSTTQhpVv+fYGPTgAqaKD5J8JhTHS9c/sBsV1zNSQmTULpykXXcO/COL
 +Yw2A7P4+KR12wNAIhpITRykUtfKiHjdAFBLmQs0ES/c/MwQ2gOwEt7RAjJB9il71oR+9Kyr
 CDkHaBoNK/mkdDyXDL/FBCqEExeiYL3XnBWckoyPZT8ivA5DQuOuiG8Yv2TyTMSaSMQFABEB
 AAHNU0xpZG9uZyBaaG9uZyAoU1VTRSBMMyB0ZWFtLiBCZWlqaW5nIE9mZmljZS4gbGlkb25n
 L2x6aG9uZyBvbiBJUkMpIDxsemhvbmdAc3VzZS5jb20+wsB/BBMBAgApBQJZ3uQ4AhsDBQkJ
 ZgGABwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsnlJphZSmJJZWgf/VSvl+O1sRDI6
 VIAXiGzFCqVnPBARZFXMahzYrTbfb/LdxTCE9R5g2ex5jM7ME8Y+j/PtCS7z0TW5jF0R9LFP
 gjTHfaUqDq7sqzrONB85NMud+qtkn07HlgTCwhIZe972LHuv96iWv7n1nRyMHe8eAMK2xVL9
 sPS3L4LW5b2AN1BEwk3x/BVoXKNMzlKP8CyoDG03UaptcBRgbm+Ds9Sgx9ZuxkAL/nUdDqvB
 6Of+FleCNRmTm5c9gawOS3w24KzVCbhOKSp+y8FSt0gS05mL1P1wVos2sErKgOk6uSNo5oa2
 TIk6T5BpWytWKRcdn2NSmM68MqezUXMpD/eCjkohF87ATQRZ3uQ4AQgAvvWi8gOGzVm4uiUj
 pxeteRthpsdvm3YU7rAWwxPPSXjZDDoSL8ogSoj5/mV7wKxJemv/UHnxWO66KNkP5YlwBVpf
 yhLWvFuas8vKgrL6xwstjIoqQkAHwzFeMGKYdXZKZbJgxl56MeE6cpGoKpMHNkRVDhbmhfOt
 yrISWhBccrOsgeYjaPos8B53sAQry5PoVA3hNhpSZ23N37VZcs4KJOtNpxbsXC3KcbrisXUr
 MqkyYnccSNVGT1Bfr4nItAp3bdgyoMPh2kWkNtX7xms5fQs3kIZoCevbjQcJeerBG/E4rNtq
 wBYtagTg9m0/bn/w+iA6RfcLZWC7Z31ggkSZ0wARAQABwsBlBBgBAgAPBQJZ3uQ4AhsMBQkJ
 ZgGAAAoJELJ5SaYWUpiScgEIAMcAuAxnvRg5L9aB1/Xrmm+ILf7qB7FYxmavGMkZ+sHrLhw1
 Ycb5jYMhQQcTGCefKpsxx44PAw5DhJe7xnbHjRAWl8ScCGXmJUof3eaQ+7p3pWtl7R/J5W4j
 C5undogrFFcRimd5ah1tWc0t4BejelxpV+OiG4u/ghuCMrEQn6DgGL++gDs3vAspW/43RNZe
 BaxvvUMbNU0B3iKlwzXUxCDlBu8EcXEltM9MF02yoG5FxLaRXa/8kqeYAgH2vQjJqfMBMBLS
 tYfhW3GUnwUCN1GlKsguZWKprwgDzAp0JIeAatemSNtCzcTpgT0gTB+iTWYac12EQTu3Ckdx
 Rdu9+hQ=
Message-ID: <5c7b0055-917c-87ee-237f-1deaeb6fc575@suse.com>
Date:   Tue, 14 Apr 2020 16:03:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <bcd5713f-d2e8-d358-17c9-323f9c125d1b@cloud.ionos.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: LNXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::21) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from l3-laptop.suse (39.78.17.73) by LNXP265CA0033.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Tue, 14 Apr 2020 08:03:29 +0000
X-Originating-IP: [39.78.17.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a497f7e7-ee5d-4eec-1ec4-08d7e04a527e
X-MS-TrafficTypeDiagnostic: DM5PR18MB2326:
X-Microsoft-Antispam-PRVS: <DM5PR18MB2326CA90740EB5DF314F7A8EF8DA0@DM5PR18MB2326.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB2150.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(956004)(316002)(81156014)(66946007)(5660300002)(8936002)(6486002)(8886007)(6512007)(186003)(31686004)(16526019)(26005)(66476007)(31696002)(6666004)(66556008)(8676002)(2616005)(478600001)(52116002)(6506007)(53546011)(36756003)(2906002)(86362001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OTF2ADfPZ3U81cJW66tPDWHeeVtZ43EnUuzyPa93w3aycDcPoofc7BSGejAEmb7IHx4hxCSzFwuM3kbd67yPVsAHMLAqeDGSG7BHc9KVu336eRQ43VROybuKk6mcURQela2Hu+YVp83oraWSJSnsG9WrPzRnODInvjDZdBNDa7BnpwQtDOkSWiSzv7kcwiGPmANMXK6ZWyIm+NUpqEIUIgcjhxN6iO9WBGYbNitr7N0q4ulR/W9Y2dj4IcCLNTgV+z6bG3987/aEgJeQtjB756atGSL5QNR7cYxsNOBJrBTOeZc+qju8NcUCmK6ZzWRoUEV5p+e5esPJoXSCkEj78hfCq5EXL2qmQ+/oHEUL8WoUkaOsiJZSh0YjOcZvV9o1zkd/suUmZNVMDXTDO8ImBM1AsuTe6deiE/Bin1Bn1TUFK3q8dVK8iivI9JWRBbA
X-MS-Exchange-AntiSpam-MessageData: cBp5UYEdRQsjiyuG8O/kmaPU+o/CzVdTnX0P8gEmLpdFZl4mZk6GWX2jIaYimRSlDIxuULRAk+ooQ42Uvw2VDwaruvETbdbt75IJ6ZgJq9V74WVdZYE+Kl1AAY5+9hpRiS+0MtidFkO8fR+xTfgkAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a497f7e7-ee5d-4eec-1ec4-08d7e04a527e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 08:03:31.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYrxhBfQ7lccL5QduN1BBdrvLrAc9YxAyMAsowQcneoRfY+trXP1WXEpt4nDq47XHw3kYsIEE/LtwUNvBma79Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2326
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 4/14/20 3:25 PM, Guoqing Jiang wrote:
> On 13.04.20 16:41, Lidong Zhong wrote:
>> On the node with /proc/mdstat is
>>
>> Personalities : [raid1]
>> md0 : active raid1 sdb[4] sdc[3] sdd[2]
>>        1046528 blocks super 1.2 [3/2] [UU_]
>>          recover=REMOTE
>>        bitmap: 1/1 pages [4KB], 65536KB chunk
>>
>> the 'State' of 'mdadm -Q -D' is accordingly
> 
> Maybe rephrase it a little bit, something like.
> 
> "Let's change the 'State' of 'mdadm -Q -D' accordingly "
> 
> Just FYI .
> 

Thank you for your suggestion, Guoqing. I'll send the
patch again.

Regards,
Lidong
>> State : clean, degraded
>> With this patch, it will be
>> State : clean, degraded, recovering (REMOTE)
>>
>> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
>> ---
>>   Detail.c | 9 ++++++---
>>   mdadm.h  | 3 ++-
>>   mdstat.c | 2 ++
>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/Detail.c b/Detail.c
>> index 832485f..03d5e04 100644
>> --- a/Detail.c
>> +++ b/Detail.c
>> @@ -496,17 +496,20 @@ int Detail(char *dev, struct context *c)
>>               } else
>>                   arrayst = "active";
>>   -            printf("             State : %s%s%s%s%s%s \n",
>> +            printf("             State : %s%s%s%s%s%s%s \n",
>>                      arrayst, st,
>>                      (!e || (e->percent < 0 &&
>>                          e->percent != RESYNC_PENDING &&
>> -                       e->percent != RESYNC_DELAYED)) ?
>> +                       e->percent != RESYNC_DELAYED &&
>> +                       e->percent != RESYNC_REMOTE)) ?
>>                      "" : sync_action[e->resync],
>>                      larray_size ? "": ", Not Started",
>>                      (e && e->percent == RESYNC_DELAYED) ?
>>                      " (DELAYED)": "",
>>                      (e && e->percent == RESYNC_PENDING) ?
>> -                   " (PENDING)": "");
>> +                   " (PENDING)": "",
>> +                   (e && e->percent == RESYNC_REMOTE) ?
>> +                   " (REMOTE)": "");
>>           } else if (inactive && !is_container) {
>>               printf("             State : inactive\n");
>>           }
>> diff --git a/mdadm.h b/mdadm.h
>> index d94569f..399478b 100644
>> --- a/mdadm.h
>> +++ b/mdadm.h
>> @@ -1815,7 +1815,8 @@ enum r0layout {
>>   #define RESYNC_NONE -1
>>   #define RESYNC_DELAYED -2
>>   #define RESYNC_PENDING -3
>> -#define RESYNC_UNKNOWN -4
>> +#define RESYNC_REMOTE  -4
>> +#define RESYNC_UNKNOWN -5
>>     /* When using "GET_DISK_INFO" it isn't certain how high
>>    * we need to check.  So we impose an absolute limit of
>> diff --git a/mdstat.c b/mdstat.c
>> index 7e600d0..20577a3 100644
>> --- a/mdstat.c
>> +++ b/mdstat.c
>> @@ -257,6 +257,8 @@ struct mdstat_ent *mdstat_read(int hold, int start)
>>                       ent->percent = RESYNC_DELAYED;
>>                   if (l > 8 && strcmp(w+l-8, "=PENDING") == 0)
>>                       ent->percent = RESYNC_PENDING;
>> +                if (l > 7 && strcmp(w+l-7, "=REMOTE") == 0)
>> +                    ent->percent = RESYNC_REMOTE;
>>               } else if (ent->percent == RESYNC_NONE &&
>>                      w[0] >= '0' &&
>>                      w[0] <= '9' &&
> 
> Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Thanks,
> Guoqing
