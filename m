Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC454AD21
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jun 2022 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354730AbiFNJUf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jun 2022 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiFNJUf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jun 2022 05:20:35 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 02:20:33 PDT
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B143AF7
        for <linux-raid@vger.kernel.org>; Tue, 14 Jun 2022 02:20:33 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 820805A5
        for <linux-raid@vger.kernel.org>; Tue, 14 Jun 2022 09:14:43 +0000 (UTC)
Date:   Tue, 14 Jun 2022 14:14:42 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     linux-raid@vger.kernel.org
Subject: How to enable bitmap on IMSM?
Message-ID: <20220614141442.1971c876@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I upgraded mdadm to 4.2 to get the bitmap support in IMSM.

I run: "mdadm --update-subarray=0 -U bitmap /dev/md127"
However the array details stay the same, with "Consistency Policy : resync".
No error is reported, and nothing in dmesg.

How to actually use it?

Thanks


# mdadm --detail /dev/md127
/dev/md127:
           Version : imsm
        Raid Level : container
     Total Devices : 4

   Working Devices : 4


              UUID : d07837ca:804cf5e3:01c52352:f64b0524
     Member Arrays : /dev/md/Volume0

    Number   Major   Minor   RaidDevice

       -       8       32        -        /dev/sdc
       -       8        0        -        /dev/sda
       -       8       48        -        /dev/sdd
       -       8       16        -        /dev/sdb

# mdadm --detail /dev/md126
/dev/md126:
         Container : /dev/md/imsm0, member 0
        Raid Level : raid10
        Array Size : 1953519616 (1863.02 GiB 2000.40 GB)
     Used Dev Size : 976759808 (931.51 GiB 1000.20 GB)
      Raid Devices : 4
     Total Devices : 4

             State : active 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0

            Layout : near=2
        Chunk Size : 64K

Consistency Policy : resync


              UUID : xxx
    Number   Major   Minor   RaidDevice State
       3       8        0        0      active sync set-A   /dev/sda
       2       8       16        1      active sync set-B   /dev/sdb
       1       8       32        2      active sync set-A   /dev/sdc
       0       8       48        3      active sync set-B   /dev/sdd

# mdadm --update-subarray=0 -U bitmap /dev/md127

# mdadm --detail /dev/md127
/dev/md127:
           Version : imsm
        Raid Level : container
     Total Devices : 4

   Working Devices : 4


              UUID : d07837ca:804cf5e3:01c52352:f64b0524
     Member Arrays : /dev/md/Volume0

    Number   Major   Minor   RaidDevice

       -       8       32        -        /dev/sdc
       -       8        0        -        /dev/sda
       -       8       48        -        /dev/sdd
       -       8       16        -        /dev/sdb

# mdadm --detail /dev/md126
/dev/md126:
         Container : /dev/md/imsm0, member 0
        Raid Level : raid10
        Array Size : 1953519616 (1863.02 GiB 2000.40 GB)
     Used Dev Size : 976759808 (931.51 GiB 1000.20 GB)
      Raid Devices : 4
     Total Devices : 4

             State : active 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0

            Layout : near=2
        Chunk Size : 64K

Consistency Policy : resync


              UUID : xxx
    Number   Major   Minor   RaidDevice State
       3       8        0        0      active sync set-A   /dev/sda
       2       8       16        1      active sync set-B   /dev/sdb
       1       8       32        2      active sync set-A   /dev/sdc
       0       8       48        3      active sync set-B   /dev/sdd



-- 
With respect,
Roman
