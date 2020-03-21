Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC36918E3F1
	for <lists+linux-raid@lfdr.de>; Sat, 21 Mar 2020 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCUTYM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Mar 2020 15:24:12 -0400
Received: from atl.turmel.org ([74.117.157.138]:38784 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCUTYM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Mar 2020 15:24:12 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jFjj8-0007Pb-JC; Sat, 21 Mar 2020 15:24:10 -0400
Subject: Re: Raid6 recovery
To:     Glenn Greibesland <glenngreibesland@gmail.com>,
        antlists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
 <5E75163B.2050602@youngman.org.uk>
 <CA+9eyigMV-E=FwtXDWZszSsV6JOxxFOFVh6WzmeH=OC3heMUHw@mail.gmail.com>
 <ab2a40b6-b4ab-9ff8-aef6-02d8cce8d587@youngman.org.uk>
 <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
Date:   Sat, 21 Mar 2020 15:24:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Glenn,

{Convention on kernel.org lists is to interleave replies or bottom post, 
and to trim non-relevant quoted material.  Please do so in the future.}

On 3/21/20 7:54 AM, Glenn Greibesland wrote:
> Yes, I am aware of the problems with WD Green and multiple partitions
> on single 4TB disk. I am in the middle of getting rid of old disks and
> I have enough new drives to stop having multiple partitions on single
> drives, but not enough power and free SATA ports. It is just a
> temporary solution. Also a reason why I did not
> include much details in the original post, I knew it would just
> distract from the problem I want to solve right away.
> 
> What I need help with now is just getting the array started with the
> 16 out of 18 disks. Then I can continue migrating data and replacing
> old disks as planned.

I've examined the material posted, and the sequence of events described. 
  The --re-add damaged that one drive's role record and there is no 
programmatic way in mdadm to correct it.

Since you seem comfortable reading source code, you might consider byte 
editing that drive's superblock to restore it to "active device 10". 
That is what I would do.  With that corrected, --assemble --force should 
give you a running array.

In lieu of superblock surgery, you will indeed need to perform a 
--create --assume-clean, as you proposed in your original email.  Since 
you have already constructed a syntactically valid command for that 
purpose, with appropriate data offsets, that might be the fastest way to 
get a running array.

I would double-check the /dev/ name versus array "active device" number 
relationship to ensure strict ordering in your --create operation. 
Incorrect ordering will utterly scramble your content.

> When I built the array in 2012, I used WD Green. They turned out to be
> horrible disks and I have since replaced some of them with WD Red. The
> newest disks I've bought are Ironwolves

I also noted the drives with Error Recovery Control turned off.  That is 
not an issue while your array has no redundancy, but is catastrophic in 
any normal array.  It is as bad as having a drive that doesn't do ERC at 
all.  Don't do that.  Do read the "Timeout Mismatch" documentation that 
Anthony recommended, if you haven't yet.

I also recommend, when you get to a running array, that you prioritize 
the backup of its content--get the critical data copied out ASAP.  Your 
array will be very vulnerable to Unrecoverable Read Errors until you've 
completed your reconfiguration onto new drives.  Do not attempt to scrub 
the array or read every file right away, as any URE may break the array 
again.

If UREs do break your array again, you will need to use an 
error-ignoring copy tool (some flavor of ddrescue) to put the readable 
data onto a new device, remove the old device from the system, and then 
--assemble --force with the replacement.  Repeat as needed.

Good luck!

Regards,

Phil
