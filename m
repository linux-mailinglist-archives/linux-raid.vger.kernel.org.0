Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4851375496
	for <lists+linux-raid@lfdr.de>; Thu,  6 May 2021 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhEFNVR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 May 2021 09:21:17 -0400
Received: from vps.thesusis.net ([34.202.238.73]:46940 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhEFNVR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 May 2021 09:21:17 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 09:21:17 EDT
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id A3C042F183;
        Thu,  6 May 2021 09:12:13 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qPUJKofxSdb6; Thu,  6 May 2021 09:12:13 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 7C0382F1A7; Thu,  6 May 2021 09:12:13 -0400 (EDT)
References: <CAC6SzHJLG=0_URJUsgQshpk-QLh6b8SBJDrfxiNg4wikQw4uyw@mail.gmail.com> <8626adeb-696c-7778-2d5e-0718ed6aefdb@redhat.com> <CAC6SzHK1A=4wsbLRaYy9RTFZhda6EZs+2FjuKxahoos_zAd0iw@mail.gmail.com>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     d tbsky <tbskyd@gmail.com>
Cc:     Xiao Ni <xni@redhat.com>,
        list Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: raid10 redundancy
Date:   Thu, 06 May 2021 09:09:12 -0400
In-reply-to: <CAC6SzHK1A=4wsbLRaYy9RTFZhda6EZs+2FjuKxahoos_zAd0iw@mail.gmail.com>
Message-ID: <871rakovki.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


d tbsky writes:

> Xiao Ni <xni@redhat.com>
>>
>> Hi
>>
>> It depends on which layout do you use and the copies you specify. There
>> is a detailed description in `man md 3`

No, it only depends on the number of copies.  They layout just effects
the performance.

> Thanks a lot for the hint. After studying the pattern I think n2 and
> o2 could survive if losing two correct disks with 4 or 5 disks. but f2
> will be dead. is my understanding correct?

No; 2 copies means you can lose one disk and still have the other copy.
Where those copies are stored doesn't matter for redundancy, only performance.

