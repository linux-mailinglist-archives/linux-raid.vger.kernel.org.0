Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B321FDD1
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jul 2020 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgGNTu4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 15:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgGNTuz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jul 2020 15:50:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E1C061755
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:50:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a24so2411777pfc.10
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=6D+RTJDpwWit47NqcVJ+njEp+dpXl556ErPta+wnACU=;
        b=gasRioaGmYZVxbnZWZC9nfSSFEddS3UXQaVNcT12qrm2Anh2JU3HJaA8Giz5UlDuUw
         TgQkMg24sN9iRnisajex1JFnCJyszhUlohaDG2UHpUDQSdpWX8fSrb+o4YuFRkWp9txA
         XQuD3+N0O+iIqkcbhTK9zwFXUraCkVWC1cMzxjFrAzi75uP3AVEKET+g/2wM8FQQokto
         ofr4DYWzanNYWsccrAf1U8/cmT8N5y9JN+YThsRjGaM7Lb/wBzAdWo5F3oyVo8pGXz5T
         //xvHOnUQReFPw/hDt2iGOmRmAMecU04Y62ajIpUSaRDGkp/69MoYoZ0CkAOEeKlpx2k
         CiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=6D+RTJDpwWit47NqcVJ+njEp+dpXl556ErPta+wnACU=;
        b=lSt/ABvaBvpg2K309ae0WHl2DuBklEKtc6BDCedZCZLDVveu1nuIg0tqGgJJ/jOKVb
         4ZNKJGEjDCte7LoPyvMAJNQHpr10bko1q1ykUK+w/XpOObbQNS1gj7jSbtgeWxHDiDgz
         ja+3cmB3seg9zPzyjxcY2YxA/uJ8RaXt73EyzlxhB+Bo1Mls3LJ/0viy6PI8jmwsxYQy
         BIASJS1xX8SqO9WSELsx/vYp+KyLFoMKYKi6qWec73bPEVl25Xt1AInUvGLAvc9motjr
         oC/3aYsIT92W6O/dDjXQMEXFCE7NvEd5t3IACMqraxV0i7fD5nqojDQlFTBcW9GeuqKV
         8nGg==
X-Gm-Message-State: AOAM533tlWpgN9Me8KJhChd2bo2A6hZnUIBUGvwWnWFCoPiWV8JYTcS5
        Fo6H/lNc9U8rMYInQQYAwWfo8SS+pwA=
X-Google-Smtp-Source: ABdhPJyDT6/qsjxL6SwB6/DpbMlNrwrjRAq0jJwLmlbW2uUUPTQBVrKqV7H9RGNdDwLNrjalZh7Dyg==
X-Received: by 2002:a63:2b93:: with SMTP id r141mr4596983pgr.171.1594756254366;
        Tue, 14 Jul 2020 12:50:54 -0700 (PDT)
Received: from [192.168.1.100] (174-23-175-238.slkc.qwest.net. [174.23.175.238])
        by smtp.gmail.com with ESMTPSA id n14sm16998969pgd.78.2020.07.14.12.50.53
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:50:53 -0700 (PDT)
To:     linux-raid@vger.kernel.org
From:   Adam Barnett <adamtravisbarnett@gmail.com>
Subject: Reshape using drives not partitions, RAID gone after reboot
Message-ID: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
Date:   Tue, 14 Jul 2020 13:50:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi everyone I had something happen to my mdadm raid after a reshape and 
reboot.

My mdadm RAID5 array just underwent a 5>8 disk grow and reshape. This 
took several days and went uninterrupted. When cat /proc/mdstat said it 
was complete I rebooted the system and now the array no longer shows.

One potential problem I can see is that I used the full disk when adding 
the new drives (e.g. /dev/sda not /dev/sda1). However these drives had 
partitions on them that should span the entire drive. I now realize this 
was pretty dumb.

I have tried:

$ sudo mdadm --assemble --scan
mdadm: No arrays found in config file or automatically

The three newly added drives do not appear to have md superblocks:

$ sudo mdadm --examine /dev/sd[kln]
/dev/sdk:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
/dev/sdl:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
/dev/sdn:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)

$ sudo mdadm --examine /dev/sd[kln]1
mdadm: No md superblock detected on /dev/sdk1.
mdadm: No md superblock detected on /dev/sdl1.
mdadm: No md superblock detected on /dev/sdn1.

the five others do and show the correct stats for the array:

$ sudo mdadm --examine /dev/sd[ijmop]1
/dev/sdi1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x1
      Array UUID : 7399b735:98d9a6fb:2e0f3ee8:7fb9397e
            Name : Freedom-2:127
   Creation Time : Mon Apr  2 18:09:19 2018
      Raid Level : raid5
    Raid Devices : 8

  Avail Dev Size : 15627795456 (7451.91 GiB 8001.43 GB)
      Array Size : 54697259008 (52163.37 GiB 56009.99 GB)
   Used Dev Size : 15627788288 (7451.91 GiB 8001.43 GB)
     Data Offset : 254976 sectors
    Super Offset : 8 sectors
    Unused Space : before=254888 sectors, after=7168 sectors
           State : clean
     Device UUID : ca3cd591:665d102b:7ab8921f:f1b55d62

Internal Bitmap : 8 sectors from superblock
     Update Time : Tue Jul 14 11:46:37 2020
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : 6a1bca88 - correct
          Events : 401415

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 3
    Array State : AAAAAAAA ('A' == active, '.' == missing, 'R' == replacing)

...ect

Forcing the assembly does not work:

$ sudo mdadm /dev/md1 --assemble --force /dev/sd[ijmop]1 /dev/sd[kln]
mdadm: /dev/sdi1 is busy - skipping
mdadm: /dev/sdj1 is busy - skipping
mdadm: /dev/sdm1 is busy - skipping
mdadm: /dev/sdo1 is busy - skipping
mdadm: /dev/sdp1 is busy - skipping
mdadm: Cannot assemble mbr metadata on /dev/sdk
mdadm: /dev/sdk has no superblock - assembly aborted

 From my looking around I now know that sometimes adding full drives can 
have issues with md superblocks being destroyed, and that I may be able 
to proceed with the --create --assume-clean command. I would like to get 
a second opinion before I go that route as it is somewhat of a last 
resort. I also may need help understanding how to transition from the 
full drives to partitions on those drives if I need to go that route.

Thank you so much for any and all help.


-Adam

