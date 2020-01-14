Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D265A13AD89
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgANPXn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 10:23:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:20892 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANPXn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jan 2020 10:23:43 -0500
Received: from [81.135.72.163] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1irO2f-0004Hw-6z; Tue, 14 Jan 2020 15:23:41 +0000
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     William Morgan <therealbrewer@gmail.com>
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk>
 <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk>
 <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E1DDCFC.1080105@youngman.org.uk>
Date:   Tue, 14 Jan 2020 15:23:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/01/20 14:47, William Morgan wrote:
> Well, I went ahead and tried the forced assembly:
> 
> bill@bill-desk:~$ sudo mdadm --assemble --force /dev/md1 /dev/sdg1
> /dev/sdh1 /dev/sdi1
> [sudo] password for bill:
> mdadm: Merging with already-assembled /dev/md/1

This looks like your problem ... it looks like you have a failed
assembly active. Did you do an "mdadm --stop /dev/md1"? You should
always do that between every attempt.

> mdadm: Marking array /dev/md/1 as 'clean'
> mdadm: failed to RUN_ARRAY /dev/md/1: Input/output error
> 
I hope that's a good sign - if it's got an array that doesn't make sense
then everything should have stopped at that point and the --force won't
have done any damage.

> (The drive letters have changed because I removed a bunch of other
> drives. The original drives are now on sd[b,c,d,e] and the copies are
> on sd[f,g,h,i] with sdf being a copy of the presumably bad sdb with
> the event count which doesn't agree with the other 3 disks.)

Make sure md1 doesn't appear to exist at all (--stop), and then try
again ...

Cheers,
Wol
