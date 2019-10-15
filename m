Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40B7D825A
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfJOVoi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 17:44:38 -0400
Received: from MAIL.NPC-USA.COM ([173.160.187.9]:37372 "EHLO
        nautilus.npc-usa.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726977AbfJOVoi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 15 Oct 2019 17:44:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by nautilus.npc-usa.com (Postfix) with ESMTP id 0B3381DC025E
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 14:44:37 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at npc-usa.com
Received: from nautilus.npc-usa.com ([127.0.0.1])
        by localhost (mail.npc-usa.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qyFgLHlv3NIJ for <linux-raid@vger.kernel.org>;
        Tue, 15 Oct 2019 14:44:35 -0700 (PDT)
Received: from [10.0.1.65] (unknown [10.0.1.65])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: curtis)
        by nautilus.npc-usa.com (Postfix) with ESMTPSA id 4EFFF1DC00C7
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 14:44:35 -0700 (PDT)
Reply-To: curtis@npc-usa.com
Subject: Re: Degraded RAID1
To:     linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
From:   Curtis Vaughan <curtis@npc-usa.com>
Openpgp: preference=signencrypt
Autocrypt: addr=curtis@npc-usa.com; keydata=
 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
Organization: North Pacific Corporation
Message-ID: <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
Date:   Tue, 15 Oct 2019 14:44:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/10/2019 21:32, Curtis Vaughan wrote:
>>
>> On 10/14/19 5:44 PM, Wols Lists wrote:
>>> On 15/10/19 00:56, Curtis Vaughan wrote:
>>>> I have reason to believe one HD in a RAID1 is dying. But I'm trying to
>>>> understand what the logs and results of various commands are
>>>> telling me.
>>>> Searching on the Internet is very confusing. BTW, this is for and
>>>> Ubuntu
>>>> Server 18.04.2 LTS.
>>> Ubuntu LTS ... hmmm. What does "mdadm --version" tell you?
>> mdadm - v4.1-rc1 - 2018-03-22
>
> That's good. A lot of Ubuntu installations seem to have mdadm 3.4, and
> that has known issues, shall we say.
>>
>>>> It seems to me that the following information is telling me on
>>>> device is
>>>> missing. It would seem to me that sda is gone.
>>> Have you got any diagnostics for sda? Is it still in /dev? has it been
>>> kicked from the system? Or just the raid?
>> It is still on the system, so I guess it's just kicked off the raid.
>>>
>>> Take a look at
>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>>> Especially the "asking for help" page. It gives you loads of
>>> diagnostics
>>> to run.
>> Ok, I already went through most of those tests, but still not sure what
>> they are telling me.
>
> That's why the page tells you to post the output to this list ...
>
> I'm particularly interested in what mdadm --examine and --detail tell
> me about sda. But given that you think the drive is dud, does that
> really matter any more?
>
> However, there's a lot of reasons drives get kicked off, that may have
> absolutely nothing to do with them being faulty. Are your drives
> raid-friendly? Have you checked for the timeout problem? It's quite
> possible that the drive is fine, and you've just had a glitch.

mdadm --examine /dev/sda*
/dev/sda:
   MBR Magic : aa55
Partition[0] :     15622144 sectors at         2048 (type fd)
Partition[1] :   1937899520 sectors at     15624192 (type fd)
/dev/sda1:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : 7414ac79:580af0ce:e6bbe02b:915fa44a
  Creation Time : Wed Jul 18 15:00:44 2012
     Raid Level : raid1
  Used Dev Size : 7811008 (7.45 GiB 8.00 GB)
     Array Size : 7811008 (7.45 GiB 8.00 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 0

    Update Time : Sun Oct 13 04:03:00 2019
          State : clean
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 9b87d9f8 - correct
         Events : 309


      Number   Major   Minor   RaidDevice State
this     0       8        1        0      active sync   /dev/sda1

   0     0       8        1        0      active sync   /dev/sda1
   1     1       8       17        1      active sync   /dev/sdb1
/dev/sda2:
          Magic : a92b4efc
        Version : 0.90.00
           UUID : ac37ca92:939d7053:3b802bf3:08298597
  Creation Time : Wed Jul 18 15:00:53 2012
     Raid Level : raid1
  Used Dev Size : 968949696 (924.06 GiB 992.20 GB)
     Array Size : 968949696 (924.06 GiB 992.20 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 1

    Update Time : Sun Oct 13 16:39:43 2019
          State : active
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 141636b2 - correct
         Events : 4874


      Number   Major   Minor   RaidDevice State
this     0       8        2        0      active sync   /dev/sda2

   0     0       8        2        0      active sync   /dev/sda2
   1     1       8       18        1      active sync   /dev/sdb2


mdadm --detail /dev/md0
/dev/md0:
           Version : 0.90
     Creation Time : Wed Jul 18 15:00:44 2012
        Raid Level : raid1
        Array Size : 7811008 (7.45 GiB 8.00 GB)
     Used Dev Size : 7811008 (7.45 GiB 8.00 GB)
      Raid Devices : 2
     Total Devices : 1
   Preferred Minor : 0
       Persistence : Superblock is persistent

       Update Time : Tue Oct 15 14:31:20 2019
             State : clean, degraded
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              UUID : 7414ac79:580af0ce:e6bbe02b:915fa44a
            Events : 0.701

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1       8       17        1      active sync   /dev/sdb1


mdadm --detail /dev/md1
/dev/md1:
           Version : 0.90
     Creation Time : Wed Jul 18 15:00:53 2012
        Raid Level : raid1
        Array Size : 968949696 (924.06 GiB 992.20 GB)
     Used Dev Size : 968949696 (924.06 GiB 992.20 GB)
      Raid Devices : 2
     Total Devices : 1
   Preferred Minor : 1
       Persistence : Superblock is persistent

       Update Time : Tue Oct 15 14:41:22 2019
             State : clean, degraded
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              UUID : ac37ca92:939d7053:3b802bf3:08298597
            Events : 0.85840

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1       8       18        1      active sync   /dev/sdb2


>
>>> Basically, we need to know whether sda has died, or whether it's a
>>> problem with raid (especially with older mdadm, like I suspect you may
>>> have, the problem could lie there).
>>>> Anyhow, for example, I received an email:
>>>>
>>>> A DegradedArray event had been detected on md device /dev/md0.
>>> Do you have a spare drive to replace sda? If you haven't, it might
>>> be an
>>> idea to get one - especially if you think sda might have failed. In
>>> that
>>> case, fixing the raid should be pretty easy. So long as fixing it
>>> doesn't tip sdb over the edge ...
>>
>> The replacement drive is coming tomorrow. I'm certain now there's a
>> major issue
>>
>> with the drive and will be replacing it.
>
> What makes you think that?


Ran Spinrite against the drives. It gets about half way through the bad
drive and basically stops.

On the good drive it goes from beginning to end without issues.

Also after running smartctl on the bad drive, I got this:

The following warning/error was logged by the smartd daemon:

Device: /dev/sda [SAT], 1568 Offline uncorrectable sectors

Device info:
ST1000DM003-9YN162, S/N:Z1D17B24, WWN:5-000c50-050e6c90f, FW:CC4C, 1.00 TB

For details see host's SYSLOG.

You can also use the smartctl utility for further investigation.
Another message will be sent in 24 hours if the problem persists.

And this:
The following warning/error was logged by the smartd daemon:

Device: /dev/sda [SAT], 1568 Currently unreadable (pending) sectors

Device info:
ST1000DM003-9YN162, S/N:Z1D17B24, WWN:5-000c50-050e6c90f, FW:CC4C, 1.00 TB

For details see host's SYSLOG.

You can also use the smartctl utility for further investigation.
Another message will be sent in 24 hours if the problem persists.

>>
>> My intent is to basically follow these instructions for replacing the
>> drive.
>>
>> sudo mdadm --remove /dev/md1 /dev/sda2
>> sudo mdadm --remove /dev/md0 /dev/sda1
>>
>> Remove the bad drive, install new drive
>>   sudo mdadm --add /dev/md1 /dev/sda2
>> sudo mdadm --add /dev/md1 /dev/sda1
>>
>>
>> Would that be the correct approach?
>
> Yup. Sounds good. The only thing that might make sense, especially if
> you're getting a slightly bigger drive to replace sda, look at putting
> dm-integrity between the partition and the raid. There's a good chance
> it's not available to you because it's a new feature, but the idea is
> that it checksums the writes. So if there's data corruption the raid
> no longer wonders which drive is correct, but the corruption triggers
> a read error and the raid will fix it. I can't give you any pointers
> sorry, because I haven't played with it myself, but you should be able
> to find some information here or elsewhere on it.

I order a drive that is exactly the same size as the failed drive. In
fact pretty much the same drive.

>>
>> Finally could you tell me how to subscribe to this newsgroup through
>> an NNTP client?
>> I was using it through the gmane server, which seems to have issues
>> of whether it's
>> being continued or not. And although I can see some recent posts from
>> last week,
>> there has been nothing new. I've been searching for a NNTP server,
>> but can't find one.
>> Thanks!
>>
> Dunno how to subscribe using an nntp client because this is a mailing
> list, but details are on the wiki home page. Click on the link to the
> mailing list, and you can subscribe to the list there.
>
> Cheers,
> Wol
