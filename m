Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAEF1C2986
	for <lists+linux-raid@lfdr.de>; Sun,  3 May 2020 05:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgECDaC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 2 May 2020 23:30:02 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:52390 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgECDaC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 2 May 2020 23:30:02 -0400
Received: from srv.home ([10.8.0.1] ident=heh10625)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1jV5J5-0006eN-Qa; Sun, 03 May 2020 11:28:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=XcflvE5mp3bPbyppirpHs+ujyzMBIKyikrtqpJol/aw=;
        b=hKZvIjs7u8CskkEKi/OgDY6Ctc0NOji8G445x5OR8WOR0E6nEho4wA01w5XXaixlh/K0Gx+qIKAxb8cqwtxvUbqb2AaqjuJ9inPIuOxvj3yY4Z5hH1ddPGRDQjAfK74rm4DAQjhD8MvC/tvTixMEovJ+qHjNaA9I7295uDJLUCA=;
Subject: Re: Does a "check" of a RAID6 actually read all disks in a stripe?
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     linux-raid@vger.kernel.org
References: <18271293-9866-1381-d73e-e351bf9278fd@fnarfbargle.com>
 <20200428154013.GA4633@lazy.lzy>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <f023d798-4a91-a18f-9548-b3e3fab2cbbb@fnarfbargle.com>
Date:   Sun, 3 May 2020 11:28:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200428154013.GA4633@lazy.lzy>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 28/4/20 11:40 pm, Piergiorgio Sartor wrote:

> I suspect, but Neil or some expert should confim
> or deny, that a check on a RAID-6 uses only the
> P parity to verify stripe consistency.
> If there are errors in the Q parity chunk, these
> will not be found.
> 

I have been able to experimentally verify that a check does indeed read 
both p & q and perform validation on them for mismatch.

I did find a couple of cases where a bad sector was not picked up during 
a check, however these appeared to be inconsistent and not reproducible. 
I suspect it is related to using a small part of the array and caching 
at the block layer. Once I removed the sync_max restriction and let the 
array run the check until I knew the data read was greater than the 
machine RAM (ie, it was all out of cache) I could not reproduce the 
issue. Incidentally, no use of drop_caches helped here, I had to let it 
just run.

I performed these tests using hdparm to create a bad sector on one of 
the array members and then forcing a check. In all sane cases, the check 
hit the read error, performed a reconstruction and re-wrote.

Oddly enough, 9 times out of 10, on the P block it simply corrected the 
read error (ie 1 bad "sector" on the disk causes 8 sectors to return 
errors due to the 4K formatting) while the Q block re-wrote the entire 
chunk every time (128 sectors).

[248861.618254] ata3: EH complete
[248861.627940] raid5_end_read_request: 7 callbacks suppressed
[248861.627964] md/raid:md3: read error corrected (8 sectors at 262144 
on sdc)
[248877.770056] md: md3: data-check interrupted.

There were instances however where performing exactly the same test on 
the P block would force an entire chunk write. Apparently inconsistent 
behaviour but always resulting in the correct on-disk result.

[249390.287825] ata3: EH complete
[249390.570722] raid5_end_read_request: 6 callbacks suppressed
[249390.570752] md/raid:md3: read error corrected (8 sectors at 262272 
on sdc)
[249390.570776] md/raid:md3: read error corrected (8 sectors at 262280 
on sdc)
[249390.570800] md/raid:md3: read error corrected (8 sectors at 262288 
on sdc)
[249390.570822] md/raid:md3: read error corrected (8 sectors at 262296 
on sdc)
[249390.570845] md/raid:md3: read error corrected (8 sectors at 262304 
on sdc)
[249390.570871] md/raid:md3: read error corrected (8 sectors at 262312 
on sdc)
[249390.570893] md/raid:md3: read error corrected (8 sectors at 262320 
on sdc)
[249390.570916] md/raid:md3: read error corrected (8 sectors at 262328 
on sdc)
[249390.570940] md/raid:md3: read error corrected (8 sectors at 262336 
on sdc)
[249390.570962] md/raid:md3: read error corrected (8 sectors at 262344 
on sdc)
[249397.549844] md: md3: data-check interrupted.

