Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9415E10AD0
	for <lists+linux-raid@lfdr.de>; Wed,  1 May 2019 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfEAQNd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 May 2019 12:13:33 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:34974 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfEAQNd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 May 2019 12:13:33 -0400
Received: from [192.168.28.40] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 68A88B005C3
        for <linux-raid@vger.kernel.org>; Wed,  1 May 2019 18:13:30 +0200 (CEST)
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
To:     linux-raid@vger.kernel.org
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
 <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
 <20190430092347.GA4799@metamorpher.de>
 <deffabb8-51e8-0120-8c63-ade9e5dfdf9b@free.fr>
 <20190430135152.GA20515@metamorpher.de>
 <8109d116-dd63-15be-2360-7763b9376393@free.fr>
 <5CC95C0E.7000702@youngman.org.uk>
From:   Julien ROBIN <julien.robin28@free.fr>
Message-ID: <c32c4ffa-cfbc-7c74-c035-6f23b91c923f@free.fr>
Date:   Wed, 1 May 2019 18:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5CC95C0E.7000702@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi folks,

tl;dr : Some more information/confirmation, and mdadm 4.1-1 test coming.

Even if I have some difficulty to reproduce the issue into another 
computer (it happened only once in a big amount of tests), on the real 
server, it failed exactly the same a second time during the night, so it 
seems that this can be repeated more easily on it. This time the ext4 
filesystem wasn't mounted.

So I'll upgrade it to Debian 10 which is using Linux 4.19 and mdadm 
4.1-1, and do the test again; in order to tell you if the problem is 
still here.

By the way, doing some tests on another computer, playing --create over 
an existing array after switching from 3.4-4 to 4.1-1, needs to specify 
the data-offset, because it changed. If changed and not given, the array 
filesystem isn't readable until you create it with the right data-offset 
value.

That is, in case of same failure (is no actual data changed - but mdadm 
cannot assemble anymore), after the upgrade, the exact sentence for 
recovering my server's RAID will be :

mdadm --create /dev/md0 --level=5 --chunk=512K --metadata=1.2 --layout 
left-symmetric --data-offset=262144s --raid-devices=3 /dev/sdd1 
/dev/sde1 /dev/sdb1 --assume-clean

It also implies that /dev/sdd1 /dev/sde1 /dev/sdb1 didn't moved (I know 
what are the associated serial numbers - so it's easy to check). If 
wrong, the array filesystem isn't readable until you create it with the 
right positions.

By doing some archeology on the list archive about "grow" subjects, I 
found this guy who suffered from what looks like the same problem on 
same Debian 9 too (his thing about inserting the disk to the VM seems 
not to be a real difference - and he found another way to get it started 
again).
https://marc.info/?t=153183310600004&r=1&w=2
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=884719

I'll probably keep you informed tonight !
