Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1E169929
	for <lists+linux-raid@lfdr.de>; Sun, 23 Feb 2020 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBWRrA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 23 Feb 2020 12:47:00 -0500
Received: from eva.aplu.fr ([91.224.149.41]:54984 "EHLO eva.aplu.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWRrA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 23 Feb 2020 12:47:00 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 12:47:00 EST
Received: from eva.aplu.fr (eva.aplu.fr [127.0.0.1])
        by eva.aplu.fr (Postfix) with ESMTP id 6422212BF
        for <linux-raid@vger.kernel.org>; Sun, 23 Feb 2020 18:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1582479537; bh=Fi83sc3Lq4fHVtFUdFSMDlmfhyXyzwuj9uiMhtw8Tzw=;
        h=To:From:Subject:Date:From;
        b=fE8QDP82CONqxowfz43jbgZhurQChhZ1EO9eZ3ScJuOFW/SBEPkqJEsKUvveMepB3
         l8zNhCfp3vxPU5zGNf7sPF8CKEWyAw7628aeqCZDLGXvjDN4Qf5pESBpWda0zZ7eRx
         10Bb/bJhm7nHOSE5sTMIM4KCJ0JABZU0dFE5nw5PmHc4hJvd0/p+QFhcaYnUrWJ7Zv
         c6Cr9aSijAem+i/PkXVe3HYi4WEPKWTYUfAX2K9671E1ys+WjBwIbc4iEeHqFyaxuM
         GJAYLUO7TeEmUtcriu1zcXPF9yWL8z3H6/RevG6FBBp2jahcshMn8DUjx+lb58EAkW
         bdgN4d+5uWX9iNB7PSX4URznHs51vpTldJUufUM4dqOU+6xUzqSwYTsF9xpe2sCB+t
         8+RKyHvaZC90o30tiHQVyMn/F/yyRC/uiU8zwxAJAUIDCYOvrJ9BIDD6ClEr6x1Bxx
         IwglJhJYa12Dw3Nr5WU/chlT5wBmpnghpbrzSmNj1p/LcyRpdpYEoe8miAu546DCa+
         Ft4ytqMBCbL2vV9Cl8ZhamNEbarP7xXLM+8ql9hmb80t/EsaJ6J+17kmlLTUornhC6
         U5CzX8JcGDvIroTM7rs+bb9qYgcGJzbAjA32U4vPqUnaHtQwOhFzLvVcHiiGjGS76e
         iB6oKzY2hNpzG+QL+lxmRq2s=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on eva.aplu.fr
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        SHORTCIRCUIT shortcircuit=ham autolearn=disabled version=3.4.2
Received: from [IPv6:2a03:7220:8081:2901::1002] (unknown [IPv6:2a03:7220:8081:2901::1002])
        by eva.aplu.fr (Postfix) with ESMTPSA id 0234E1160
        for <linux-raid@vger.kernel.org>; Sun, 23 Feb 2020 18:38:56 +0100 (CET)
Authentication-Results: eva.aplu.fr; dmarc=fail (p=none dis=none) header.from=aplu.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1582479537; bh=Fi83sc3Lq4fHVtFUdFSMDlmfhyXyzwuj9uiMhtw8Tzw=;
        h=To:From:Subject:Date:From;
        b=fE8QDP82CONqxowfz43jbgZhurQChhZ1EO9eZ3ScJuOFW/SBEPkqJEsKUvveMepB3
         l8zNhCfp3vxPU5zGNf7sPF8CKEWyAw7628aeqCZDLGXvjDN4Qf5pESBpWda0zZ7eRx
         10Bb/bJhm7nHOSE5sTMIM4KCJ0JABZU0dFE5nw5PmHc4hJvd0/p+QFhcaYnUrWJ7Zv
         c6Cr9aSijAem+i/PkXVe3HYi4WEPKWTYUfAX2K9671E1ys+WjBwIbc4iEeHqFyaxuM
         GJAYLUO7TeEmUtcriu1zcXPF9yWL8z3H6/RevG6FBBp2jahcshMn8DUjx+lb58EAkW
         bdgN4d+5uWX9iNB7PSX4URznHs51vpTldJUufUM4dqOU+6xUzqSwYTsF9xpe2sCB+t
         8+RKyHvaZC90o30tiHQVyMn/F/yyRC/uiU8zwxAJAUIDCYOvrJ9BIDD6ClEr6x1Bxx
         IwglJhJYa12Dw3Nr5WU/chlT5wBmpnghpbrzSmNj1p/LcyRpdpYEoe8miAu546DCa+
         Ft4ytqMBCbL2vV9Cl8ZhamNEbarP7xXLM+8ql9hmb80t/EsaJ6J+17kmlLTUornhC6
         U5CzX8JcGDvIroTM7rs+bb9qYgcGJzbAjA32U4vPqUnaHtQwOhFzLvVcHiiGjGS76e
         iB6oKzY2hNpzG+QL+lxmRq2s=
To:     linux-raid@vger.kernel.org
From:   Aymeric <mulx@aplu.fr>
Subject: mdadm RAID1 with 3 disks active on 2 disks configuration
Autocrypt: addr=mulx@aplu.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4cf4cbe7-989e-d7ec-cad9-cfde022bd4bf@aplu.fr>
Date:   Sun, 23 Feb 2020 18:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I've a system with a RAID1 using two disks (sda + sdb) + 1 spare (sdc).

For some stupid reason (cable) the spare (sdc) became active and sda was
out the array.

I then added back sda to the RAID1 but now I've RAID1 with three active
disks and zero spare.
I don't understand why the spare device didn't switch back as spare
after sda have been rebuild.

I used the following command to add sda to the RAID1:
# mdadm  /dev/md0 --add /dev/sda3


What did I do wrong here? And how to fix it? Do I have to set sdc to
faulty and add it back?

Thanks!

Here are the RAID1 status:

# cat /proc/mdstat
Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5]
[raid4] [raid10]
md0 : active raid1 sda3[2] sdc3[3](W)(R) sdb3[0]
      976015360 blocks super 1.2 [2/3] [UU]
      bitmap: 1/8 pages [4KB], 65536KB chunk

# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Wed Sep  5 09:45:55 2018
        Raid Level : raid1
        Array Size : 976015360 (930.80 GiB 999.44 GB)
     Used Dev Size : 976015360 (930.80 GiB 999.44 GB)
      Raid Devices : 2
     Total Devices : 3
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Sun Feb 23 18:28:45 2020
             State : clean
    Active Devices : 3
   Working Devices : 3
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : bitmap

              Name : sharon:2
              UUID : 98299cb7:9cbe61e9:c8374bcb:3c72d5ca
            Events : 704774

    Number   Major   Minor   RaidDevice State
       0       8       19        0      active sync   /dev/sdb3
       2       8        3        1      active sync   /dev/sda3
       3       8       35        1      active sync writemostly   /dev/sdc3


-- 
Aymeric
