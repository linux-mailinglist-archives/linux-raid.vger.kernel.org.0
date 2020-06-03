Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105C61ECA83
	for <lists+linux-raid@lfdr.de>; Wed,  3 Jun 2020 09:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgFCH2N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Jun 2020 03:28:13 -0400
Received: from hammer.websitemanagers.com.au ([59.100.172.130]:38880 "EHLO
        hammer.websitemanagers.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgFCH2N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 3 Jun 2020 03:28:13 -0400
Received: (qmail 24797 invoked by uid 1011); 3 Jun 2020 07:28:09 -0000
Received: from 192.168.5.112 by hammer (envelope-from <mailinglists@websitemanagers.com.au>, uid 1008) with qmail-scanner-1.24 
 (clamdscan: 0.102.1/25831. spamassassin: 3.4.2.  
 Clear:RC:1(192.168.5.112):. 
 Processed in 0.04302 secs); 03 Jun 2020 07:28:09 -0000
Received: from unknown (HELO ADAM-MBP.local) (adamg+websitemanagers.com.au@192.168.5.112)
  by 0 with ESMTPA; 3 Jun 2020 07:28:09 -0000
To:     linux-raid@vger.kernel.org
From:   Adam Goryachev <mailinglists@websitemanagers.com.au>
Subject: Helpful archives
Organization: Website Managers
Message-ID: <2a690668-e2c6-259b-514a-101a846695df@websitemanagers.com.au>
Date:   Wed, 3 Jun 2020 17:28:06 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have a "test" machine with a RAID10 (4 drives) and one drive has 
failed. I decided to just convert to RAID5, but since the root FS is on 
this raid, it would be annoying to simply destroy the raid and then have 
to re-install. So a quick google to see if I could do what I wanted led 
me directly to my email I sent to this list almost 5 years ago. 
(Included below for additional reference points). So, thanks to everyone 
who provided advice and guidance 5 years ago, and thanks to me for 
writing an excellent summary/howto, which still works perfectly today.

Todays process:

Starting point:
md2 : active raid10 sdb3[0] sda3[2] sdc3[3]
       209715072 blocks 64K chunks 2 near-copies [4/3] [U_UU]
       bitmap: 1/2 pages [4KB], 65536KB chunk

mdadm --grow --bitmap=none /dev/md2
mdadm --grow --level=0 --raid-devices=2 /dev/md2
mdadm --grow --level=5 --raid-devices=3 /dev/md2 -a /dev/sda3 
--backup-file=/boot/backup-file-md2-20200603
mdadm --grow --bitmap=internal /dev/md2

Note: I didn't add the 4th drive since it is missing, so I end up with a 
3 drive RAID5 which is clean.

End result:
md2 : active raid5 sda3[2] sdb3[0] sdc3[1]
       209715072 blocks level 5, 64k chunk, algorithm 5 [3/3] [UUU]
       bitmap: 1/1 pages [4KB], 65536KB chunk

Regards,
Adam

Original email from the archives: 
https://www.spinics.net/lists/raid/msg50210.html

  * /To/: Phil Turmel <philip@xxxxxxxxxx <mailto:philip@DOMAIN.HIDDEN>>,
    Anugraha Sinha <asinha.mailinglist@xxxxxxxxx
    <mailto:asinha.mailinglist@DOMAIN.HIDDEN>>,
    linux-raid@xxxxxxxxxxxxxxx <mailto:linux-raid@DOMAIN.HIDDEN>
  * /Subject/: Re: Converting 4 disk RAID10 to RAID5
  * /From/: Adam Goryachev <mailinglists@xxxxxxxxxxxxxxxxxxxxxx
    <mailto:mailinglists@DOMAIN.HIDDEN>>
  * /Date/: Wed, 28 Oct 2015 12:57:41 +1100
  * /In-reply-to/: <562F6A77.20502@turmel.org
    <https://www.spinics.net/lists/raid/msg50200.html>>
  * /User-agent/: Mozilla/5.0 (X11; Linux x86_64; rv:38.0)
    Gecko/20100101 Thunderbird/38.3.0

------------------------------------------------------------------------

On 27/10/15 23:13, Phil Turmel wrote:

    On 10/27/2015 02:32 AM, Adam Goryachev wrote:

        On 27/10/15 17:19, Anugraha Sinha wrote:

    \

            This will restart your array with the required raid-level and also
            start the resyncing process.

    You shouldn't have needed to stop it.

        I got:
        mdadm: Failed to restore critical section for reshape, sorry.
        Possibly you needed to specify the --backup-file

    Probably just need "mdadm /dev/md0 --grow --continue --backup-file=...."

    where .... is a file location outside the array.  You may also need
    --invalid-backup

    Phil
    --
    To unsubscribe from this list: send the line "unsubscribe linux-raid" in
    the body of a message to majordomo@xxxxxxxxxxxxxxx
    More majordomo info athttp://vger.kernel.org/majordomo-info.html

Thank you, that did it (if I don't do the stop):
mdadm --grow --continue --backup-file=/tmp/nofile /dev/md0
mdadm: Need to backup 3072K of critical section..
mdadm: Reshape is delayed, but cannot wait carefully with this kernel.
        You might experience problems until other reshapes complete.

Just in case someone else is looking later, this is how to convert from 
4 disk RAID10 to 4 disk RAID5.

Starting again from scratch, I followed this process:
mdadm --create --level=10 --raid-devices=4 /dev/md0 /dev/vd[cdef]1
mdadm --grow --bitmap=internal /dev/md0

#This gets me to my current live config....

# Remove the bitmap since it causes problems later
mdadm --grow --bitmap=none /dev/md0

# Grow to RAID0 which basically just drops two devices, it finishes 
immediately.

mdadm --grow --level=0 --raid-devices=2 /dev/md0

# Grow to RAID5, only add one device
mdadm --grow --level=5 --raid-devices=3 /dev/md0 -a /dev/vdd1

# A resync is completed, looks good/normal

# Grow to add the 4th device
mdadm --grow --raid-devices=4 /dev/md0 -a /dev/vdf1

# Problems, stuck with resync=DELAYED, we were not asked to supply a 
backup file for this...

# Just ask mdadm to continue, and now supply a backup file
mdadm --grow --continue --backup-file=/tmp/nofile /dev/md0

# All good. Add the bitmap again
mdadm --grow /dev/md0 --bitmap=internal

It would seem to me that this is generally a relatively "dangerous" 
exercise, you are very vulnerable to failed disks due to using RAID0, 
and then migrating to RAID5, any read/write failure during that process 
could cause significant data loss. Finally, the grow to add the 4th disk 
should be fine, unless you have a problem with the same block on two 
devices.

Any final comments/suggestions before I start the process "for real"?

Thanks,
Adam


--
Adam Goryachev Website Managers www.websitemanagers.com.au

