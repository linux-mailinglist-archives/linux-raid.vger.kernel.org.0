Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C996D13B5AF
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jan 2020 00:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgANXLi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 18:11:38 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:46295 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgANXLi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jan 2020 18:11:38 -0500
Received: by mail-vs1-f53.google.com with SMTP id t12so9338973vso.13
        for <linux-raid@vger.kernel.org>; Tue, 14 Jan 2020 15:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oDKaiqQtSt9OAT2mfxAMw5hyJaxzZPlsvVSN6N68M2Y=;
        b=ffSSeKAjUet5R0Sq56YnewUaU/IVqBDdRMEINWM4D4QOnnyA9t2DICWXnnuiK+HqvK
         jQKN1v7Hhl4suPn1KrKWxHL36N+TNkgzDNzq6mjDNaldyej4ctRaWDR90fL0TcZIcuwH
         5L+Ijf2hGIa9luxCFT3cOPbDto38/vPjkHW23uI/bTRhS211Tu62hgZkp/RuGqqj+XdS
         YT6WysWnde4u8d1CtDZR73ew2vRASHN2zsPOlHXpnXxxSF1SmUmRxSjUajHHPj5UK/UN
         1xoRKe4YdJRQ90MpxYWsztsMjz7W/pS4XIy8Xwvp+47Znfeb61Z94q8Zhhl6jYj90Zqu
         diMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oDKaiqQtSt9OAT2mfxAMw5hyJaxzZPlsvVSN6N68M2Y=;
        b=hMxdzcLsRY38y1V7+ZRrxgvCYqWYGrwE9LA5zCQsXKA908TVKEjLeEqEHbaJUgZNKX
         LhCrH8rEd5OGe1Yzo6foHgcZhld+sIbCFRndnN+9wzQUXFa82AGTWmZsGnJGgw0GmYaZ
         jh6kPIc8RciqgDEJZK18Qrj1JPuUMMXqOya++P3EyDrPTpl8022nzbr132/UwRrJxmkZ
         yK6cM4TE/yfLHk38HdCQwJzl1Aq00u4DR98GIyfVwBZ0ElxGwL5TC/Cj34KzG/GZEWQj
         qJdEhy2i8++MbXsfg9ZphcIKrtXuyYX8moK7t57qdOG3Dqg6i1svyq3ZG5hErqhSHqUY
         I5MA==
X-Gm-Message-State: APjAAAVe6CIxXAFe87BzFSXVza9s8wwmTe1idL7GEuX9gYDGrUy8q9x1
        A0FPLot6dEotar43kGuSoqFrzsRhcKxIu+Hvszm/eMYOIt4=
X-Google-Smtp-Source: APXvYqz1xS5AfZjwXEaSz9Y8RgClL7qt106m+Ecvbc02dSbJ6NlC8E8SdvZg2TAXZFwQSGYimSzFbbMgsDb9134ZCNc=
X-Received: by 2002:a05:6102:3024:: with SMTP id v4mr2844887vsa.220.1579043497100;
 Tue, 14 Jan 2020 15:11:37 -0800 (PST)
MIME-Version: 1.0
References: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
 <5E1D6C8E.8030607@youngman.org.uk>
In-Reply-To: <5E1D6C8E.8030607@youngman.org.uk>
From:   Rickard Svensson <myhex2020@gmail.com>
Date:   Wed, 15 Jan 2020 00:11:25 +0100
Message-ID: <CAC4UdkbwYvPHgufBPjNTWzcZW0FcGgGrbmFD_k_mc-Z7NVH9Pw@mail.gmail.com>
Subject: Re: Debian Squeeze raid 1 0
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, I'm very grateful for all  help!

The Debian 6  mdadm version is:
mdadm - v3.1.4 - 31st August 2010

I have avoided doing much with the server...
And the server is still running, did not want to stop it...  But I
should stop it now?

Attaches  below a summary in the log, /sde died by the 9th, but came
back as /sdf  ???
And the 12th /sdc dies, and the morning after I discover the problem.
What I've done since then is only.
* Remont drive as read only
* Unmounted ext4, to run fsck
And that's when I realized it might be even worse.


My idea is to make a ddrescue copy of the problem disks, and then in a
new Debian 10 with new mdadm, try to start the raid on the new hd
copy..?

Yes, backing up via ddrescue sounds right.
BTW it is gddrescue?  ddrescue in Debian 10 seems to be a Windows
rescue program.