This test did validate the theory I had that using dd-rescue to clone a 
dying drive and then using hdparm to mark the unrecoverable sectors as 
bad on the clone would prevent md from reading corrupt data from the 
clone and allowing a rebuild on that stripe.

For completeness, the test was performed with many variants along these 
lines :

test:~# mdadm --assemble /dev/md3
mdadm: /dev/md3 has been started with 9 drives.
test:~# hdparm --yes-i-know-what-i-am-doing --make-bad-sector f262144 
/dev/sdm

/dev/sdm:
Corrupting sector 262144 (WRITE_UNC_EXT as flagged): succeeded
test:~# export MD=/sys/block/md3/md/ ; echo 256 > $MD/sync_max ; echo 
check > $MD/sync_action
test:~# export MD=/sys/block/md3/md/ ; echo idle > $MD/sync_action ; 
echo 0 > $MD/sync_min
test:~# mdadm --stop /dev/md3

[249036.634236] md: md3 stopped.
[249036.700205] md/raid:md3: device sde operational as raid disk 0
[249036.700227] md/raid:md3: device sdm operational as raid disk 8
[249036.700246] md/raid:md3: device sdc operational as raid disk 7
[249036.700264] md/raid:md3: device sdf operational as raid disk 6
[249036.700283] md/raid:md3: device sdk operational as raid disk 5
[249036.700301] md/raid:md3: device sdj operational as raid disk 4
[249036.700319] md/raid:md3: device sdl operational as raid disk 3
[249036.700338] md/raid:md3: device sdi operational as raid disk 2
[249036.700356] md/raid:md3: device sdg operational as raid disk 1
[249036.700832] md/raid:md3: raid level 6 active with 9 out of 9 
devices, algorithm 2
[249036.720763] md3: detected capacity change from 0 to 14001852841984
[249056.033360] md: data-check of RAID array md3
[249056.154104] sd 2:0:7:0: [sdm] tag#246 UNKNOWN(0x2003) Result: 
hostbyte=0x00 driverbyte=0x08
[249056.154136] sd 2:0:7:0: [sdm] tag#246 Sense Key : 0x3 [current]
[249056.154157] sd 2:0:7:0: [sdm] tag#246 ASC=0x11 ASCQ=0x0
[249056.154178] sd 2:0:7:0: [sdm] tag#246 CDB: opcode=0x28 28 00 00 04 
00 00 00 00 80 00
[249056.154206] blk_update_request: critical medium error, dev sdm, 
sector 262144 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
[249056.155056] md/raid:md3: read error corrected (8 sectors at 262144 
on sdm)
[249056.155081] md/raid:md3: read error corrected (8 sectors at 262152 
on sdm)
[249056.155107] md/raid:md3: read error corrected (8 sectors at 262160 
on sdm)
[249056.155131] md/raid:md3: read error corrected (8 sectors at 262168 
on sdm)
[249056.155157] md/raid:md3: read error corrected (8 sectors at 262176 
on sdm)
[249056.155181] md/raid:md3: read error corrected (8 sectors at 262184 
on sdm)
[249056.155207] md/raid:md3: read error corrected (8 sectors at 262192 
on sdm)
[249056.155232] md/raid:md3: read error corrected (8 sectors at 262200 
on sdm)
[249056.155258] md/raid:md3: read error corrected (8 sectors at 262208 
on sdm)
[249056.155282] md/raid:md3: read error corrected (8 sectors at 262216 
on sdm)
[249064.025753] md: md3: data-check interrupted.
[249064.190722] md3: detected capacity change from 14001852841984 to 0
[249064.190756] md: md3 stopped.

With these test results I'm at a loss as to explaining how repeated full 
disk checks missed the bad sectors on the drive previously, but it 
certainly happened.

Regards,
Brad
