Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211171A6163
	for <lists+linux-raid@lfdr.de>; Mon, 13 Apr 2020 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgDMBsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sun, 12 Apr 2020 21:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgDMBsm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Apr 2020 21:48:42 -0400
Received: from m9a0013g.houston.softwaregrp.com (m9a0013g.houston.softwaregrp.com [15.124.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A3DC0A3BE0
        for <linux-raid@vger.kernel.org>; Sun, 12 Apr 2020 18:48:37 -0700 (PDT)
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Mon, 13 Apr 2020 01:47:21 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 13 Apr 2020 01:48:16 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 13 Apr 2020 01:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTRTtsxdT/safr8p3BpgS5BwXrwga7DnCVX8o2+WPAhfJZYu7zHGQK6qK07e0tFJDjIkMdwmn0qAI66OeREV3BCJMFqTiye/n86vnVlQeuGBwPVZsioVCWyHB7r6dJ/KG7n3ILBuxqXBbNTWo5QmTBHEgUCIEYnG1kRF0HZXQFK5laewy2QZEOeMP77hDbhqrUAxy9q0X98jSpzaaFGUh94tYG232CsWnl/hb/px6RL1LNj4sJQpwCcAZjJwO6F32MoiAfzNzcyMqVZ8XmLAHiIn1PrtDRfnZoJ/+Wi3Qk5DehD7ks/lTOG7MZJYh3MagniUP8MXwDUW3Cuz+8wg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN8Beqwn45rKODVi72LS4tNuIe/w9DbrZ2Xt+T0Lo1c=;
 b=kcmxhlBfYL998rim+OqKegbMCJsQ6JTSdrzXDm1+37xSDe4J77HII8prar+Ry/ZYo89PVw372LybmMk5hMpXI1NJsvPTMUZFHNQ/7ij0COOpyAZi1QyyL5sJKOj1wghYgKEqya6L8JwhAaA+aQ0L8Wtp0VHsIvzw1NZ+5soJlaVb4qsO/qjaIQh58FUtDj8MhKlfbdYsqOEeOlWXQspi4ck+KTLzO4hAqHUY+Ya3BoeX6/7omzfz26IMbz5nAz56cGnUv1ULexRFQdY7SNa8XdzOrxYNs9I0Fao2n3OMLC2pv0cv0bgl2Z7WDOi7vYgAo5++3c00OOT387cIYOZ2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB1674.namprd18.prod.outlook.com (2603:10b6:3:14b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 01:48:15 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::4de6:2be:d5a:60b0]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::4de6:2be:d5a:60b0%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 01:48:15 +0000
To:     Coly Li <colyli@suse.de>, <jes@trained-monkey.org>,
        <linux-raid@vger.kernel.org>
CC:     Shinkichi Yamazaki <shinkichi.yamazaki@suse.com>
References: <20200410162446.6292-1-colyli@suse.de>
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
Subject: Re: [PATCH] Monitor: improve check_one_sharer() for checking
 duplicated process
Message-ID: <f62b9338-10d4-c9d5-3d8f-a0ac432b11e2@suse.com>
Date:   Mon, 13 Apr 2020 09:47:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20200410162446.6292-1-colyli@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from l3-laptop.suse (39.78.17.73) by HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.5 via Frontend Transport; Mon, 13 Apr 2020 01:48:13 +0000
X-Originating-IP: [39.78.17.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e51f3e1-1129-42ff-7316-08d7df4cbb90
X-MS-TrafficTypeDiagnostic: DM5PR18MB1674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR18MB167465821D501207D2FCC77CF8DD0@DM5PR18MB1674.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB2150.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(36756003)(2906002)(26005)(66946007)(52116002)(6512007)(66556008)(66476007)(316002)(6506007)(53546011)(478600001)(2616005)(956004)(16526019)(8936002)(4326008)(8676002)(31686004)(107886003)(6486002)(81156014)(86362001)(31696002)(186003)(5660300002)(8886007)(6666004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TARj8iIkxXUp7gs3NyHb/W2rFs8LP+H5l7OSKBfwr4WXHirEsFrqJ1/zxKbn6NSL3qHGTZiMbkGwdFTFpRvAeH5txmDglbdAZCQxlrIYKu2MJwpaBqJizSbKaY8pRRJ83u6HyfF3qrevDPLb3hkeb2L9moXTQmxNf5pMUsN6lpF+eS5qEiEGnrfXsBDExy4x4r08kOProH07uFJDviFZoh9EDlYAo7tiDecKba+rap0uQAq7qyLd2vAYuJvoo6D+TfhaYRhrlv/Mb2PoPj5O8J0jP9dXXbyDkE1Z6UrjUqX66ZKULNMS9mRXmGzQQNLPHSVWai5HTB7obQCPjoflWe4W/68SvsQUQpneJqVdRTK75PQ6a6rCd3KnrVXHiKQjqdDOWYZ7gaiMivncPrWdy7Cqd/fHgmg6n+kfom6OJy9SD744jRgg5UWQbTqiIay
X-MS-Exchange-AntiSpam-MessageData: q0lehnSoz1mmWwUDE26T9xaJxK2Er2onoPz6VBPrFrxb8WbVmxme4s/K5qnNvJ7KtYa1ykXaMenM6STVyOgPOgTINX6bSOKtMVoFlip3PMhx1vLsH3acxZIRGT/9bVXGtNWeuceCU5KJrySPh6/+UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e51f3e1-1129-42ff-7316-08d7df4cbb90
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 01:48:15.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgOEtiP5BSpAK4sqEExJCtnHn3GT+cMjvTcC/zjQmO1+leuNy9fJEjtUSD6EZdJoXxFGRQKRCS9Wrtq83RbrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1674
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/11/20 12:24 AM, Coly Li wrote:
> When running mdadm monitor with scan mode, only one autorebuild process
> is allowed. check_one_sharer() checks duplicated process by following
> steps,
> 1) Read autorebuild.pid file,
>    - if file does not exist, no duplicated process, go to 3).
>    - if file exists, continue to next step.
> 2) Read pid number from autorebuild.pid file, then check procfs pid
>    directory /proc/<PID>,
>    - if the directory does not exist, no duplicated process, go to 3)
>    - if the directory exists, print error message for duplicated process
>      and exit this mdadm.
> 3) Write current pid into autorebuild.pid file, continue to monitor in
>    scan mode.
> 
> The problem for the above step 2) is, if after system reboots and
> another different process happens to have exact same pid number which
> autorebuild.pid file records, check_one_sharer() will treat it as a
> duplicated mdadm process and returns error with message "Only one
> autorebuild process allowed in scan mode, aborting".
> 
> This patch tries to fix the above same-pid-but-different-process issue
> by one more step to check the process command name,
> 1) Read autorebuild.pid file
>    - if file does not exist, no duplicated process, go to 4).
>    - if file exists, continue to next step.
> 2) Read pid number from autorebuild.pid file, then check procfs file
>    comm with the specific pid directory /proc/<PID>/comm
>    - if the file does not exit, it means the directory /proc/<PID> does
>      not exist, go to 4)
>    - if the file exits, continue next step
> 3) Read process command name from /proc/<PIC>/comm, compare the command
>    name with "mdadm" process name,
>    - if not equal, no duplicated process, goto 4)
>    - if strings are equal, print error message for duplicated process
>      and exit this mdadm.
> 4) Write current pid into autorebuild.pid file, continue to monitor in
>    scan mode.
> 
> Now check_one_sharer() returns error for duplicated process only when
> the recorded pid from autorebuild.pid exists, and the process has exact
> same command name as "mdadm".
> 

