Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0827AF1
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2019 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfEWKm4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 May 2019 06:42:56 -0400
Received: from drutsystem.com ([84.10.39.251]:42903 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKm4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 23 May 2019 06:42:56 -0400
From:   Michal Soltys <soltys@ziu.info>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1558608170; bh=moEqkI2KO/Ylp0HReZfOhp1zxghyVX49K4sl1IFh5xw=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To;
        b=FNi1zcz9lK4xldcOyt0NTPSd68i9lQQ6Mbv2t1cKVkLS7TuD4PqdwghJfyXwCNckX
         9ehd6O8+Sw3zRlucVePUvyYhwg4C3u8VKE6zUD5LBW4IAks/aOcSZFuVgz5H7v5JRh
         GqHyioqb942h+z6Kont5aD7NCL3AdUChQ0f7RGCQ=
Subject: Re: Few questions about (attempting to use) write journal + call
 traces
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
Message-ID: <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
Date:   Thu, 23 May 2019 12:42:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: 7ABA87467BF.A1DEE
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/22/19 8:27 PM, Song Liu wrote:
> On Wed, May 22, 2019 at 6:18 AM Michal Soltys <soltys@ziu.info> wrote:
>>
>> Hi,
>>
>> As I started experimenting with journaled raids:
>>
>> 1) can another (raid1) device or lvm mirror (using md underneath) be used formally as a write journal ?
>> 2) for the testing purposes, are loopback devices expected to work ?
>>
>> I know I can successfully create both of the above (case scenario below), but any attempt to write to such md device ends with hung tasks and D states.
>>
>>
>> kernel 5.1.3
>> mdadm 4.1
>> btrfs filesystem with /var subvolume (where losetup files were created with fallocate)
>>
>> What I did:
>>
>> - six 10gb files as backings for /dev/loop[0-5]
>> - /dev/loop[4-5] - raid1
>> - /dev/loop[0-3] - raid5
>>
>> Now at this point both raids work just fine, separately. The problem starts if I create raid1 as raid5's journal (doesn't matter whether w-t or w-b). Any attempt to write to a device like that instantly ends with D and respective traces in dmesg:
> 
> Hi Michal,
> 
> Yes, the journal _should_ work with another md, lvm, or loop device.
> Could you please share the commands you used in this test?
> 
> Thanks,
> Song
> 

Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.

0) Common start

# cd /var/tmp
# for x in {0..5}; do fallocate -l 10g $x; done
# for x in {0..5}; do losetup /dev/loop$x $x; done



1) Following from (0), *works*:

# mdadm -C /dev/md/journ -N journ  -n2 -l1 -e1.2 /dev/loop[45]
(wait for sync / or create with --assume-clean)
# mdadm -C /dev/md/master -N master  -n4 -l5 -e1.2 --write-journal /dev/md/journ /dev/loop[0123]
(wait for sync / or create with --assume-clean)
# mdadm -Es >>/dev/mdadm.conf

# dd if=/dev/zero of=/dev/md/master bs=262144 count=1
(works)

# mdadm -Ss
# mdadm -A /dev/md/journ
# mdadm -A /dev/md/master

# dd if=/dev/zero of=/dev/md/master bs=262144 count=1
(works)



2) Following from (0), *does not* work (adding journal afterwards):

# mdadm -C /dev/md/journ -N journ  -n2 -l1 -e1.2 /dev/loop[45]
(wait for sync / or create with --assume-clean)
# mdadm -C /dev/md/master -N master  -n4 -l5 -e1.2 /dev/loop[0123]
(wait for sync / or create with --assume-clean)

# mdadm --readonly /dev/md/master
# mdadm /dev/md/master --add-journal /dev/md/journ

# dd if=/dev/zero of=/dev/md/master bs=262144 count=1
(hangs)

Variation of the above that does work:

- adding journal afterwards
- stopping both arrays
- assembly
- writing 


3) Following from (0), *does not* work (adding correct journal after assembly with missing one):

mdadm -C /dev/md/journ -N journ  -n2 -l1 -e1.2 /dev/loop[45]
(wait for sync / or create with --assume-clean)
mdadm -C /dev/md/master -N master  -n4 -l5 -e1.2 --write-journal /dev/md/journ /dev/loop[0123]
(wait for sync / or create with --assume-clean)
mdadm -Es >>/dev/mdadm.conf
mdadm -Ss

# mdadm -A --force /dev/md/master
mdadm: Journal is missing or stale, starting array read only.
mdadm: /dev/md/master has been started with 4 drives.

# mdadm -A  /dev/md/journ
mdadm: /dev/md/journ has been started with 2 drives.

# mdadm /dev/md/master --add-journal /dev/md/journ
mdadm: Journal added successfully, making /dev/md/master read-write
mdadm: added /dev/md/journ

# dd if=/dev/zero of=/dev/md/master bs=262144 count=1
(hangs)

Same variation as in (2) - stopping and assembling normally - works as well.
