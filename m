Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF421CCA89
	for <lists+linux-raid@lfdr.de>; Sun, 10 May 2020 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgEJLHE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 10 May 2020 07:07:04 -0400
Received: from mailrelay1-3.pub.mailoutpod1-cph3.one.com ([46.30.212.10]:20340
        "EHLO mailrelay1-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgEJLHE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 10 May 2020 07:07:04 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2020 07:07:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sam-hurst.co.uk; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:to:
         subject:from:from;
        bh=1G0YsxP2VtDYRycNq765beqIBJF/CCdQ2Wts5KhXItY=;
        b=BaT992xYqPMOk1y7Yqq811DxHWpiR8xOL4XTFgVbCL7iIW1j/GrkePZmd7J9+LTewS4LTYZ+epGdz
         M5T2h8IF/ElcwAXbR44aKdJmGN8+nZToRCR11N3VioNRyzng0j5Ecw/ZQ1hwW2Rc3Ln4I09MOo52Gl
         ebxIVMxJN/Tlkf1f2kASQye9xSX3mJxEUbuy8WllnnfE+2Gi0seu5ylfq3lVTT4xnu7mthCAzMD+Ek
         /biH1RMWy54o7TjOyzK0VECD0aFv7tdGKlWePW5gRLE3VnyObtizL/szekTu0ERy1nNFP7lahkv4LO
         uHWKAFLEXKEi2l3kc5ubzfDaQEQ0sNQ==
X-HalOne-Cookie: 2c594d36a964f05748c0b3ab227c0111dbf7d452
X-HalOne-ID: 2150652a-92ac-11ea-9ad8-d0431ea8a283
Received: from [10.0.0.13] (82-69-64-9.dsl.in-addr.zen.co.uk [82.69.64.9])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2150652a-92ac-11ea-9ad8-d0431ea8a283;
        Sun, 10 May 2020 10:50:58 +0000 (UTC)
From:   Sam Hurst <sam@sam-hurst.co.uk>
Subject: RAID wiped superblock recovery
To:     linux-raid@vger.kernel.org
Message-ID: <922713c5-0cc1-24cb-14a6-9de7db631f98@sam-hurst.co.uk>
Date:   Sun, 10 May 2020 11:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

** TL;DR: Preamble for first three paragraphs - issue meat at para 4 **

I have a fairly long lived array that once started life as a 4 disk 
RAID5, had a disk replaced, and recently I've made it larger by adding 
three new disks and changing it to a RAID6 array. However, I've hit an 
issue with these three new drives.

The original RAID was set up using the raw block devices as opposed to a 
partition on the disk, and I did the same with the three new drives. 
However, these "new" drives had previously been in a machine where they 
had GPT partition tables. I hadn't thought anything of it, as I figured 
that adding the new drives to the array would wipe everything that 
already existed.

However, the backup GPT table was not wiped from the end of the disk. We 
recently discovered a peculiarity [1] with ASRock motherboard firmware 
that tries to be helpful and repair what it thinks might be a damaged 
GPT if it can find a valid one at the end of a disk on boot. So when I 
recently had to shut down the machine to replace a poorly UPS battery, 
on boot my array didn't come up.

So, I now have three drives with a wiped superblock. I'm fairly certain 
it hasn't wiped anything else, hex dumping the drives looks like the 
data all begins at the same place. First we tried recreating the 
superblocks by hand, but that didn't work. All the different 
combinations of --assemble I've tried haven't been much help, as it 
always ends the same way:

root@toothless:~# mdadm --assemble --force /dev/md127 $OVERLAYS
mdadm: failed to add /dev/mapper/sdf to /dev/md127: Invalid argument
mdadm: failed to add /dev/mapper/sdg to /dev/md127: Invalid argument
mdadm: failed to add /dev/mapper/sdh to /dev/md127: Invalid argument
mdadm: failed to RUN_ARRAY /dev/md127: Input/output error
root@toothless:~# dmesg -T | grep sdf
[Sun May 10 09:57:04 2020] md: invalid superblock checksum on sdf
[Sun May 10 09:57:04 2020] md: sdf does not have a valid v1.2 
superblock, not importing!

So I've come to the conclusion that the only way forward is to use 
`mdadm --create` and hope I get the array back that way, with new 
superblocks. I've found a Stack Overflow discussion where someone 
experimented with erasing superblocks and rebuilding, and have been 
trying to follow that [2], combined with the instructions on the Linux 
RAID wiki for using overlays to protect the underlying disk [3].

However, it's my understanding that you need to add these disks in the 
correct order - and given I have 7 disks, that's 5040 possible 
permutations! The original four disks show their device roles, so I'm 
/assuming/ that's the order in which they need adding:

/dev/sda:
    Device Role : Active device 0
/dev/sdb:
    Device Role : Active device 2
/dev/sdc:
    Device Role : Active device 1
/dev/sdd:
    Device Role : Active device 3
/dev/sdf:
    Device Role : spare
/dev/sdg:
    Device Role : spare
/dev/sdh:
    Device Role : spare

So I've tried all six permutations of the devices showing as "spare" at 
the end and I can never get a sensible filesystem out when I do a --create.

Does anyone have any other ideas, or can offer some wisdom into what to 
do next? Otherwise I'm writing a shell script to test all 5040 
permutations...


Best Regards,
Sam



[1]: 
http://forum.asrock.com/forum_posts.asp?TID=10174&title=asrock-motherboard-destroys-linux-software-raid

[2]: 
https://serverfault.com/questions/347606/recover-raid-5-data-after-created-new-array-instead-of-re-using/347786#347786

[3]: https://raid.wiki.kernel.org/index.php/Recovering_a_damaged_RAID