Consider another corner case: what if the recorded pid from
autorebuild.pid is actually used by other mdadm command, such as "mdadm
--wait"? It shouldn't report error now.

Thanks,
Lidong

> Reported-by: Shinkichi Yamazaki <shinkichi.yamazaki@suse.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  Monitor.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/Monitor.c b/Monitor.c
> index b527165..2d6b3b9 100644
> --- a/Monitor.c
> +++ b/Monitor.c
> @@ -301,26 +301,34 @@ static int make_daemon(char *pidfile)
>  
>  static int check_one_sharer(int scan)
>  {
> -	int pid, rv;
> +	int pid;
> +	FILE *comm_fp;
>  	FILE *fp;
> -	char dir[20];
> +	char comm_path[100];
>  	char path[100];
> -	struct stat buf;
> +	char comm[20];
> +
>  	sprintf(path, "%s/autorebuild.pid", MDMON_DIR);
>  	fp = fopen(path, "r");
>  	if (fp) {
>  		if (fscanf(fp, "%d", &pid) != 1)
>  			pid = -1;
> -		sprintf(dir, "/proc/%d", pid);
> -		rv = stat(dir, &buf);
> -		if (rv != -1) {
> -			if (scan) {
> -				pr_err("Only one autorebuild process allowed in scan mode, aborting\n");
> -				fclose(fp);
> -				return 1;
> -			} else {
> -				pr_err("Warning: One autorebuild process already running.\n");
> +		snprintf(comm_path, sizeof(comm_path),
> +			 "/proc/%d/comm", pid);
> +		comm_fp = fopen(comm_path, "r");
> +		if (comm_fp) {
> +			if (fscanf(comm_fp, "%s", comm) &&
> +			    strncmp(basename(comm), Name, strlen(Name)) == 0) {
> +				if (scan) {
> +					pr_err("Only one autorebuild process allowed in scan mode, aborting\n");
> +					fclose(comm_fp);
> +					fclose(fp);
> +					return 1;
> +				} else {
> +					pr_err("Warning: One autorebuild process already running.\n");
> +				}
>  			}
> +			fclose(comm_fp);
>  		}
>  		fclose(fp);
>  	}
> 
