Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474C790662
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfHPRC4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 13:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfHPRC4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 16 Aug 2019 13:02:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D0B9CCFE6;
        Fri, 16 Aug 2019 17:02:55 +0000 (UTC)
Received: from [10.10.124.81] (ovpn-124-81.rdu2.redhat.com [10.10.124.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 851639CA3;
        Fri, 16 Aug 2019 17:02:54 +0000 (UTC)
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     NeilBrown <neilb@suse.com>, Song Liu <liu.song.a23@gmail.com>,
        Xiao Ni <xni@redhat.com>, Neil F Brown <nfbrown@suse.com>
Cc:     Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20190812153039.13604-1-ncroxon@redhat.com>
 <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
 <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
 <875zmxj3cf.fsf@notabene.neil.brown.name>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <9770f0c0-58a3-c283-02c0-25c0f94dc514@redhat.com>
Date:   Fri, 16 Aug 2019 13:02:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875zmxj3cf.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 16 Aug 2019 17:02:55 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/15/19 9:39 PM, NeilBrown wrote:
> On Thu, Aug 15 2019, Song Liu wrote:
>
>> On Mon, Aug 12, 2019 at 4:38 PM Xiao Ni <xni@redhat.com> wrote:
>>>
>>>
>>> On 08/12/2019 11:30 PM, Nigel Croxon wrote:
>>>> Often limits can be changed by admin. When discussing such things
>>>> it helps if you can provide "self-sustained" facts. Also
>>>> sometimes the admin thinks he changed a limit, but it did not
>>>> take effect for some reason or he changed the wrong thing.
>>>>
>>>> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
>>>> ---
>>>>    drivers/md/raid5.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>>> index 522398f61eea..e2b58b58018b 100644
>>>> --- a/drivers/md/raid5.c
>>>> +++ b/drivers/md/raid5.c
>>>> @@ -2566,8 +2566,8 @@ static void raid5_end_read_request(struct bio * bi, int error)
>>>>                                bdn);
>>>>                } else if (atomic_read(&rdev->read_errors)
>>>>                         > conf->max_nr_stripes)
>>>> -                     pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
>>>> -                            mdname(conf->mddev), bdn);
>>>> +                     pr_warn("md/raid:%s: Too many read errors (%d), failing device %s.\n",
>>>> +                            mdname(conf->mddev), conf->max_nr_stripes, bdn);
>>>>                else
>>>>                        retry = 1;
>>>>                if (set_bad && test_bit(In_sync, &rdev->flags)
>>> Hi Nigel
>>>
>>> Is it better to print rdev->read_errors too? So it can know the error
>>> numbers and the max nr stripes
>> I think rdev->read_errors is more useful here.
>>
>> Hi Neil,
>>
>> I have a question for this case: this patch changes an existing pr_warn() line,
>> which in theory, may break user scripts that grep for this line from dmesg.
>> How much do we care about these scripts?
> I don't think we need to care about this.  Kernel log message aren't
> normally considered part of the ABI.
> However in this case, it might actually be more readable to have just
> add another line:
>
>    md/raid:md0: 513 read_errors, > 512 stripes
>    md/raid:md0: Too many read errors, failing device sda1
>
> ??
>
> NeilBrown

Here is a new patch and a log of a run.


From: Nigel Croxon <ncroxon@redhat.com>
Date: Fri, 16 Aug 2019 11:54:24 -0400
Subject: [PATCH] raid5 improve too many read errors msg by adding limits

Often limits can be changed by admin. When discussing such things
it helps if you can provide "self-sustained" facts. Also
sometimes the admin thinks he changed a limit, but it did not
take effect for some reason or he changed the wrong thing.

V2: Add read_errors value to pr_warn.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
  drivers/md/raid5.c | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 59cafafd5a5d..b20a9bc8241d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2549,10 +2549,13 @@ static void raid5_end_read_request(struct bio * bi)
                  (unsigned long long)s,
                  bdn);
          } else if (atomic_read(&rdev->read_errors)
-             > conf->max_nr_stripes)
+             > conf->max_nr_stripes) {
+            pr_warn("md/raid:%s: %d read_errors, > %d stripes\n",
+                   mdname(conf->mddev), atomic_read(&rdev->read_errors),
+                   conf->max_nr_stripes);
              pr_warn("md/raid:%s: Too many read errors, failing device 
%s.\n",
                     mdname(conf->mddev), bdn);
-        else
+        } else
              retry = 1;
          if (set_bad && test_bit(In_sync, &rdev->flags)
              && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
-- 
2.20.1


[  +0.393256] md/raid:md127: device dm-0 operational as raid disk 0
[  +0.000002] md/raid:md127: device dm-3 operational as raid disk 3
[  +0.000000] md/raid:md127: device dm-2 operational as raid disk 2
[  +0.000001] md/raid:md127: device dm-1 operational as raid disk 1
[  +0.000330] md/raid:md127: raid level 6 active with 4 out of 4 
devices, algorithm 2
[  +0.000024] md127: detected capacity change from 0 to 2109734912
[  +0.285498] md: requested-resync of RAID array md127
[ +26.448446] device-mapper: integrity: Checksum failed at sector 0xfa767
[  +0.000022] device-mapper: integrity: Checksum failed at sector 0xfa76f
[  +0.000011] device-mapper: integrity: Checksum failed at sector 0xfa777
[  +0.000009] device-mapper: integrity: Checksum failed at sector 0xfa77f
[  +0.000010] device-mapper: integrity: Checksum failed at sector 0xfa767
[  +0.000001] device-mapper: integrity: Checksum failed at sector 0xfa787
[  +0.000009] device-mapper: integrity: Checksum failed at sector 0xfa78f
[  +0.000010] device-mapper: integrity: Checksum failed at sector 0xfa797
[  +0.000011] device-mapper: integrity: Checksum failed at sector 0xfa79f
[  +0.000009] device-mapper: integrity: Checksum failed at sector 0xfa7a7
[  +0.000515] md/raid:md127: read error corrected (8 sectors at 1025888 
on dm-0)
[  +0.000547] md/raid:md127: read error corrected (8 sectors at 1025904 
on dm-0)
[  +0.000009] md/raid:md127: read error corrected (8 sectors at 1025920 
on dm-0)
[  +0.000009] md/raid:md127: read error corrected (8 sectors at 1025912 
on dm-0)
[  +0.000054] md/raid:md127: read error corrected (8 sectors at 1025896 
on dm-0)
[  +0.000472] md/raid:md127: read error corrected (8 sectors at 1025936 
on dm-0)
[  +0.000009] md/raid:md127: read error corrected (8 sectors at 1025944 
on dm-0)
[  +0.000016] md/raid:md127: read error corrected (8 sectors at 1025952 
on dm-0)
[  +0.000119] md/raid:md127: read error corrected (8 sectors at 1025928 
on dm-0)
[  +0.000049] md/raid:md127: read error corrected (8 sectors at 1025968 
on dm-0)
[  +1.645278] md/raid:md127: 782 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000002] md/raid:md127: Disk failure on dm-0, disabling device.
               md/raid:md127: Operation continuing on 3 devices.
[  +0.000013] md/raid:md127: 783 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 784 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000020] md/raid:md127: 785 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000012] md/raid:md127: 786 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 787 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000019] md/raid:md127: 788 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000009] md/raid:md127: 789 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 790 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000017] md/raid:md127: 791 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000009] md/raid:md127: 792 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 793 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000018] md/raid:md127: 794 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000009] md/raid:md127: 795 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 796 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000018] md/raid:md127: 797 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 798 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000017] md/raid:md127: 799 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 800 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 801 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000021] md/raid:md127: 802 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000009] md/raid:md127: 803 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000009] md/raid:md127: 804 read_errors, > 781 stripes
[  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.000008] md/raid:md127: 805 read_errors, > 781 stripes
[  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
[  +0.928614] md: md127: requested-resync interrupted.