I'm change to raid 1 now on the server later on, I have two new 10Tb
drives, so not the same setup.
But I have a 6 Tb drive, which I intend to use for this rescue.

A question about the copy. is it possible to copy to a different
partition, for example copy sdc2 TO (new 6 TB disk) sdx1,  and then
sde2 TO (same new disk!) sdx2...
And mdadm should (with same luck) be able to put it to the same md0 device.
Or I'm asking, a copy of a partition will be the same, from what mdadm
is looking for?


"
Jan  9 00:14:44 ttserv kernel: [1503608.349157] sd 5:0:0:0: rejecting
I/O to offline device
Jan  9 00:14:44 ttserv kernel: [1503608.349199] sd 5:0:0:0: [sde]
killing request
Jan  9 00:14:44 ttserv kernel: [1503608.349225] sd 5:0:0:0: rejecting
I/O to offline device
Jan  9 00:14:44 ttserv kernel: [1503608.349232] ata6: hard resetting link
Jan  9 00:14:44 ttserv kernel: [1503608.349279] sd 5:0:0:0: rejecting
I/O to offline device
Jan  9 00:14:44 ttserv kernel: [1503608.349317] end_request: I/O
error, dev sde, sector 19531293
Jan  9 00:14:44 ttserv kernel: [1503608.349359] md: super_written gets
error=-5, uptodate=0
Jan  9 00:14:44 ttserv kernel: [1503608.349366] raid10: Disk failure
on sde2, disabling device.
Jan  9 00:14:44 ttserv kernel: [1503608.349368] raid10: Operation
continuing on 3 devices.
..
Jan  9 00:14:53 ttserv kernel: [1503617.083592] sd 5:0:0:0: [sdf]
5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
Jan  9 00:14:53 ttserv kernel: [1503617.083599] sd 5:0:0:0: [sdf]
4096-byte physical blocks
Jan  9 00:14:53 ttserv kernel: [1503617.083745] sd 5:0:0:0: [sdf]
Write Protect is off
Jan  9 00:14:53 ttserv kernel: [1503617.083752] sd 5:0:0:0: [sdf] Mode
Sense: 00 3a 00 00
Jan  9 00:14:53 ttserv kernel: [1503617.083816] sd 5:0:0:0: [sdf]
Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  9 00:14:54 ttserv kernel: [1503617.084192]  sdf: sdf1 sdf2
Jan  9 00:14:54 ttserv kernel: [1503618.637572] sd 5:0:0:0: [sdf]
Attached SCSI disk
Jan  9 00:14:55 ttserv kernel: [1503619.097302] RAID10 conf printout:
Jan  9 00:14:55 ttserv kernel: [1503619.097310]  --- wd:3 rd:4
Jan  9 00:14:55 ttserv kernel: [1503619.097318]  disk 0, wo:0, o:1, dev:sda2
Jan  9 00:14:55 ttserv kernel: [1503619.097325]  disk 1, wo:0, o:1, dev:sdb2
Jan  9 00:14:55 ttserv kernel: [1503619.097331]  disk 2, wo:0, o:1, dev:sdc2
Jan  9 00:14:55 ttserv kernel: [1503619.097338]  disk 3, wo:1, o:0, dev:sde2
Jan  9 00:14:55 ttserv kernel: [1503619.140524] RAID10 conf printout:
Jan  9 00:14:55 ttserv kernel: [1503619.140530]  --- wd:3 rd:4
Jan  9 00:14:55 ttserv kernel: [1503619.140537]  disk 0, wo:0, o:1, dev:sda2
Jan  9 00:14:55 ttserv kernel: [1503619.140542]  disk 1, wo:0, o:1, dev:sdb2
Jan  9 00:14:55 ttserv kernel: [1503619.140547]  disk 2, wo:0, o:1, dev:sdc2
...
Jan 12 00:11:16 ttserv kernel: [1762600.077809] sd 2:0:0:0: [sdc]
Unhandled sense code
Jan 12 00:11:16 ttserv kernel: [1762600.077813] sd 2:0:0:0: [sdc]
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jan 12 00:11:16 ttserv kernel: [1762600.077820] sd 2:0:0:0: [sdc]
Sense Key : Medium Error [current] [descriptor]
Jan 12 00:11:16 ttserv kernel: [1762600.077828] Descriptor sense data
with sense descriptors (in hex):
Jan 12 00:11:16 ttserv kernel: [1762600.077832]         72 03 11 04 00
00 00 0c 00 0a 80 00 00 00 00 00
Jan 12 00:11:16 ttserv kernel: [1762600.077849]         7c 4b fd c8
Jan 12 00:11:16 ttserv kernel: [1762600.077856] sd 2:0:0:0: [sdc] Add.
Sense: Unrecovered read error - auto reallocate failed
Jan 12 00:11:16 ttserv kernel: [1762600.077865] sd 2:0:0:0: [sdc] CDB:
Read(10): 28 00 7c 4b fd c5 00 00 08 00
Jan 12 00:11:16 ttserv kernel: [1762600.077881] end_request: I/O
error, dev sdc, sector 2085354952
Jan 12 00:11:16 ttserv kernel: [1762600.077924] raid10: sdc2:
rescheduling sector 4131643312
...
Jan 12 00:11:32 ttserv kernel: [1762616.114440] sd 2:0:0:0: [sdc]
Unhandled sense code
Jan 12 00:11:32 ttserv kernel: [1762616.114445] sd 2:0:0:0: [sdc]
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jan 12 00:11:32 ttserv kernel: [1762616.114451] sd 2:0:0:0: [sdc]
Sense Key : Medium Error [current] [descriptor]
Jan 12 00:11:32 ttserv kernel: [1762616.114460] Descriptor sense data
with sense descriptors (in hex):
Jan 12 00:11:32 ttserv kernel: [1762616.114464]         72 03 11 04 00
00 00 0c 00 0a 80 00 00 00 00 00
Jan 12 00:11:32 ttserv kernel: [1762616.114481]         7c 4b fd c8
Jan 12 00:11:32 ttserv kernel: [1762616.114488] sd 2:0:0:0: [sdc] Add.
Sense: Unrecovered read error - auto reallocate failed
Jan 12 00:11:32 ttserv kernel: [1762616.114497] sd 2:0:0:0: [sdc] CDB:
Read(10): 28 00 7c 4b fd c5 00 00 08 00
Jan 12 00:11:32 ttserv kernel: [1762616.114513] end_request: I/O
error, dev sdc, sector 2085354952
Jan 12 00:11:32 ttserv kernel: [1762616.114575] raid10: Disk failure
on sdc2, disabling device.
Jan 12 00:11:32 ttserv kernel: [1762616.114579] raid10: Operation
continuing on 2 devices.
Jan 12 00:11:32 ttserv kernel: [1762616.114584] ata3: EH complete
Jan 12 00:11:32 ttserv kernel: [1762616.114692] raid10: sdc:
unrecoverable I/O read error for block 4131643312
Jan 12 00:11:32 ttserv kernel: [1762616.557061] RAID10 conf printout:
Jan 12 00:11:32 ttserv kernel: [1762616.557068]  --- wd:2 rd:4
Jan 12 00:11:32 ttserv kernel: [1762616.557075]  disk 0, wo:0, o:1, dev:sda2
Jan 12 00:11:32 ttserv kernel: [1762616.557080]  disk 1, wo:0, o:1, dev:sdb2
Jan 12 00:11:32 ttserv kernel: [1762616.557084]  disk 2, wo:1, o:0, dev:sdc2
Jan 12 00:11:32 ttserv kernel: [1762616.573021] RAID10 conf printout:
Jan 12 00:11:32 ttserv kernel: [1762616.573026]  --- wd:2 rd:4
Jan 12 00:11:32 ttserv kernel: [1762616.573032]  disk 0, wo:0, o:1, dev:sda2
Jan 12 00:11:32 ttserv kernel: [1762616.573037]  disk 1, wo:0, o:1, dev:sdb2
Jan 12 00:11:32 ttserv kernel: [1762616.573549] Buffer I/O error on
device md0, logical block 518896617
Jan 12 00:11:32 ttserv kernel: [1762616.573611] lost page write due to
I/O error on md0
Jan 12 00:11:37 ttserv kernel: [1762621.834664] JBD2: Detected IO
errors while flushing file data on md0-8
Jan 12 00:12:02 ttserv kernel: [1762647.011386] Buffer I/O error on
device md0, logical block 517494752
Jan 12 00:12:02 ttserv kernel: [1762647.011429] lost page write due to
I/O error on md0
"
