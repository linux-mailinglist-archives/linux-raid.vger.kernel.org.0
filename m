Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC085A6A1D
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfICNjj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 09:39:39 -0400
Received: from atl.turmel.org ([74.117.157.138]:39540 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICNjj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 3 Sep 2019 09:39:39 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1i5921-0005S1-Kz; Tue, 03 Sep 2019 09:39:37 -0400
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     =?UTF-8?Q?Krzysztof_Jak=c3=b3bczyk?= <krzysiek.jakobczyk@gmail.com>,
        NeilBrown <neilb@suse.de>
Cc:     Neil F Brown <nfbrown@suse.com>, linux-raid@vger.kernel.org,
        Wols Lists <antlists@youngman.org.uk>
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk>
 <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
 <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org>
 <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
 <87h85udyfs.fsf@notabene.neil.brown.name>
 <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <d9a08687-0225-407f-dff0-f7f440786654@turmel.org>
Date:   Tue, 3 Sep 2019 09:39:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good morning Krzysztof,

On 9/3/19 7:38 AM, Krzysztof Jakóbczyk wrote:
> Hello Neil,
> 
> Many thanks for your input! The support you guys are providing is one of a kind!
> 
> I've been able to kill some of the blocked processes, releasing the
> locked files in the `/data` mount point, but some of them remained
> locked.
> I've booted with SystemRescueCD and it automatically detected and
> assembled the array as md127. The array was in read-only state, but
> after mounting it in SystemRescueCD `/mnt` the reshape process started
> from begining. Right now the `/proc/mdstat` looks as follows:

"auto-read-only" is a standard state for an anonymous array (the 
thumbdrive wouldn't have an mdadm.conf file that explicitly identified 
your array.)

You could have used --run to get the reshape going instead of mounting. 
Mounting is not always safe in these situations.

> [root@sysresccd ~]# cat /proc/mdstat
> Personalities : [raid6] [raid5] [raid4]
> md127 : active raid6 sda1[5] sdg1[6] sdd1[4] sdf1[3]
>        7813771264 blocks super 1.2 level 6, 512k chunk, algorithm 18 [4/3] [UUU_]
>        [=================>...]  reshape = 88.1% (3444089344/3906885632)
> finish=189.5min speed=40688K/sec
>        bitmap: 8/30 pages [32KB], 65536KB chunk
> 
> unused devices: <none>
> 
> Initially the speed was reaching 63M/sec, but now it's a bit slower,
> however still at a very good level.

Not surprising.  You are in a very good place right now...

[trim /]

> The question that still remains is: when the reshape in SystemRescueCD
> finishes, can I safely mount the array in the outdated host and
> perform mdadm and system updates?

Yes.

> Also, what I've found in `dmesg` is quite distressing:

No, not distressing.  The key is "corrected".  In other words, MD is 
handling normal read errors as only a redundant array can -- by 
reconstructing the missing data and writing it back where it belongs. 
Unrecoverable read errors are normal.  (Search the archives on this 
topic for many discussions on the why and the mitigations.)

The fact you are getting several during a reshape suggests that your 
system has not been doing regular "check" scrubs, which keep these 
cleaned up.  Most modern distros have a weekly cron job that kicks off 
the necessary tasks.  Self-tests within the drives are *not* a 
substitute for regular scrubs.  Self-tests can only *find* problem 
sectors, not *fix* them.

> [ 7234.974190] perf: interrupt took too long (2517 > 2500), lowering
> kernel.perf_event_max_sample_rate to 79400

Uhm?  Why are you running perf during this reshape?

> What do you think of that? The `smartctl -a` for the reported drives
> is not showing anything unusual and the drives are new, so it
> shouldn't be a hardware problem (still not noticed by SMART):

Sectors go bad.  Randomly, but not often.  The bad sectors cannot be 
detected until they are read.  They cannot be fixed without writing to them.

Detected but unfixed show in smartctl as "Pending Sectors".  The fix may 
or may not involve relocation.  Relocation on new drives is rare.

[trim /]

> Can I see if the filest at those reported sectors are correct?

They were corrected.  You can work backwards with your filesystem's 
tools to find the file or inode there, if any, but MD would have no 
information about the "correctness" of the files.  It would be your 
judgement.

> Best regards,
> Krzysztof Jakobczyk

Regards,

Phil


ps.  Please avoid top-posting, and *do* trim your replies.  {Standard 
list etiquette for kernel.org.}  There's nothing more annoying in a 
properly threaded email client than gobs of unnecessary quoted material.
