Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A42A59C2
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfIBOwH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 10:52:07 -0400
Received: from atl.turmel.org ([74.117.157.138]:41171 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbfIBOwH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 10:52:07 -0400
X-Greylist: delayed 1177 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2019 10:52:06 EDT
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1i4nNc-0007Lf-Sd; Mon, 02 Sep 2019 10:32:29 -0400
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     =?UTF-8?Q?Krzysztof_Jak=c3=b3bczyk?= <krzysiek.jakobczyk@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk>
 <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org>
Date:   Mon, 2 Sep 2019 10:32:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good morning Krzysztof,

On 9/2/19 7:30 AM, Krzysztof Jakóbczyk wrote:
> Thank you for your input and I'll wait with further steps until confirmation!
> 
> Best regards,
> Krzysztof Jakobczyk
> 
> pon., 2 wrz 2019 o 12:52 Wols Lists <antlists@youngman.org.uk> napisał(a):
>>
>> On 02/09/19 11:05, Krzysztof Jakóbczyk wrote:
>>> My questions are the following:
>>>
>>> What to do in order to move the reshape process forward?
>>
>> I'll leave that to others, but my gut reaction is just to restart it
>> (don't follow my advice! Wait for someone else to say it's safe :-)

Don't do anything more in your current kernel and mdadm version.

>>> Do you think the data on the md0 is safe?
>>
>> Yes I do.

I agree.

>>> How to access the data on md0 if I cannot cd to it?
>>>
>> Wait for the system to (be) recover(ed).
>>
>>> What are those stack traces in the dmesg output?

Those are from an unrelated process (postgres) that is stuck.  It might 
be stuck as a side effect of not being able to reach data on your array.

>>> Help will be greatly appreciated.
>>>
>> MAKE SURE you've got a rescue disk with the latest mdadm and an
>> up-to-date kernel. I strongly suspect you've got an out-of-date system -
>> mdadm 3.2.2 is pretty ancient. This sounds to me like a well-known
>> problem from back then, and if I'm right the fix is as simple as booting
>> into a up-to-date recovery system, letting the reshape complete, and
>> then booting back into the old system.
>>
>> Can someone else confirm, please!!!

Yes, this is what I would do.  Do as clean a shutdown as you can on your 
system as-is.  Reboot into a rescue environment that has a current 
mdadm.  (I am a fan of SystemRescueCD, on a thumb drive, but others 
should work fine too.)

Note that device names may change from kernel to kernel--you will want 
to use smartctl to verify which drive serial number is on which device 
name and adjust your command lines accordingly.

You will likely have to use --assemble --force, specifying all relevant 
devices, as I doubt the current kernel will cleanly shutdown, and 
therefore some superblock data will prevent auto-start.  If you used a 
backup file in your reshape command, you will need to supply it to your 
--assembly command.  (Backup files are not generally needed, and reduce 
reshape performance.)

If reshape does not resume, supply the output of "mdadm -E" for all of 
your member partitions, and "smartctl -iA -l srterc" for the devices. 
When you paste the above into your email client, turn off word wrapping 
so the long lines won't be mangled.

>> Cheers,
>> Wol

Regards,

Phil
