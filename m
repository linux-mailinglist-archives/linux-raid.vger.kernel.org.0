Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75010A5474
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 12:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfIBKwb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 06:52:31 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:16749 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfIBKwb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 06:52:31 -0400
Received: from [81.153.82.187] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1i4jwj-0000MS-73; Mon, 02 Sep 2019 11:52:29 +0100
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     =?UTF-8?Q?Krzysztof_Jak=c3=b3bczyk?= <krzysiek.jakobczyk@gmail.com>,
        linux-raid@vger.kernel.org
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Cc:     NeilBrown <neilb@suse.com>, Phil Turmel <philip@turmel.org>
Message-ID: <5D6CF46B.8090905@youngman.org.uk>
Date:   Mon, 2 Sep 2019 11:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02/09/19 11:05, Krzysztof Jakóbczyk wrote:
> My questions are the following:
> 
> What to do in order to move the reshape process forward?

I'll leave that to others, but my gut reaction is just to restart it
(don't follow my advice! Wait for someone else to say it's safe :-)
> 
> Do you think the data on the md0 is safe?

Yes I do.
> 
> How to access the data on md0 if I cannot cd to it?
> 
Wait for the system to (be) recover(ed).

> What are those stack traces in the dmesg output?
> 
> Help will be greatly appreciated.
> 
MAKE SURE you've got a rescue disk with the latest mdadm and an
up-to-date kernel. I strongly suspect you've got an out-of-date system -
mdadm 3.2.2 is pretty ancient. This sounds to me like a well-known
problem from back then, and if I'm right the fix is as simple as booting
into a up-to-date recovery system, letting the reshape complete, and
then booting back into the old system.

Can someone else confirm, please!!!

Cheers,
Wol

