Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2522DDBC
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jul 2020 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgGZJXB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jul 2020 05:23:01 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:44923 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgGZJXA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 Jul 2020 05:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595755376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7n2cAa0xazLcC36+eggW8dbpDdsE9OW2EGdMTvqxLo=;
        b=Po2Djc4r8aZMeUKTdpfBKB8R/Upz6xfQWFx7ZfneorJhjQEGapPzJyKyZREFbZJ/ioKTxZ
        0Z0frd9FCRDIWCbN6HCLTzETdd/41CNCd/nQSx5bTLPpiIdNYYklifllmNKyitlNaqXRBB
        kpuSM/foKPkrHGCyZ2VAq2Eh1x+4rek=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-EPGcTcPXNWuphYNfIQOk0Q-2;
 Sun, 26 Jul 2020 11:22:55 +0200
X-MC-Unique: EPGcTcPXNWuphYNfIQOk0Q-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0MExJSydE5ChTqW6bdwn8dDSkUt/GOO4/oyNygIuijc+qcxa5LDVhIsGWzySY5HB1XlHToKM7kHxZmiCYkqIipyiu8kq03pMSrn6eBS3ePfRlv9kFy4AOi1gI3XM8cGOmMfmaRpemb/0NsueMmeGzrXoRwfWU0cP/ou9YfqzRdiqI+ACrXJlhYretay/72w9NTCuR+WmfNkFdlQ5F5H8LyRtG3mvNtoKQe+xSzP492qWVgiA7YdPeIGbtpG7GjwFo/M0S9z1L4MuMTEXmNkPzEUeEzD82phwezuPtlqZuTpWD3Ot1YddNc0+nPHVBUyF8hx1grqp3qQCRneogqFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7n2cAa0xazLcC36+eggW8dbpDdsE9OW2EGdMTvqxLo=;
 b=d09OOrzovIDmoz8+RpD7mOggWFcKvIgR2lMAmSTJ0fv/12rEtfAbWbg5Ow9jXySbzdHE7YCfmhJ2+FATCrFP0oo1tT+74Z9uwnZAYsLHjsMizIr7KfxyC84S5sW0YHHrqw/qojxbw+j8bTB1AzTbr7bmYeGHz8gMh8pXZJNyf0GNswF/aCvACo/hQ0AkqLkVdDbNT3QCSXc0RL96NGOShdQY5vUNgOF0kMmmNMwNAbvi1wa5kKiI83azP7wZiXN4m2kROfuPYdo4/LI+PAGZS1YxkDBA1ESpaZYrQYC5+8DI7uy6zA6Mm5tq/VYCACoZUWp7gOBuMr8kzaGzlnW02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: trained-monkey.org; dkim=none (message not signed)
 header.d=none;trained-monkey.org; dmarc=none action=none
 header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4665.eurprd04.prod.outlook.com (2603:10a6:5:38::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.26; Sun, 26 Jul 2020 09:22:52 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3216.030; Sun, 26 Jul 2020
 09:22:52 +0000
Subject: Re: [PATCH v2] mdadm/Detail: show correct state for cluster-md array
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com, jes@trained-monkey.org
References: <1595401905-3459-1-git-send-email-heming.zhao@suse.com>
 <7697b7eb-76f9-8102-a490-1684e5f18acf@suse.com>
 <5F1D3B50.8080006@youngman.org.uk>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <7aeb1f5a-df3c-183e-93cd-61631a40e9b5@suse.com>
Date:   Sun, 26 Jul 2020 17:22:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5F1D3B50.8080006@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.131.123) by HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Sun, 26 Jul 2020 09:22:50 +0000
X-Originating-IP: [123.123.131.123]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7141693e-2d28-49e9-441e-08d83145787f
X-MS-TrafficTypeDiagnostic: DB7PR04MB4665:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB46650BE55A6AABDCB37CC74B97750@DB7PR04MB4665.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Y4cdiyeZgx2y9G12xlq9g9xErpP7tj8fx332k2x3qKB5S1MpmIkjqT9DGLhQGr4nNEjMwgycjtHVO2MLyAJrV327w0IMgq7hibqxInDlKINcrXDlfXravc56nTVH0phMhjTeIAtm1PmMnxqGN6Zt2Q/ODAmggKuHyv4fg9qsMXAGGl0qJU2WAWdAz5P0EUK0C5Ysd8lQKfwPE2AU88QRD8b70IV0uYj651AiWb4BY+KRqDcX6MUc2elYtLT4BpH4ion4TSi5IQNOIIo7F+lzPGdE3Axelq/3Lg/Vc/S5Efoukko7m632QXa+uo1llhpChCbs9yEmP6hA4+S8G0ivHWmhzTY5ky6E0uchWMoHEv3enjC/1ihsHn3f+CKt5oL+qqbP6ByBj/qsrso8Ju+4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(366004)(396003)(346002)(31696002)(16526019)(53546011)(8936002)(52116002)(6512007)(4326008)(186003)(478600001)(5660300002)(31686004)(8676002)(86362001)(6506007)(2906002)(6486002)(316002)(83380400001)(2616005)(36756003)(66946007)(956004)(8886007)(66556008)(6666004)(66476007)(26005)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZadkRQJp4l1ntVchXu/ah4PnEXPmidu7kIJf4azohrGviUDSG8C2tZ+2MBxEs7RyZHI7slTQzAzuUAA/6lc3KwlLzaw1+7HdHRjkfJV5z1xmcNaDr7e3eva5urs1x7Nrb7C7YksVePinGVzlsAysz7FuEe4E2wJI/1x9F54imz2jQT61gV3yGCaT8c3a/jZUAzCPO1Rno8gnRvA5HS9QPMBayZXtGKKP7CXpPjr8+Pb1Y/+lOwN36GUjFN/HfKrJ63F3P8x7Lh1h4KQpTHUs9RQRgg3OEuLFNwI5yQsY2ljNcyas9yrltfoAySAYEqz42KweMmQtE41FdNCEv1uHrwplkIsNAFxZ37jglAEPqngQTIr01gGuB73YNO5H/8ydN1xcc3m510dHQzqFv7Tg5FK+VsX8jfS1z++vdfzlRzdhyUCSOgHpG8DOP5tEaco35ZCCNIwqDkNZnPSV4xg5cfvk/NojmsZigR/tQXqwuYA=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7141693e-2d28-49e9-441e-08d83145787f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2020 09:22:52.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvc6QOXkYnvq0JPG0ORnRwGdDOk68sdbUCTTfzZL6rWvLbOgFaiTGK8TDSRCWvNymod2uP6ziXjAGC9xFeIGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4665
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Wols,

