Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12231BD06C
	for <lists+linux-raid@lfdr.de>; Tue, 24 Sep 2019 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406833AbfIXRPw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Sep 2019 13:15:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50122 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437027AbfIXRPw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 24 Sep 2019 13:15:52 -0400
Received: from [86.132.37.92] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iCnuX-000728-4t; Tue, 24 Sep 2019 17:43:33 +0100
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro, 'John Stoffel' <john@stoffel.org>,
        'Sarah Newman' <srn@prgmr.com>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <23940.1755.134402.954287@quad.stoffel.home>
 <094701d56f7c$95225260$bf66f720$@ugal.ro>
 <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
 <23941.15337.175082.79768@quad.stoffel.home>
 <001e01d5705d$b1785360$1468fa20$@ugal.ro> <5D863E19.4000309@youngman.org.uk>
 <01d601d57239$13098130$391c8390$@ugal.ro>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D8A47B4.9000206@youngman.org.uk>
Date:   Tue, 24 Sep 2019 17:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <01d601d57239$13098130$391c8390$@ugal.ro>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 23/09/19 19:02, Liviu Petcu wrote:
>> On 21/09/19 10:19, Liviu Petcu wrote:
>>> Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
>>> almost finished making images of all the discs, and for the second
> "failed"
>>> disc ddrescue reported error-free copying. I intend to use the images to
>>> recreate the array. I haven't done this before, but I hope I can handle
>>> it...
> 
>> Could be that failure that knocked the other drive out of the array too.
>> Dunno why it should happen with SATA, they're supposedly independent,
>> but certainly with the old PATA disks in pairs, a problem with one drive
>> could affect the other.
> 
> Hello,
> You were right Wol. Only one of the disks was damaged. I reinstalled the 5
> drive plus a new one and started the system. I copied the partition table
> from one drive to the new drive and then added the partitions to the 2
> arrays. The recovery has started. It  seems to be almost all right. On raid
> 10 array md1 is a Xen Storage, and some VMs that have XFS file system,
> booted up but report errors like "XFS (dm-2): Internal error
> XFS_WANT_CORRUPTED_GOTO". But this is probably the subject of another
> discussion...
> Thank you all for your support and advices.
> 
Couple of points. Seeing as you're running mirrors, read up on
dm-integrity. It's good for any raid but especially mirrors - it will
check-sum writes so if data gets corrupted (it does happen) it will
return a read error rather than duff data.

And secondly, I think it's okay with MBR but definitely don't use dd to
copy a GPT partition table. GPT has uuids, and the same uuid on more
than one disk or partition will lead to chaos ... :-)

Cheers,
Wol

