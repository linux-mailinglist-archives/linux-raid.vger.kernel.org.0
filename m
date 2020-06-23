Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA9206272
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbgFWVCK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 17:02:10 -0400
Received: from mail-mw2nam12olkn2059.outbound.protection.outlook.com ([40.92.23.59]:64384
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404265AbgFWVCB (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jun 2020 17:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxkmsmrOy7SsAzcvNmIXyq9vyDJcKo+ZmI/dD+xwUC1KqenWD42y1qVYIhBPPTS8+7z3YaaLruaoZCAzu0CVb6n2WZqUQBYP9AOEIjJkS2PFUDukBCbuJArqu5N/XQZ8PHlOX4OuyT5vWyJTZIOKvCMQzVCIHMWyOWR4VXhc+P4QgIFAgiEKxdEEBPy/qI2tzyWanE6lau0AobMHQIyJjjQpyYfPCasSusgyURqG0tG4ceLuDSYyfTOPPGEVKOEHq5CdNoNyt8pOXGySU3AOKkNlatAF6j6eWgfOe72UU24nSZEMjTnxByoJ0fyv7rXXWT+pGmti+yCUH3kFIFZCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkuK9BswZTsgNusRGPdoL9ubAV4VRDq3K+1wf8SqleE=;
 b=Gc1+CU52QF6DkgD/Sj+jVNLvjiL4fkOK/ZAfGp1e4tuChAdl/Ps/fITzePXAouJ55qgtVbP4zVc3WKINuMe67olXjg5xXG/9IppxfX3gdxnwCGGGGcr+rKdNqqN4J+CZtaiUIA2fSVuLXN/Nmi2hWfW0qmXqFkDDdlMr7ZN5CCRG/G4K2XkbQUisvVMbkRXmgMaB+G+2a/SHMYPOl4kiI6j+ls17Y420Jlyq0abpuAJqWCHQFnPKOX8JR8W3bu0JbruUP7wVo4Dv/lT9CyuxgQv50qg/N34knBZdibA32BnykzHCQVjbZtikfYB4gYqh76elj5L5LMWOxGRWvnyDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkuK9BswZTsgNusRGPdoL9ubAV4VRDq3K+1wf8SqleE=;
 b=Dg1GQyQuYuNcqs6x15m6QiG+8oRpgqLEANO/J3u+tC3CNTxNwKv8UzjzSwVkwGjd2MRf621lOgEFjlY73rHSiuhfYj92JnrM5Jjkve1MI2MdzoYCGWFFPrEMfFHzTv3XzUzFqK9n6blEOIpPmFPZ0FD6HNh8p0gG/xahgQ9o9mLofhiK914Um9CBcwWWt+HEhbA+hdXOt5WuNnJipC3/6kg1pDcISwIoSkji9lorLrp85boyA+aFdswQMiKhgSPXooMSCawyAjFzSfnCmDZWegBNqLFtjB+Hki/lguQnEW1JnrJxkAJuQNjvAx8zf9C6MzxdPLQMK4qzGABy+s/+qA==
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::42) by
 MW2NAM12HT200.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::156)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.13; Tue, 23 Jun
 2020 21:01:59 +0000