I just started to learn mdadm code. Maybe there are some historical reasons to keep leaked issue. 
I guess your said daemon mode is: "mdadm --monitor --daemonise ...".
After very quickly browsing the code in Monitor.c, these mode check /proc/mdstat, send ioctl GET_ARRAY_INFO, and
read some /sys/block/mdX/md/xx files. There is no way to call ExamineBitmap().
In currently mdadm code, the only way to call ExamineBitmap() is by cmd "mdadm -X /dev/sdX". So as my last mail said, when the mdadm program finish, all leaked memory will be released.
And last week, before I send v2 patch, I try to use valgrind to check memory related issue, there are many places to leak. e.g. 
```
<1>
# valgrind --leak-check=full  ./mdadm -D /dev/md0
... ...
==3929== 
==3929== HEAP SUMMARY:
==3929==     in use at exit: 12,991 bytes in 190 blocks
==3929==   total heap usage: 354 allocs, 164 frees, 2,414,075 bytes allocated
==3929== 
==3929== 184 bytes in 1 blocks are definitely lost in loss record 15 of 24
==3929==    at 0x4C306B5: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==3929==    by 0x47EB4C: xcalloc (xmalloc.c:62)
==3929==    by 0x4495E2: match_metadata_desc1 (super1.c:2316)
==3929==    by 0x4125CE: super_by_fd (util.c:1213)
==3929==    by 0x424E53: Detail (Detail.c:103)
==3929==    by 0x408AAA: misc_list (mdadm.c:1970)
==3929==    by 0x407CEF: main (mdadm.c:1640)
==3929== 
==3929== LEAK SUMMARY:
==3929==    definitely lost: 184 bytes in 1 blocks
==3929==    indirectly lost: 0 bytes in 0 blocks
==3929==      possibly lost: 0 bytes in 0 blocks
==3929==    still reachable: 12,807 bytes in 189 blocks
==3929==         suppressed: 0 bytes in 0 blocks
==3929== Reachable blocks (those to which a pointer was found) are not shown.
==3929== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==3929== 
==3929== For lists of detected and suppressed errors, rerun with: -s
==3929== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)


<2>
valgrind --leak-check=full  ./mdadm -X /dev/sda
 ... ...
==4077== 
==4077== HEAP SUMMARY:
==4077==     in use at exit: 8,944 bytes in 58 blocks
==4077==   total heap usage: 161 allocs, 103 frees, 458,399 bytes allocated
==4077== 
==4077== 184 bytes in 1 blocks are definitely lost in loss record 13 of 19
==4077==    at 0x4C306B5: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4077==    by 0x47EB4C: xcalloc (xmalloc.c:62)
==4077==    by 0x412885: guess_super_type (util.c:1290)
==4077==    by 0x47359F: guess_super (mdadm.h:1222)
==4077==    by 0x473C1C: bitmap_file_open (bitmap.c:205)
==4077==    by 0x473DB1: ExamineBitmap (bitmap.c:253)
==4077==    by 0x408B62: misc_list (mdadm.c:1988)
==4077==    by 0x407CEF: main (mdadm.c:1640)
==4077== 
==4077== 736 bytes in 4 blocks are definitely lost in loss record 15 of 19
==4077==    at 0x4C306B5: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4077==    by 0x47EB4C: xcalloc (xmalloc.c:62)
==4077==    by 0x412885: guess_super_type (util.c:1290)
==4077==    by 0x47359F: guess_super (mdadm.h:1222)
==4077==    by 0x473C1C: bitmap_file_open (bitmap.c:205)
==4077==    by 0x4742A5: ExamineBitmap (bitmap.c:337)
==4077==    by 0x408B62: misc_list (mdadm.c:1988)
==4077==    by 0x407CEF: main (mdadm.c:1640)
==4077== 
==4077== LEAK SUMMARY:
==4077==    definitely lost: 920 bytes in 5 blocks
==4077==    indirectly lost: 0 bytes in 0 blocks
==4077==      possibly lost: 0 bytes in 0 blocks
==4077==    still reachable: 8,024 bytes in 53 blocks
==4077==         suppressed: 0 bytes in 0 blocks
==4077== Reachable blocks (those to which a pointer was found) are not shown.
==4077== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==4077== 
==4077== For lists of detected and suppressed errors, rerun with: -s
==4077== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)


<3>
# valgrind --leak-check=full  ./mdadm -a /dev/md0 /dev/sdc
  ... ...
==4096== Warning: noted but unhandled ioctl 0x1269 with no size/direction hints.
==4096==    This could cause spurious value errors to appear.
==4096==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
mdadm: added /dev/sdc
==4096== Syscall param write(buf) points to uninitialised byte(s)
==4096==    at 0x512C244: write (in /lib64/libc-2.26.so)
==4096==    by 0x57FB706: ??? (in /usr/lib64/libdlm_lt.so.3.0)
==4096==    by 0x57FC0F1: dlm_ls_unlock (in /usr/lib64/libdlm_lt.so.3.0)
==4096==    by 0x40F84E: cluster_release_dlmlock (util.c:198)
==4096==    by 0x40837B: main (mdadm.c:1780)
==4096==  Address 0x1ffefffc0e is on thread 1's stack
==4096==  in frame #2, created by dlm_ls_unlock (???:)
==4096== 
==4096== Syscall param write(buf) points to uninitialised byte(s)
==4096==    at 0x512C244: write (in /lib64/libc-2.26.so)
==4096==    by 0x57FC4E0: dlm_release_lockspace (in /usr/lib64/libdlm_lt.so.3.0)
==4096==    by 0x40F906: cluster_release_dlmlock (util.c:218)
==4096==    by 0x40837B: main (mdadm.c:1780)
==4096==  Address 0x1ffeffeb5e is on thread 1's stack
==4096==  in frame #1, created by dlm_release_lockspace (???:)
==4096== 
==4096== 
==4096== HEAP SUMMARY:
==4096==     in use at exit: 13,737 bytes in 197 blocks
==4096==   total heap usage: 278 allocs, 81 frees, 3,253,146 bytes allocated
==4096== 
==4096== 184 bytes in 1 blocks are definitely lost in loss record 19 of 30
==4096==    at 0x4C306B5: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4096==    by 0x47EB4C: xcalloc (xmalloc.c:62)
==4096==    by 0x4495E2: match_metadata_desc1 (super1.c:2316)
==4096==    by 0x4125CE: super_by_fd (util.c:1213)
==4096==    by 0x419258: Manage_subdevs (Manage.c:1344)
==4096==    by 0x407398: main (mdadm.c:1477)
==4096== 
==4096== 184 bytes in 1 blocks are definitely lost in loss record 20 of 30
==4096==    at 0x4C306B5: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4096==    by 0x47EB4C: xcalloc (xmalloc.c:62)
==4096==    by 0x4127E7: dup_super (util.c:1268)
==4096==    by 0x417D73: Manage_add (Manage.c:813)
==4096==    by 0x419C3F: Manage_subdevs (Manage.c:1564)
==4096==    by 0x407398: main (mdadm.c:1477)
==4096== 
==4096== LEAK SUMMARY:
==4096==    definitely lost: 368 bytes in 2 blocks
==4096==    indirectly lost: 0 bytes in 0 blocks
==4096==      possibly lost: 0 bytes in 0 blocks
==4096==    still reachable: 13,369 bytes in 195 blocks
==4096==         suppressed: 0 bytes in 0 blocks
==4096== Reachable blocks (those to which a pointer was found) are not shown.
==4096== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==4096== 
==4096== Use --track-origins=yes to see where uninitialised values come from
==4096== For lists of detected and suppressed errors, rerun with: -s
==4096== ERROR SUMMARY: 5 errors from 5 contexts (suppressed: 0 from 0)
```

Thanks,
heming

On 7/26/20 4:14 PM, Wols Lists wrote:
> On 22/07/20 08:20, heming.zhao@suse.com wrote:
>> During I was creating patch, I found the ExamineBitmap() has memory leak issue.
>> I am not sure whether the leak issue should be fixed.
>> (Because when mdadm cmd finish, all leaked memory will be released).
>> The IsBitmapDirty() used some of ExamineBitmap() code, and I only fixed leaked issue in IsBitmapDirty().
>>
> My gut feel?
> 
> Firstly, "do things right" - it should be fixed.
> Second - are you sure this code is not run while mdadm is running as a
> daemon? It's all very well saying it will be released, but but mdadm
> could be running for a looonnngg time.
> 
> Cheers,
> Wol
> 

