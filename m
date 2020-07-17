Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8BA2231D4
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 05:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQD4f (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 23:56:35 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:29742 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGQD4e (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 23:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594958190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lwn7lHC38IoMVzd+M5dIZl0mbUwqG1wPX8dSihZ1Zw=;
        b=d2vQ2scNAWYpQTLiOXu9RfCLlBBTJ2t3pYdJVe20IOb8oqSFKxhY5kgdhAxsPwiP/7/POr
        aJED0AkeXdu2/5tjBoKh0ROV9Mo9lOlrmtTnDSZS3LJsC2k8hhSugfuHcBC5xTKqA38IJZ
        E4KqieO7Zg6qElXTDuEcX6nWXvORAzA=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-j0s5qJOhOwmDhj_v3ZbMvw-1; Fri, 17 Jul 2020 05:56:29 +0200
X-MC-Unique: j0s5qJOhOwmDhj_v3ZbMvw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4iS81Lreo+zQIBAhRyScWl6ciT/A735o5osm4M4xyOJyV+njFzkR2JB2I27fYKKF6mDt0bT4WXRMweLKBLAQ3/z56fLYOeACBjwow3X4pOTA+8eH34s9yLcPIoQ/fXZDF7axFFweJxpJYMlOqO7+GSXftjE+aam6fu/8YbGfpnPFt/lfxj7ox4H/fkD6oMD1yzRxFHpJsOph754W2jRH25o8sHHQjjAB0Zu3eaF2H2yVYoLMBlZU7Bnvk1A2LpXIVZ3QRi9PI5pOlVFRrKK1GHwuURyG/5fiT+xO6ENuxBngXKKq7rUnYGK3FXIGBTdBwMCy+KM8raZq4Nm+SFrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lwn7lHC38IoMVzd+M5dIZl0mbUwqG1wPX8dSihZ1Zw=;
 b=J3u9Elj8LsPS8urYdTlIa8/YV1lB4kGodUEn25ywSM7QlgGd7YFeuqwXMtH60pRNo17zQCAhJWPYuXNaomc3mKwxTXArFIOs5YsxtYDJ38NfsGvf4Xf/jDfh1p2Hp0qG0tY4ez0xBi6aq3v5z9eWAwbdmTMrwt6HCP5cvqrAYNqxIXiK9NtqEDsXKMCu2nQRoceQefFxySR/rkzGHKHtpfUHLyZHACBex/1BAF0mfcXaPKX6nQ00oEtZ8FO8TXjVp93/eo87OljkZy9JtOSAmrGmYRuubsOCs8Kuxs+m13n7Et9bp9GIwm+g+Q4npeUkA3YYqt6kBqAsWkIF/oRvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB8PR04MB5644.eurprd04.prod.outlook.com (2603:10a6:10:a4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Fri, 17 Jul 2020 03:56:27 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 03:56:27 +0000
Subject: Re: [PATCH v2] md-cluster: fix safemode_delay value when converting
 to clustered bitmap
To:     NeilBrown <neil@brown.name>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com, song@kernel.org
References: <1594911043-16956-1-git-send-email-heming.zhao@suse.com>
 <87wo33vxqo.fsf@notabene.neil.brown.name>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <f1e24754-d221-4ef2-8b2f-42cfcdca51f6@suse.com>
Date:   Fri, 17 Jul 2020 11:56:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <87wo33vxqo.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR04CA0062.apcprd04.prod.outlook.com (2603:1096:202:14::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 03:56:25 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514b9d92-1e71-4855-83ba-08d82a056146
X-MS-TrafficTypeDiagnostic: DB8PR04MB5644:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB56446909B3340FA9185E7FEA977C0@DB8PR04MB5644.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgOiq2ZfnUpeBWtiGc2e0QyoewwvTKLTJ+HT8Wfv5Hdu91Ee0xViW1pPwIes3YX2RSUVU4yLFoJ5cze85u3wyi5O822rExYEn71M1MK4dKY8cKyyc21cI4Dx1SQJ84khDkL/whGdHSWuo0M8JLxzDnVTCVfFN2s7G5CuBL8TTjLLs+QrNlUnlUObVfY5RjE3lqp/k8z6rJUvtrjSLbHPs/NH0IZ0RkXQKzG1CvnTWse+XFKz2qMDnww5XnHqQhNU7GfudMzwMe3/L9vjNINiiSOaYvYYrsNLcuEREMPnL0AgJDEsi0DiNb19NYFiRj2U6DL20xapYTJmjK9ophWZdccInOm044BdH4DPdfr9NRYQ0vNIh8KA51bH4eIXIRRGMTbIzcEgBTUG2Ji5hq8EtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(8886007)(6486002)(316002)(53546011)(6506007)(6512007)(2906002)(16526019)(83380400001)(956004)(31696002)(31686004)(2616005)(186003)(6666004)(36756003)(8676002)(8936002)(478600001)(66946007)(66556008)(5660300002)(26005)(52116002)(86362001)(66476007)(4326008)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SNiSFzZDSL/TfxnIoKx6WcJs8+k3d+mdyJXVAzGUkau/UcC8RQgaucMP/wJltMJ/6uWoo+BsuKO0WyE53a8XkMhCauBn5FMBBF4l/ZHO3jMDFmZfArz2cp9rRaITj3pzjVenQ/VxP69BXZLDlewFkwHNTg9YD8nwz5yxTsfyYJPAeNYj1cpQloNfkmIEEIpjQ6nfXJvjxsEinztwd1KHOJ7ii8A1CWihldyYTh+0qsrnzrvLt3pQu7o84qLrhh5y0i3CQSHboACrMvpB2mbjzRn12RFYIwYtW7LHILN8mL0ZL7OESa64cqN2e1kq/ZVqQR5prU+IiLlYb4kieUZS66ljV7BrOmVRhTf17Ax8lfddyDa03OQlGK19MWGUHImZHvrVcp0lvhcaze54Y4n++ZObhjW7lSObKd0K2nMGA3IGSPIreIeL7u5MUEyKB94OMHisX/GxqTxMGCKtNmh0hGIOznE5+GQmLNwWcAaN/ng=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514b9d92-1e71-4855-83ba-08d82a056146
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 03:56:27.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgnQWCliX1RhL6FiTI4IvS3iOkWf+JEaFZqCnVVT+NhOqkyQPOIeRygrXxuwk2vPLuMsOlAmKZ5yV0drjwK/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5644
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 7/17/20 7:36 AM, NeilBrown wrote:
> On Thu, Jul 16 2020, Zhao Heming wrote:
> 
>> When array convert to clustered bitmap, the safe_mode_delay doesn't clean and vice versa.
>> the /sys/block/mdX/md/safe_mode_delay keep original value after changing bitmap type.
... ...
>>   			}
>>   			mddev_suspend(mddev);
>>   			md_bitmap_destroy(mddev);
>> @@ -8366,6 +8369,7 @@ int md_setup_cluster(struct mddev *mddev, int nodes)
>>   	}
>>   	spin_unlock(&pers_lock);
>>   
>> +	mddev->safemode_delay = 0;
>>   	return md_cluster_ops->join(mddev, nodes);
> 
> ->join can fail.
> I'd rather you checked the error there, and only clear safemode_delay if
> the return value is zero.
> 
> NeilBrown
> 
accept, I was aware of this issue after I sent the patch.
the md_cluster_stop() looks a good place to do the clear job.
md_bitmap_read_sb will call md_cluster_stop when md_setup_cluster return error.
I will send patch v3 after I finish test.

btw,
with investigation safemode_delay bug, I found there is another bug with cluster-md:
md_cluster module can't rmmod in some condition.

below test using original SUSE leap15.2 kernel (5.3.18-xx)
```
node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
mdadm: array /dev/md0 started.
node1 # lsmod | egrep  "raid|md_"
md_cluster             28672  1
raid1                  53248  1
md_mod                176128  2 raid1,md_cluster
dlm                   212992  14 md_cluster
node1 # mdadm -S --scan
node1 # lsmod | egrep  "raid|md_"
md_cluster             28672  0
raid1                  53248  0
md_mod                176128  2 raid1,md_cluster
dlm                   212992  9 md_cluster       <=== looks cluster-md holds sth, but md_cluster can rmmod now.

node1 # mdadm --zero-superblock /dev/sd{a,b}
node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
node1 # mdadm -G /dev/md0 -b none
node1 # lsmod | egrep  "raid|md_"
md_cluster             28672  1
raid1                  53248  1
md_mod                176128  2 raid1,md_cluster
dlm                   212992  9 md_cluster
node1 # mdadm -S --scan
node1 # lsmod | egrep  "raid|md_"
md_cluster             28672  1   <=== something still live
raid1                  53248  0
md_mod                176128  2 raid1,md_cluster
dlm                   212992  9 md_cluster
```

I plan to fix this rmmod bug after I fixing mdadm show active issue.
> 
>>   }
>>   
>> -- 
>> 1.8.3.1

