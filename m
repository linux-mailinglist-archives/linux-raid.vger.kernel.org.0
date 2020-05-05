Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F151C51FE
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEJe5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 05:34:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:58654 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEJe5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 May 2020 05:34:57 -0400
Received: from [81.153.126.158] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jVtyZ-0005Ou-7p; Tue, 05 May 2020 10:34:55 +0100
Subject: Re: RAID 1 | Test Booting from /dev/sdb
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
 <5EB12900.3030505@youngman.org.uk>
 <608e4d08-a99d-97f3-0476-3a880096f858@peter-speer.de>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5EB1333E.1010801@youngman.org.uk>
Date:   Tue, 5 May 2020 10:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <608e4d08-a99d-97f3-0476-3a880096f858@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/05/20 10:25, Stefanie Leisestreichler wrote:
> 
> On 05.05.20 10:51, Wols Lists wrote:
>>> Change boot medium to /dev/sdb
>>> and do a "mdadm /dev/md0 --add /dev/sda1" to get it recovered again
>>> without loosing the "added" data (i.e. in /var/log) from booting? Also
>>> device identifiers could change I guess. Even if I am fine with loosing
>>> the "added" data from booting with /dev/sdb, will - when booting again
>>> from /dev/sda - /dev/sda be the master in the array again?
>>>
>>> It is not clear to me if I understood correctly in which case which
>>> array member will be the master which will be the base for recovery. Is
>>> it always the HD one booted from?
>>>
>> The "master" if recovery is required will be the "older" one - in this
>> case sda because it was disconnected. HOWEVER. Just check whether you
>> have a bitmap or journal enabled. You can't have both at once, but the
>> result should be that sda rejoins the array cleanly, raid has a record
>> of which writes occurred while it was offline, and it will be updated.
>>
> 
> Does this mean in my scenario /dev/sda1 will come up again and will held
> data in /var/log/ where I can see i.e. log entries which are written
> when the system booted up using /dev/sdb as boot device?

No. The journal or bitmap are stored as part of the array, not the
filesystem. sdb will have a load of "flags" set to say "these blocks
were written to while the array was degraded". So when sda is added back
in, these delayed writes will be copied from sdb to sda.
> 
> I try to be prepared, just in case :-)

Don't we all :-)
> 
> Thanks again for sharing your knowledge, Wols.
> It is highly appreciated.

It's not that deep, but I do try to be clear what I do and don't know
:-) I'm lucky I have a very good memory.

Cheers,
Wol
