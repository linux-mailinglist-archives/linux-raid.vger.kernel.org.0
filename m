Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90D1D6859
	for <lists+linux-raid@lfdr.de>; Sun, 17 May 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgEQOBz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 17 May 2020 10:01:55 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:30764
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbgEQOBz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 17 May 2020 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sam-hurst.co.uk; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:to:from:subject:from;
        bh=mjOSb8QJrsPzQM+42eF4UHqzzBEn7CvYyD3Mw9AlEaU=;
        b=XCsXDU8WgyA7bgFWWJOaInDqQ674lOsOmn5rN3tlLBXp1lVIvmYhBsJkFPC+uUJYI6y77ybvVn+2g
         AWtX0YVsNN9eu2OChUjVauLJ0p9PfXWNle+PtTfGsTFUql4olUkC2jY8/mo6129z8mf78L/hwJ4iny
         F+gWgDe2QuILaDbNAKdOBNtWhfLnn1kS8RO8HxTMDPEoasUVslmGRuc2h04J6H+K8Fv5wy1fJKclb7
         hqdbdKtvu2ytS9gKpoi8XoJqy1eZBrJ6R+PHGTvZLHjd2bWKq2J4yeKQ6sb6jhtwJoCC52beZAki+a
         kP1oXRB3+ZOtEVXlhdxAm/Efr/L6LKQ==
X-HalOne-Cookie: f8f16dcba0c337cf96a0e6cda8375a3cdabd7f55
X-HalOne-ID: f55d667e-9846-11ea-9e62-d0431ea8bb03
Received: from [10.0.0.13] (82-69-64-9.dsl.in-addr.zen.co.uk [82.69.64.9])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id f55d667e-9846-11ea-9e62-d0431ea8bb03;
        Sun, 17 May 2020 14:01:52 +0000 (UTC)
Subject: Re: RAID wiped superblock recovery
From:   Sam Hurst <sam@sam-hurst.co.uk>
To:     Phil Turmel <philip@turmel.org>, linux-raid@vger.kernel.org
References: <922713c5-0cc1-24cb-14a6-9de7db631f98@sam-hurst.co.uk>
 <0f954924-e7ae-c81e-55f1-afc41e293a18@turmel.org>
 <05011140-3625-5326-96c9-e995f93260f4@sam-hurst.co.uk>
Message-ID: <aa4b9947-39cd-6c30-79f0-138d307c9620@sam-hurst.co.uk>
Date:   Sun, 17 May 2020 15:01:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <05011140-3625-5326-96c9-e995f93260f4@sam-hurst.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 17/05/2020 14:55, Sam Hurst wrote:
> So I've now tried doing this and sadly haven't really gotten anywhere. 
> Given the output of mdadm -E, I've specified the chunk size as 512K, and 
> the data offset as 134MB (given the reported offset of 262144 sectors * 
> sector size of 512 bytes on the devices).
> 
> Given your statement that I could trust the existing superblocks, I 
> haven't messed around with the order of those and instead I've just been 
> messing around with the order of the three disks which are unhappy. So 
> I've been putting sda first (active 0), then sdc (active 1), sdb (active 
> 2), and sdd (active 3). As I said last time, I'm using overlay images to 
> avoid screwing up the disks. My create command line is as below:
> 
> mdadm --create /dev/md1 --chunk=512 --level=6 --assume-clean 
> --data-offset=134M --raid-devices=7 /dev/mapper/sda /dev/mapper/sdc 
> /dev/mapper/sdb /dev/mapper/sdd ${UNHAPPY_DISK1} ${UNHAPPY_DISK2} 
> ${UNHAPPY_DISK3}

One other thing which I meant to write on the previous email but forgot, 
my test of "is the array sane" is to try and mount the XFS filesystem on 
the array. However, each time it just fails to find the filesystem 
superblock and is generally unhappy.

Reading the manpage, the only other thing I can see which I could put 
into the --create command is the layout of the array, which I'm fairly 
sure was left-symmetric because that's what the original RAID 5 array 
was according to my backup of the RAID configuration before moving to 
RAID 6, but I can't remember what the second parity disk layout was.

And in case it is helpful, the following is what mdadm thinks about the 
new array that I try to build.

root@toothless:~# mdadm -D /dev/md1
/dev/md1:
            Version : 1.2
      Creation Time : Sun May 17 14:38:34 2020
         Raid Level : raid6
         Array Size : 14650644480 (13971.94 GiB 15002.26 GB)
      Used Dev Size : 2930128896 (2794.39 GiB 3000.45 GB)
       Raid Devices : 7
      Total Devices : 7
        Persistence : Superblock is persistent

      Intent Bitmap : Internal

        Update Time : Sun May 17 14:38:34 2020
              State : clean
     Active Devices : 7
    Working Devices : 7
     Failed Devices : 0
      Spare Devices : 0

             Layout : left-symmetric
         Chunk Size : 512K

Consistency Policy : bitmap

               Name : toothless.local:1  (local to host toothless.local)
               UUID : ddf9f835:dc0fdad0:c864d5f5:f70ecbbf
             Events : 1

     Number   Major   Minor   RaidDevice State
        0     253        2        0      active sync   /dev/dm-2
        1     253        3        1      active sync   /dev/dm-3
        2     253        0        2      active sync   /dev/dm-0
        3     253        1        3      active sync   /dev/dm-1
        4     253        4        4      active sync   /dev/dm-4
        5     253        6        5      active sync   /dev/dm-6
        6     253        5        6      active sync   /dev/dm-5

-Sam
