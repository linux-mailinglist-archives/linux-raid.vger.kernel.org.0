Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70053B97B6
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfITTUH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 15:20:07 -0400
Received: from mail.prgmr.com ([71.19.149.6]:35664 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfITTUH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 15:20:07 -0400
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id A319F72008B;
        Fri, 20 Sep 2019 20:15:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com A319F72008B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1569024922;
        bh=1m5fwkY0S2ZSBwBI/Uskogar7JpP5v0V2E40GLD9nV0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=XsRAxi5xYUYZvICT/cb4gh8psQzi+OrXCU9OKW+EUR9PEW0iJ2mwmr6EbLEYz5K9e
         OyeGvbNHDk5lYGyzZPVlVLR0yYCWJG31PoXuhLjHHJ563WlVRJOuM+KZru1A/qRLAG
         ma3ZrBk6BpCHL+MbVWM/V1S/y0Xs7nub5CXR/CSY=
Subject: Re: RAID 10 with 2 failed drives
To:     Wols Lists <antlists@youngman.org.uk>, Liviu.Petcu@ugal.ro,
        linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <5D84F749.9070801@youngman.org.uk>
 <56ccd626-44fe-7266-563c-1da5d11d4180@prgmr.com>
 <5D851C92.4030009@youngman.org.uk>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <60d078c9-6850-52fc-db52-db3dcf4528be@prgmr.com>
Date:   Fri, 20 Sep 2019 12:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D851C92.4030009@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/20/19 11:38 AM, Wols Lists wrote:
> On 20/09/19 17:24, Sarah Newman wrote:
>> On 9/20/19 8:59 AM, Wols Lists wrote:
>>> On 19/09/19 21:45, Liviu Petcu wrote:
>>>> Hello,
>>>>
>>>> Please let me know if in this situation detailed below, there are
>>>> chances of restoring the RAID 10 array and how I can do it safely.
>>>> Thank you!
>>>
>>> This is linux raid 10, not some form of raid 1+0? That's what it looks
>>> like to me. I notice it says the array is active! That I think is good
>>> news!
>>
>> I thought that there should be a flag like 'degraded' if the raid was
>> actually running. I can't find the kernel documentation any more.
>>
>>>
>>> Can you mount it read-only and read it? I would be surprised if you
>>> can't, which means the array is running fine in degraded mode. NOT GOOD
>>> but not a problem provided nothing further goes wrong. I notice it's
>>> also version 0.9 - is it an old array? Have the drives themselves
>>> failed? (which I guess is probably the case :-( I guess the drives
>>> effectively have just the one partition - 2 - and 1 is something
>>> unimportant?
>>
>> What you said is definitely true for a near layout for an even number of
>> devices and n=2.
>>
>> I thought the offset layout meant any two adjacent raid devices failing
>> was data loss, assuming this is accurate:
>>
>> http://www.ilsistemista.net/index.php/linux-a-unix/35-linux-software-raid-10-layouts-performance-near-far-and-offset-benchmark-analysis.html?start=1
>>
> Except you've failed to extrapolate, sorry. We have six drives, not the
> four of the example. Although you could still be right. Does "offset=2"
> mean 2 copies, offset layout?
> 
> The rule with raid-10 is that you can lose AT LEAST n-1 drives where n
> is the number of mirrors. So if there are three mirrors of two drives
> each, this array is safe. You can lose AT MOST p drives, where p is the
> number of drives in a mirror. So this array *could* be safe with 2
> mirrors. What you can't do is lose n drives that are mirroring each
> other. The fact that the array is active makes me suspect that he is lucky.

On 9/20/19 11:38 AM, Wols Lists wrote:> On 20/09/19 17:24, Sarah Newman wrote:
 >> On 9/20/19 8:59 AM, Wols Lists wrote:
 >>> On 19/09/19 21:45, Liviu Petcu wrote:
 >>>> Hello,
 >>>>
 >>>> Please let me know if in this situation detailed below, there are
 >>>> chances of restoring the RAID 10 array and how I can do it safely.
 >>>> Thank you!
 >>>
 >>> This is linux raid 10, not some form of raid 1+0? That's what it looks
 >>> like to me. I notice it says the array is active! That I think is good
 >>> news!
 >>
 >> I thought that there should be a flag like 'degraded' if the raid was
 >> actually running. I can't find the kernel documentation any more.
 >>
 >>>
 >>> Can you mount it read-only and read it? I would be surprised if you
 >>> can't, which means the array is running fine in degraded mode. NOT GOOD
 >>> but not a problem provided nothing further goes wrong. I notice it's
 >>> also version 0.9 - is it an old array? Have the drives themselves
 >>> failed? (which I guess is probably the case :-( I guess the drives
 >>> effectively have just the one partition - 2 - and 1 is something
 >>> unimportant?
 >>
 >> What you said is definitely true for a near layout for an even number of
 >> devices and n=2.
 >>
 >> I thought the offset layout meant any two adjacent raid devices failing
 >> was data loss, assuming this is accurate:
 >>
 >> http://www.ilsistemista.net/index.php/linux-a-unix/35-linux-software-raid-10-layouts-performance-near-far-and-offset-benchmark-analysis.html?start=1
 >>
 > Except you've failed to extrapolate, sorry. We have six drives, not the
 > four of the example. Although you could still be right. Does "offset=2"
 > mean 2 copies, offset layout?

 >
 > The rule with raid-10 is that you can lose AT LEAST n-1 drives where n
 > is the number of mirrors. So if there are three mirrors of two drives
 > each, this array is safe. You can lose AT MOST p drives, where p is the
 > number of drives in a mirror. So this array *could* be safe with 2
 > mirrors. What you can't do is lose n drives that are mirroring each
 > other. The fact that the array is active makes me suspect that he is lucky.

When I stop a RAID device cleanly using mdadm, this does not appear to change 'state' stored on the drive. This is why I don't think an 'active' 
devices indicates the array can be recovered. I think it just means there was I/O happening at the time the array was stopped. It actually seems more 
likely to indicate an unclean shutdown since hopefully otherwise md would wait for the drive to be clean before stopping the device.

The meaning of 'state' appears a little different for mdadm --detail since that runs on the assembled array. If mdadm --detail showed 'active' I 
believe that means it is operational and there is I/O in flight.

You can test which drives are required for a given layout by using loopback devices created with losetup:

$ sudo /sbin/mdadm --create -n6 --level=raid10 --layout=o2 --metadata=0.9 /dev/md0 \
    /dev/loop18 /dev/loop19 /dev/loop20 /dev/loop21 /dev/loop22 /dev/loop23

$ sudo /sbin/mdadm --examine /dev/loop18
/dev/loop18:
           Magic : a92b4efc
         Version : 0.90.00
            UUID : 240dae40:25058853:2619f2ef:6cb7fea7
   Creation Time : Fri Sep 20 11:49:48 2019
      Raid Level : raid10
   Used Dev Size : 130048 (127.00 MiB 133.17 MB)
      Array Size : 390144 (381.00 MiB 399.51 MB)
    Raid Devices : 6
   Total Devices : 6
Preferred Minor : 0

     Update Time : Fri Sep 20 11:49:50 2019
           State : clean
  Active Devices : 6
Working Devices : 6
  Failed Devices : 0
   Spare Devices : 0
        Checksum : 4025b569 - correct
          Events : 18

          Layout : offset=2
      Chunk Size : 512K

       Number   Major   Minor   RaidDevice State
this     0       7       18        0      active sync   /dev/loop18

    0     0       7       18        0      active sync   /dev/loop18
    1     1       7       19        1      active sync   /dev/loop19
    2     2       7       20        2      active sync   /dev/loop20
    3     3       7       21        3      active sync   /dev/loop21
    4     4       7       22        4      active sync   /dev/loop22
    5     5       7       23        5      active sync   /dev/loop23

$ sudo /sbin/mdadm --fail /dev/md0 /dev/loop19 #device 1
mdadm: set /dev/loop19 faulty in /dev/md0
$ sudo /sbin/mdadm --fail /dev/md0 /dev/loop20 #device 2
mdadm: set device faulty failed for /dev/loop20:  Device or resource busy
$ sudo /sbin/mdadm --fail /dev/md0 /dev/loop21 #device 3
mdadm: set /dev/loop21 faulty in /dev/md0
$ sudo /sbin/mdadm --fail /dev/md0 /dev/loop22 #device 4
mdadm: set device faulty failed for /dev/loop22:  Device or resource busy
$ sudo /sbin/mdadm --fail /dev/md0 /dev/loop23 #device 5
mdadm: set /dev/loop23 faulty in /dev/md0

$ sudo /sbin/mdadm --examine /dev/loop18
/dev/loop18:
           Magic : a92b4efc
         Version : 0.90.00
            UUID : 240dae40:25058853:2619f2ef:6cb7fea7
   Creation Time : Fri Sep 20 11:49:48 2019
      Raid Level : raid10
   Used Dev Size : 130048 (127.00 MiB 133.17 MB)
      Array Size : 390144 (381.00 MiB 399.51 MB)
    Raid Devices : 6
   Total Devices : 6
Preferred Minor : 0

     Update Time : Fri Sep 20 11:54:04 2019
           State : clean
  Active Devices : 3
Working Devices : 3
  Failed Devices : 3
   Spare Devices : 0
        Checksum : 4025b6a6 - correct
          Events : 24

          Layout : offset=2
      Chunk Size : 512K

       Number   Major   Minor   RaidDevice State
this     0       7       18        0      active sync   /dev/loop18

    0     0       7       18        0      active sync   /dev/loop18
    1     1       0        0        1      faulty removed
    2     2       7       20        2      active sync   /dev/loop20
    3     3       0        0        3      faulty removed
    4     4       7       22        4      active sync   /dev/loop22
    5     5       0        0        5      faulty removed

--Sarah
