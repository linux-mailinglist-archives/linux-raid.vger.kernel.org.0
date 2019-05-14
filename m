Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D91CE2E
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfENRlm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 13:41:42 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:20995 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfENRll (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 13:41:41 -0400
Received: from [192.168.8.29] ([86.214.62.250])
        by mwinf5d07 with ME
        id CHhe200095Px8Mi03Hhfy6; Tue, 14 May 2019 19:41:39 +0200
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 14 May 2019 19:41:39 +0200
X-ME-IP: 86.214.62.250
Reply-To: eric.valette@free.fr
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Julien ROBIN <julien.robin28@free.fr>, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <b4c92096-3096-63ff-24ea-b2745b20942c@free.fr>
 <27ab1f31-f125-4043-e417-6942a1d57965@free.fr>
 <cb0ab61f-788a-2c7d-ed17-5588726793fe@free.fr>
From:   Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <ecdd014f-9fb3-03ea-0272-7e05ccd69eb8@free.fr>
Date:   Tue, 14 May 2019 19:41:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cb0ab61f-788a-2c7d-ed17-5588726793fe@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/2019 19:25, Julien ROBIN wrote:

Thanks a lot. I think I'm ok (rather will be in 5 hours).

> mdadm --assemble /dev/md0 /dev/loop0 /dev/loop1 /dev/loop3 /dev/loop4
> mdadm: /dev/md0 assembled from 3 drives and 1 spare - need all 4 to 
> start it (use --run to insist).

I only did mdadm --assemble --run /dev/md0

and it started rebuilding automatically using the spare. Dunno why it 
did not work automatically (did not put --run the first time I tried).

mdadm --detail /dev/md0
/dev/md0:
            Version : 1.2
      Creation Time : Wed Jun 20 23:56:59 2012
         Raid Level : raid10
         Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
      Used Dev Size : 2930134016 (2794.39 GiB 3000.46 GB)
       Raid Devices : 4
      Total Devices : 4
        Persistence : Superblock is persistent

        Update Time : Tue May 14 19:29:22 2019
              State : clean, degraded, recovering
     Active Devices : 3
    Working Devices : 4
     Failed Devices : 0
      Spare Devices : 1

             Layout : near=2
         Chunk Size : 512K

Consistency Policy : resync

     Rebuild Status : 0% complete

               Name : nas2:0  (local to host nas2)
               UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
             Events : 1194

     Number   Major   Minor   RaidDevice State
        0       8       17        0      active sync set-A   /dev/sdb1
        1       8       33        1      active sync set-B   /dev/sdc1
        4       8       65        2      spare rebuilding   /dev/sde1
        3       8       49        3      active sync set-B   /dev/sdd1
root@nas2:~# cat /proc/mdstat
Personalities : [raid10]
md0 : active raid10 sdb1[0] sde1[4] sdd1[3] sdc1[1]
       5860268032 blocks super 1.2 512K chunks 2 near-copies [4/3] [UU_U]
       [>....................]  recovery =  0.1% (3835328/2930134016) 
finish=292.4min speed=166753K/sec