Received: from CH2PR22MB1768.namprd22.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT050.mail.protection.outlook.com
 (2a01:111:e400:fc65::241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.13 via Frontend
 Transport; Tue, 23 Jun 2020 21:01:59 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A956743DC8B1841558CEFF67E51A00046C4ED1EF9403C83A2C5E2D5CAFC006A9;UpperCasedChecksum:D0D3C13C702E3310D4A46A85B10CFF6EC1B1682F36E671162696D8B2F85D620A;SizeAsReceived:8580;Count:46
Received: from CH2PR22MB1768.namprd22.prod.outlook.com
 ([fe80::cd8a:6d3c:b7f7:b7b9]) by CH2PR22MB1768.namprd22.prod.outlook.com
 ([fe80::cd8a:6d3c:b7f7:b7b9%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 21:01:59 +0000
To:     linux-raid@vger.kernel.org
From:   Alexander Murashkin <AlexanderMurashkin@msn.com>
Subject: stripe_cache_size and journal (cache) in write-back mode
Message-ID: <CH2PR22MB1768B9C137438BD5F512A73BD5940@CH2PR22MB1768.namprd22.prod.outlook.com>
Date:   Tue, 23 Jun 2020 16:01:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: CH2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:610:50::24) To CH2PR22MB1768.namprd22.prod.outlook.com
 (2603:10b6:610:86::10)
X-Microsoft-Original-Message-ID: <0a5eb253-9ccd-564c-316d-973651ade195@msn.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from glaive.castle.aimk.com (98.226.243.162) by CH2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:610:50::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 21:01:59 +0000
X-Microsoft-Original-Message-ID: <0a5eb253-9ccd-564c-316d-973651ade195@msn.com>
X-TMN:  [CGa8auMLOi8/zp6PjWW7tmVFL0XC/8d6]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 98fa23bd-4a46-4571-5a43-08d817b8ab77
X-MS-TrafficTypeDiagnostic: MW2NAM12HT200:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTZSA26URmaUsjWJQpASXyUtjPyTxqy9A6DJ440FU7IYHbj0x2LtSkpkYLaldcYYvMhxclNkB1EGny5ffXku4OXN8Ig6HGn6aFTiEaIrqoucwwaqWGUdnPRzj7vr9ZZ9CJFl8BxK+oOtKtzWcGxu05BYqdTRodomuF66Qep3Cg8mIXYo554c+5+2yBbhqgmwKRcdY89Kg0VHHS5YFrmZUtXHyaLCPPPRJUgfyXTQFCjDXbNX76fmQwiHTXMYDg6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB1768.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: bnX9i4xWMuAq7BASurS0WO6EthGWqd2Xf9ke7jAKtUrJyF0J/crDvYcNUuqhnaEszD2uLVtJPe4MPuHtyhuvTJvGbnwt/g71RTNwV5YtQDWO2o2UGQNZ59HT/nBTP3CROryzlyJX2seCHy5Qs1aDoA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fa23bd-4a46-4571-5a43-08d817b8ab77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 21:01:59.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT200
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear MD,

After reading md documentation describing stripe_cache_size and journal 
(cache) in write-back mode, I found some inconsistencies

- sometimes the documentation states that the cache is for RAID 4/5/6, 
sometimes just for RAID 5
- it is nothing explicitly said about the cache block device size and 
how one is related to the memory cache size
- it is stated that the memory cache <includes> the same data stored on 
cache disk - that is somewhat ambiguous
- stripe_cache_size is the number of pages per device, but it is also 
called the number of entries

Here are some statements about the journal. Could somebody confirm that 
they are true (or not)?

- the journal and all its features can be used with md RAID 4/5/6
- references to RAID 5 only are wrong (in regards to the journal)
- cache block device size in bytes shall be the same as memory cache 
size in bytes
- any extra block device or memory space (larger than the minimum of 
cache block device and memory cache sizes) is not used
- the cache block device and the memory cache contain the same data
- the cache entry is exactly one page (so the number of pages and the 
number of entries are the same)

Below are few extracts from the related documentation, for your convenience.

md(4)
====

     md/stripe_cache_size
         This is only available on RAID5 and RAID6. It records the size 
(in pages per device) of the stripe cache which
         is used for synchronising all write operations to the array and 
all read operations if the array is degraded.
         memory_consumed = system_page_size * nr_disks * stripe_cache_size

https://www.kernel.org/doc/Documentation/md/raid5-cache.txt
=======================================

RAID5 cache
------------------

Raid 4/5/6 could include an extra disk for data cache...

write-back mode:
------------------------

Write-back cache will aggregate the data and flush the data to RAID 
disks only after the data becomes a full stripe write...
In write-back mode, MD also caches data in memory. The memory cache 
includes the same data stored on cache disk, ...
A user can configure the size by: echo "2048" > 
/sys/block/md0/md/stripe_cache_size

The implementation:
-----------------------------

In write-back mode, MD writes IO data to the log and reports IO 
completion. The data is also fully cached in memory at that
time, which means read must query memory cache. If some conditions are 
met, MD will flush the data to RAID disks
... MD will write both data and parity into RAID disks, then MD can 
release the memory cache. The flush conditions could be
stripe becomes a full stripe write, free cache disk space is low or free 
in-kernel memory cache space is low.

https://www.kernel.org/doc/html/latest/admin-guide/md.html
======================================

stripe_cache_size (currently raid5 only)
     number of entries in the stripe cache...
