Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6519819F8CC
	for <lists+linux-raid@lfdr.de>; Mon,  6 Apr 2020 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgDFP1r (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Apr 2020 11:27:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgDFP1r (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Apr 2020 11:27:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id j19so5908wmi.2
        for <linux-raid@vger.kernel.org>; Mon, 06 Apr 2020 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n422n9v2cKxXZA1eAOUXwDBGRHNCdUJAWrGtsfJhE0s=;
        b=Is2ScPzhtb7/Wb5eYXBhTUgGueGV5J0KcnfbNXtNI3m5JPWfK6y4Y7r5i7C1i2otAr
         7XyaieNt8JgedSY5nPAIS941+XVMRsr+yrZQ/NQAZpU9U/tdPZPDyyBhh9e5Q4ZRhJ09
         LNYumSRCE1Q0o7V5AwefFqkze5jsh1yi7NCoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n422n9v2cKxXZA1eAOUXwDBGRHNCdUJAWrGtsfJhE0s=;
        b=dyUlRdER2VBPo8Fv1g8W25jaPWPIhJ9qg3Uuhj3y+z0itcokUfKXq8d30heMAPc249
         610T7tAGjD9zxIyv8s2SUNhZTj4IOQ3YSesrjdh1x87TkV8OVdImUhPptNnACQ8Uugag
         +kp2gmi4aRRgCGa/+P9g80OBk8PRJVVFOquizXbeh/u4oDzJI+h+prmJvDYfhADttemx
         8qUuegB35AysZlQW2KAdtAKr1hu7YjFmlSO6TMWC70s2NyWtr9u6UC9JxfrKu7RxEr+9
         ZSEyiNKlV9S7gn9cFe5EFGA86hLEoFKcCEKjsdPuPtG0W9isH3cDu8qmIQ2RBshM3ioP
         gWRw==
X-Gm-Message-State: AGi0PuaugkqvGCrPHzDr8/2asymxGFw5FLYW3Hk68WNB4dOhgdRHUykr
        t2EsUR87Dbg7fSSc2Wfwg5JzguCbQA8ILw==
X-Google-Smtp-Source: APiQypL48TWGjbYA/bXJYUDTF3yzTbfGLzZikUDMU+ba5PuzWbUjlRzrXNvxWhVCZlcivSDPIaz+6w==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr206661wmc.101.1586186859148;
        Mon, 06 Apr 2020 08:27:39 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id o145sm25794697wme.42.2020.04.06.08.27.37
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:27:38 -0700 (PDT)
Subject: Re: Raid-6 cannot reshape
From:   Alexander Shenkin <al@shenkin.org>
To:     Linux-RAID <linux-raid@vger.kernel.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
Autocrypt: addr=al@shenkin.org; prefer-encrypt=mutual; keydata=
 mQENBE1dbG8BCACgMArnyVGKmnRGsdbTeDHSmAIZnuOitigsD1oEiBaAFE7uKsXTMWn1jKeu
 QocRN5l2eBUCrGB+oyTutebbNOxlGU1Y4eTjOsChuSXkYVS3lxqDwIdj1FpuDQw1jFetYtSz
 KEGBFOfXSvdIs7keTeSRbB4GU+nz612k9I1kjYfVKXMMK39PqaemVx3SDqEKoTx++/h4y9Dw
 Vk0QJcB6r5tARr2HMjUdW7QM9jf4RoU+8j+n8zDMKTgvPJF2xYvf/RwrY8EUgFz5cQ1TcIbl
 2vOsycpwLkL8QtuLAW2ylgjqp0u/Em8Eu4bBVG/kjx0Cj4rG845TcCxfmu2Ie/gWGdfrABEB
 AAG0IkFsZXhhbmRlciBTaGVua2luIDxhbEBzaGVua2luLm9yZz6JATgEEwECACIFAk1dbG8C
 GwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJENqfFYlMlYrSmy4H+gPMexnwlxFZ/2+G
 zbsJB0EMmlNcMDBqZoelxAMk3wFhhrmu0Z4R+KUJs8AK42RCktk5NLooqMLyOQa8sSI5jq0y
 71y/Ujle4WqJFnea9C0BwxHI7lQAwXFgsDH5/ZG/JrX/3EZkmLvYV/a63QbjnhrVo0zv1+r1
 9tuRekvBWwVKi03e+TyZgU4VbQg5GWGS7Iv4VibbPlficuZ5sSmF4Mn9YgduPi3M0vU/I67o
 q4ETVE3PY8e2o1I9zKL3SLQJE5J1wDPHiuJTpPvPAxlxMABmdpMeLyV5n9XZ2mderGGlfPTV
 fAnBRhvUZA5FdjU56WLWkfx4/gBNKwbRrhvfV8K5AQ0ETV1sbwEIAOt0HMNQhG3RprVQ/R36
 sZB0/CrJzPOwt+Rz1UWOaqzB3c7KkjpvgOTh21G9VGEmjCa+Y0RievO7viu65L7/lD8kxjL7
 3g1t0CyTnXjrlVER/ntV5ZpCAU6t9LEaGJcpunEbtV3RZxqlP6furXl5+AzYR3SgvybbB6Bx
 bUxBrtVbqKbI1UsfB1s5bYR3MCX1IbH+ieovWwtkXYmo2V/1sFgi4ikBQ7TtYnjKSSbl7Bll
 ZbW0ZEmJpCLgqQesLWUiEDLiW7Ce7Bfl1//nwekS/9G7xajS+WFx5XxB2OR7nHcwBWbw70mI
 i+k0DxPFy7+hEngP23UO6iZFzJWVjWFHY9UAEQEAAYkBHwQYAQIACQUCTV1sbwIbDAAKCRDa
 nxWJTJWK0nvJB/wJd6904rR49X9XhLY38FK710w0wMVxSsZIzLZhPFAO3ymv7DUknOUWNVPL
 M3OtVjS1rMIR1VeAjYsp2uxBUOYHHyU4dvC/6Un4jHMU4Y/+WBngG7TvcxczNK3mHzPAXGYM
 PraBN/PyEYt3lbeYdLpPrCOditwD2IFTss+hkUDUTAzzDd5rb1IufGZGUILFnYQI7mHTcbFM
 nYnIbd2xamCtTmAxylCygaBVFAuwMf48N8V9IljdMysvM89+N2aHveDgZUMZPuMBq1N46QsL
 qRYo5UFd8OPrY3xKLMdjaI7jGcjeHG2g83Mu9zT6P8dh0GuZfa51FNdknHpC/5OG5HRr
Message-ID: <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
Date:   Mon, 6 Apr 2020 16:27:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 200405-0, 04/05/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 4/4/2020 9:19 AM, Alexander Shenkin wrote:
> On 4/1/2020 11:16 AM, Alexander Shenkin wrote:
>> Hi all,
>>
>> I had a problem that caused my Ubuntu Server 14 to go down, and it now
>> will not boot.  I added a drive to my raid1 (/dev/md0 -> /boot) + raid6
>> (/dev/md2 -> /) setup.  I was previously running with /dev/md0 (raid1)
>> assembled from /dev/sd[a-f]1, and /dev/md2 (raid6) assembled
>> /dev/sd[a-f]3.  Both partitions from the new drive were successfully
>> added to the two md arrays, and the raid1 (the smaller of the two)
>> resync'd successfully it seemed (I think that resync is the correct word
>> to use, meaning that mdadm is spreading out the data amongst the drives
>> once an array has been grown).  When resyncing the larger raid6,
>> however, the sync speed was quite slow (kb's/sec), and got slower and
>> slower (7kb/sec... 5kb/sec... 3kb/sec... 1kb/sec...) until the system
>> entirely halted and I eventually turned the power off.  It now will not
>> boot.
>>
>> Thanks to Roger Heflin's help, I've booted into a livecd environment
>> (ubuntu server 18) with all the necessary raid personalities available.
>>
>> When trying to --assemble md127 (raid6), i get the following error:
>> "Failure to restore critical section for reshape, sorry.  Perhaps you
>> needed to specify the --backup-file".  Needless to say, I didn't save a
>> backup file when adding the drive.
>>
>> I have attached some diagnostic output here.  It seems that my raid6
>> array is not being recognized as such.  I'm not sure what the next steps
>> are - do I need to figure out how to get the resync up and running
>> again?  Any help would be greatly appreciated.
>>
>> Many thanks,
>>
>> Allie
>>
> 
> Hello again,
> 
> Reading through https://raid.wiki.kernel.org/index.php/Assemble_Run and
> https://raid.wiki.kernel.org/index.php/RAID_Recovery, the advice seems
> to be to force assemble the array given that my event counts are all the
> same.  However, I don't want to do that until some experts have chimed
> in.  I've seen some other threads about using overlays to avoid data
> loss... not sure if that is still a recommended method.
> 
> I'm including the dmesg and mdadm --examine output here...  any advice
> much appreciated!
> 
> Thanks,
> Allie
> 
> (note below - arrays are on /dev/md[a-g])
> 
> root@ubuntu-server:/home/ubuntu-server# mdadm -A --scan --verbose
> mdadm: looking for devices for further assembly
> mdadm: Cannot assemble mbr metadata on /dev/sdh1
> mdadm: Cannot assemble mbr metadata on /dev/sdh
> mdadm: no recogniseable superblock on /dev/md/bobbiflekman:0
> mdadm: no recogniseable superblock on /dev/sdf4
> mdadm: /dev/sdf3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sdf2
> mdadm: /dev/sdf1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sdf
> mdadm: no recogniseable superblock on /dev/sdg4
> mdadm: /dev/sdg3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sdg2
> mdadm: /dev/sdg1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sdg
> mdadm: no recogniseable superblock on /dev/sde4
> mdadm: /dev/sde3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sde2
> mdadm: /dev/sde1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sde
> mdadm: cannot open device /dev/sr1: No medium found
> mdadm: cannot open device /dev/sr0: No medium found
> mdadm: no recogniseable superblock on /dev/sdd4
> mdadm: /dev/sdd3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sdd2
> mdadm: /dev/sdd1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sdd
> mdadm: no recogniseable superblock on /dev/sdc4
> mdadm: /dev/sdc3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sdc2
> mdadm: /dev/sdc1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sdc
> mdadm: no recogniseable superblock on /dev/sdb4
> mdadm: /dev/sdb3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sdb2
> mdadm: /dev/sdb1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sdb
> mdadm: no recogniseable superblock on /dev/sda4
> mdadm: /dev/sda3 is busy - skipping
> mdadm: no recogniseable superblock on /dev/sda2
> mdadm: /dev/sda1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sda
> mdadm: no recogniseable superblock on /dev/loop7
> mdadm: no recogniseable superblock on /dev/loop6
> mdadm: no recogniseable superblock on /dev/loop5
> mdadm: no recogniseable superblock on /dev/loop4
> mdadm: no recogniseable superblock on /dev/loop3
> mdadm: no recogniseable superblock on /dev/loop2
> mdadm: no recogniseable superblock on /dev/loop1
> mdadm: no recogniseable superblock on /dev/loop0
> mdadm: No arrays found in config file or automatically
> 

Hi again all,

Apologies for all the self-followed-up emails.  I realized my previous
--examine was done without stopping the array in question.  When stopped
and reexamined, the critical bit seems to be this:

mdadm: /dev/sdf3 is identified as a member of /dev/md/ubuntu:2, slot 4.
mdadm: /dev/sdg3 is identified as a member of /dev/md/ubuntu:2, slot 6.
mdadm: /dev/sde3 is identified as a member of /dev/md/ubuntu:2, slot 5.
mdadm: /dev/sdd3 is identified as a member of /dev/md/ubuntu:2, slot 3.
mdadm: /dev/sdc3 is identified as a member of /dev/md/ubuntu:2, slot 2.
mdadm: /dev/sdb3 is identified as a member of /dev/md/ubuntu:2, slot 1.
mdadm: /dev/sda3 is identified as a member of /dev/md/ubuntu:2, slot 0.
mdadm: /dev/md/ubuntu:2 has an active reshape - checking if critical
section needs to be restored
mdadm: No backup metadata on device-6
mdadm: Failed to find backup of critical section
mdadm: Failed to restore critical section for reshape, sorry.
       Possibly you needed to specify the --backup-file

That is, it thinks there is an active reshape.

Thanks,
Allie


root@ubuntu-server:/home/ubuntu-server# mdadm -A --scan --verbose
mdadm: looking for devices for further assembly
mdadm: Cannot assemble mbr metadata on /dev/sdh1
mdadm: Cannot assemble mbr metadata on /dev/sdh
mdadm: no recogniseable superblock on /dev/md/bobbiflekman:0
mdadm: no recogniseable superblock on /dev/sdf4
mdadm: No super block found on /dev/sdf2 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdf2
mdadm: /dev/sdf1 is busy - skipping
mdadm: No super block found on /dev/sdf (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdf
mdadm: No super block found on /dev/sdg4 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdg4
mdadm: No super block found on /dev/sdg2 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdg2
mdadm: /dev/sdg1 is busy - skipping
mdadm: No super block found on /dev/sdg (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdg
mdadm: No super block found on /dev/sde4 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sde4
mdadm: No super block found on /dev/sde2 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sde2
mdadm: /dev/sde1 is busy - skipping
mdadm: No super block found on /dev/sde (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sde
mdadm: cannot open device /dev/sr1: No medium found
mdadm: cannot open device /dev/sr0: No medium found
mdadm: No super block found on /dev/sdd4 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdd4
mdadm: No super block found on /dev/sdd2 (Expected magic a92b4efc, got
9c6196f1)
mdadm: no RAID superblock on /dev/sdd2
mdadm: /dev/sdd1 is busy - skipping
mdadm: No super block found on /dev/sdd (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdd
mdadm: No super block found on /dev/sdc4 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdc4
mdadm: No super block found on /dev/sdc2 (Expected magic a92b4efc, got
9c6196f1)
mdadm: no RAID superblock on /dev/sdc2
mdadm: /dev/sdc1 is busy - skipping
mdadm: No super block found on /dev/sdc (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdc
mdadm: No super block found on /dev/sdb4 (Expected magic a92b4efc, got
53425553)
mdadm: no RAID superblock on /dev/sdb4
mdadm: No super block found on /dev/sdb2 (Expected magic a92b4efc, got
9c6196f1)
mdadm: no RAID superblock on /dev/sdb2
mdadm: /dev/sdb1 is busy - skipping
mdadm: No super block found on /dev/sdb (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sdb
mdadm: No super block found on /dev/sda4 (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sda4
mdadm: No super block found on /dev/sda2 (Expected magic a92b4efc, got
9c6196f1)
mdadm: no RAID superblock on /dev/sda2
mdadm: /dev/sda1 is busy - skipping
mdadm: No super block found on /dev/sda (Expected magic a92b4efc, got
00000000)
mdadm: no RAID superblock on /dev/sda
mdadm: No super block found on /dev/loop7 (Expected magic a92b4efc, got
72756769)
mdadm: no RAID superblock on /dev/loop7
mdadm: No super block found on /dev/loop6 (Expected magic a92b4efc, got
69622f21)
mdadm: no RAID superblock on /dev/loop6
mdadm: No super block found on /dev/loop5 (Expected magic a92b4efc, got
14ea0a05)
mdadm: no RAID superblock on /dev/loop5
mdadm: No super block found on /dev/loop4 (Expected magic a92b4efc, got
1824ef5d)
mdadm: no RAID superblock on /dev/loop4
mdadm: No super block found on /dev/loop3 (Expected magic a92b4efc, got
1e993ae9)
mdadm: no RAID superblock on /dev/loop3
mdadm: No super block found on /dev/loop2 (Expected magic a92b4efc, got
cb4d8c8e)
mdadm: no RAID superblock on /dev/loop2
mdadm: No super block found on /dev/loop1 (Expected magic a92b4efc, got
d2964063)
mdadm: no RAID superblock on /dev/loop1
mdadm: No super block found on /dev/loop0 (Expected magic a92b4efc, got
e7e108a6)
mdadm: no RAID superblock on /dev/loop0
mdadm: /dev/sdf3 is identified as a member of /dev/md/ubuntu:2, slot 4.
mdadm: /dev/sdg3 is identified as a member of /dev/md/ubuntu:2, slot 6.
mdadm: /dev/sde3 is identified as a member of /dev/md/ubuntu:2, slot 5.
mdadm: /dev/sdd3 is identified as a member of /dev/md/ubuntu:2, slot 3.
mdadm: /dev/sdc3 is identified as a member of /dev/md/ubuntu:2, slot 2.
mdadm: /dev/sdb3 is identified as a member of /dev/md/ubuntu:2, slot 1.
mdadm: /dev/sda3 is identified as a member of /dev/md/ubuntu:2, slot 0.
mdadm: /dev/md/ubuntu:2 has an active reshape - checking if critical
section needs to be restored
mdadm: No backup metadata on device-6
mdadm: Failed to find backup of critical section
mdadm: Failed to restore critical section for reshape, sorry.
       Possibly you needed to specify the --backup-file
mdadm: looking for devices for further assembly
mdadm: /dev/sdf1 is busy - skipping
mdadm: /dev/sdg1 is busy - skipping
mdadm: /dev/sde1 is busy - skipping
mdadm: /dev/sdd1 is busy - skipping
mdadm: /dev/sdc1 is busy - skipping
mdadm: /dev/sdb1 is busy - skipping
mdadm: /dev/sda1 is busy - skipping
mdadm: No arrays found in config file or automatically
