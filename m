Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594461BAA01
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD0QWI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 12:22:08 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:56213 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbgD0QWH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Apr 2020 12:22:07 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Mon, 27 Apr 2020 16:21:22 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 27 Apr 2020 16:20:06 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 27 Apr 2020 16:20:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWskqc1TofNQrSXJPiuOyEHbYqtP+EYjl21+RQEafm/DuN0iMFVslyy/Hl0EtdpRX01UHkH5sjhNVWBDI6mfU5725nlUvXEeuITLlkHix87ghhTZckw/w/9iqca1MEnCRzzyekss5J1TNAGq88sSD+kIypC7Y5Ie5HePo0zkCBkXXxIsPyo0dMSUeaAWaqDV6cj+KDt+eJ3Az9melK2Y0WWdSeDbX6wADraco3FRF1Wue+cxJudxUr8ALu+RZXUGPx62nrRKn2d4NjLhgI5ycmCQAOGJgkRMRrWwdVs92Qv8rlga/it8CyxOAQlBdWBjTLgsE6t1vwd/ZiwnNIjOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3aYJ4Rix+/Ezp6ZRdLqoSn7m2SGNHwQ1ODbshJ22hg=;
 b=epFXOjntZAAjibwQ4BWNbmbQk0yeMilv6LMIwq0WRWpNySOOAiRzv0MIe2clzf4Wol3G2HEYd0UuqPPWhqMDHcQGyyqJWUxmdOcbDqZgSBC9ElzOzrPFSWSe5A6UOEeTKrArq+0N6KP2w6E/1fTO0pgXUmwsGZUhAqYWR3NmzZeqCJsqVFzxaTToS8oErvg1zqFB4XQpAkq8ZTUQEnkjGLBTkurcdRm2ek1d/aWokegRMKdhUnu36/PiZEFUGkR/r/nDjlSlLn1ll1qCT5LXrurDmRjpbWgeL3i7DDs5+ueTsy14zAPaCqE8ZBNfZG2YkblMg+mw6j5UpXIipq3jEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from BN6PR1801MB1985.namprd18.prod.outlook.com
 (2603:10b6:405:66::32) by BN6PR1801MB1859.namprd18.prod.outlook.com
 (2603:10b6:405:66::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 16:20:04 +0000
Received: from BN6PR1801MB1985.namprd18.prod.outlook.com
 ([fe80::a471:16c0:7214:f206]) by BN6PR1801MB1985.namprd18.prod.outlook.com
 ([fe80::a471:16c0:7214:f206%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 16:20:04 +0000
Subject: Re: [PATCH] Monitor: remove autorebuild pidfile when it exits
To:     Jes Sorensen <jes@trained-monkey.org>
CC:     <linux-raid@vger.kernel.org>
References: <20200327012854.5654-1-lidong.zhong@suse.com>
 <7fce6b8e-dbbc-b8b9-608b-cc5479484882@trained-monkey.org>
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
Message-ID: <23c27b96-b6ef-396c-bd8b-3f7b14c25c46@suse.com>
Date:   Tue, 28 Apr 2020 00:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <7fce6b8e-dbbc-b8b9-608b-cc5479484882@trained-monkey.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0356.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::32) To BN6PR1801MB1985.namprd18.prod.outlook.com
 (2603:10b6:405:66::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from l3-laptop.suse (39.91.1.129) by LO2P265CA0356.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 16:20:03 +0000
X-Originating-IP: [39.91.1.129]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc78c3d-2323-4b16-5731-08d7eac6d81f
X-MS-TrafficTypeDiagnostic: BN6PR1801MB1859:
X-Microsoft-Antispam-PRVS: <BN6PR1801MB1859588D2F97664E9D0DE09AF8AF0@BN6PR1801MB1859.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1801MB1985.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(186003)(6512007)(6506007)(53546011)(478600001)(31686004)(5660300002)(86362001)(26005)(316002)(2906002)(6486002)(6916009)(16526019)(36756003)(52116002)(956004)(8676002)(6666004)(81156014)(8936002)(31696002)(8886007)(66476007)(4326008)(66946007)(2616005)(66556008);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hZxUZK6s7Zr1LlzbYBYHJZkf3z0zkgWIVMhd0B2Bx2/1QohvP3Dv0Q0WBoqV9Rr8RLLZGGiJga3WOwngFwrkKZRq7Irz0264TUzVnF3RC5r1JDTEwoUYsbxJDvV2pqZI0VtMsZxTcNn4KeurILRwd1Jp6prai3dmQZKT5j5lL6Bz4u/hiXSVPNOr3SIZ9nVcPF4A7EfZohCS+4Rkiu3wUzmkZ3FTYCLDyrzVjF63mUt0ixqTRExZyoaV31JUlBWKiKiCasdimpwr/eYVUbGndGS23aZ0O/DJEhrN12Y8eXVELSHbtvOsKchMxQV6qOYkp0WISAa1zzZ3Nn2/aZVy1jbtROZDen7RRsCijCqblkjsXy01c5yft0XGVQSmrU85K+zrsgHLZL+LWL+nOVQv9bOy1LVKZmeGE3+ryF1X6jBLQKp1Xv+G7V6rpQIfjMu
X-MS-Exchange-AntiSpam-MessageData: 9EOMitRoAcqVcFZHbIFa5NOjHBZqoYDZrxnWSD62weVtQSHuR4cUqAi9jW7F8FX1rfV7CHqKvNBC5NCRyedSePBvbjoYMJIwHIXPPjK79J1uqFSu6TKGeyPGSSOiR29mckSo+FK9+rYlpUBk4AhrE5cOEdx2bUnOhiG1QvKP6a9Q1qrppXRCEeTFPPWo5d2dzlGoRBANAUuB657C++5Vis+A0gq9vaty5s12Rx0T96rBcOcR6KE1PjF+Le1U5e/yJ7AwcKKFVogxjW26wX2tqOHnPeOwGYPoit7rieFULptw5DpK3qlKJFCIIcxDzU2U2OlfSeR8FD7FndXfc7dF5NqQcA5+Fn2ev3CSlE5PdjnG0t6+sz8sH2t7voMlcDgfwmSBP5W6mX/YxiH5dXHXcU+h4RcM5WVt8FKPVKtVicSaGjTd1/rftYhhlUF8NFZ5Gd8w0+ySkeV1tCEP5uz+7l/OSCvIrkVOpi73q299wIIvLw4qYrCNS6p3jOZRthkHHZ2asf4CndlHxb2JEyq2dvjo2pjs1qwVDN5GXz1euxQNo6cvOQFzXkHq1SaDtqUTlnur2FLrQ9DvBjHHZGV0cl4RnyyrwqAC5D0tNJF59OMh91gbZgABl3rQpNex83u2GLoJb3+4Xlf5XLOjKfPA51lXH1BC93w6pYYMjF8mNfO60UnNWZD6vj58levq/bg+0RRuIMaqh6uyzRSqE9IGRMo4/wlomaq+V0joF6SH+PLpKh6UsAdKqCUj0jtV+4HQbJnTRsWfo7hxJG/j4bcCUcRcSLvqc9HrW524KwM/+B0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc78c3d-2323-4b16-5731-08d7eac6d81f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 16:20:04.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chvAQ3/auoqrwg54iqmlijSuIfNGp6iv5IauakFo61ffKaLOEOXX3epnY936jy1c7mNqeZ6s/TXFbfRaoQBgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1801MB1859
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/27/20 10:40 PM, Jes Sorensen wrote:
> On 3/26/20 9:28 PM, Lidong Zhong wrote:
>> mdadm monitor is supposed to run in background and never exit. However
>> if it is killed by accident and the pid stored in autorebuild.pid is 
>> taken by some other process, it reports an error when restarting
>> "mdadm: Only one autorebuild process allowed in scan mode, aborting"
>> even though no autorebuild process exists. With the patch, this file
>> will be removed at the end to fix this scenario.
>>
>> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
>> ---
>> Hi Jes, 
>>
>> Sorry to ping you, but could you please share your opinion about this patch? TIA.
>> ---
>>  Monitor.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/Monitor.c b/Monitor.c
>> index b527165..4cb113d 100644
>> --- a/Monitor.c
>> +++ b/Monitor.c
>> @@ -62,6 +62,7 @@ struct alert_info {
>>  	int dosyslog;
>>  };
>>  static int make_daemon(char *pidfile);
>> +static int cleanup_sharer_pidfile();
>>  static int check_one_sharer(int scan);
>>  static void alert(char *event, char *dev, char *disc, struct alert_info *info);
>>  static int check_array(struct state *st, struct mdstat_ent *mdstat,
>> @@ -71,6 +72,12 @@ static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist,
>>  			  int test, struct alert_info *info);
>>  static void try_spare_migration(struct state *statelist, struct alert_info *info);
>>  static void link_containers_with_subarrays(struct state *list);
>> +static volatile sig_atomic_t finished = 0;
>> +
>> +static void _exit_handler(int sig)                                                                                               
>> +{
>> +	finished= 1;
> 
> Please respect formatting rules.
> 
> Also this patch fails to apply cleanly:
> 
> Applying: Monitor: remove autorebuild pidfile when it exits
> Using index info to reconstruct a base tree...
> M	Monitor.c
> .git/rebase-apply/patch:27: trailing whitespace.
> static void _exit_handler(int sig)
> 
> .git/rebase-apply/patch:46: trailing whitespace.
> 	
> .git/rebase-apply/patch:47: trailing whitespace.
> 	signal(SIGTERM, &_exit_handler);
> .git/rebase-apply/patch:48: trailing whitespace.
> 	signal(SIGKILL, &_exit_handler);
> warning: 4 lines add whitespace errors.
> Falling back to patching base and 3-way merge...
> Auto-merging Monitor.c
> 
> Please fix and resubmit a v2.
> 

Hi Jes,

Thanks for your reply. Please ignore this one since Coly's patch

Monitor: improve check_one_sharer() for checking duplicated process

is already applied. They are aimed to fix the same issue.

Regards,
Lidong
> Jes
> 
